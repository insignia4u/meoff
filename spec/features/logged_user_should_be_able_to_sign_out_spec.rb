require "spec_helper"

feature "Sign out" do
  given(:user) { create(:user, :confirmed) }

  scenario "with logged users" do
    login_with(user)

    visit root_path

    click_on "Sign Out"

    expect(page).to have_content("Signed out successfully.")
    expect(current_path).to eql(root_path)
  end
end
