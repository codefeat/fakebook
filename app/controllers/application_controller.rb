class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :configure_permitted_parameters, if: :devise_controller?


protected

  	def configure_permitted_parameters
    	devise_parameter_sanitizer.for(:sign_up) << :first_name
    	devise_parameter_sanitizer.for(:sign_up) << :last_name
  	end

private

	def require_login
		unless current_user
			flash[:error] = "You must log in to use the site"
			redirect_to root_path
		end
	end
end
