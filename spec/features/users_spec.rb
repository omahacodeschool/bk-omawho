require 'spec_helper'

describe "Users" do
 it "should not save user without image" do
    user = User.new
    assert !user.save, "Saved the post without a title"
  end
  
  it "has evnts on the front page" do
    visit root_path
    expect(page).to have_content("events")
  end
  
  it "has users on the front page" do
    visit root_path
    expect(page).to have_content(@users)
  end
  
  it "has categories" do
    visit root_path
    expect(page).to have_content("Category")
  end
  
  
end
