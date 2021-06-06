class ApplicationController < ActionController::Base
  before_action :authorize

  private

  def authorize
    redirect_to authorize_path if session[:access_token].nil?
  end
end
