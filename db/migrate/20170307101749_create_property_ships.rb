class CreatePropertyShips < ActiveRecord::Migration[5.0]
  def change
    create_table :property_ships do |t|
    	t.integer :product_id
    	t.integer :property_id
      t.timestamps
    end
  end
end
