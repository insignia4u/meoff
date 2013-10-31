class RegistrationsController < Devise::RegistrationsController
  private
  def sign_up_params
     super.merge(manager: true)
  end
end 
