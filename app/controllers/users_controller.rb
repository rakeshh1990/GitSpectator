class UsersController < ApplicationController
  def index
    access_token = session[:access_token]

    @auth_result = GithubApi.new(access_token).get_user_details
    @user_repos = GithubApi.new(access_token).get_repos
    @user_projects = GithubApi.new(access_token).get_projects
  end
end
