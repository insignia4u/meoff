require "spec_helper"

feature "Manage Users shows" do
  given(:user) { create(:user, :confirmed) }

  background do 
    login_with(user)
  end

  context "with signed up User" do
    scenario "and manager account" do
      visit root_path

      expect(current_path).to eql(root_path)
      expect(page).to have_content("Manage Users")
    end
  end 

  context "with invited User" do
    background do 
      visit new_user_invitation_path
    end

    scenario "and common account" do
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

      visit root_path

      expect(current_path).to eql(root_path)
      expect(page).to_not have_content("Manage Users")
    end
  end
end
