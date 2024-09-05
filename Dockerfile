FROM nginx:1.18
COPY website/. /usr/share/nginx/html
EXPOSE 80
