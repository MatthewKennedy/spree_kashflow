class AddKashFlowNumberToSpreeOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_orders, :kashflow_number, :integer
  end
end
