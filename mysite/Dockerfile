FROM python:3

ENV POSTGRES_PASSWORD=pic-django
ENV POSTGRES_USER=django
ENV POSTGRES_DB=djangopolls
ENV POSTGRES_HOST=db
WORKDIR /django-mysite
COPY . .
RUN pip install -r requirements.txt
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-client nginx
