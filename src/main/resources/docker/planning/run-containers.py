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

def generate_steps(deployed):
    context.addStep(steps.os_script(
        description="Run the container '%s' (%s)" % (deployed.name, deployed.image),
        order=65,
        script="docker/docker-run",
        freemarker_context={'deployed': deployed},
        target_host=deployed.container.host))

docker_run_containers = deployeds(lambda delta: (delta.operation == "CREATE" or delta.operation == "MODIFY") and delta.deployedOrPrevious.type == "docker.RunContainer")
map(generate_steps,sorted(docker_run_containers, sort_by_link))
