class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :dany_access, except: [:index]
  respond_to :html, :json

  def index 
    @users = User.all
  end

  def show
    @signed_user = signed_user?
    @provider = set_user.providers.find_by(provider: 'github')
    if !@provider.nil?
      client = Octokit::Client.new(:access_token => @provider.oauth_token)
      @repositories = client.repos
      respond_with({user: set_user, repositories: @repositories, notice: "GitHub account is already binded"}, status: 200)
    else
      respond_with({user:set_user, notice: "User hasn't linked a GitHub account yet"}, status: 200)
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def signed_user?
    set_user == current_user
  end

  def dany_access
    if !same_roles? && !signed_user?
      redirect_to root_path, :alert => "Access denied."
    end
  end

  def same_roles?
    set_user.role == current_user.role
  end

  def set_user
    user = User.find_by(id: params[:id])
  end
end
