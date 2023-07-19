# Docker spark

Build image with name spark-cluster
```
docker build . --tag spark-cluster
```

run with bash execution command

```shell
 docker run -p 4043:8080  -it spark-cluster bash
```

to run docker compose with 3 workers 
```
docker-compose up -d --scale worker=3
```


inspired from [docker-spark](https://hub.docker.com/r/p7hb/docker-spark) and [docker-spark-standalone](https://github.com/Ouwen/docker-spark-standalone/tree/master)


