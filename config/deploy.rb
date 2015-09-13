lock '3.4.0'

set :application,     'glasatni'
set :repo_url,        'https://github.com/obshtestvo/glasatni.bg.git'
set :linked_files,    %w(config/database.yml config/secrets.yml config/application.yml)
set :linked_dirs,     %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)
set :keep_releases,   20
set :rails_env,       'production'
set :puma_init_active_record, true
set :nginx_server_name, 'glasatni.bg *.glasatni.bg'

namespace :deploy do
  namespace :nginx do
    desc 'Generate an Nginx configuration file'
    task :config do
      on roles(:web) do |role|
        template_puma('nginx_conf', "#{shared_path}/#{fetch(:nginx_config_name)}_nginx.conf", role)
      end
    end
  end
end

after 'deploy:check', 'deploy:nginx:config'
after 'deploy:check', 'puma:config'
