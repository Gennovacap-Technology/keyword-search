class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate

  # Returns the API version in use.
    def get_api_version()
      return TargetingIdeaService.api_version
    end

    # Returns currently selected account.
    def selected_account
      @selected_account ||= session[:selected_account]
      return @selected_account
    end

    # Sets current account to the specified one.
    def selected_account=(new_selected_account)
      @selected_account = new_selected_account
      session[:selected_account] = @selected_account
    end

    # Checks if we have a valid credentials.
    def authenticate()
      token = session[:token]
      redirect_to authorizations_login_path if token.nil?
      return !token.nil?
    end

    # Returns an API object.
    def get_adwords_api
      @api ||= create_adwords_api()
      return @api
    end

    # Creates an instance of AdWords API class. Uses a configuration file and
    # Rails config directory.
    def create_adwords_api()
      @api = AdwordsApi::Api.new({
              :authentication => {
                :method => 'OAuth2',
                :oauth2_client_id => ENV.fetch("OAUTH2_CLIENT_ID") ,
                :oauth2_client_secret => ENV.fetch("OAUTH2_CLIENT_SECRET"),
                :developer_token => ENV.fetch("DEVELOPER_TOKEN"),
                :user_agent => ""
              },
              :service => {
                :environment => 'PRODUCTION'
              }
            })

      token = session[:token]
      # If we have an OAuth2 token in session we use the credentials from it.
      if token
        credentials = @api.credential_handler()
        credentials.set_credential(:oauth2_token, token)
        credentials.set_credential(:client_customer_id, selected_account)
      end
      return @api
    end
end
