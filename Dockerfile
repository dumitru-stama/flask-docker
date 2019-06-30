FROM ubuntu:latest

RUN apt update && apt install -y --no-install-recommends python3 python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools supervisor libpcre3 libpcre3-dev nginx mc

# Install python requirements
COPY requirements.txt /
RUN pip3 install --trusted-host pypi.python.org -r /requirements.txt

# Setup NGINX
RUN \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Copy the flask app
WORKDIR /app
COPY ./app /app

# Copy the config files for nginx, uwsgi and supervisord
COPY uwsgi.ini /etc/uwsgi/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx-app /etc/nginx/sites-available/

# Add the nginx server config file
RUN rm -rf /etc/nginx/sites-enabled/*
RUN ln -s /etc/nginx/sites-available/nginx-app /etc/nginx/sites-enabled

# Copy the startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]


