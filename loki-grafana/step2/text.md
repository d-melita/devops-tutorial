# Step 2: Run the docker containers

Now that we have the `docker-compose.yml` file configured, we can start the Loki, Promtail, and Grafana containers using the `docker-compose` command.

1. Run the following command to start the containers:

```bash
docker-compose up -d
```{{exec}}

This command will start the Loki, Promtail, and Grafana containers in detached mode, which means they will run in the background.

2. To verify that the containers are running, you can use the following command:

```bash
docker ps
```{{exec}}

This command will list all the running containers on your system. You should see the Loki, Promtail, and Grafana containers in the list.
