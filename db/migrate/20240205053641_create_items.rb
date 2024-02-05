class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :order_tag_relation, null: false, foreign_key: true
      t.string :name
      t.string :code
      t.string :capacity
      t.string :site
      t.timestamps
    end
  end
end
