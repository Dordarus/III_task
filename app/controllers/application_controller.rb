class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_for_profile_user
    redirect_to users_path if current_user.profile_user?
  end

  def check_for_default_user
    redirect_to users_path if current_user.user?
  end
end
