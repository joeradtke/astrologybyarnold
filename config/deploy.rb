# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'astrologybyarnold'
set :repo_url, 'https://github.com/joeradtke/astrologybyarnold.git'
set :nginx_domains, "astrologybyarnold.com www.astrologybyarnold.com"
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :app_server_socket, "/home/joe/astrologybyarnold/shared/tmp/sockets/puma.sock"
# Default deploy_to directory is /var/www/my_app_name
 set :deploy_to, '/home/joe/astrologybyarnold'
set :deploy_user, 'joe'
set :sudo_user, 'joe'
# Default value for :scm is :git
# set :scm, :git
set :stage, :production
# Default value for :format is :pretty
# set :format, :pretty
set :puma_init_active_record, true
# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}
set :rvm1_ruby_version, "2.1.5"

# Default value for linked_dirs is []
 set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
set :ssh_options, {
  config:false
}
namespace :deploy do
  after :deploy, "setup:move_seed_images_into_place"
  after :deploy, "nginx:restart"
  after :deploy, "puma:restart" 
  desc 'Restart application'
end
