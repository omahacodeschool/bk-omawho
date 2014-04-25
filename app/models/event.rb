class Event < ActiveRecord::Base
  attr_accessible :description, :link, :location, :name, :venue
  attr_accessible :cancelled, :end_time, :start_time
  
  has_and_belongs_to_many :users
  
  scope :approved, where(:approved => true)
  scope :cancelled, where(:cancelled => true)
  scope :not_cancelled, where(:cancelled => false)
  
  validates_presence_of :start_time
  validates_presence_of :location
  validates_presence_of :name

  validates_uniqueness_of :start_time, :scope => :name


  def generate_slug
    self.slug = "#{name.parameterize}-#{start_time.year}-#{start_time.month}-#{start_time.day}"
  end

  def is_current
    self.start_time > Time.now
  end
  
  
  
end


