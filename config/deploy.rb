require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :repository, 'https://AugustoSandim@bitbucket.org/dinneer/dinneer-web.git'
set :shared_paths, ['config/database.yml', 'log', 'public/system', 'tmp/pids', 'tmp/sockets', 'config/application.yml']

set :identity_file, ENV['IDENTIFY_FILE']
set :environment,   ENV['ENV']

set :term_mode, true
set :rvm_path, "/usr/local/rvm/scripts/rvm"
set :force_assets, true

if environment == 'production'
  set :user, 'dinneer'
  set :domain, '52.36.127.85'
  set :ruby_version,  'ruby-2.3.1'
  set :deploy_to, '/var/www/dinneer/production'
  set :branch,    'master'
  set :gemset,    'dinneer_production'
  set :rails_env, 'production'
elsif environment == 'staging'
  set :user, 'dinneer'
  set :domain, '52.36.127.85'
  set :ruby_version,  'ruby-2.3.1'
  set :deploy_to, '/var/www/dinneer/staging'
  set :branch,    'develop'
  set :gemset,    'dinneer_staging'
  set :rails_env, 'staging'
end


task :environment do
  if !environment
    abort "You need to pass the identify file and environment, ex. mina deploy ENV=[production,staging] IDENTIFY_FILE=$HOME/ec2/key.pem"
  end 
    invoke :"rvm:use[#{ruby_version}@#{gemset}]"
end

task restart: :environment do
  pidfile = "#{deploy_to}/current/tmp/pids/unicorn.pid"
  queue "if [ -f #{pidfile} ]; then kill -s USR2 `cat #{pidfile}`;fi"
end

task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "Be sure to edit 'shared/config/database.yml'."]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/pids"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/sockets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/sockets"]

  queue! %[mkdir -p "#{deploy_to}/shared/public/system"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/public/system"]
end

desc "Deploys the current version to the server."
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    queue  %[#{bundle_bin} install --without development test]
    invoke :"rvm:wrapper[#{ruby_version}@#{gemset}, #{gemset} ,unicorn_rails]"
    invoke :'rails:db_migrate'
    queue  %[#{bundle_bin} exec rake redis:refresh_keys] if refresh_redis_keys

    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :restart
    end
  end
end
