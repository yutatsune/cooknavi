class CreateMaterials < ActiveRecord::Migration[6.0]
  def change
    create_table :materials do |t|
      t.string :name, null: false
      t.integer :postcode, null: false
      t.integer :prefecture_code, null: false
      t.string :address_city, null: false
      t.string :address_building
      t.string :explanation, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
