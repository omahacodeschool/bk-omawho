class Embed < ActiveRecord::Base
  attr_accessible :description, :link, :user_id, :embed_type
  
  belongs_to :user
  
  validates_presence_of :link
  validates_inclusion_of :embed_type, :in => %w(video audio), :message => "specified embed type not recognized"
  
end
