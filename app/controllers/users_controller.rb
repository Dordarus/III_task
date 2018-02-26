class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  before_action -> { check_id(:id) }
  respond_to :html, :json

  def show
    if !provider.nil?
      client = Octokit::Client.new(:access_token => provider.oauth_token)
      @repositories = client.repos
      respond_with({user: set_user, repositories: @repositories, notice: "GitHub account is already binded"}, status: 200)
    else
      respond_with({user:set_user, notice: "User hasn't linked a GitHub account yet"}, status: 200)
    end
  end

  def edit
  end

  private

  def provider
    @provider = set_user.providers.find_by(provider: 'github')
  end

  def set_user
    user = User.find_by(id: params[:id])
  end

  def check_id(arg)
    if set_user.nil?
      render_404
    end
  end
  
  def render_404
    respond_to do |format|
      format.html {render file: "#{Rails.root}/public/404.html", layout: false, status: 404}
      format.json {render json: {}, status: 404}
    end
  end
end
