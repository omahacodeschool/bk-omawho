class RemoveFileCacheFromImages < ActiveRecord::Migration
  def up
    remove_column :images, :file_cache
  end

  def down
    add_column :images, :file_cache
  end
end
