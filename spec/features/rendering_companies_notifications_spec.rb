require "spec_helper"

feature "Listing notifications" do
  given(:user) { create(:user, :confirmed) }

  background do
    visit notifications_path
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
    
    scenario "can see company's notifications" do
      notification = create(:notification, user: user, company: user.company)
      another_notification = create(:notification, company: user.company)

      visit notifications_path

      expect(page).to have_content(notification.reason)
      expect(page).to have_content(notification.scheduled_on)
      expect(page).to have_content(another_notification.reason)
      expect(page).to have_content(another_notification.scheduled_on)
    end
  end
end
