class User

  attr_accessor :login, :name, :location, :repo_count, :repos

  def initialize(args = {})
    @login = args[:login]
    @name = args[:name]
    @location = args[:location]
    @repo_count = args[:repo_count]
    @repos = []
  end

  def self.create_users(profiles)
    profiles.each_with_object([]) do |profile, array|
      array << User.new({login: profile["login"], name: profile["name"], location: profile["location"]})
    end
  end
end