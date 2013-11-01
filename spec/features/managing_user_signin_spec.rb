require "spec_helper"

feature "Manage Users it displays" do
  scenario "with manager user sign in" do
    user = create(:user, :confirmed, :as_manager)  
    login_with(user)

    visit root_path

    expect(current_path).to eql(root_path)
    expect(page).to have_content("Manage Users")
  end

  scenario "with user sign in" do
    user = create(:user, :confirmed)
    login_with(user)

    visit root_path

    expect(current_path).to eql(root_path)
    expect(page).to_not have_content("Manage Users")
  end
end
