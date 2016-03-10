require_relative 'github_getter'
require_relative 'csv_writer'
require_relative 'user'
require_relative 'controller'


controller = Controller.new
controller.authenticate
controller.choose_parameters