class CreateHows < ActiveRecord::Migration[6.0]
  def change
    create_table :hows do |t|
      t.text :how, null: false
      t.references :recipe, null: false, foreign_key: true
      t.timestamps
    end
  end
end
