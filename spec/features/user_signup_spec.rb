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
    
    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(current_path).to eql(root_path)
  end

  scenario "signing up for an account with invalid data" do
    click_on "Sign up"

    expect(User.count).to eql(0)
    expect(current_path).to eql('/users')
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

  scenario "signing up with an existing email account" do
    user = create(:user)

    fill_in "user[company_attributes][name]",   with: "New Company"
    fill_in "user[full_name]",                  with: "Bruce Wayne"
    fill_in "user[email]",                      with: user.email
    fill_in "user[password]",                   with: "123123123"
    fill_in "user[password_confirmation]",      with: "123123123"

    click_on "Sign up"

    expect(User.count).to eql(1)
    expect(page).to have_content("Email has already been taken")
    expect(current_path).to eql("/users")
  end
end
