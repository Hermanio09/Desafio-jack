FROM nginx:latest

RUN useradd -M -s /sbin/nologin myuser

COPY ./index.html /usr/share/nginx/html/index.html
COPY ./css /usr/share/nginx/html/css

RUN mkdir -p /var/cache/nginx/client_temp \
    && chown -R myuser /var/cache/nginx \
    && chmod -R 755 /var/cache/nginx \
    && touch /var/run/nginx.pid \
    && chmod -R 755 /var/run/nginx.pid \
    && chown -R myuser /var/run/nginx.pid

EXPOSE 80

USER myuser

CMD ["nginx", "-g", "daemon off;"]