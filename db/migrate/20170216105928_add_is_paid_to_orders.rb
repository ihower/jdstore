class AddIsPaidToOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :paid_at
    add_column :orders, :is_paid, :boolean, :default => false
  end
end
