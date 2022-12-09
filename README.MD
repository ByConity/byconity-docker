## Start the cluster

Make sure you have `docker` and `docker-compose` installed on your system. From current directory, run:

```
docker-compose up
```

Wait until all containers are ready. We can use following commands to check the readiness of byconity components: 

```s
# return 1 indicates that server is working properly
curl '127.0.0.1:21557/?query=SELECT%20count()%20FROM%20system.one'
# return 1 indicates that read worker is working properly and server can connect to it
curl '127.0.0.1:21557/?query=SELECT%20count()%20FROM%20cnch(`vw_default`,system,one)'
# return 1 indicates that write worker is working properly and server can connect to it
curl '127.0.0.1:21557/?query=SELECT%20count()%20FROM%20cnch(`vw_write`,system,one)'
```

Check the tcp protocol by sending a simple query.

```s
# return 10 indicates that tcp server is working properly
docker run -it --network byconity_network -v "`pwd`/byconity/server.yml:/client.yml" hub.byted.org/clickhouse/byconity:2.0.0.27 clickhouse-client -C client.yml --host 10.5.0.4 --query "SELECT count() FROM numbers(10)"
```

## Trying some queries

Internally, byconity read/write to hdfs with username `clickhouse`, which is not created by default when starting hadoop cluster. We can use following commands to create the user `clickhouse` on hdfs.

```s
docker exec hdfs-namenode-0 hdfs dfs -mkdir /user
docker exec hdfs-namenode-0 hdfs dfs -mkdir /user/clickhouse
docker exec hdfs-namenode-0 hdfs dfs -chown clickhouse /user/clickhouse
docker exec hdfs-namenode-0 hdfs dfs -chmod -R 775 /user/clickhouse 
```

Use following command to open a client terminal to server

```s
docker run -it --network byconity_network -v "`pwd`/byconity/server.yml:/client.yml" hub.byted.org/clickhouse/byconity:2.0.0.27 clickhouse-client -C client.yml --host 10.5.0.4
```

We can use following queries to create a database, create a table, insert some data to table, and query from it:

```sql
CREATE DATABASE test;
USE test;
CREATE TABLE events (`id` UInt64, `s` String) ENGINE = CnchMergeTree ORDER BY id;
INSERT INTO events SELECT number, toString(number) FROM numbers(10);
SELECT * FROM events ORDER BY id;
```

If the system is working correctly, the select query should show a similar result as bellow:

```sql
10.5.0.4 :) SELECT * FROM events ORDER BY id;

SELECT *
FROM events
ORDER BY id ASC

Query id: b5c4bc8e-b768-432c-b24c-1aa98c5e512d

┌─id─┬─s─┐
│  0 │ 0 │
│  1 │ 1 │
│  2 │ 2 │
│  3 │ 3 │
│  4 │ 4 │
│  5 │ 5 │
│  6 │ 6 │
│  7 │ 7 │
│  8 │ 8 │
│  9 │ 9 │
└────┴───┘

10 rows in set. Elapsed: 0.015 sec. 
```