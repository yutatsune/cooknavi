class CreateMaterialLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :material_likes do |t|
      t.references :user, foreign_key: true
      t.references :material, foreign_key: true
      t.timestamps
      t.index [:user_id, :material_id], unique: true
    end
  end
end
