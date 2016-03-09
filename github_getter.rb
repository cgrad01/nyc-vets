require 'net/http'
require 'json'

class GithubGetter

  BASE_URL = "https://api.github.com"

  NY_SEARCH_URL = "https://api.github.com/search/users?q=location%3A%22new+york%22&sort=joined&order=asc"

  def initialize (username, password)
    @username = username
    @password = password
    @profiles = []
  end

  def get(url)
    uri = URI(url)
    req = Net::HTTP::Get.new(uri)
    req.basic_auth @username, @password
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true){|http| http.request(req).body}
  end

  def ny_search
    JSON.parse(get(NY_SEARCH_URL))["items"][0..9]
  end

  def get_profiles(results)
    results.each {|result|
      @profiles << JSON.parse(get(BASE_URL + "/users" + "/#{result["login"]}"))
    }
    @profiles
  end

  def get_repo_counts(users)
    users.each do |user|
      user.repo_count = JSON.parse(get("https://api.github.com/search/repositories?q=+user:#{user.login}+created:%3E2015-01-01T00:00:00z"))["total_count"]
    end
  end

end
