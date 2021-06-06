class LoginController < ApplicationController
  skip_before_action :authorize

  def github_authorize
    @client_id = ENV['GH_BASIC_CLIENT_ID']
  end

  def github_callback
    session_code = params[:code]

    # ... and POST it back to GitHub
    result = RestClient.post('https://github.com/login/oauth/access_token',
                             { client_id: ENV['GH_BASIC_CLIENT_ID'],
                               client_secret: ENV['GH_BASIC_SECRET_ID'],
                               code: session_code },
                             accept: :json)

    if result.code == 200
      result = JSON.parse(result.body)

      unless result['error']
        # extract token and granted scopes
        p access_token = result['access_token']
        scopes = result['scope'].split(',')

        session[:access_token] = access_token
        session[:scopes] = scopes
      end
    end

    redirect_to root_path
  end

  def logout
    session[:access_token] = nil
    session[:scopes] = nil

    redirect_to root_path
  end
end
