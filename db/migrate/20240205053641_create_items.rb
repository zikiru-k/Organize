class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :group_id, null: false
      t.string :name
      t.string :code
      t.string :capacity
      t.string :site
      t.timestamps
    end
  end
end
