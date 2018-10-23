require 'mina/rails'

set :application_name, 'acao-dashboard'
set :domain, 'linobis.acao.it'
set :production_domain, 'lino.acao.it'
set :deploy_to, '/opt/acao-dashboard'
set :shared_dirs, fetch(:shared_dirs, []) + [ ]
set :shared_files, fetch(:shared_files, []) + [ 'config/secrets.yml', ]
set :repository, 'foobar'
set :keep_releases, 20
set :rsync_excludes, [
  '.git*',
  '/config/secrets.yml',
  '/vendor/bundle',
  '/tmp/cache',
  '/log',
].map { |x| "--exclude \"#{x}\"" }.join(' ')

task :environment do
end

task :setup do
end

task :restart do
  comment 'Restarting server'
  command "kill -TERM `cat #{fetch(:deploy_to)}/shared/log/puma-production.pid` ; true"
end

desc 'Does local cleanup'
task :local_cleanup do
  sh 'rm -r vendor/cache'
  sh 'bundle install --without ""'
end

task :production do
  set :domain, fetch(:production_domain)
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    sh 'bundle install --quiet --with "assets"'
    sh 'RAILS_ENV=assets bundle exec rake assets:precompile'
    sh 'bundle install --quiet --without "development test assets"'
    sh 'bundle package --all'

    sh "rsync --recursive --delete --delete-excluded #{fetch(:rsync_excludes)} . #{fetch(:domain)}:#{fetch(:deploy_to)}/upload"

    comment 'Copying upload to build path.'
    command "cp -r #{fetch(:deploy_to)}/upload/public/assets/{.??,}* #{fetch(:deploy_to)}/shared/public/assets/"
    command "cp -r #{fetch(:deploy_to)}/upload/{.??,}* ."

    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'deploy:cleanup'
    invoke :local_cleanup

    on :launch do
      invoke :restart
    end
  end
end

desc 'Put the server in maintenance mode'
task :down do
  command 'touch tmp/maintenance'
end

desc 'Put the server in production from maintenance'
task :up do
  command 'rm tmp/maintenance'
end
