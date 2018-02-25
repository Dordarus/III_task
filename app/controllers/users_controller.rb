class UsersController < ApplicationController
  before_action :authentocated!, only: [:edit]
  def show
    @provider = current_user.providers.find_by(provider: 'github')
    if !@provider.nil?
      client = Octokit::Client.new(:access_token => @provider.oauth_token)
      @repositories = client.repos
    end
  end

  def edit
  end
end
