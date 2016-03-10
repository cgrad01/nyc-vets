require 'net/http'
require 'json'

class GithubGetter

  BASE_URL = "https://api.github.com"

  NY_SEARCH_URL = "https://api.github.com/search/users?q=location%3A%22new+york%22&sort=joined&order=asc"

  def initialize (args = {})
    @username = args[:username]
    @password = args[:password]
    @profiles = []
    @repos = []
  end

  def get(url)
    uri = URI(url)
    req = Net::HTTP::Get.new(uri)
    if @username && @password
      req.basic_auth @username, @password
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true){|http| http.request(req).body}
    else
      res = Net::HTTP.get(uri)
    end
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

  def make_query_string(users)
    @query_string = ""
    users.each do |user|
      @query_string += "+user:#{user.login}"
    end
    @query_string
  end

  def get_repos(query_string)
    @repos = JSON.parse(get("https://api.github.com/search/repositories?q=#{@query_string}+created:%3E2015-01-01T00:00:00z"))["items"]
  end

  def count_repos(users, repos)
    users.each do |user|
      assign_repos(user, repos)
    end
  end

  def assign_repos(user, repos)
    repos.each do |repo|
      if user.login == repo["owner"]["login"]
        user.repos << repo
      end
    end
  end
end
