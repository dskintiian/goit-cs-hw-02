FROM python:3-alpine

#COPY . /app/
#WORKDIR /app

RUN apk update \
    && pip install --upgrade pip \
    && apk add --no-cache --update libpq-dev \
    && apk add --no-cache --update build-base \
    && apk add --no-cache --update linux-headers bash curl unit-openrc unit unit-python3 openrc git apk-cron supervisor \
    && apk add --no-cache --update postgresql-libs \
    && apk add --no-cache --update gcc musl-dev libpq postgresql-dev python3-dev libc-dev


RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN source $HOME/.cargo/env

COPY requirements.txt requirements.txt
RUN pip install setuptools --upgrade
RUN pip install --no-cache-dir -r requirements.txt

#CMD [ "python3", "/app/main.py"]