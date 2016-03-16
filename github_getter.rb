require 'net/http'
require 'json'

class GithubGetter

  BASE_URL = "https://api.github.com"

  def initialize (args = {})
    @username = args[:username]
    @password = args[:password]
    @profile_results= []
    @repo_results = []
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

  def search(location, number)
    JSON.parse(get("https://api.github.com/search/users?q=location%3A%22#{location.gsub(/\s/,'+')}%22&sort=joined&order=asc"))["items"][0..number-1]
  end

  # above returns an array, below takes and returns array

  def get_profiles(results)
    results.each_with_object([]) {|result, array|
      @profile_results = array << JSON.parse(get(BASE_URL + "/users" + "/#{result["login"]}"))
    }
  end

  def make_query_string(users)
    @query_string = ""
    users.each_with_object("") {|user, string|
      @query_string += "+user:#{user.login}"
    }
    @query_string
  end

  def get_repos(query_string)
    @repo_results = JSON.parse(get("https://api.github.com/search/repositories?q=#{@query_string}+created:%3E2015-01-01T00:00:00z"))["items"]
  end

  def count_repos(users, repos)
    users.each {|user|
      assign_repos(user, repos)
    }
  end

  def assign_repos(user, repos)
    repos.each {|repo|
      if user.login == repo["owner"]["login"]
        user.repos << repo["name"]
      end
    }
    user.repo_count = user.repos.length
  end

  def get_repo_counts(users)
    q_string = make_query_string(users)
    get_repos(q_string)
    count_repos(users, @repo_results)
  end

  def self.show_rate_limits
    uri = URI("https://api.github.com/rate_limit")
    res = Net::HTTP.get(uri)
    core_remaining = JSON.parse(res)["resources"]["core"]["remaining"]
    search_remaining = JSON.parse(res)["resources"]["search"]["remaining"]
    puts ""
    puts "You have #{core_remaining} out of 60 unauthenticated requests remaining, and #{search_remaining} out 10 unauthenticated search requests remaining. If either of these numbers reach zero, your previous search may have been incomplete."
  end
end
