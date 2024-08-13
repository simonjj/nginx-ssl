FROM nginx:latest

COPY entrypoint.sh /entrypoint.sh
COPY default.conf.template-only /etc/nginx/default.conf.template-only
COPY ssl/nginx.crt /etc/nginx/ssl/nginx.crt
COPY ssl/nginx.key /etc/nginx/ssl/nginx.key

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]