This repo provides a quick way to play with ByConity with docker compose.

Noted, since FoundationDB cannot work propertly in Docker on Apple Silicon machines, this repo is not working on mac m1/m2.

The structure of this repo is shown below.

| Module                      | Description |
|----------------------------|-------------|
| [asserts](assets/)               | static files    |
| [build](build/)       |    build ByConity docker image     |
| [byconity-multiworkers-cluster](byconity-multiworkers-cluster/)       | multi worker configurations        |
| [byconity-simple-cluster](byconity-simple-cluster/)           | single worker configurations        |
| [datasets](datasets/)         | some dataset for testing        |
| [hdfs](hdfs/) | hdfs config        |
| [docker-compose.yml](docker-compose.yml) | docker compose file       |
| [docker-compose.yml.multiworkers](docker-compose.yml.multiworkers) | docker compose file for multi worker        |

## Bring the cluster up

From the current directory, run:

```
docker-compose up
```

Wait until all containers are ready. By default, docker exposes the tcp port at 9000 and http port at 8123. We can use following commands to check the readiness of byconity components: 

```s
# return 1 indicates that server is working properly
curl '127.0.0.1:8123/?query=select%20count()%20from%20system.one'
# return 1 indicates that read worker is working properly and server can connect to it
curl '127.0.0.1:8123/?query=select%20count()%20from%20cnch(`vw_default`,system,one)'
# return 1 indicates that write worker is working properly and server can connect to it
curl '127.0.0.1:8123/?query=select%20count()%20from%20cnch(`vw_write`,system,one)'
```

## Trying some basic queries

Internally, byconity read/write to hdfs with username `clickhouse` (and data is stored in `/user/clickhouse/`), which is not created by default when starting hadoop cluster. We can use following commands to create the user `clickhouse` on hdfs.

```s
./hdfs/create_users.sh
```

Connect to byconity with command

```s
docker exec -it server-0 clickhouse-client --port 52145
```

