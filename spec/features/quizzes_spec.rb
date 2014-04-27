require 'spec_helper'

describe "Quizzes" do
 
  before(:each) do
    i = Image.new
    i.file = File.open("public/user-avatar.jpg")
    i.save
    
    User.create(email: "dw@example.com", username: "dw", first_name: "Dan", last_name: "Wells", company: "Some Place", password: "pass", profile_image_id:  i.id)
    User.create(email: "bs@example.com", username: "bs", first_name: "Bob", last_name: "Smith", company: "Flywheel", password: "pass", profile_image_id: i.id)
    User.create(email: "bw@example.com", username: "bw", first_name: "Bob", last_name: "Wells", company: "Grain & Mortar", password: "pass", profile_image_id: i.id)
    
    @users = User.all
    @random_co = User.random.first.company
  end
  
  it "can go to the Name Game page", :js => true do
    visit root_path
    click_on("name game")
    expect(page).to have_content("What's my name?")
    # save_and_open_page
  end
  
  it "chooses random companies from User model for multiple choice quiz", :js => true do     
    visit root_path
    click_on("name game")
    expect(page).to have_content(@random_co)
  end

  it "displays guess results on check_quiz page", :js => true do
    visit name_game_path
    click_button("TAKE A GUESS")
    expect(page).to have_content("Hi! My name is")
  end
  
  it "alternates between name_game and check_quiz pages", :js => true do
    visit name_game_path
    click_button("TAKE A GUESS")
    click_on("SHOW ANOTHER FACE")
    expect(page).to have_content("Where do I work?")
  end
  
end
