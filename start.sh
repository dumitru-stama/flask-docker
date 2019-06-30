#! /usr/bin/env sh

# exit immediately if a command errors out
set -e

# Start Supervisor, with Nginx and uWSGI
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf


