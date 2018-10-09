# Here some instructions to build and run the project:

cd django-polls-nginx

# Build krisocc/mysite:latest image:

cd mysite && docker build -t krisocc/app-server:1.0 -f Dockerfile .
cd ..

# Run the group of containers:

docker-compose up

# In Safari window go to http://localhost:8000/admin

# In Portainer, go to Containers and open django-polls-nginx-app-server_1 Console, run the command:

python manage.py createsuperuser

# User: admin, e-mail: admin@example.com, password: admin

# In Safari window, use above data to login
# Create some questions and answers

# In Safari window go to http://localhost:8000/polls
