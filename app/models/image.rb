class Image < ActiveRecord::Base
  attr_accessible :description, :file, :file_cache, :profile_picture, :user_id
end
