FROM ubuntu:14.04

EXPOSE 80

RUN apt-get update
RUN apt-get install -y python nginx

RUN pip install sphinx