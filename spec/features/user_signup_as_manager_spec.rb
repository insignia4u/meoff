require "spec_helper"

feature "User Signup" do
  background do
    visit new_user_registration_path
  end

  scenario "for an account as manager with valid data" do
    fill_in "user[company_attributes][name]",   with: "Wayne Inc."
    fill_in "user[full_name]",                  with: "Bruce Wayne"
    fill_in "user[email]",                      with: "bruce@wayne.com"
    fill_in "user[password]",                   with: "123123123"
    fill_in "user[password_confirmation]",      with: "123123123"

    click_on "Sign up"

    expect(User.where(email: "bruce@wayne.com")).to exist
    expect(Company.where(name: "Wayne Inc.")).to exist
    expect(Company.where(name: "Wayne Inc.").first.users).to include(User.where(email:"bruce@wayne.com").first)
    expect(User.last.manager).to eql(true)    
    expect(page).to have_content("A message with a confirmation link has been sent")
    expect(current_path).to eql(root_path)
  end
end
