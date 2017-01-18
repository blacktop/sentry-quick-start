FROM nginx

RUN rm /etc/nginx/conf.d/default.conf

COPY sites-enabled /etc/nginx/conf.d/
COPY certs /etc/ssl/
