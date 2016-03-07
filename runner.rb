require_relative 'github_getter'
require_relative 'csv_writer'
require_relative "user"

test = GithubGetter.new()
writer = CSVWriter.new
writer.write_headers
dudes = JSON.parse(test.ny_search)["items"][0..1]

test.get_profiles(dudes).each do |user|
  guy = User.new({login: user["login"], name: user["name"], location: user["location"]})
  p guy
end

# cor = User.new({login: "cgrad01", name: "Corey Grad"})
# cor.repo_count = 25