namespace :setup do
  desc "Upload database.yml file."
  task :upload_yml do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config" 
      upload! StringIO.new(File.read("config/database.yml")),"#{shared_path}/config/database.yml"
    end
  end
  
  desc "Move seed images into place"
  task :move_seed_images_into_place  do
    on roles(:app) do
      execute "cp -R #{release_path}/app/assets/seed_images/* #{shared_path}/public/system"
    end
  end
end
