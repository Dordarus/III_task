class Auth::CallbacksController < Devise::OmniauthCallbacksController

	def provider
		user = User.create_from_omniauth(omniauth_params, true)
    sign_in_and_redirect user, event: :authentication if user.persisted?
	end

	def github
		user = User.create_from_omniauth(omniauth_params, false)
		redirect_to user
	end

  def failure
    redirect_to root_path
	end
	
	alias_method :linkedin, :provider
	alias_method :facebook, :provider

	private

	def omniauth_params
		request.env["omniauth.auth"]
	end
end