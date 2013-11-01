class Users::InvitationsController < Devise::InvitationsController
  before_filter :user_correct

  def user_correct
    if user_signed_in?
      redirect_to root_path, notice: "You don't have the privileges to access this feature." unless current_user.manager 
    end
  end

  private
  def invite_params
     super.merge(company_id: current_company.id)
  end
end
