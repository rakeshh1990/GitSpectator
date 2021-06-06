class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :github_api_object, :get_user_details, if: -> { session[:access_token].present? }

  private

  def authorize
    redirect_to authorize_path if session[:access_token].nil?
  end

  def get_user_details
    @current_user = @github_api_object.get_user_details

    if @current_user.nil?
      session[:access_token] = nil
      redirect_to root_path
    end
  end

  def github_api_object
    @github_api_object ||= GithubApi.new(session[:access_token])
    if @github_api_object.nil?
      session[:access_token] = nil
      redirect_to root_path
    end
  end
end
