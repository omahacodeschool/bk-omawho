# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: "Web & Software")
Category.create(name: "Graphic Design")
Category.create(name: "Architecture & Interior Design")
Category.create(name: "Photography")
Category.create(name: "Music/Film/Art")
Category.create(name: "Fashion")
Category.create(name: "Writing")
Category.create(name: "Venture Capital")
Category.create(name: "Community Connector")
Category.create(name: "Non-Profit")



i = Image.new
i.file = File.open("public/user-avatar.jpg")
i.save


User.create(:username => "admin", :email => "admin@example.com", :password => "password", :first_name => "Lawrence of", :last_name => "Adminia", :profile_image_id => i.id, :company => "Omaha Code School", :company_site => "omahacodeschool.com")
User.find_by_username("admin").update_attribute(:admin, true)

if Rails.env == "development" 
# Example non-Admin Users
  User.create(email: "dw@example.com", username: "dw", first_name: "Dan", last_name: "Wells", company: "Some Place", password: "pass", profile_image_id: i.id, website: "website_link", company_site: "company_site_link", facebook: "facebook_link", googleplus: "googleplus_link", dribbble: "dribbble_link", instagram: "instagram_link", tumblr: "tumblr_link")
  User.create(email: "bs@example.com", username: "bs", first_name: "Bob", last_name: "Smith", company: "Flywheel", password: "pass", profile_image_id: i.id)
  User.create(email: "jd@example.com", username: "jd", first_name: "John", last_name: "Doe", company: "Lyconic", password: "pass", profile_image_id: i.id, website: "website_link", facebook: "facebook_link", twitter: "twitter_link", pinterest: "pinterest_link", googleplus: "googleplus_link", dribbble: "dribbble_link", instagram: "instagram_link", tumblr: "tumblr_link")
  User.create(email: "ds@example.com", username: "ds", first_name: "Dan", last_name: "Smith", company: "Way Out There Inc.", password: "pass", profile_image_id: i.id, website: "website_link", company_site: "company_site_link")
  User.create(email: "cd@example.com", username: "cd", first_name: "Carlene", last_name: "Danger", company: "Grain & Mortar", password: "pass", profile_image_id: i.id, facebook: "facebook_link", twitter: "twitter_link", pinterest: "pinterest_link", linkedin: "linkedin_link")
  User.create(email: "bw@example.com", username: "bw", first_name: "Becky", last_name: "Williams", company: "Flywheel", password: "pass", profile_image_id: i.id, website: "website_link", company_site: "company_site_link", facebook: "facebook_link", twitter: "twitter_link", pinterest: "pinterest_link", linkedin: "linkedin_link", github: "github_link", googleplus: "googleplus_link", dribbble: "dribbble_link", instagram: "instagram_link", tumblr: "tumblr_link")

  User.all.each do |u|
    u.categories << Category.random.limit(2)
  end

  # Example Events
  @now = DateTime.now
  Event.create(name: "Omaha Code School Graduation", venue: "Omaha Code School", location: "Suite #4107\n200 S 31st Ave\nOmaha, Nebraska", start_time: @now - 1.hour, end_time: @now - 1.day + 1.hour)
  Event.create(name: "CodeDay", venue: "Omaha Code School", location: "Suite #4107\n200 S 31st Ave\nOmaha, Nebraska", start_time: @now + 1.day, end_time: @now + 1.day + 1.hour)
  Event.create(name: "Summer Class", venue: "Omaha Code School", location: "Suite #4107\n200 S 31st Ave\nOmaha, Nebraska", start_time: @now + 1.week, end_time: @now + 1.week + 1.hour)
  Event.create(name: "Quadcopter World Championship", venue: "Omaha Code School", location: "Suite #4107\n200 S 31st Ave\nOmaha, Nebraska", start_time: @now + 1.month, end_time: @now + 1.month + 1.hour)

  # Example events approved via direct assignments
  Event.all.each do |event|
    event.update_attribute(:approved, true)
  end
end
