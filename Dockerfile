FROM ubuntu:16.10
MAINTAINER William Falcon <will@hacstudios.com>

ENV DEBIAN_FRONTEND noninteractive

# ------------------------
# BASIC SYSTEM SETUP
# ------------------------
# install linux deps
RUN apt-get update && apt-get install -y \
    python-pip python-dev uwsgi-plugin-python \
    nginx supervisor curl git

# ----------------------
# DB DRIVERS (OPTIONAL)
# needed to install psycopg2 succesfully
RUN apt-get install -y libpq-dev

# ------------------------
# INSTALL SERVER STACK
# Nginx, uwsgi, supervisor
# ------------------------
COPY nginx/flask.conf /etc/nginx/sites-available/
COPY supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /var/log/nginx/app /var/log/uwsgi/app /var/log/supervisor
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/flask.conf /etc/nginx/sites-enabled/flask.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# ------------------------
# DATA SCIENCE STACK
# miniconda et al.
# ------------------------
# Install miniconda to /miniconda
ENV MINICONDA_VERSION 3-4.2.12
RUN echo "export PATH=/opt/conda/bin:$PATH" > /etc/profile.d/conda.sh
RUN curl -fSL https://repo.continuum.io/miniconda/Miniconda${MINICONDA_VERSION}-Linux-x86_64.sh -o ~/miniconda.sh
RUN /bin/bash ~/miniconda.sh -b -p /opt/conda
RUN rm ~/miniconda.sh

ENV PATH /opt/conda/bin:$PATH
RUN conda create --name python3_4 python=3.4

# ---------------------------
# INSTALL FLASK AND APP DEPS
# Nginx, uwsgi, supervisor
# ---------------------------
# install python deps
RUN /bin/bash -c ". activate python3_4 && pip install uwsgi"
COPY app/requirements.txt /var/www/app/requirements.txt
RUN /bin/bash -c ". activate python3_4 && pip install -r /var/www/app/requirements.txt"

# ---------------------------
# RUN APP
# Nginx, uwsgi, supervisor
# ---------------------------
# set up application after all the heavy installs so we don't rebuild image
# every time we change code
RUN chown -R www-data:www-data /var/www/app
RUN chown -R www-data:www-data /var/log
COPY app /var/www/app

# starts supervisor given the apps in the config file
CMD ["/usr/bin/supervisord"]
