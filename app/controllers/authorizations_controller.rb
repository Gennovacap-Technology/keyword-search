class AuthorizationsController < ApplicationController

  skip_before_action :authenticate

  GOOGLE_LOGOUT_URL = 'https://www.google.com/accounts/Logout'

  def login
    api = get_adwords_api

    if session[:token]
      redirect_to keywords_path
    else
      begin
        token = api.authorize({:oauth2_callback => authorizations_callback_url})
      rescue AdsCommon::Errors::OAuth2VerificationRequired => e
        @login_url = e.oauth_url
      end
    end
  end

  def callback
    api = get_adwords_api
    begin
      session[:token] = api.authorize(
        {
          :oauth2_callback => authorizations_callback_url,
          :oauth2_verification_code => params[:code]
        }
      )
      flash.notice = 'Authorized successfully'
      redirect_to accounts_path
    rescue AdsCommon::Errors::OAuth2VerificationRequired => e
      flash.alert = 'Authorization failed'
      redirect_to authorizations_login_path
    end
  end

  def logout
    [:selected_account, :token].each {|key| session.delete(key)}
    redirect_to GOOGLE_LOGOUT_URL
  end
end
