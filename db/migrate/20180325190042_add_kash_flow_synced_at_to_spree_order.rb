class AddKashFlowSyncedAtToSpreeOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_orders, :kashflow_synced_at, :datetime
  end
end
