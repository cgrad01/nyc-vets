require 'net/http'
require 'json'

class GithubGetter

  BASE_URL = "https://api.github.com"

  NY_SEARCH_URL = "https://api.github.com/search/users?q=location%3A%22new+york%22&sort=joined&order=asc"

  def initialize (username, password)
    @username = username
    @password = password
    @users = []
  end

  def ny_search
    uri = URI(NY_SEARCH_URL)
    req = Net::HTTP::Get.new(uri)
    req.basic_auth @username, @password
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) {|http|
      http.request(req).body
    }
  end

  def get_profiles(users)
    users.each {|user|
      uri = URI(BASE_URL + "/users" + "/#{user["login"]}")
      req = Net::HTTP::Get.new(uri)
      req.basic_auth @username, @password
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) {|http|
        @users << JSON.parse(http.request(req).body)
      }
    }
    @users
  end

  # experiment with query string to get the accurate repo response given time restraints
  # this works for two users:
  # https://api.github.com/search/repositories?q=+user:cgrad01+user:brynary+created:%3E2015-01-01T00:00:00z
  def get_repo_counts(users)
    users.each do |user|
      uri = URI("https://api.github.com/search/repositories?q=+user:#{user.login}+created:%3E2015-01-01T00:00:00z")
      req = Net::HTTP::Get.new(uri)
      req.basic_auth @username, @password
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) {|http|
        user.repo_count = JSON.parse(http.request(req).body)["total_count"]
      }
    end
  end

end
