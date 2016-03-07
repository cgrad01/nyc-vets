require 'csv'
require_relative 'user'

class CSVWriter

  HEADERS = ["login", "name", "location", "repo_count"]

  def initialize
  end

  def write(users)
    CSV.open("output.csv", "wb") do |csv|
      csv << HEADERS
      users.each do |user|
        csv << [user.login, user.name, user.location, user.repo_count]
      end
    end
  end

end