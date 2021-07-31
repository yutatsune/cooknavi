class CreateMaterialTags < ActiveRecord::Migration[6.0]
  def change
    create_table :material_tags do |t|

      t.timestamps
    end
  end
end
