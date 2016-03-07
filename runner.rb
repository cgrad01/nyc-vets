require_relative 'github_getter'

test = GithubGetter.new()
dudes = JSON.parse(test.search_users)

dudes["items"][0..10].each do |dude|
  p dude["login"]
end
