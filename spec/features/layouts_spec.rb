require 'spec_helper'

describe "Layouts" do
  it "can go to the About page", :js => true do
    visit root_path
    click_on("About")
    expect(page).to have_content("ABOUT OMAWHO")
  end
  
  it "can filter by Category", :js => true do
    Category.create(name: "Graphic Design")
    visit root_path
    find("#topnavtext").click
    click_on("Graphic Design")
    expect(page).to have_content("Showing 'Graphic Design' Faces")
  end
  
  it "can go to the home page", :js => true do
    User.create(email: "bs@example.com", username: "bs", first_name: "Bob", last_name: "Smith", company: "Flywheel", password: "pass")
    visit("/events")
    find(:css, "#logo").click
    expect(page).to have_css("#face-display")
  end
  
  it "can go to the events page", :js => true do
    visit root_path
    click_on("events")
    expect(page).to have_content("Upcoming Events")
  end
  
  it "can go to the name game page", :js => true do
    User.create(email: "bs@example.com", username: "bs", first_name: "Bob", last_name: "Smith", company: "Flywheel", password: "pass")
    visit root_path
    click_on("name game")
    expect(page).to have_content("What's my name?")
  end
end
