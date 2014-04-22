class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :description
      t.string :location
      t.string :name
      t.string :link
      t.string :venue
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :cancelled, :default => false

      t.timestamps
    end
  end
end
