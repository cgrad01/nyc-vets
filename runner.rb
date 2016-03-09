require_relative 'github_getter'
require_relative 'csv_writer'
require_relative "user"

users = []
test = GithubGetter.new()
writer = CSVWriter.new
dudes = test.ny_search(10)
test.get_profiles(dudes).each do |user|
  users << User.new({login: user["login"], name: user["name"], location: user["location"]})
end
test.get_repo_counts(users)

writer.write(users)

puts "done"