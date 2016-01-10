# -*- encoding : utf-8 -*-
lock '3.3.5'

set :scm, :git
set :repo_url, 'git@github.com:seairy/Osmanthus.git'
set :keep_releases, 5
set :linked_files, %w{config/database.yml config/settings.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/system}
set :use_sudo, false

namespace :deploy do
  namespace :passenger do
    desc 'Restart passenger server'
    task :restart do
      on roles(:app) do
        within current_path do
          execute :touch, 'tmp/restart.txt'
        end
      end
    end
  end
end
after 'deploy', 'deploy:passenger:restart'