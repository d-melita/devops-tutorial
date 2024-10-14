Before you start, we recommend you to expand this side panel a bit to better
view the images of the next steps.

In this step, you will learn how to deploy [Loki] and [Grafana] with Docker Compose.
The former is a **log aggregation service**, which received and stores logs from various sources,
while the latter is a **visualization and monitoring tool**, which will be used to keep track of
the logs and send alerts when certain criteria is met.

1. Start by creating a new directory for your deployment and navigate to it:

    ```bash
    mkdir loki-grafana
    cd loki-grafana
    ```{{exec}}

2. Create a new file named `docker-compose.yml`:

    ```bash
    touch docker-compose.yml
    ```{{exec}}

3. Open the `docker-compose.yml` file in a text editor of your choice
   (for simplicity, use the built-in editor of KillerCoda) and add the following content:

    ```yaml
    version: "3"

    services:
      grafana:
        image: grafana/grafana:11.2.2
        ports:
          - "3000:3000"
        volumes:
          - grafana-storage:/var/lib/grafana
        networks:
          - loki
      loki:
        image: grafana/loki:3.2.0
        volumes:
          - loki-storage:/loki
        networks:
          - loki

    networks:
      loki:

    volumes:
      grafana-storage:
      loki-storage:
    ```{{copy}}

    This configuration creates two services, Grafana (version 11.2.2) and Loki (version 3.2.0),
    and persists their data across restarts (see `volumes`).

4. Save and close the file.

In this file, you defined two services: `loki` (using version 3.2.) and `grafana`
(using version 11.2.2).
Each service is configured to persist their data across restarts through
[Docker volumes][docker-volumes].
Port 3000 of the Grafana container is [exposed][docker-ports] to allow for external
access to the dashboard.

[Loki]: https://grafana.com/oss/loki/
[Grafana]: https://grafana.com/oss/grafana/
[docker-volumes]: https://docs.docker.com/reference/compose-file/volumes/
[docker-ports]: https://docs.docker.com/reference/compose-file/services/#ports
