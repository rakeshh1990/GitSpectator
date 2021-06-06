class GithubApi
  def initialize(access_token)
    @access_token = access_token
    @auth_token = "token #{access_token}"

    response = RestClient.get('https://api.github.com/user', { params: { access_token: @access_token }, Authorization: @auth_token, accept: :json })

    @user_details = JSON.parse(response)
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
end
