# Working with Docker Containers
1. Search an image on Docker registry `docker search [OPTIONS] TERM`
  - `docker search --limit 5 alpine`
  - `docker search --filter is-automated=true --filter stars=20 alpine`
  - add `--insecure-registry` which allows to search/pull/commit images from an insecure registry
2. Pulling an image `docker image pull [OPTIONS] NAME[:TAG|@DIGEST]`, or legacy command `docker pull [OPTIONS] NAME[:TAG|@DIGEST]`
  - `docker image pull ubuntu`
  - `docker image pull centos:centos7`
  - `docker image pull --all-tags alpine`
  - `docker image pull nginx@sha256:788fa27763db6d69ad3444e8ba72f947df9e7e163bad7c1f5614f8fd27a311c3`
3. Listing images `docker image ls` or `docker images`
4. Starting a container `docker run [OPTIONS] IMAGE [COMMAND] [ARG...]docker container run [OPTIONS] IMAGE [COMMAND] [ARG...]`
  - `docker container run -i -t --name mycontainer ubuntu /bin/bash`
  - `ID=$(docker container create -t -i ubuntu /bin/bash)`
    `docker container start -a -i $ID`
  - `docker container run -d -i -t ubuntu /bin/bash 0df95cc49e258b74be713c31d5a28b9d590906ed9d6e1a2dc75672aa48f28c4f`
  - `ID=$(docker container run -d -t -i ubuntu /bin/bash)`
    `docker attach $ID`
  - `docker container run -d ubuntu /bin/bash -c "while [ true ]; do date; sleep 1; done"`
5. Listing containers `docker container ls [OPTIONS]`, or legacy command `docker ps [OPTIONS]`
  - `docker container ls -a` show all
  - `docker container ls -aq` show all & only display numeric IDs
6. Looking at the container logs `docker container logs [OPTIONS] CONTAINER`
  - `ID=$(docker container run -d ubuntu /bin/bash -c "while [ true ]; do date; sleep 1; done")`
    `docker container logs $ID`
  - add `-t` get the timestamp with each log lines
  - add `-f` get tail-like behavior
7. Stopping a container `docker container stop [OPTIONS] CONTAINER [CONTAINER...]`, or legacy command `docker stop [OPTIONS] CONTAINER [CONTAINER...]`
  - `ID=$(docker run -d -i ubuntu /bin/bash)`
    `docker stop $ID`
  - `docker stop $(docker ps -q)` stop all container
8. Removing a container `docker container rm [OPTIONS] CONTAINER [CONTAINER]`, or legacy command `docker rm [OPTIONS] CONTAINER [CONTAINER]`
  - `ID=$(docker container create ubuntu /bin/bash)`
    `docker container stop $ID`
    `docker container rm $ID`
  - `docker stop $(docker ps -q)` stop all container firstly,
    `docker rm $(docker ps -aq)` then remove all container
9. Removing all stopped containers `docker container prune [OPTIONS]`
  - `docker container create --name c1 ubuntu /bin/bash` and `docker container run --name c2 ubuntu /bin/bash`
    `docker container prune`
  - add `-f` or `--force` to avoid the confirmation
10. Setting the restart policy on a container `docker container run --restart=POLICY [OPTIONS] IMAGE[:TAG]  [COMMAND] [ARG...]`
  - `docker container run --restart=always -d -i -t ubuntu /bin/bash`
  - `docker container run --restart=on-failure:3 -dit ubuntu /bin/bash`
11. Getting privileged access inside a container `docker container run --privileged [OPTIONS] IMAGE [COMMAND] [ARG...]`
  - `docker container run --privileged -i -t ubuntu /bin/bash`
    `mount --bind /home/ /mnt/`
    `touch /home/file-in-home`
    `ls -l /mnt/`
  - two new flags `--cap-add` and `--cap-del` to prevent chown inside container ,e.g. `docker container run --cap-drop=CHOWN [OPTIONS] IMAGE [COMMAND] [ARG...]`
12. Accessing the host device inside a container `docker container run --device=<Host Device>:<Container Device Mapping>:<Permissions> [OPTIONS] IMAGE [COMMAND]  [ARG...]`
  - `docker container run --device=/dev/sda:/dev/xvdc -it ubuntu /bin/bash`
13. Injecting a new process into a running container `docker exec [OPTIONS] CONTAINER COMMAND [ARG...]`
  - `ID=$(docker container run -d redis)`
    `docker container exec -it $ID /bin/bash`
14. Reading a container's metadata `docker container inspect [OPTIONS] CONTAINER [CONTAINER...]`
  - `ID=$(docker container run -d -i ubuntu /bin/bash)`
    `docker container inspect $ID`
  - `docker container inspect $ID --format='{{.NetworkSettings.IPAddress}}'` use the GOlang template to get specfic information
15. Labeling and filtering containers
  - `docker container ls -a --filter label=<keyword>`
  - `docker inspect $ID --format '{{json .Config.Labels}}' | jq "."`
16. Reaping a zombie inside a container `docker container run --init [OPTIONS] IMAGE [COMMAND] [ARG...] `
  - `docker container run --rm alpine pstree -p`
    `docker container run --rm alpine sh -c "pstree -p"`
    `docker container run --rm --init alpine pstree -p`
    `docker container run --rm --init alpine sh -c "pstree -p"`
# DONE