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

@now = DateTime.now

Event.create(name: "Test Event 1", location: "Loc 1", start_time: @now - 1.day, end_time: @now - 1.day + 1.hour)

Event.create(name: "Test Event 2", location: "Loc 2", start_time: @now + 1.day, end_time: @now + 1.day + 1.hour)
Event.create(name: "Test Event 3", location: "Loc 3", start_time: @now + 1.week, end_time: @now + 1.week + 1.hour)
Event.create(name: "Test Event 4", location: "Loc 4", start_time: @now + 1.month, end_time: @now + 1.month + 1.hour)

Event.all.each do |event|
  event.update_attribute(:approved, true)
end