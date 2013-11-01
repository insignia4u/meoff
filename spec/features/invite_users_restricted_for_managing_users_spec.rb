require "spec_helper"

feature "Invitation users" do
  scenario "access granted to manager users" do
    user = create(:user, :confirmed, :as_manager)  
    login_with(user)

    visit new_user_invitation_path

    expect(current_path).to eql(new_user_invitation_path)
    expect(page).to have_content("Send invitation")
  end

  scenario "access denied to invite users" do
    user = create(:user, :confirmed)
    login_with(user)

    visit new_user_invitation_path

    expect(current_path).to eql(root_path)
    expect(page).to have_content("You don't have the privileges to access this feature")
  end
end
