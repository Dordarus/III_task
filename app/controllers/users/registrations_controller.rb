class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [profile_attributes: [:name, :role]])
    devise_parameter_sanitizer.permit(:account_update, keys: [profile_attributes: [:name, :role]])
  end
 
  def update_resource(resource, params)
    if ['facebook', 'linkedin'].include?(current_user.profile.current_provider)
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end