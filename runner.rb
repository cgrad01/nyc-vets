require_relative 'github_getter'
require_relative 'csv_writer'

test = GithubGetter.new("cgrad01", "ogle9hued")
writer = CSVWriter.new
dudes = JSON.parse(test.ny_search)["items"][0..10]







# test.get_profiles(dudes).each do |user|
#   p user["login"]
#   p user["location"]
#   p user["public_repos"]
# end
