# Containerisation

## Activity 0 - Warm up
1. What is the difference between image and container?

Docker image is the template loaded onto the container to run it while container is a self-contained, runnable software application or service.

2. Where are images stored?

For Linux, they are stored under /var/lib/docker/overlay2, while for windows there are stored under C:\ProgramData\docker\windowsfilter.

3. What is Docker?

Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers.

4. Compare the size of an alpine and debian image, which is smaller?

Alpine images tend to be much smaller than Debian-based images due to their minimalistic nature.

## Activity 1a: Explore Debian and Build on It
1. Run a debian container and exec into it

```sh
docker run -it debian sh
```
2. Use the ping command to reach google.com
    - ping not found 

```sh
apt update && apt upgrade
apt install iputils-ping
```

3. Use the curl command to reach google.com

```apt install curl```

4. Use debian:bookworm as the base image, build a new image (name: my-nodejs:bookworm)
    - create a Dockerfile
    - `docker build . -t myexpress-app:0.1nodejs:bookworm`
Include the curl binary. Verify that it exists.
Include v12.x of the node binary. Verify the binary version.
    - on root, run 
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
const msg = `Hello from ${ENV} environment`;

Rebuild the image and verify the changes

```docker run -dp 9091:8080 express-app:0.1```

2. Replace the ENV variable line to the following,
const ENV = process.env.APP_ENVIRONMENT || 'undefined';

Rebuild the image and verify the changes

Provide the environment variable when running the container such that it would not show 'undefined'

```docker run -e APP_ENVIRONMENT=default -dp 9093:8080 express-app:0.1```