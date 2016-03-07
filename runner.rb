require_relative 'github_getter'
require_relative 'csv_writer'
require_relative "user"

users = []
test = GithubGetter.new()
writer = CSVWriter.new
dudes = JSON.parse(test.ny_search)["items"][0..9]

test.get_profiles(dudes).each do |user|
  users << User.new({login: user["login"], name: user["name"], location: user["location"]})
end

writer.write(users)

puts "done"