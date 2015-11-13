#
# THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
# FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
#

def to_deployed(delta):
    return delta.deployedOrPrevious


def deployeds(candidate_filter):
    return set(map(to_deployed, filter(candidate_filter, deltas.deltas)))


def sort_by_link(x, y):
    if x.container.id == y.container.id:
        for l in x.links:
            if l.alias == x.name:
                return 1
        for l in y.links:
            if l.alias == x.name:
                return -1
    return 0


def create_docker_container(deployed):
    context.addStep(steps.os_script(
        description="Create the container '%s' (%s)" % (deployed.name, deployed.image),
        order=65,
        script="docker/docker-create",
        freemarker_context={'deployed': deployed},
        target_host=deployed.container.host))


def start_docker_container(deployed):
    context.addStep(steps.os_script(
        description="Start the container '%s' (%s)" % (deployed.name, deployed.image),
        order=80,
        script="docker/docker-start",
        freemarker_context={'name': deployed.name},
        target_host=deployed.container.host))


docker_run_containers = deployeds(
    lambda delta: (delta.operation == "CREATE" or delta.operation == "MODIFY") and delta.deployedOrPrevious.type == "docker.RunContainer")

map(create_docker_container, sorted(docker_run_containers, sort_by_link))
map(start_docker_container, sorted(docker_run_containers, sort_by_link))
