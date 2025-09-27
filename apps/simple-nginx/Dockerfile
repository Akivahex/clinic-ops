# Etapa 1: Imagen Final
FROM nginx:1.27-alpine-slim

# Eliminar la configuración por defecto y copiar la nuestra.
# También ajustamos la configuración global de Nginx para que el proceso maestro se ejecute como nuestro usuario.
RUN rm /etc/nginx/conf.d/default.conf && \
    sed -i 's/user  nginx;/user  appuser;/g' /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/conf.d/

# Copiar los archivos de nuestra aplicación
COPY ./src /usr/share/nginx/html

# Crear un grupo y usuario de sistema sin privilegios
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Cambiar el propietario de los archivos de Nginx para que nuestro usuario pueda acceder a ellos
RUN chown -R appuser:appgroup /var/cache/nginx && \
    chown -R appuser:appgroup /var/log/nginx && \
    chown -R appuser:appgroup /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
    chown -R appuser:appgroup /var/run/nginx.pid

# Cambiar al usuario no-root
USER appuser
