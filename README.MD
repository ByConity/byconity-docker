This repo provides a quick way to play with ByConity with docker compose.

Noted, since FoundationDB cannot work propertly in Docker on Apple Silicon machines, this repo is not working on mac m1/m2.

The structure of this repo is shown below. See [How to deploy Byconity with docker](https://byconity.github.io/docs/quick-start/deploy-byconity-with-docker)

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
