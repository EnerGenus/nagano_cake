class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :item_id, null: false
      t.integer :order_id, null: false
      t.decimal :price_including_tax, null: false
      t.integer :amount_ordered, null: false
      t.integer :making_status, null: false

      t.timestamps
    end
  end
end
