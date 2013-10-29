require "spec_helper"

feature "Homepage redirect" do
  given(:user) { create(:user, :confirmed) }

  scenario "for visitors" do
    visit root_path

    expect(page).to have_content("Meoff Homepage")
  end

  scenario "for logged in users" do
    login_with(user)

    click_on "MeOff"

    expect(page).to have_content("List of Notifications")
    expect(current_path).to eql(root_path)
  end
end
