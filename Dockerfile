FROM ubuntu:14.04

EXPOSE 80

RUN apt-get update
RUN apt-get install python nginx
