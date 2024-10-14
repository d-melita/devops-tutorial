Now that we have the `docker-compose.yml` file configured, we can start
all four containers using the `docker-compose` command.

1. Run the following command to start the containers:

   ```bash
   docker-compose up -d
   ```{{exec}}

   This command starts Loki, Promtail, Grafana and the sample application
   in detached mode, which means they will run in the background.

2. To verify that the containers are running, you can use the following command:

   ```bash
   docker ps
   ```{{exec}}

   This command lists all the running containers on your system.
   You should see all four containers in the list, as below.

   ```
   CONTAINER ID   IMAGE                                   COMMAND                  CREATED          STATUS          PORTS                                       NAMES
   5ef6b692ce03   grafana/grafana:11.2.2                  "/run.sh"                21 seconds ago   Up 15 seconds   0.0.0.0:3000->3000/tcp, :::3000->3000/tcp   loki-grafana-grafana-1
   1aa92a70aec1   ghcr.io/d-melita/devops-tutorial:edge   "docker-entrypoint.s…"   21 seconds ago   Up 15 seconds                                               spoon-app
   3f3ba62c084b   grafana/promtail:3.2.0                  "/usr/bin/promtail -…"   21 seconds ago   Up 15 seconds                                               loki-grafana-promtail-1
   d0df40edc9f7   grafana/loki:3.2.0                      "/usr/bin/loki -conf…"   21 seconds ago   Up 15 seconds   3100/tcp                                    loki-grafana-loki-1
   ```

That is all, you have now successfully started all four containers!

Before proceeding, take a look at the logs we will be importing into Grafana:

```bash
docker-compose logs spoon-app
```

In the next step, you will login into Grafana and configure Loki as a data source.
