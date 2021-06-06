class GithubApi
  def initialize(access_token)
    @access_token = access_token
    @auth_token = "token #{access_token}"

    response = RestClient.get('https://api.github.com/user', { params: { access_token: @access_token }, Authorization: @auth_token, accept: :json })

    @user_details = JSON.parse(response)
  rescue
    false
  end

  # fetch user information
  def get_user_details
    @user_details
  end

  def get_repos
    url = "https://api.github.com/users/#{@user_details['login']}/repos"
    response = RestClient.get(url, { params: { access_token: @access_token }, Authorization: @auth_token, accept: :json })

    JSON.parse(response)
  end

  def get_projects
    url = "https://api.github.com/users/#{@user_details['login']}/projects"
    response = RestClient.get(url, { params: { access_token: @access_token }, Authorization: @auth_token, accept: 'application/vnd.github.inertia-preview+json' })

    JSON.parse(response)
  end

  def get_repo_commits(repo_name)
    url = "https://api.github.com/repos/#{@user_details['login']}/#{repo_name}/commits"
    response = RestClient.get(url, { params: { access_token: @access_token }, Authorization: @auth_token, accept: 'application/vnd.github.inertia-preview+json' })

    commits_data = JSON.parse(response)

    chart_data = []
    commits_data.group_by { |commit| commit['commit']['author']['name'] }.each do |author, commit|
      chart_data << [author, commit.length]
    end

    chart_data
  end
end
