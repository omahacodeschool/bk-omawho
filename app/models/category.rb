class Category < ActiveRecord::Base
  attr_accessible :name
  
  scope :random, order("RANDOM()")
  
  has_and_belongs_to_many :users
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  after_commit :delete_cache
  
  def delete_cache
    Rails.cache.delete("categories")
  end
  
  def self.cached_all
    Rails.cache.fetch("categories") {all()}
  end
end
