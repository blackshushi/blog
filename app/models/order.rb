class Order < ApplicationRecord
	include ReferenceNumber
	
	has_many :order_items

	accepts_nested_attributes_for :order_items, allow_destroy: true

	before_create :assign_reference_number

	def self.randomly_create_order(item_counts, cname, caddress)
		order = Order.new(customer_name: cname, customer_address: caddress)

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

		order.save
	end

	def total_price
		self.order_items.map do |oi|
			oi.quantity * oi.unit_price
		end.sum
	end

	def receipt
		full_pdf = CombinePDF.new

		self.order_items do |oi|
			receipt = Receipts::Receipt.new(
	      id: oi.id,
	      subheading: "RECEIPT FOR #{oi.name}",
	      product: oi.name,
	      company: {
	        email: "blackshushi4571+09@gmail.com",
	      },
	      line_items: [
	        ["Date",           oi.created_at.to_s],
	        ["Account Billed", "#{self.customer_name}"],
	        ["Product",        oi.name],
	        ["Amount",         oi.quantity * oi.unit_price],
	        ["Address",        self.customer_address]
	      ]
	    )

			pp receipt
	    full_pdf.push(receipt)
		end

		full_pdf
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