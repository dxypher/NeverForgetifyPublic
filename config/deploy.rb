ssh_options[:forward_agent] = true
default_run_options[:pty] = true
set :bundle_cmd, "LANG='en_US.UTF-8' LC_ALL='en_US.UTF-8' bundle"
set :application, "neverforgetify"
set :deploy_via, :remote_cache
set :environment, "development"
set :copy_exclude, ["*.psd"]
set :repository,  "git@github.com:kohactive/Neverforgetify.git"
set :user, "deployment"
set :scm_verbose, true
set :scm, :git
set :use_sudo, false

#deployment settings
set :current_dir, "current"
set :deploy_to, "/usr/share/nginx/ruby/apps/#{application}"
set :site_root, "/usr/share/nginx/ruby/apps/#{application}/#{current_dir}"
set :keep_releases, 3


server "rkelly.kohsrv.net", :app, :web, :db, :primary => true

task :check_revision do
  run "cat #{site_root}/REVISION"
end


after "deploy:create_symlink", "deploy:update_crontab"

namespace :deploy do
  
  task :finalize_update do
    transaction do
      run "cd #{release_path}; RAILS_ENV=#{environment} bundle install", :only => { :primary => true }
      run "cd #{release_path}; RAILS_ENV=#{environment} bundle exec rake db:migrate", :only => { :primary => true }
      run "cd #{release_path}; bundle exec rake assets:precompile RAILS_ENV=production" if environment == "Production"
    end
  end
  task :update_crontab, :roles => [:app, :web] do  
    run "cd #{site_root}; whenever --update-crontab #{application}"  
  end  
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app do
    run "mkdir -p /usr/share/nginx/ruby/apps/#{application}/#{current_dir}/tmp"
    run "sudo chmod 775 -R /usr/share/nginx/ruby/apps/#{application}/#{current_dir}/tmp"
    run "sudo chmod 775 -R /usr/share/nginx/ruby/apps/#{application}/#{current_dir}/public/assets" if environment == "Production"
    run "touch #{File.join("/usr/share/nginx/ruby/apps/#{application}/#{current_dir}/tmp",'restart.txt')}"
  end
end