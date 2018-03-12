class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :dany_access, except: [:index]
  before_action :set_user, only: [:show]
  respond_to :html, :json

  def index 
    if current_user.profile.reader?
      @users = users_by_role("author")
    else 
      @users = users_by_role("reader")
    end
    if @users.empty? then @role = "No records found" else @role = @users.first.profile.role.capitalize.pluralize  end  
  end
  
  def show
  end

  private

  def current_user_profile?
    set_user  == current_user  
  end

  def users_by_role(role) 
    u_id = Profile.where(role: role).pluck(:user_id)
    return User.find(u_id)
  end

  def subscription
    if !current_user.allow_user?
      redirect_to new_charge_path, alert: "Access denied. To be able to view authors profiles, buy a subscription."
    end
  end
  
  def dany_access
    if !current_user_profile?
      if current_user.profile.author? 
        redirect_to user_path(current_user), alert: "Access denied. You are login as author, you can't view another profiles"
      elsif set_user.profile.author?
        subscription
      else
        redirect_to user_path(current_user), alert: "Access denied. You are login as reader, you can't view another readers profiles"
      end
    end
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
