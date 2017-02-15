class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|

      t.integer :total, default: 0
      t.integer :user_id
      t.string :billing_name
      t.string :billing_address
      t.string :shipping_name
      t.string :shipping_address

      t.timestamps
    end
  end
end
