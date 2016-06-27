require 'csv'
require_relative 'user'

class UserCollection

  attr_accessor :users

  HEADERS = ["login", "name", "location", "repo_count"]

  def initialize
    @users = []
  end

  def write_to_csv(file)
    CSV.open(file, "w", write_headers: true, headers: HEADERS) do |csv|
      @users.each do |user|
        csv << [user.login, user.name, user.location, user.repo_count]
      end
    end
  end
end