# Paso 1: Construir la aplicación de React
FROM node:18 AS build
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build

# Paso 2: Configurar Nginx
FROM nginx:alpine
COPY --from=build /usr/src/app/dist/apps/nx-mono /usr/share/nginx/html
COPY  /generate-config.sh /script/generate-config.sh
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /script/generate-config.sh /entrypoint.sh
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

ENTRYPOINT [ "/entrypoint.sh" ]
