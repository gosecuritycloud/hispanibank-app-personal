#!/bin/bash
# Espera a que la base de datos esté lista (si usas otro contenedor para la DB)
# Puedes agregar lógica para esperar, por ejemplo con wait-for-it o sleep unos segundos
echo "Aplicando migraciones..."
python manage.py migrate --noinput

echo "Recolectando archivos estáticos..."
python manage.py collectstatic --noinput

echo "Iniciando el servidor de desarrollo de Django..."
exec python manage.py runserver 0.0.0.0:8000
