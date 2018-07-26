[supervisord]
nodaemon=true

[program:laravel-worker]
process_name=%(program_name)s_%(process_num)02d
command=php %%WWWHOME%%/artisan queue:work %%QUEUE_CONNECTION%% --queue=%%QUEUE_NAME%% --sleep=%%SLEEP_TIME%% --tries=%%NUL_RETRIES%%
autostart=true
autorestart=true
numprocs=1
startretries=10
stdout_events_enabled=1
