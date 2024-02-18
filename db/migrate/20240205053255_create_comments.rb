class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :order_id, null: false
      t.text :content
      t.timestamps
    end
  end
end
