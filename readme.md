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


