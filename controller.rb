

class Controller

  def authenticate
    puts "Please input your github username:"
    username = $stdin.gets.chomp
    puts "And password:"
    password = $stdin.gets.chomp
    @getter = GithubGetter.new(username, password)
    @writer = CSVWriter.new
  end

  def choose_parameters
    puts "A DEFAULT request will run as the instructions intended, a CUSTOM request will allow you to alter some parameters"
    puts "please choose DEFAULT or CUSTOM request"
    type = $stdin.gets.chomp.upcase
    if type == "DEFAULT"
      default
    end
    puts "output.csv is ready"
  end

  def default
    results = @getter.ny_search
    profiles = @getter.get_profiles(results)
    users = User.create_users(profiles)
    @getter.get_repo_counts(users)
    @writer.write(users)
  end

  def custom
  end

end