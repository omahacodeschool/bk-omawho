class Image < ActiveRecord::Base
  attr_accessible :description, :file, :file_cache, :user_id
  
  belongs_to :user
  
  mount_uploader :file, ImageAssetUploader
  
end
