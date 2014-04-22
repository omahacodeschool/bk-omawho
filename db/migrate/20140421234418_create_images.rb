class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file
      t.string :file_cache
      t.integer :user_id
      t.string :description
      t.boolean :profile_picture

      t.timestamps
    end
  end
end
