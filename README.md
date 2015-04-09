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


# TODO #

* docker.Volume linked with docker.DeployedFolderVolume
* Manage Volume modification -> stop / start container.

# Start the Software Factory
The Software Factory contains a Jenkins and a Docker Registry
In the `Environments` directory run
* docker-compose -f  software-factory.yml  build
* docker-compose -f  software-factory.yml  up

# Set up a docker registry
on your docker machine
* docker-machine ssh <machine>
* sudo vi /var/lib/boot2docker/profile
Add `EXTRA_ARGS='--insecure-registry <IP_MACHINE>:5000` to the EXTRA_ARGS line
* exit
* docker-machine stop <machine>
* docker-machine start <machine>
* docker log file is located here: tail -f /var/log/docker.log

# Jenkins PetPortal Job
* Adminstration Jenkin: define a default Maven location.
* Maven Job
* Git : https://github.com/bmoussaud/xld-petclinic-tomcat.git
* Branch: docker
* Commands after build
  * cp ${WORKSPACE}/PetClinic/target/PetClinic.war $WORKSPACE/docker/petclinic/PetClinic.war
  * /usr/bin/docker build -t petdocker/petdocker-app:$BUILD_NUMBER $WORKSPACE/docker/petclinic
  * /usr/bin/docker tag petdocker/petdocker-app:$BUILD_NUMBER  <IP_MACHINE>:5000/petdocker/petdocker-app:$BUILD_NUMBER 
  * /usr/bin/docker push <IP_MACHINE>:5000/petdocker/petdocker-app:$BUILD_NUMBER 
 
docker run -p 5000:5000 registry
test registry http://192.168.99.100:5000/v1/search



