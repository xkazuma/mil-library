FROM node:20.3.0-bullseye

# work directiory for this application
WORKDIR /app

COPY mil-library/ ./

RUN apt update && yarn install

# open port for node app
EXPOSE 5173
