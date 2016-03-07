class User

  attr_accessor :login, :name, :location, :repo_count

  def initialize(args = {})
    @login = args[:login]
    @name = args[:name]
    @location = args[:location]
    @repo_count = args[:repo_count]
  end

end