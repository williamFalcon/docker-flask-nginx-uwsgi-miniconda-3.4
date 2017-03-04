# Docker Image with NGINX UWSGI FLASK Miniconda and python 3.4
This image is meant as a starting point for a fast performance REST API for Machine learning / Data Science applications.   

You can install anything else you want on here.

## To use
1. Clone the project.
````
git clone https://github.com/williamFalcon/docker-flask-nginx-uwsgi-miniconda-3.4.git
````
2. cd to /docker-flask-nginx-uwsgi-miniconda-3.4
````
cd ./docker-flask-nginx-uwsgi-miniconda-3.4
````
3. Build app
````
docker build . -t myApp
````
4. Run app
````
docker run -p 80:80 -t myApp
````
5. Open your browser to http://localhost    
    

