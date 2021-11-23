class Item < ApplicationRecord
	has_many :order_items

	def self.randomly_create(count)
		count.times do 
			Item.create(name: "test-product#{Item.count+1}", sku: rand(100..1000), price: rand(1..100))
		end
	end
end