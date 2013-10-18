require "spec_helper"

feature "User Signup" do
  background do
    visit new_user_registration_path
  end

  scenario "signing up for an account with valid data" do
    fill_in "user[company_attributes][name]",   with: "New Company"
    fill_in "user[full_name]",                  with: "Bruce Wayne"
    fill_in "user[email]",                      with: "bruce@wayneinc.com"
    fill_in "user[password]",                   with: "123123123"
    fill_in "user[password_confirmation]",      with: "123123123"

    click_on "Sign up"

    expect(User.where(email: "bruce@wayneinc.com")).to exist
    expect(Company.where(name: "New Company")).to exist
    
    expect(page).to have_content("A message with a confirmation link has been sent")
    expect(last_email).not_to be_nil
    expect(last_email.to).to include("bruce@wayneinc.com")
    expect(current_path).to eql(root_path)
  end

  scenario "confirming devise user account by email" do
    fill_in "user[company_attributes][name]",   with: "New Company"
    fill_in "user[full_name]",                  with: "Bruce Wayne"
    fill_in "user[email]",                      with: "bruce@thehulk.com"
    fill_in "user[password]",                   with: "123123123"
    fill_in "user[password_confirmation]",      with: "123123123"
 
    click_button "Sign up"
 
    last_user = User.last
    open_email(last_user.email)
    current_email.click_on "Confirm my account"
 
    expect(page).to have_content("Your account was successfully confirmed.")
    expect(current_path).to eql(new_user_session_path)
    expect(last_user.reload).to be_confirmed
  end

  scenario "signing up for an account with invalid data" do
    click_on "Sign up"

    expect(User.count).to eql(0)
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")

    expect(current_path).to eql('/users')
    expect(last_email).to be_nil
  end

  scenario "signing up with an existing email account" do
    user = create(:user)
    ActionMailer::Base.deliveries.clear

    fill_in "user[company_attributes][name]",   with: "New Company"
    fill_in "user[full_name]",                  with: "Bruce Wayne"
    fill_in "user[email]",                      with: user.email
    fill_in "user[password]",                   with: "123123123"
    fill_in "user[password_confirmation]",      with: "123123123"

    click_on "Sign up"

    expect(User.count).to eql(1)
    expect(page).to have_content("Email has already been taken")
    expect(current_path).to eql("/users")
    expect(last_email).to be_nil
  end
end
