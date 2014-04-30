class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :email, :password, :password_confirmation
  attr_accessible :username, :first_name, :last_name, :tagline
  attr_accessible :bio, :website, :company, :company_site
  attr_accessible :facebook, :twitter, :pinterest, :linkedin, :github, :googleplus, :dribbble, :instagram, :tumblr
  attr_accessible :profile_image_id, :category_ids
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
  #validates :website, :format => { :with => /^http/ }, :allow_blank => true
  #validates :company_site, :format => { :with => /^http/ }, :allow_blank => true
  validates_exclusion_of :username, :in => %w(category login logout add profile quiz beta)
  validates_length_of :bio, :within => 0..400
  validates_length_of :password, :within => 4..99, :allow_blank => :allow_blank_password
  validates_length_of :tagline, :within => 0..30
  
  has_and_belongs_to_many :events
  has_and_belongs_to_many :categories
  has_many :images
  has_many :embeds
  
  scope :random, order("RANDOM()")

  accepts_nested_attributes_for :categories
  
  #allow the password to be blank when editing a user
  def allow_blank_password
    !new_record?
  end
  
  #Formats image as a square
  def profile_image
    self.profile_image_id ? Image.find(self.profile_image_id).file.square : nil
  end
  
  # Public: Utility to get full user name.
  #
  #
  # Returns the user first/last names concatenated into a String.
  def full_name
    "#{first_name.strip} #{last_name.strip}"
  end

  # Public: Utility to return description of where the user works.
  #
  #
  # Returns a String describing the user's place of work.
  def work_description
    if company.nil? || company == ""
      "I work at __. (I haven't listed a company. Maybe I'm saving the world.)"     else
      "I work at #{company.titleize}."
    end
  end
  
  # Public: Utility to determine if a guess matches user's full name.
  #
  # guess - The String containing a guess for the user's full name.
  #
  # Returns false if guess is nil. Otherwise returns the string comparison of 
  # the guess to the user's name.
  def name_matches?(guess)
    case guess
    when nil
      false
    else
      full_name.downcase == guess.downcase
    end
  end

  # Public: Utility to determine if a guess matches user's company.
  #
  # guess - The String containing a guess for the user's company.
  #
  # Returns true if the guess and user's company is either nil or the empty 
  # string. Otherwise returns the string comparison of the guess to the 
  # user's company (case insensitive).  
  def company_matches?(guess)
    case guess
    when nil
      company.nil? || company == ""
    when ""
      company.nil? || company == ""
    else
      !company.nil? && company.downcase == guess.downcase
    end
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
    # Return nil on nil query
    return nil if !query_str
    
    # split the query into multiple strings, return nil if empty query
    splits = query_str.split
    return nil if splits.count <= 0
    
    found_users = []
    
    # if two parameter strings, assume searching for person by first + last name
    if splits.count == 2
      fname = splits[0]
      lname = splits[1]
      found_users = User.where("LOWER(first_name) LIKE ? AND LOWER(last_name) LIKE ?", "%#{fname.downcase}%", "%#{lname.downcase}%")
    end
    
    # if nothing found, iterate over each parameter string and find any matches
    # in first name, last name, or company name
    if found_users.flatten.count <= 0
      splits.each do |s|
        found_users << User.where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR LOWER(company) LIKE ?", "%#{s.downcase}%", "%#{s.downcase}%", "%#{s.downcase}%")
      end
    end
        
    # If one or more found, return flattened and uniq array of users
    if found_users.flatten.count > 0
      return found_users.flatten.uniq
    # Otherwise, catch all return nil
    else
      return nil
    end
    
  end
  
  # Public: Utility to retrieve list of contact/social links.
  #
  #
  # Returns a hash of existing links for the user.  
  def contact_links
    links = {}
    
    (links["facebook"] = facebook_url) if facebook && facebook != ""
    (links["twitter"] = twitter_url) if twitter && twitter != ""
    (links["pinterest"] = pinterest_url) if pinterest && pinterest != ""
    (links["linkedin"] = linkedin_url) if linkedin && linkedin != ""
    (links["github"] = github_url) if github && github != ""
    (links["googleplus"] = googleplus_url) if googleplus && googleplus != ""
    (links["dribbble"] = dribbble_url) if dribbble && dribbble != ""
    (links["instagram"] = instagram_url) if instagram && instagram  != ""
    (links["tumblr"] = tumblr_url) if tumblr && tumblr != ""
    
    links
  end
  
  def googleplus_url
    format_social_link(googleplus, "plus.google.com", "https://plus.google.com/+$USERNAME")
  end
  
  def instagram_url
    format_social_link(instagram, "instagram.com", "http://instagram.com/$USERNAME")
  end
  
  def tumblr_url
    format_social_link(tumblr, "tumblr.com", "http://$USERNAME.tumblr.com")
  end
  
  def linkedin_url
    format_social_link(linkedin, "linkedin.com", "http://linkedin.com/in/$USERNAME")
  end

  def facebook_url
    format_social_link(facebook, "facebook.com", "http://facebook.com/$USERNAME")
  end

  def twitter_url
    format_social_link(twitter.gsub(/^@/, ""), "twitter.com", "http://twitter.com/$USERNAME")
  end

  def dribbble_url
    format_social_link(dribbble, "dribbble.com", "http://dribbble.com/$USERNAME")
  end

  def github_url
    format_social_link(github, "github.com", "http://github.com/$USERNAME")
  end

  def pinterest_url
    format_social_link(pinterest, "pinterest.com", "http://pinterest.com/$USERNAME")
  end

  def company_url
    format_link(company_site)
  end
  
  def personal_url
    format_link(website)
  end
  
protected
  def format_social_link(input, domain, example)
    # If "domain" is present, they probably added the whole URL.
    if input =~ /#{domain}/

      # If it starts with a valid protocol, use the link as is.
      if input =~ /^https?:\/\//
        input

      # If just the protocol is absent, add it.
      elsif input =~ /^((www\.)|(#{domain}))/
        "http://#{input}"

      # Otherwise I don't know what is going on.
      else
        input
      end

    # Sane people just used their username.
    else
      "#{example.gsub("$USERNAME", input)}"
    end
  end
  
  def format_link(input)
      # If it starts with a valid protocol, use the link as is.
      if input =~ /^https?:\/\//
        input

      # If just the protocol is absent, add it.
      else
        "http://#{input}"
      end
  end
end
