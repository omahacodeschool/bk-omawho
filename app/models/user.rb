class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :email, :password, :password_confirmation
  attr_accessible :username, :first_name, :last_name, :tagline
  attr_accessible :bio, :website, :company, :company_site
  attr_accessible :facebook, :twitter, :pinterest, :linkedin, :github, :googleplus, :dribbble, :instagram, :tumblr
  # Note: security encryption and administrative status items not included in
  #       attr_accessible lists
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  validates :username, :format => { :with => /^(\w|-)*$/, :message => "can only contain letters, numbers, underscores, and dashes" }
  validates :website, :format => { :with => /^http/ }, :allow_blank => true
  validates :company_site, :format => { :with => /^http/ }, :allow_blank => true
  validates_exclusion_of :username, :in => %w(category login logout add profile quiz beta)
  validates_length_of :bio, :within => 0..400
  validates_length_of :password, :within => 4..99
  validates_length_of :tagline, :within => 0..30
  
  has_and_belongs_to_many :events
  has_and_belongs_to_many :categories
  has_many :images
  has_many :embeds
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def self.search_name(query_str)
    # split the query into multiple strings
    splits = query_str.split
    found_users = []
    
    # if two or more parameter strings, use first two for searching against 
    #   first and last name
    if splits.count >= 2
      fname = splits[0]
      lname = splits[1]
      found_users = User.find(:all, :conditions => ["lower(first_name) = ? and lower(last_name) = ?", fname.downcase, lname.downcase])
      
    # otherwise use single string and search against any name
    elsif splits.count > 0
      anyname = splits[0]  # default to first query string an
      found_users = User.find(:all, :conditions => ["lower(first_name) = ?", anyname.downcase])
      found_users += User.find(:all, :conditions => ["lower(last_name) = ?", anyname.downcase])

    # catch-all for query string errors (send back nil results)
    else
      return nil
      
    end
    
    found_users
  end
  
end
