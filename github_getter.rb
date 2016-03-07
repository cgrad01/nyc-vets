require 'csv'
require 'net/http'
require 'json'

class GithubGetter

  SEARCH_URL = "https://api.github.com/search/users?q=location%3A%22new+york%22&sort=joined&order=asc"

  def initialize (username, password)
    @username = username
    @password = password
    @users = []
  end

  def ny_search
    uri = URI(SEARCH_URL)
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

end
