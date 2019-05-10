# Puppet Webhook Docker container

This folder contains the file necessary to build and/or run the Puppet Webhook API server in a Docker container using `docker-compose`.

## Build locally
The `Dockerfile` was created so we can automate the build of containers nightly and for release, but it can also be used to build your own local container (or add onto our base container) if you so choose.

#### Build steps
1. `cd build/docker`
2. Build the container: `docker build -t <container_name:tag> .`

Simple as that.

#### Running the container using `docker-compose`

Included is a sample `docker-compose.yml` file for anyone to use or base their own compose file off.

The compose file doesn't build any containers, instead it just ensures that you have a Puppet Webhook container, a Redis container, and a Sidekiq container. The default volumes are examples for where you can point the containers to get the `r10k` and `puppet_webhook` config files and where r10k will deploy puppet code to. This can be changed however you prefer.
