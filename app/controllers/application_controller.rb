class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def check_author
    if current_user.profile.author? 
      then redirect_to users_path
      danger_flash
    end
  end
  
  def check_reader
    if current_user.profile.reader? 
      then redirect_to books_path
      danger_flash
    end
  end
  
  private

  def danger_flash
    flash[:danger] = "Access is denied because you are #{current_user.profile.role}. You do not have access rights"
  end
  
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
