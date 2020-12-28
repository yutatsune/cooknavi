class CreateMaterialImages < ActiveRecord::Migration[6.0]
  def change
    create_table :material_images do |t|
      t.references :material ,null: false, foreign_key: true
      t.string     :src ,null: false
      t.timestamps
    end
  end
end
