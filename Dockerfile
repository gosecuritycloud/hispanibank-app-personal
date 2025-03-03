# Usa una imagen base de Python (por ejemplo, Python 3.9-slim)
FROM python:3.9-slim

# Variables de entorno para evitar la generación de archivos .pyc y buffer de salida
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Establece el directorio de trabajo
WORKDIR /app

# Instala dependencias del sistema necesarias (opcional)
RUN apt-get update && apt-get install -y gcc

# Copia el archivo de requerimientos e instala las dependencias de Python
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copia el resto del código de la aplicación
COPY . /app/

# Copia el script de entrada y le asigna permisos de ejecución
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

# Expone el puerto 8000 (puerto por defecto de Django)
EXPOSE 8000

# Comando de entrada: ejecuta el script que aplica migraciones y arranca el servidor
CMD ["/app/entrypoint.sh"]
