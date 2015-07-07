class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	skip_before_action :require_login

	def facebook
		@user = User.from_omniauth(request.env["omniauth.auth"])

		if @user.persisted?
			flash[:success] = "Success"
			sign_in_and_redirect @user
		else
			session["devise.facebook_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url
		end
	end
end
