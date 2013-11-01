require "spec_helper"

feature "Invite Users" do
  given(:user) { create(:user, :confirmed, :as_manager) }

  background do
    visit new_user_invitation_path
  end

  context "with not logged user" do
    scenario "can't access" do
      expect(page).to have_content("You need to sign in or sign up before continuing.")
      expect(current_path).to eql(user_session_path)
    end
  end

  context "with logged user" do
    background do 
      login_with(user)
    end
    
    scenario "can send" do
      visit new_user_invitation_path
      
      fill_in "user[full_name]",  with: "Tony Starks"
      fill_in "user[email]",      with: "tony@starks.com"
      
      click_on "Send an invitation"

      expect(page).to have_content("An invitation email has been sent")
      expect(User.where(email: "tony@starks.com")).to exist
      expect(user.company_id).to eql(User.last.company_id)
    end

    scenario "and confirming user invitation by email" do
      visit new_user_invitation_path

      fill_in "user[full_name]",  with: "Tony Starks"
      fill_in "user[email]",      with: "tony@starks.com"
      
      click_on "Send an invitation"

      visit root_path

      click_on "Sign Out"

      last_user = User.last

      open_email(last_user.email)
      current_email.click_on "Accept invitation"
   
      fill_in "user[password]",               with: "123456789"
      fill_in "user[password_confirmation]",  with: "123456789"
      
      click_on "Set my password"

      expect(page).to have_content("Your password was set successfully. You are now signed in.")
      expect(current_path).to eql(notifications_path)
      expect(last_user.reload).to be_confirmed
    end
  end
end
