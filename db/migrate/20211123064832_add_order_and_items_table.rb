class AddOrderAndItemsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :reference_number, :limit => 9
      t.string :customer_name
      t.string :customer_address
    end

    create_table :order_items do |t|
      t.references :order
      t.references :item
      t.integer :quantity
    end

    create_table :items do |t|
      t.integer :sku
      t.string :name
      t.integer :unit_price
    end
  end
end
