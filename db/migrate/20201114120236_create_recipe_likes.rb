class CreateRecipeLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_likes do |t|
      t.references :user, foreign_key: true
      t.references :recipe, foreign_key: true
      t.timestamps
      t.index [:user_id, :recipe_id], unique: true
    end
  end
end
