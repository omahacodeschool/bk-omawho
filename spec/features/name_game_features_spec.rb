require 'spec_helper'

describe "Name Game features" do
  before :each do
    i = Image.new
    i.file = File.open("public/user-avatar.jpg")
    i.save
    User.create(email: 'rufus@example.com', username: 'rufus', password: 'rufus', first_name: 'Rufus', last_name: 'Wainwright', company: 'PayPal', twitter: 'rufuswainwright', profile_image_id: i.id)
  end
  
  it "shows the results of a quiz: first question correct, second question unanswered", :js => true do
    visit "/name_game"
    fill_in('name_guess', :with => 'Rufus Wainwright')
    find('.submit_button').click
    expect(page).to have_content("Rufus Wainwright")
    expect(page).to have_content("You were right!")
    expect(page).to have_content("Come on, it was multiple choice. I must be doing something.")
  end
  
  it "shows the results of a quiz, second question correct, first question unanswered", :js => true do
    visit "/name_game"
    find(".name_game_company").click
    find('.submit_button').click
    expect(page).to have_content("You didn't even guess. What's the deal?")
    expect(page).to have_content("PayPal")
  end
  
  it "shows the results of a quiz, first question wrong, second question unanswered", :js => true do
    visit "/name_game"
    fill_in('name_guess', :with => 'Hootie Blowfish')
    find(".name_game_company").click
    find('.submit_button').click
    expect(page).to have_content("You said it was Hootie Blowfish")
    expect(page).to have_content("PayPal")
  end
  
  it "shows the results of a quiz, both questions unanswered", :js => true do
    visit "/name_game"
    find('.submit_button').click
    expect(page).to have_content("You didn't even guess. What's the deal?")
    expect(page).to have_content("Come on, it was multiple choice. I must be doing something.")
  end
end