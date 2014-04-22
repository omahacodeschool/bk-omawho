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

User.create(:username => "admin_user", :email => "admin@example.com", :password => "jijijiji", :first_name => "Lawrence of ", :last_name => "Adminia")
User.find_by_username("admin_user").update_attribute(:admin, true)