class AddTokenToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :token, :string
  end
end
