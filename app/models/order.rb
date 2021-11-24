class Order < ApplicationRecord
	include ReferenceNumber
	
	has_many :order_items

	accepts_nested_attributes_for :order_items, allow_destroy: true

	before_create :assign_reference_number

	def self.randomly_create_order(opts={})
    item_counts = opts[:item_counts].to_i
		order = Order.new(customer_name: opts[:customer_name], customer_address: opts[:customer_address])

		ic = Item.count
		if ic < item_counts
			Item.randomly_create(item_counts - ic)
		end

		order_items_attributes = []
		item_ids = Item.pluck(:id).sample(item_counts)

		item_counts.times do |i|
			order_item_attributes = {
				item_id: item_ids[i],
				quantity: rand(1..4)
			}

			order_items_attributes.push(order_item_attributes)
		end

		order.order_items_attributes = order_items_attributes

    order
	end

	def total_price
		self.order_items.map do |oi|
			oi.quantity * oi.unit_price
		end.sum
	end

  def self.generate_multiple_receipts(reference_numbers, file_name)
  	pdf = CombinePDF.new
    
  	reference_numbers.uniq.each do |reference_number| 
    	o = Order.where(reference_number: reference_number.delete("\r")).first
    	if o.nil?
    		next
    	end

      pdf << CombinePDF.parse(o.receipt.render)
    end

		pdf.save file_name
  end

	def receipt
    line_items = [
      ["Date",           self.created_at.to_s],
      ["Account Billed", self.customer_name],
      ["==========================================", "=========================================="],
      ["Product", "Amount"],
      ["---------------------------------------------------", "---------------------------------------------------"]
    ]

    self.order_items.each do |oi|
      line_items.push([oi.name, oi.quantity * oi.unit_price])
    end

    line_items.push(["==========================================", "=========================================="])
    line_items.push(["Total Amount",        self.total_price])
    line_items.push(["Address",        self.customer_address])
            
    receipt = Receipts::Receipt.new(
      id: self.reference_number,
      subheading: "RECEIPT FOR #{self.reference_number}",
      product: "Order",
      company: {
        name: 'Company name',
        address: 'Malaysia',
        email: "blackshushi4571+09@gmail.com",
      },
      line_items: line_items
    )

    receipt
	end

	private
	def assign_reference_number
		self.reference_number = self.generate_reference_number
	end

	def reference_number_length
		9
	end

	def reference_number_prefix
		'O'
	end
end