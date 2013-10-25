class Users::InvitationsController < Devise::InvitationsController
  private
  def invite_params
     super.merge(company_id: current_company.id)
  end
end
