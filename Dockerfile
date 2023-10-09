# Paso 1: Construir la aplicación de React
FROM node:18 AS build
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build

# Paso 2: Configurar Nginx
FROM nginx:alpine
COPY --from=build /usr/src/app/dist/apps/nx-mono /usr/share/nginx/html
COPY --from=build /usr/src/app/generate-config.sh /usr/share/nginx/html/generate-config.sh
RUN chmod +x /usr/share/nginx/html/generate-config.sh
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["/bin/sh", "-c", "/usr/share/nginx/html/generate-config.sh /usr/share/nginx/html/ && nginx -g 'daemon off;'"]
