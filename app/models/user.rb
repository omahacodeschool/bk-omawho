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
  
end
