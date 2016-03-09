require_relative 'github_getter'
require_relative 'csv_writer'
require_relative "user"

test = GithubGetter.new()
writer = CSVWriter.new
results = test.ny_search
profiles = test.get_profiles(results)
users = User.create_users(profiles)
test.get_repo_counts(users)
writer.write(users)

puts "done"