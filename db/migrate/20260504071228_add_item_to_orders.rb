class AddItemToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :item, null: false, foreign_key: true
  end
end
