require "spec_helper"

feature "Invite Users" do
  given(:user) { create(:user, :confirmed) }

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

      expect(User.where(email: "tony@starks.com")).to exist
      expect(user.company_id).to eql(User.last.company_id)
    end
  end
end
