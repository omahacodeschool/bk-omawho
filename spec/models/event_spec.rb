require 'spec_helper'

describe Event do
  
  it "can make a new event" do
    @event = Event.create(name: "Omaha Code School Graduation", venue: "Omaha Code School", location: "Suite #4107\n200 S 31st Ave\nOmaha, Nebraska", start_time: @now, end_time: @now)
    expect(@event.name).to eq("Omaha Code School Graduation")
  end
  
  it "errors on an event that doesnt have a start time" do
    @event = Event.create(name: "Omaha Code School Graduation", venue: "Omaha Code School", location: "Suite #4107\n200 S 31st Ave\nOmaha, Nebraska")
    @event.errors ? errors = true : errors = false
    expect(errors).to eq(true)
  end
  
  it "errors on an event that doesnt have a name" do
    @event = Event.create(venue: "Omaha Code School", location: "Suite #4107\n200 S 31st Ave\nOmaha, Nebraska", start_time: @now, end_time: @now)
    @event.errors ? errors = true : errors = false
    expect(errors).to eq(true)
  end
  
  
end
