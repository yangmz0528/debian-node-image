# Containerisation

## Activity 0 - Warm up
Q: What is the difference between image and container?

`Docker image is the template loaded onto the container to run it while container is a self-contained, runnable software application or service.`

Q: Where are images stored?

`For Linux, they are stored under /var/lib/docker/overlay2, while for windows there are stored under C:\ProgramData\docker\windowsfilter.`

Q: What is Docker?

`Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers.`

Q: Compare the size of an alpine and debian image, which is smaller?

`Alpine images tend to be much smaller than Debian-based images due to their minimalistic nature.`

## Activity 1a: Explore Debian and Build on It

1. Run a debian container and exec into it

```sh
docker run -it debian sh
```
2. Use the ping command to reach google.com (ping not found)
```sh
apt update && apt upgrade
apt install iputils-ping
```

3. Use the curl command to reach google.com

``` sh
apt install curl
```

4. Use debian:bookworm as the base image, build a new image (name: my-nodejs:bookworm)
    - create a Dockerfile
    - `docker build . -t myexpress-app:0.1nodejs:bookworm`
    - Include the curl binary. Verify that it exists.
    - Include v12.x of the node binary. Verify the binary version.
```sh 
curl -fsSL https://deb.nodesource.com/setup_21.x | bash - &&\
apt install -y nodejs
```

## Activity 1b: Containerize the App

Using the same Dockerfile from the last activity, extend on it to containerize our NodeJS application.
Build a new image (name: express-app:0.1)

```docker build . -t express-app:0.1```

Run the container and verify that your website is reachable

```docker run -dp 9090:8080 express-app:0.1```

## Activity 1c: Environment Variables

1. Replace the msg variable line to the following,
```sh
const msg = `Hello from ${ENV} environment`;
```

Rebuild the image and verify the changes

```sh
docker run -dp 9091:8080 express-app:0.1
```

2. Replace the ENV variable line to the following,
```sh
const ENV = process.env.APP_ENVIRONMENT || 'undefined';
```

Rebuild the image and verify the changes and
provide the environment variable when running the container such that it would not show 'undefined'

```sh
docker run -e APP_ENVIRONMENT=default -dp 9093:8080 express-app:0.1
```

### Activity 1e: Build and Run in an EC2 instance

1. Create a t2.micro instance with internet access
2. Install docker
    - verify that you can execute docker commands as a non-root user 
    - by adding group membership for the dafault ec2-user so you can run all docker command without using sudo
```sh
sudo usermod -a -G docker ec2-user
id ec2_user
# reload a linux user's group assignment to docker w/o logout
newgrp docker
```
3. Install git and clone this repo (using http-based url, repo can be cloned without credentials)
4. Build the image and run the container
5. Verify that website is reachable

reference: [link](https://www.cyberciti.biz/faq/how-to-install-docker-on-amazon-linux-2/)