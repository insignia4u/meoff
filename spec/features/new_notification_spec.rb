require "spec_helper"

feature "New Notification" do
  background do
    visit new_notification_path
  end

  context "not logged user" do
    scenario "Unauthorized access" do
      expect(page).to have_content("You need to sign in or sign up before continuing.")
      expect(current_path).to eql(user_session_path)
    end
  end

  context "logged user" do
    given(:user) { create(:user, :confirmed) }

    background do 
      login_with(user)
      visit new_notification_path
    end

    scenario "Posting a new notification" do
      fill_in "notification[reason]",         with: "Doctor Appointment"
      fill_in "notification[scheduled_on]",   with: 3.days.from_now
      
      click_on "Notify the team"

      expect(page).to have_content("The Notification was created correctly.")
      expect(Notification.where(reason: "Doctor Appointment")).to exist
      expect(user.company.notifications).to include(Notification.last)
    end

    scenario "Failed posting" do
      
      click_on "Notify the team"

      expect(Notification.count).to eql(0)
      expect(page).to have_content("Reason can't be blank")
      expect(page).to have_content("Scheduled on can't be blank")
      expect(current_path).to eql(notifications_path)
    end
  end
end
