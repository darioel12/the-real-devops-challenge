# Usa una imagen base con Python
FROM python:3.8

# Establece el directorio de trabajo en /app
WORKDIR /app

ARG MONGO_URL
ENV MONGO_URL=$MONGO_URL

# Instala herramientas necesarias para venv
RUN apt-get update && \
    apt-get install -y python3-venv

# Copia las carpetas app y tests al contenedor
COPY src /app
COPY requirements.txt /app

# Instala las dependencias definidas en requirements.txt
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt

# Exponer los puertos necesarios
EXPOSE 8000

# Comando para ejecutar la aplicación y las pruebas
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
