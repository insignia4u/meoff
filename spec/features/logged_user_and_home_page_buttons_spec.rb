require "spec_helper"

feature "The Sign in and Sign out buttons" do
  given(:user) { create(:user, :confirmed) }

  scenario "can to be seen for visitors" do

    visit root_path

    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
  end

  scenario "can't to be seen for logged users" do
    login_with(user)

    visit root_path

    expect(page).to_not have_content("Sign In")
    expect(page).to_not have_content("Sign Up")
    expect(current_path).to eql(root_path)
  end
end
