class AddTimestamps < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :created_at, :datetime, null: false , default: Time.zone.now 
    add_column :orders, :updated_at, :datetime, null: false , default: Time.zone.now
    add_column :order_items, :created_at, :datetime, null: false , default: Time.zone.now
    add_column :order_items, :updated_at, :datetime, null: false , default: Time.zone.now
    add_column :items, :created_at, :datetime, null: false , default: Time.zone.now
    add_column :items, :updated_at, :datetime, null: false , default: Time.zone.now
  end
end
