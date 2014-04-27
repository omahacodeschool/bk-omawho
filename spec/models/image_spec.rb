require 'spec_helper'

describe Image do
  
  it "can save an image" do
    i = Image.new
    i.file = File.open("public/user-avatar.jpg")
  
    expect(i.file).to end_with("/user-avatar.jpg")
  end
end
