
def stop_start_docker_container(docker_container):
    if docker_container is None:
        return
    context.addStep(steps.os_script(
        description="Stopping docker container %s" % docker_container.name,
        order=20,
        script="docker/docker-stop",
        freemarker_context={'name': docker_container.name},
        target_host=docker_container.container.host)
    )
    context.addStep(steps.os_script(
        description="Starting docker server %s" % docker_container.name,
        order=80,
        script="docker/docker-start",
        freemarker_context={'name': docker_container.name},
        target_host=docker_container.container.host))

def docker_run_containers():
    return map(lambda x: x.deployedOrPrevious, filter(lambda delta: delta.deployedOrPrevious.type == "docker.RunContainer" , deltas.deltas ))


def getRunContainer(d):

    for deployed in docker_run_containers():
        c_id = "%s/%s" % (deployed.id, deployed_name)
        candidates  = filter(lambda volume: volume.id == c_id, deployed.volumes)
        if len(candidates) > 0:
            return deployed
        else:
            return None

docker_containers = set(map(getRunContainer,filter(lambda delta: delta.operation == "MODIFY" and delta.deployedOrPrevious.type == "docker.DeployedFolderVolume", deltas.deltas)))
map(stop_start_docker_container, docker_containers)

