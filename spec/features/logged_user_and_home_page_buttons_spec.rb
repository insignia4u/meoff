require "spec_helper"

feature "User session buttons presentation" do
  given(:user) { create(:user, :confirmed) }

  scenario "with a visitor" do

    visit root_path

    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
  end

  scenario "with a logged in user" do
    login_with(user)

    visit root_path

    expect(page).to_not have_content("Sign In")
    expect(page).to_not have_content("Sign Up")
    expect(current_path).to eql(root_path)
  end
end
