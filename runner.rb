require_relative 'github_getter'
require_relative 'csv_writer'
require_relative 'user'
require_relative 'controller'

controller = Controller.new
controller.choose_authentication
controller.choose_parameters
GithubGetter.show_rate_limits