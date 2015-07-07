class RegistrationsController < Devise::RegistrationsController
	skip_before_action :require_login, :only => [:new, :create]

	protected

	def after_sign_up_path_for(resource)
		"/"
	end
end