class CreateMaterialComments < ActiveRecord::Migration[6.0]
  def change
    create_table :material_comments do |t|
      t.integer :user_id, null: false
      t.integer :material_id, null: false
      t.text :text, null: false
      t.timestamps
    end
  end
end
