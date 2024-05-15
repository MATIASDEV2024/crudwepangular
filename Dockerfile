# Etapa de construcción
FROM node:18-alpine as build-step

# Crear y establecer el directorio de trabajo
WORKDIR /app

# Copiar package.json y package-lock.json (si existe)
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto de la aplicación
COPY . .

# Construir la aplicación
RUN npm run build --prod

# Etapa de producción
FROM nginx:1.17.1-alpine

# Copiar archivos de construcción al directorio de Nginx
COPY --from=build-step /app/dist/crud-cicd /usr/share/nginx/html
