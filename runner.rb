require_relative 'github_getter'

test = GithubGetter.new()
p JSON.parse(test.search_users)