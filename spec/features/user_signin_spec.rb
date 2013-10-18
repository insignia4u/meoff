require "spec_helper"

feature "User Signin" do
  given(:user) { create(:user, :confirmed) }
  given(:unconfirmed_user) { create(:user) }

  background do
    visit new_user_session_path
  end

  scenario "signing in with an existing and confirmed user account" do
    fill_in "user[email]",    with: user.email
    fill_in "user[password]", with: "123123123"

    click_button 'Sign in'

    expect(current_path).to eql(root_path)
  end

  scenario "signing in with an unexisting user account" do
    click_button 'Sign in'

    expect(page).to have_content("Invalid email or password")
    expect(current_path).to eql(new_user_session_path)
  end

  scenario "signing in with an unconfirmed user account" do
    fill_in "user[email]",    with: unconfirmed_user.email
    fill_in "user[password]", with: "123123123"

    click_button 'Sign in'

    expect(page).to have_content("You have to confirm your account before continuing")
  end
end
