# Docker Image with NGINX UWSGI FLASK Miniconda and python 3.4
This image is meant as a starting point for a fast performance REST API for Machine learning / Data Science applications.   

You can install anything else you want on here.

## To use    

Clone the project

```
git clone https://github.com/williamFalcon/docker-flask-nginx-uwsgi-miniconda-3.4.git
```

cd to /docker-flask-nginx-uwsgi-miniconda-3.4

```
cd ./docker-flask-nginx-uwsgi-miniconda-3.4
```

Build app

```
docker build . -t myApp
```

Run app

```
docker run -p 80:80 -t myApp
```

Open your browser to http://localhost    
    

