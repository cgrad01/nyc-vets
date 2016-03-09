require_relative 'github_getter'
require_relative 'csv_writer'
require_relative "user"

puts "Would you like to run an authenticated search (Y/N)?"
auth = $stdin.gets.chomp.upcase
if auth == "Y"
  puts "Please input your github username and password"
  login_info = $stdin.gets.chomp.split(" ")
  getter = GithubGetter.new(login_info.first, login_info.last)
  writer = CSVWriter.new
else
  getter = GithubGetter.new
  writer = CSVWriter.new
end
puts "A DEFAULT request will run as the instructions intended, a CUSTOM request will allow you to alter some of the assignment parameters"
puts "please choose DEFAULT or CUSTOM request"
type = $stdin.gets.chomp.upcase
if type == "DEFAULT"
  results = getter.ny_search
  profiles = getter.get_profiles(results)
  users = User.create_users(profiles)
  getter.get_repo_counts(users)
  writer.write(users)
  puts "output.csv is ready"
end