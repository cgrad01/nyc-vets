require_relative 'github_getter'

test = GithubGetter.new()
dudes = JSON.parse(test.ny_search)

dudes["items"][0..10].each do |dude|
  p dude["login"]
end
