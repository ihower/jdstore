class CreateProductLists < ActiveRecord::Migration[5.0]
  def change
    create_table :product_lists do |t|

      t.integer :order_id
      t.string  :product_name
      t.integer :product_price
      t.integer :quantity

      t.timestamps
    end
  end
end
