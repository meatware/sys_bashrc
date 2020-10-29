
docker abbreviations
====================


***(in /home/bsgt/sys_bashrc/aliases/docker_aliases.sh)***
## Aliases


| **Alias Name** | **Code** | **Descripion** |
| :------------- |:-------------:| -----:|
| **dk** | `docker` | 
| **dklc** | `docker ps -l' ` |  List last Docker container
| **dklcid** | `docker ps -l -q' ` |  List last Docker container ID
| **dklcip** | `docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)' ` |  Get IP of last Docker container
| **dkps** | `docker ps' ` |  List running Docker containers
| **dkpsa** | `docker ps -a' ` |  List all Docker containers
| **dki** | `docker images' ` |  List Docker images
| **dkrmac** | `docker rm $(docker ps -a -q)' ` |  Delete all Docker containers
| **dkelc** | `docker exec -it $(dklcid) bash --login'` |  Enter last container (works with Docker 1.3 and above)
| **dkrmflast** | `docker rm -f $(dklcid)` | 
| **dkbash** | `dkelc` | 
| **dkex** | `docker exec -it '` |  Useful to run any commands into container without leaving host
| **dkri** | `docker run --rm -i ` | 
| **dkrit** | `docker run --rm -it ` | 
| **dkip** | `docker image prune -a -f` | 
| **dkvp** | `docker volume prune -f` | 
| **dksp** | `docker system prune -a -f` | 
| **dkpruneall** | `docker system prune -a -f --all --volumes` | 
| **dm** | `docker-machine` | 
| **dmx** | `docker-machine ssh` | 
| **dks** | `docker service` | 
| **dkrm** | `docker rm` | 
| **dkl** | `docker logs` | 
| **dklf** | `docker logs -f` | 
| **dkflush** | `docker rm $(docker ps --no-trunc -aq)` | 
| **dkflush2** | `docker rmi $(docker images --filter "danglin` | 
| **dkt** | `docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"` | 
| **dkps** | `docker ps` | 
