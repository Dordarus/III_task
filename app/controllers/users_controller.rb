class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  respond_to :html, :json

  def show
    #byebug
    if !current_user.nil?
      @provider = current_user.providers.find_by(provider: 'github')
     # byebug
      if !@provider.nil?
        client = Octokit::Client.new(:access_token => @provider.oauth_token)
        @repositories = client.repos
       # byebug
      end
    end
  end

  def edit
  end
end
