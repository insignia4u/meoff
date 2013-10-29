require "spec_helper"

feature "Homepage" do
	given(:user) { create(:user, :confirmed) }

	scenario "for logged in users" do
		login_with(user)

		expect(current_path).to eql(notifications_path)
	end

	scenario "for visitors" do
		visit root_path

		expect(page).to have_content("Meoff Homepage")
	end
end
