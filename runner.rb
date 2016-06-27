require_relative 'github_getter'
require_relative 'user_collection'
require_relative 'user'
# require_relative 'controller'

def choose_authentication
  puts "In order to run an authenticated github request, you must input your username and password, you can choose to run an unauthenticated request, but you will be limited in the amount of requests you can make."
  puts "Would you like to run an authenticated request?"
  puts "Y/N:"
  response = $stdin.gets.chomp.upcase
  if response == "Y"
    authenticate
  elsif response == "N"
    dont_authenticate
  else
    puts "invalid response"
    choose_authentication
  end
end

def choose_parameters
  puts "A DEFAULT request will run as the instructions intended, a CUSTOM request will allow you to alter some parameters"
  puts "please choose DEFAULT or CUSTOM request"
  type = $stdin.gets.chomp.upcase
  if type == "DEFAULT"
    default
  elsif type == "CUSTOM"
    custom
  else
    puts "invalid response"
    choose_parameters
  end
  puts "output.csv is ready"
end


def authenticate
  puts "Please input your github username:"
  username = $stdin.gets.chomp
  puts "And password:"
  password = $stdin.gets.chomp
  @getter = GithubGetter.new(username: username, password: password)
  @collection = UserCollection.new
end

def dont_authenticate
  @getter = GithubGetter.new
  @collection = UserCollection.new
end

def default
  results = @getter.search("new york", 10)
  profiles = @getter.get_profiles(results)
  @collection.users = User.create_users(profiles)
  @getter.get_repo_counts(@collection.users)
  @collection.write_to_csv("output.csv")
end

def custom
  puts "Input the name of the city you would like to search:"
  location = $stdin.gets.chomp
  results = @getter.search(location, validate_number)
  profiles = @getter.get_profiles(results)
  @collection.users = User.create_users(profiles)
  @getter.get_repo_counts(@collection.users)
  @collection.write_to_csv("output.csv")
end

def validate_number
  puts "Pick the number of results you would like to receive (between 1 & 20):"
  number = $stdin.gets.chomp.to_i
  if number >= 1 && number <= 20
    number
  else
    puts "invalid number"
    validate_number
  end
end

choose_authentication
choose_parameters
@getter.show_rate_limits