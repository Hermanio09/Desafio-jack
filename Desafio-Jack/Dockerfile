FROM nginx:latest

COPY ./index.html /usr/share/nginx/html/index.html

RUN useradd -M -s /sbin/nologin myuser

EXPOSE 80

USER myuser

CMD ["nginx", "-g", "daemon off;"]
