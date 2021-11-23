class OrderItem < ApplicationRecord
	belongs_to :order
	belongs_to :item

	after_create :update_item_sku
	
	def sku
		self.item.sku
	end

	def name
		self.item.name
	end

	def unit_price
		self.item.price
	end

	private
	def update_item_sku
		self.item.with_lock do 
			csku = self.item.sku

			self.item.update(sku: csku - self.quantity)
		end
	end
end