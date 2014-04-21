class Embed < ActiveRecord::Base
  attr_accessible :description, :link, :type, :user_id
end
