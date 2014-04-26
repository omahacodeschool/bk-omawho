require 'spec_helper'

describe User do

  before(:all) do
    User.create(email: "dw@example.com", username: "dw", first_name: "Dan", last_name: "Wells", company: "Some Place", password: "pass", profile_image_id:  1, website: "http://website_link", company_site: "http://company_site_link", facebook: "facebook_link", googleplus: "googleplus_link", dribbble: "dribbble_link", instagram: "instagram_link", tumblr: "tumblr_link")
    User.create(email: "bs@example.com", username: "bs", first_name: "Bob", last_name: "Smith", company: "Flywheel", password: "pass", profile_image_id: 1)
  end
  
  it "returns nil for nil search query" do
    query = nil
    expect(User.search_name(query)).to be_nil
  end

  it "returns nil for empty search query" do
    query = ""
    expect(User.search_name(query)).to be_nil
  end

  it "test seeds loading" do
    expect(User.count).to be <= 0
  end
  
end
