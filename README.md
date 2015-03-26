# Overview #

The Docker plugin is a XL Deploy plugin that adds capability for deploying applications to a Docker container.

# Installation #

Place the plugin JAR file into your `SERVER_HOME/plugins` directory.

# Sample Application PetDocker #
1. Go to the PetDocker folder
2. Run the package.sh script with a version `./package.sh 3.5`
3. Import the created dar in XLD

# Set up an Environment #
1. Create new Docker Machine using the virtualbox provider `docker-machine create --driver virtualbox dev-machine`
2. Run `docker-machine env dev-machine` to get information about it

```
export DOCKER_TLS_VERIFY=yes
export DOCKER_CERT_PATH=/Users/bmoussaud/.docker/machine/machines/dev-machine
export DOCKER_HOST=tcp://192.168.99.100:2376
```

3. In XL Deploy, Create new CI `dev-machine` of type `docker.Machine` with the following properties
   * id: Infrastructure/dev-machine/mysql-dev
   * type: docker.Machine
   * Port: 2376
   * Private Key File: /Users/bmoussaud/.docker/machine/machines/dev-machine
   * username: docker
   * address: localhost

4. Run a new MySql Docker Container: `docker run --name mysql-dev -e MYSQL_ROOT_PASSWORD=deployit -d mysql:5.7.6`
5. Add it in XLD
    * id: Infrastructure/dev-machine/mysql-dev
    * type: sql.DockerMySqlClient
    * image: mysql:5.7.6
    * username: root
    * password: deployit
6. Add a new CI
    * id: Infrastructure/dev-machine/smoke-test-runner
    * type: smoketest.DockerRunner
    * image: cmfatih/ubuntu
    * Volume Directory: /opt/docker/volumes

4. Add the created CIs in your environment.

![initial deployment with xld-docker-plugin](img/docker-deployment.png)


