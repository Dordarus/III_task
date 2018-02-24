class UsersController < ApplicationController
  before_action :authentocated!, only: [:edit]
  def show
  end

  def edit
  end
end
