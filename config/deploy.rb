# config valid for current version and patch releases of Capistrano
lock "~> 3.9.1"

set :application, "sample_app"
set :repo_url, "git@github.com:vovantra1198/sample_app.git"

append :linked_files, 'config/database.yml', 'config/secrets.yml', '.env'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets'


set :keep_releases, 3
after 'deploy:finished', 'unicorn_action:restart'