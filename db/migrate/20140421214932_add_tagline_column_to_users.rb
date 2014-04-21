class AddTaglineColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tagline, :string  # set to maximum 30 characters
  end
end
