require 'spec_helper'

describe "Reset password" do
  it "sends email with instructions" do
    visit login_path
    click_on("Reset my password!")
    
    expect(page).to have_content("Instructions have been sent to your email.")
  end
end
  
describe "Log In" do
  it "Sends to profile page" do
    visit login_path
    click_on("Log In")
  
    expect(page).to have_content("@Omawho")
  end
end

describe "Sign up for free" do
  it "Sends to sign up" do
    visit login_path
    click_on("Sign up for free")
  
    expect(page).to have_content("Add your web presence and bio")
  end
end