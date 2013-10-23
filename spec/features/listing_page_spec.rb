require "spec_helper"

feature "Listing Page" do
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
    
    scenario "can see a listing of his notifications" do
      notification = create(:notification, user: user, company: user.company)

      visit notifications_path

      expect(page).to have_content(notification.reason)
      expect(page).to have_content(notification.scheduled_on)
      expect(current_path).to eql(notifications_path)
    end

    scenario "can't see a notifications listing of another company" do
      notification = create(:notification, user: user, company: user.company)
      some_notification = create(:notification)

      visit notifications_path

      expect(page).to have_content(notification.reason)
      expect(page).to have_content(notification.scheduled_on)
      expect(page).to_not have_content(some_notification.reason)
      expect(page).to_not have_content(some_notification.scheduled_on)
    end
  end
end
