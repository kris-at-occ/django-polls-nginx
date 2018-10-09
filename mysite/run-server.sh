#! /bin/bash

cd /django-mysite

# Wait for Postgres SQL container to be ready
# Adapted from: https://docs.docker.com/compose/startup-order/
# changed -U "postgres" to "$POSTGRES_USER", defined in django-polls.env

until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done
# end of Wait for Postgres SQL container

mkdir -p static
ln -s /django-mysite/mysite_nginx.conf /etc/nginx/sites-available/mysite_nginx.conf
ln -s /django-mysite/mysite_nginx.conf /etc/nginx/sites-enabled/mysite_nginx.conf

python manage.py migrate
python manage.py collectstatic
/etc/init.d/nginx restart
uwsgi --chdir=/django-mysite \
    --module mysite.wsgi:application \
    --env DJANGO_SETTINGS_MODULE=mysite.settings \
    --master --pidfile=/tmp/project-master.pid \
    --socket 127.0.0.1:8001 \
    --chmod-socket=666 \
    --processes=5 \
    --harakiri=20 \
    --max-requests=5000 \
    --vacuum
