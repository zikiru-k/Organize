class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :group, null: false, foreign_key: true
      t.integer :customer_id
      t.integer :draft
      t.integer :stats, default: 0
      t.timestamps
    end
  end
end
