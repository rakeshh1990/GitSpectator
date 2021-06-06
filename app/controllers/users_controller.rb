class UsersController < ApplicationController

  def index
    @user_repos = @github_api_object.get_repos
    @user_projects = @github_api_object.get_projects
  end
end
