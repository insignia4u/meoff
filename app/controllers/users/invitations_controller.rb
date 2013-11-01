class Users::InvitationsController < Devise::InvitationsController
  before_filter :check_user_privileges, only: [:new]

  def check_user_privileges
    unless current_user.try(:manager?)
      redirect_to root_path, notice: "You don't have the privileges to access this feature."
    end
  end

  private
  def invite_params
     super.merge(company_id: current_company.id)
  end
end
