require 'spec_helper'

describe User do

  before(:all) do
    User.create(email: "dw@example.com", username: "dw", first_name: "Dan", last_name: "Wells", company: "Some Place", password: "pass", profile_image_id:  1, website: "http://website_link", company_site: "http://company_site_link", facebook: "facebook_link", googleplus: "googleplus_link", dribbble: "dribbble_link", instagram: "instagram_link", tumblr: "tumblr_link")
    User.create(email: "bs@example.com", username: "bs", first_name: "Bob", last_name: "Smith", company: "Flywheel", password: "pass", profile_image_id: 1)
    User.create(email: "bw@example.com", username: "bw", first_name: "Bob", last_name: "Wells", company: "Flywheel", password: "pass", profile_image_id: 1)
  end
  
  it "returns nil for nil search query" do
    query = nil
    expect(User.search_name(query)).to be_nil
  end

  it "returns nil for empty search query" do
    query = ""
    expect(User.search_name(query)).to be_nil
  end

  it "finds one or more users matching fuzzy search query" do
    expect(User.search_name("Ob pLaCE").count).to eq(3)
  end
    
  it "finds users by fuzzy search on first name" do
    target_user = User.find_by_first_name("Bob")
    expect(User.search_name("Ob")).to include(target_user)
  end
  
  it "finds users by fuzzy search on last name" do
    target_user = User.find_by_last_name("Wells")
    expect(User.search_name("WEl")).to include(target_user)
  end
  
  it "finds users by fuzzy search on company name" do
    target_user = User.find_by_company("Flywheel")
    expect(User.search_name("Fly whe")).to include(target_user)
  end  
  
  it "find users by fuzzy search with long query string" do
    target_user1 = User.find_by_last_name("Smith")
    target_user2 = User.find_by_company("Some Place")
    expect(User.search_name("works at Some Place with SMit as name")).to include(target_user1, target_user2)
  end
  
end
