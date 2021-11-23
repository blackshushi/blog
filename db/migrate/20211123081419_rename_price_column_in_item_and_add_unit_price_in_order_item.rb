class RenamePriceColumnInItemAndAddUnitPriceInOrderItem < ActiveRecord::Migration[6.1]
  def change
    rename_column :items, :unit_price, :price
  end
end
