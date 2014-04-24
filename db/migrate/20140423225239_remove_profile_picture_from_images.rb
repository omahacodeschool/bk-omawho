class RemoveProfilePictureFromImages < ActiveRecord::Migration
  def up
    remove_column :images, :profile_picture
  end

  def down
    add_column :images, :profile_picture, :integer
  end
end
