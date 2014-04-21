class CreateEmbeds < ActiveRecord::Migration
  def change
    create_table :embeds do |t|
      t.string :link
      t.integer :user_id
      t.string :description
      t.string :type

      t.timestamps
    end
  end
end
