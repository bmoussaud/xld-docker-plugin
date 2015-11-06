# Overview #

The Docker plugin is a XL Deploy plugin that adds capability for deploying Docker Images to Docker Machines.

# Installation #

Place the plugin JAR file into your `SERVER_HOME/plugins` directory.
Dependencies:

* XL Deploy 4.5+ 
* xld-smoke-test plugin 1.0.2 https://github.com/xebialabs-community/xld-smoke-test-plugin/releases/tag/1.0.2


# Sample Applications #
* XL Deploy Docker Sample Application https://github.com/bmoussaud/xld-petclinic-docker
* XL Deploy Docker MicroService Sample Application https://github.com/bmoussaud/xld-micropet-docker

# Docker RunContainer Configuration #

A `docker.RunContainer` may be configured with with Embedded Deployeds:
* `docker.EnvironmentVariable` to configure environment variable (name,value)
* `docker.Port` to configure the exposed ports
* `docker.Link` to configure on which other containers the container should be linked with
* `docker.Volume` to configure the volumes the container should use (hostPath:containerPath)


# Integration with a Docker Registry #

A docker registry can be set up on each `docker.RunContainer` ci using the property `Registry Host` & `Registry Port`:

* If the property is blank no registry is used. 
* If it is not blank, the images will be pulled from the Docker Registry and tagged locally.


# Usage in Deployment Packages #

Please refer to Packaging Manual for more details about the DAR packaging format.

```

<?xml version="1.0" encoding="UTF-8"?>
<udm.DeploymentPackage version="3.0-CD-20151106-164038" application="Docker/PetDocker">
  <orchestrator>
    <value>parallel-by-deployment-group</value>
  </orchestrator>
  <deployables>
    
    <smoketest.HttpRequestTest name="smoke test">
      <expectedResponseText>{{title}}</expectedResponseText>
      <links>
        <value>petclinic:petclinic</value>
      </links>
      <url>http://petclinic:8080/petclinic</url>
    </smoketest.HttpRequestTest>
    
    <smoketest.HttpRequestTest name="smoke test - ha">
      <expectedResponseText>{{title}}</expectedResponseText>
      <url>http://{{HOST_ADDRESS}}/petclinic/</url>
    </smoketest.HttpRequestTest>
    
    <docker.Image name="petclinic">
      <ports>
        <docker.PortSpec name="petclinic/exposed-port">
          <hostPort>8888</hostPort>
          <containerPort>8080</containerPort>
        </docker.PortSpec>
      </ports>
      <registryHost>{{PROJECT_REGISTRY_HOST}}</registryHost>
      <image>petportal/petclinic:3.1-20150611154030</image>
      <links>
        <docker.LinkSpec name="petclinic/petclinic-backend">
          <alias>petclinic-backend</alias>
        </docker.LinkSpec>
      </links>
      <volumes>
        <docker.VolumeSpec name="petclinic/petclinic-config">
          <containerPath>/application/properties</containerPath>
          <hostPath>{{HOST_TARGET_PATH}}</hostPath>
        </docker.VolumeSpec>
      </volumes>
      <variables>
        <docker.EnvironmentVariableSpec name="petclinic/loglevel">
          <value>{{LOGLEVEL}}</value>
        </docker.EnvironmentVariableSpec>
      </variables>
    </docker.Image>
    
    <docker.Image name="petclinic-backend">
      <registryHost>{{PROJECT_REGISTRY_HOST}}</registryHost>
      <image>petportal/petclinic-backend:1.1-20150611154030</image>
    </docker.Image>
    
    <docker.Image name="ha-proxy">
      <ports>
        <docker.PortSpec name="ha-proxy/web">
          <hostPort>80</hostPort>
          <containerPort>80</containerPort>
        </docker.PortSpec>
        <docker.PortSpec name="ha-proxy/admin">
          <hostPort>1936</hostPort>
          <containerPort>1936</containerPort>
        </docker.PortSpec>
      </ports>
      <image>eeacms/haproxy:latest</image>
      <variables>
        <docker.EnvironmentVariableSpec name="ha-proxy/BACKENDS">
          <value>{{HOST_ADDRESS}}:8888</value>
        </docker.EnvironmentVariableSpec>
      </variables>
    </docker.Image>
    
    <docker.File name="petclinic.properties" file="petclinic.properties/petclinic.properties">
      <targetPath>{{HOST_TARGET_PATH}}/petclinic.properties</targetPath>
    </docker.File>
  </deployables>
</udm.DeploymentPackage>

```

# Deployed Actions Table  #

The following table describes the effect a deployed has on its container.

| Deployed | Create | Destroy | Modify |
|----------|--------|---------|--------|
| docker.RunContainer| Pull the container image, Start the container | Stop the container, Remove the container | Stop the container, Remove the container, Pull the container image, Start the container  |
| docker.DataFileVolume| Copy the file to the remote location | Delete the file from the remote location | Delete the file from the remote location, Copy the file to the remote location|
| docker.DataFolderVolume| Copy the folder to the remote location - *or* - create a new image with the data| Delete the folder from the remote location - *or* - delete the data container | Delete the folder from the remote location, Copy the folder to the remote location - *or* - delete the data container, create the new data container |

