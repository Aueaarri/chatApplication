require 'rails_helper'

describe "Message management: " do
  context "when user is in a room" do
    it "allows user to edit their message", js: true do
      user_goes_to_room
      user_creates_message
      user_edits_message
      user_should_see_edited_message
    end
  end
end

def user_goes_to_room
  visit rooms_path
  click_link 'DEMO ROOM'
end

def user_creates_message
  within '#message-form' do
    fill_in 'message_content', with: "Hello World"
    click_button 'Send'
  end
end

def user_edits_message
  within '.message-container' do
    click_link 'Edit'
  end
  
  within "turbo-frame[id^='message_']" do
    fill_in 'message_content', with: "Updated Message"
    click_button 'Update'
  end
end

def user_should_see_edited_message
  expect(page).to have_content 'Updated Message'
end