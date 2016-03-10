require_relative 'github_getter'
require_relative 'csv_writer'
require_relative 'user'
require_relative 'controller'


# controller = Controller.new
# controller.choose_authentication
# controller.choose_parameters

corey = User.new(login: "cgrad01")
bry = User.new(login: "brynary")
users = [corey, bry]
getter = GithubGetter.new(username: "cgrad01", password: "ogle9hued")
query_string = getter.make_query_string(users)
repos = getter.get_repos(query_string)
getter.count_repos(users, repos)
p corey.repos.length
p bry.repos.length
