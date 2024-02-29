# Usa la versión de Node.js adecuada para tu proyecto
FROM node:20.11.1 AS build
WORKDIR /app
# Copia todos los archivos necesarios en un solo comando
COPY . .
# Instala las dependencias sin una etapa intermedia innecesaria
RUN npm install
# Construye la aplicación Angular en una etapa separada
FROM nginx:1.23.3 AS nginx
# Exporta el puerto 80
EXPOSE 80
# Copia el directorio de la aplicación Angular compilada a la ubicación correcta
COPY --from=build /app/dist/app-nginx /usr/share/nginx/html
# Inicia Nginx con la configuración por defecto
CMD ["nginx", "-g", "daemon off;"]


# FROM node:20.11.1 as build

# WORKDIR /app

# COPY . .

# RUN npm install

# RUN npm run build

# FROM nginx:1.23.3 as prod

# EXPOSE 80

# COPY --from=build /app/dist/app-nginx /usr/share/nginx/html

# CMD [ "nginx","-g","daemon off;" ]