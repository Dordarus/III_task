class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :dany_access, except: [:index]
  before_action :set_user, only: [:show]
  respond_to :html, :json

  def index 
    if current_user.profile.profile_user?
      @users = User.all
    else
      uid = Profile.where(role: "profile_user").pluck(:user_id)
      @users = User.find(uid)
    end
  end

  def show
    @same_users = same_users?
    @provider = set_user.providers.find_by(provider: 'github')
    if !@provider.nil?
      client = Octokit::Client.new(access_token: @provider.oauth_token)
      @repositories = client.repos
      respond_with({user: set_user, repositories: @repositories, notice: "GitHub account is already binded"}, status: 200)
    else
      respond_with({user: set_user, notice: "User hasn't linked a GitHub account yet"}, status: 200)
    end
  end

  private

  def same_users?
    set_user == current_user
  end

  def subscription
    if !current_user.allow_user?
      redirect_to new_charge_path, alert: "Access denied. To be able to view profiles, buy a subscription."
    end
  end

  def dany_access
    if !same_users?
      if current_user.profile.profile_user? 
        redirect_to user_path(current_user), alert: "Access denied. You are 'profile user', you can't view another profiles"
      else
        if set_user.profile.profile_user?
          subscription
        else
          redirect_to user_path(current_user), alert: "Access denied. You are 'user', you can't view another 'user' profiles"
        end
      end
    end
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
