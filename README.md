# Docker Image with NGINX UWSGI FLASK Miniconda and python 3.4
This image is meant as a starting point for a fast performance REST API for Machine learning / Data Science applications.   

You can install anything else you want on here.

## To use
1. Clone the project.
2. cd to /docker-flask-nginx-uwsgi-miniconda-3.4    
3. Build app    
````
docker build . -t myApp
````    
3. Run app    
````
docker run -p 80:80 -t myApp
````    
4. Open your browser to http://localhost    
    

