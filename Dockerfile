# Usa una imagen base con Python
FROM python:3.8

# Establece el directorio de trabajo en /app
WORKDIR /app

ARG MONGO_URL
ENV MONGO_URL=$MONGO_URL

# Copia las carpetas app y tests al contenedor
COPY src /app
COPY requirements.txt /app

# Instala las dependencias definidas en requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Exponer los puertos necesarios
EXPOSE 8000

# Comando para ejecutar la aplicación y las pruebas
CMD ["sh", "-c", "uvicorn app_v2:app --reload"]
