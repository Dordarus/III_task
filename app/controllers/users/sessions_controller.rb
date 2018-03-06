class Users::SessionsController < Devise::SessionsController
  def destroy
    current_user.profile.update({current_provider: ""})
    super
  end
end
