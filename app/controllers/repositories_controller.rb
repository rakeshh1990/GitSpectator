class RepositoriesController < ApplicationController

  def index
    @user_repos = @github_api_object.get_repos
  end

  def show
    @chart_data = @github_api_object.get_repo_commits(params.require(:id))
  end

end
