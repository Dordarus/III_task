class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_profile_user
    redirect_to users_path if current_user.profile.profile_user?
  end

  def check_default_user
    redirect_to users_path if current_user.profile.user?
  end
end
