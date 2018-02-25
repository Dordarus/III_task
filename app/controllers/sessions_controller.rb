class SessionsController < Devise::SessionsController
  def destroy
    current_user.update({current_provider: ""})
    super
  end
end
