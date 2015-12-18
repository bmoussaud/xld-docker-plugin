# TODO #

* Delete data in the volume (DESTROY)
* XL Deploy plugins packaged as docker images (xld smoke test plugin as a container).
* Docker Swarm.
* Decide if the container_name should contains the application name (like in docker-compose)
* Support Docker network http://www.javacodegeeks.com/2015/11/deploying-containers-docker-swarm-docker-networking.html
    $ docker create network mynetwork
    Error: Error response from daemon: 500 Internal Server Error: failed to parse pool request for address space "GlobalDefault" pool "" subpool "": cannot find address space GlobalDefault (most likely the backing datastore is not configured)
    - https://github.com/docker/docker/issues/17932
    - https://gist.github.com/cpuguy83/79ad11aaf8e78c40ca71
 
 
