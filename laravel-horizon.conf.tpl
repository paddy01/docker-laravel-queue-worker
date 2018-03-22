[supervisord]
nodaemon=true

[program:laravel-horizon]
process_name=%(program_name)s_%(process_num)02d
command=php %%WWWHOME%%/artisan horizon
autostart=true
autorestart=true
numprocs=1
startretries=10
stdout_events_enabled=1
