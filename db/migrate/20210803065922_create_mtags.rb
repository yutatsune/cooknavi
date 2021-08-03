class CreateMtags < ActiveRecord::Migration[6.0]
  def change
    create_table :mtags do |t|
      t.string :tag_name

      t.timestamps
    end
  end
end
