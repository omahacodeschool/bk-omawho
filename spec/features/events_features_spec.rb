require 'spec_helper'

describe "Events features" do
  before :each do
    @now = DateTime.now
    Event.create(name: "Quadcopter World Championship", venue: "Omaha Code School", location: "Suite #4107\n200 S 31st Ave\nOmaha, Nebraska", start_time: @now + 1.month, end_time: @now + 1.month + 1.hour)
    Event.all.each do |event|
      event.update_attribute(:approved, true)
    end
  end
  
  it "shows an event's details" do
    visit "/events"
    find('#event_name').click
    expect(page).to have_content("OMAWHERE")
  end
end