class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  include Users::OmniauthCallbacksHelper

  def amazon
    omniauth_authentication
  end

  def facebook
    omniauth_authentication
  end

  def github
    omniauth_authentication
  end

  def google_oauth2
    omniauth_authentication
  end

  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
