require 'rails_helper'

describe "user can edit meessage", type: :feature do
  context "when a room exists, the user can edit the message" do
  before :each do
    @room = Room.create!(name: 'test room')
    @message = Message.create!(content: 'test message',room_id:@room.id)
  end

  it "edits message" do
    user_goes_room_page
    user_clicks_edit_link
    user_fills_edit_message
    user_should_see_updated_message
  end

  def user_goes_room_page
    visit rooms_path
  end

  def user_clicks_edit_link
    find("a[data-turbo-frame='message_#{@message.id}']").click

  end

  def user_fills_edit_message
    within "form[data-turbo-frame='message_#{@message.id}']" do
      fill_in 'message_content', with: 'edited message'
      click_button "Update"
    end
   
  end

  def user_should_see_updated_message
    expect(page).to have_content('edited message')
  end

  end
end