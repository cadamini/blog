# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

desc "create default admin user"
task :createadmin => :environment do
  admin = User.create(
    :email => "admin@example.com", 
    :password => "mypassword", 
    )
  admin.save!
end

Rails.application.load_tasks