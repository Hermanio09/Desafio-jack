FROM nginx:latest

RUN useradd -M -s /sbin/nologin myuser

COPY ./index.html /usr/share/nginx/html/index.html

USER myuser
