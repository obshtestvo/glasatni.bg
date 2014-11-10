server  'koi.obshtestvo.bg:2214',
        user: 'www-data',
        roles: %w(app web db)

set :deploy_to,       '/var/www/glasatni.bg'
set :puma_threads,    [15, 15]
set :puma_workers,    4
