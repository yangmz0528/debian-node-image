FROM debian:bookworm 

# install curl and ping
RUN apt update
RUN apt install -y \
    curl \
    iputils-ping

# Install node v21.x
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash - &&\
apt install -y nodejs

# Application specific layer
WORKDIR /app
COPY . /app
RUN npm install
EXPOSE 8080

CMD ["node", "index.js"]

# build the docker image
# docker build . -t mynodejs:bookworm