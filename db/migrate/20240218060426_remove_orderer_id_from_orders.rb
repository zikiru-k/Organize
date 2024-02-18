class RemoveOrdererIdFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :orderer_id, :integer
  end
end
