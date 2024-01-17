# Usa una imagen base con Python
FROM python:3.8-alpine

# Crea un usuario no root
RUN adduser -D automation && \
    mkdir /app && \
    chown -R automation /app

# Establece el usuario no root como el usuario por defecto
USER automation

# Establece el directorio de trabajo en /app
WORKDIR /app

ARG MONGO_URL
ENV MONGO_URL=$MONGO_URL

# Instala herramientas necesarias para venv
RUN mkdir -p /run/apk && \
    chmod 777 /run/apk && \
    apk update && \
    apk add --no-cache python3-dev py3-pip build-base

# Ejecutar el venv
RUN python3 -m venv venv && \
    . venv/bin/activate

# Copia las carpetas app y tests al contenedor
COPY src /app
COPY requirements.txt /app

# Instalar las dependecias necesarias
RUN pip install --no-cache-dir -r requirements.txt

# Exponer los puertos necesarios
EXPOSE 8000

# Comando para ejecutar la aplicación y las pruebas
CMD ["uvicorn", "app_v2:app", "--host", "0.0.0.0", "--port", "8000"]
