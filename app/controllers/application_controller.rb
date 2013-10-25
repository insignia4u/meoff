class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :full_name,
        :email, :password, :password_confirmation, :company_attributes => (:name))
    end

    devise_parameter_sanitizer.for(:invite) do |u|
      u.permit(:full_name, :email, :invitation_token)
    end    

    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:full_name, :password, :password_confirmation, :invitation_token)
    end
  end

  def after_sign_in_path_for(resource)
    notifications_path
  end

  def current_company
  	return nil unless current_user

  	@current_company ||= current_user.company
  end
  helper_method :current_company
end
