# alpine-nginx

Nginx and NodeJs image based on Alpine linux.

## How to use it

You might want something like this:


    FROM ukti/alpine-nginx-nodejs:5.4.1

    ...
    USER www-data
    COPY conf/nginx/default.conf /etc/nginx/sites-enabled/default.conf
    ...

    RUN apk add --update g++ make python

    WORKDIR /app

    USER www-data
    COPY . /app

    USER root
    RUN chown -R www-data:www-data .

    USER www-data
    RUN npm install

    USER root
    RUN apk del g++ make python

    USER root
    CMD ./run.sh
