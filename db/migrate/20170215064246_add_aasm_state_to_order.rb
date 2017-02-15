class AddAasmStateToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :aasm_state, :string, default: "order_placed"
    add_index  :orders, :aasm_state
  end
end
