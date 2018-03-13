class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def check_author
    redirect_to users_path if current_user.profile.author? 
  end
  
  def check_reader
    redirect_to books_path if current_user.profile.reader? 
  end
  
  private
  
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
