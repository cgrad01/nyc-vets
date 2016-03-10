class Controller

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

  def authenticate
    puts "Please input your github username:"
    username = $stdin.gets.chomp
    puts "And password:"
    password = $stdin.gets.chomp
    @getter = GithubGetter.new(username: username, password: password)
    @writer = CSVWriter.new
  end

  def dont_authenticate
    @getter = GithubGetter.new
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