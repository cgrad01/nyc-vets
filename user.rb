class User

  attr_accessor :login, :name, :location, :repo_count, :repos

  def initialize(args = {})
    @login = args[:login]
    @name = args[:name]
    @location = args[:location]
    @repo_count = args[:repo_count]
  end

  def self.create_users(profiles)
    output = []
    profiles.each do |profile|
      output << User.new({login: profile["login"], name: profile["name"], location: profile["location"]})
    end
    output
  end

end