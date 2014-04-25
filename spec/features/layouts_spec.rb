require 'spec_helper'

describe "Layouts" do
  it "can go to the About page", :js => true do
    visit root_path
    click_on("About")
    expect(page).to have_content("ABOUT OMAWHO")
  end
end
