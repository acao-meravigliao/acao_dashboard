require 'mina/bundler'
require 'mina/rails'
require 'mina/simple'

# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
# require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :user, 'yggdra'
set :domain, 'lino.acao.it'
set :deploy_to, '/opt/acao_dashboard/frontend'

set :shared_paths, [ 'log', ]
set :exclude, [ '.git', 'tmp/*', ]
set :bundle_options, lambda { %{--without "development test assets" --path "#{bundle_path}" --deployment} }

task :environment do
  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-1.9.3-p125@default]'
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]
end

task :bundler_workaround do
  queue 'echo -----> Applying workaround to bundler bug'
  queue! %[ sed -i 's/\\.\\.\\/\\.\\.\\/yggdra\\/plugins\\//vendor\\/cache\\//g' Gemfile ]
end

desc 'Does local cleanup'
task :local_cleanup do
  sh 'rm -r vendor/cache'
  sh 'bundle install --without ""'
end

desc 'Deploys the current version to the server.'
task :deploy => :environment do
#    sh 'rake tmp:cache:clear'
#    invoke :extgui_assets

  sh 'bundle install --without "development test"'
  sh 'RAILS_ENV=assets rake assets:precompile'
  sh 'bundle install --without "development test assets"'
  sh 'bundle package --all'
  sh 'bundle package --all' # Do it twice otherwise Gemfile.lock keeps listing ../../plugins/... bundler bug?

  deploy do
    invoke :'simple:upload_project'
    invoke :'deploy:link_shared_paths'
    invoke :'bundler_workaround'
    invoke :'bundle:install'

    to :stage do
    end

    to :launch do
      queue! '/usr/local/bin/pumactl -S log/puma-production.state restart ; true'
    end
  end

  invoke :local_cleanup
end

desc 'Put the server in maintenance mode'
task :down do
  queue! 'touch tmp/maintenance'
end

desc 'Put the server in production from maintenance'
task :up do
  queue! 'rm tmp/maintenance'
end
