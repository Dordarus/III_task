class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_author
    redirect_to root_path if current_user.profile.author?
  end

  def check_reader
    redirect_to root_path if current_user.profile.reader?
  end
end
