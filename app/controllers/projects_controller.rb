class ProjectsController < ApplicationController

  def index
    @user_projects = @github_api_object.get_projects
  end
end
