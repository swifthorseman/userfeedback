class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Rails 4.0 and Devise With Strong Params and Custom Fields
  # http://gorails.com/blog/rails-4-0-and-devise-with-strong-params-and-custom-fields
  # check to see if the current controller processing the request is one from Devise.
  # If it is, then we override the parameters that are allowed.
  before_filter :configure_permitted_parameters, if: :devise_controller?


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| 
      u.permit(:full_name, :profile_name, :email, :password, :password_confirmation) 
    }

    devise_parameter_sanitizer.for(:account_update) { |u| 
      u.permit(:full_name, :profile_name, :email, :password, :password_confirmation, :current_password)
    }

    # for devise invitable
    # devise_parameter_sanitizer.for(:accept_invitation).concat [:full_name, :profile_name]
  end
end
