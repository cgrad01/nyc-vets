require 'csv'
require 'net/http'
require 'json'

class GithubGetter

  BASE_URL = "https://api.github.com"

  SEARCH_URL = "https://api.github.com/search/users?q=location%3A%22new+york%22&sort=joined&order=asc"

  def initialize (username, password, args = {})
    @username = username
    @password = password
    @args = args
    @users = []
  end

  def get_users
    uri = URI(BASE_URL + "/users")
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

  def filter_by_location(location)
    @users.delete_if{|user|
      !(user["location"].to_s.upcase.include?(location.upcase))
    }
    @users
  end

  def search_users
    uri = URI(SEARCH_URL)
    req = Net::HTTP::Get.new(uri)
    req.basic_auth @username, @password
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) {|http|
      http.request(req).body
    }
  end

end
