class CreateMaterialTags < ActiveRecord::Migration[6.0]
  def change
    create_table :material_tags do |t|
      t.references :material, foreign_key: true
      t.references :mtag, foreign_key: true

      t.timestamps
    end
    add_index :material_tags, [:material_id,:mtag_id],unique: true
  end
end
