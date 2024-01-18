# Usa una imagen base con Python
FROM python:3.8-alpine

# Crea un usuario no root
RUN adduser -D automation && \
    mkdir /app && \
    mkdir /home/automation/apk-cache && \
    chown -R automation /app /home/automation/apk-cache

# Establece el usuario no root como el usuario por defecto
USER automation
WORKDIR /app

# Configura el directorio de caché temporal de APK
ENV APK_CACHE_DIR /home/automation/apk-cache

# Cambia al usuario root temporalmente para realizar la actualización de apk
USER root
RUN mkdir -p $APK_CACHE_DIR && \
    chown -R automation $APK_CACHE_DIR && \
    apk add --no-cache python3-dev py3-pip build-base && \
    python3 -m venv /venv && \
    chown -R automation /venv  

# Cambia de nuevo al usuario no root
USER automation

ARG MONGO_URL
ENV MONGO_URL=$MONGO_URL

# Copia las carpetas app y tests al contenedor
COPY src /app
COPY requirements.txt /app

# Ejecutar el venv e instalar requirements
RUN /venv/bin/python -m pip install --no-cache-dir -r requirements.txt

# Exponer los puertos necesarios
EXPOSE 8000

# Comando para ejecutar la aplicación y las pruebas
CMD ["/venv/bin/uvicorn", "app_v2:app", "--host", "0.0.0.0", "--port", "8000"]
