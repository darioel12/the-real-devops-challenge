# Usa una imagen base con Python
FROM python:3.8

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia las carpetas app y tests al contenedor
COPY src /app/src
COPY tests /app/tests
COPY requirements.txt /app/

# Instala las dependencias definidas en requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Exponer los puertos necesarios
EXPOSE 8000

# Comando para ejecutar la aplicación y las pruebas
CMD ["sh", "-c", "python src/app_v2.py"]
