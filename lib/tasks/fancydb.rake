namespace :db do
  task :envcreate do
   require "#{Rails.root}/setenv.rb" 
   Rake::Task["db:create"].invoke 
  end
end