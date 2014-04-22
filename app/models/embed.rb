class Embed < ActiveRecord::Base
  attr_accessible :description, :link, :type, :user_id
  
  belongs_to :user
  
  validates_presence_of :link
  validates_inclusion_of :type, :in => %w(video audio), :message => "specified embed type not recognized"
  
end
