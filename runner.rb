require_relative 'github_getter'

test = GithubGetter.new("cgrad01", "ogle9hued")
users = JSON.parse(test.get_users)
test.get_profiles(users[0..200])
p test.filter_by_location("New York")
