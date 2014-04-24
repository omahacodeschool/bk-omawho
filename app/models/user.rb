class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :email, :password, :password_confirmation
  attr_accessible :username, :first_name, :last_name, :tagline
  attr_accessible :bio, :website, :company, :company_site
  attr_accessible :facebook, :twitter, :pinterest, :linkedin, :github, :googleplus, :dribbble, :instagram, :tumblr
  attr_accessible :profile_image_id
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
  # validates :website, :format => { :with => /^http/ }, :allow_blank => true
  # validates :company_site, :format => { :with => /^http/ }, :allow_blank => true
  validates_exclusion_of :username, :in => %w(category login logout add profile quiz beta)
  validates_length_of :bio, :within => 0..400
  validates_length_of :password, :within => 4..99
  validates_length_of :tagline, :within => 0..30
  
  has_and_belongs_to_many :events
  has_and_belongs_to_many :categories
  has_many :images
  has_many :embeds
  

  
  
  def profile_image
    self.profile_image_id ? Image.find(self.profile_image_id).file.square : nil
  end
  
  # Public: Utility to get full user name.
  #
  #
  # Returns the user first/last names concatenated into a String.
  def full_name
    "#{first_name} #{last_name}"
  end

  # Class Method:
  # Public: Search for users by name.
  #
  # query_str - The String containing the search query. Expectation is that the 
  #             query will hold a first name, a last name, or a first & 
  #             last name. Added functionality for partial name searches and 
  #             companies.
  # 
  #
  # Examples
  #
  #   User.search_name("John Smith")
  #   # => One or more User objects matching 
  #          first_name == "John", last_name == "Smith"
  #
  #   User.search_name("Joe")
  #   # => Array of User objects with first_name == "Joe"
  # 
  #   User.search_name("wheel")
  #   # => Array of User objects with first_name, last_name, or company 
  #        matching a String LIKE "%wheel%"
  #
  # Returns an Array of 0 or more User model objects matching name_search query 
  # parameter strings or nil if there are errors
  def self.search_name(query_str)
    # split the query into multiple strings
    splits = query_str.split
    found_users = []
    
    # if two or more parameter strings, use first two for searching against 
    #   first and last name
    if splits.count >= 2
      fname = splits[0]
      lname = splits[1]
      found_users = User.where("(LOWER(first_name) LIKE ? AND LOWER(last_name) LIKE ?) OR LOWER(company) LIKE ? OR LOWER(company) LIKE ?", "%#{fname.downcase}%", "%#{lname.downcase}%", "%#{fname.downcase}%", "%#{lname.downcase}%")
      
    # otherwise use single string and search against any name
    elsif splits.count > 0
      anyname = splits[0].downcase  # default to first query string an
      found_users = User.where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR LOWER(company) LIKE ?", "%#{anyname}%", "%#{anyname}%", "%#{anyname}%")
      
    # catch-all for query string errors (send back nil results)
    else
      return nil
      
    end
    
    # Return the found user(s)
    found_users
  end
  
  # Public: Utility to retrieve list of contact/social links.
  #
  #
  # Returns a hash of existing links for the user.  
  def contact_links
    links = {}
    
    links["website"] = website if website
    links["company_site"] = company_site if company_site
    links["facebook"] = facebook if facebook
    links["twitter"] = twitter if twitter
    links["pinterest"] = pinterest if pinterest
    links["linkedin"] = linkedin if linkedin
    links["github"] = github if github
    links["googleplus"] = googleplus if googleplus
    links["dribbble"] = dribbble if dribbble
    links["instagram"] = instagram if instagram
    links["tumblr"] = tumblr if tumblr
    
    links
  end







    
  
end
