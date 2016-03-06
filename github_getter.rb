require 'csv'
require 'net/http'
require 'json'

class GithubGetter

  BASE_URL = "https://api.github.com"

  def initialize (username, password, args = {})
    @username = username
    @password = password
    @args = args
  end

  def get
    uri = URI(BASE_URL)
    req = Net::HTTP::Get.new(uri)
    req.basic_auth @username, @password
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) {|http|
      http.request(req)}
  end
end
