class AddImageToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :image, :string
  end
end
