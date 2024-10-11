Before we start, we recommed you to expand this side panel a bit to better view the images of the next steps.

In this step, we’ll create a docker-compose.yaml file that will define three services: Loki, Promtail, and Grafana. Each service plays a crucial role in the setup:

- **Loki**: Loki is the log aggregation service that will store logs.
- **Promtail**: Promtail is the agent that will collect logs from your system and forward them to Loki.
- **Grafana**: Grafana will be used to visualize logs stored in Loki.



1. Start by creating a new directory for your project and navigate to it:

```bash
mkdir loki-grafana
cd loki-grafana
```{{exec}}

2. Create a new file named `docker-compose.yml`:

```bash
touch docker-compose.yml
```{{exec}}

3. Open the `docker-compose.yml` file in a text editor:

```bash
nano docker-compose.yml
```{{exec}}

4. Add the following content to the `docker-compose.yml` file:

```yaml
version: "3"

networks:
  loki:

services:
  loki:
    image: grafana/loki:2.9.10
    ports:
      - "3100:3100"
    command: -config.file=/etc/loki/local-config.yaml
    networks:
      - loki

  promtail:
    image: grafana/promtail:2.9.10
    volumes:
      - /var/log:/var/log
    command: -config.file=/etc/promtail/config.yml
    networks:
      - loki

  grafana:
    environment:
      - GF_AUTH_ANONYMOUS_ENABLED=true
      - GF_AUTH_ANONYMOUS_ORG_ROLE=Admin
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    networks:
      - loki
```

5. Save and close the file by pressing `Ctrl + X`, then `Y`, and then `Enter`.

In this file, we defined three services: `loki`, `promtail`, and `grafana`. Each service is configured with the necessary settings to run the Loki, Promtail, and Grafana containers.

- The `loki` service uses the `grafana/loki:2.9.10` image and exposes port `3100` to access the Loki service.

- The `promtail` service uses the `grafana/promtail:2.9.10` image and mounts the `/var/log` directory from the host to collect logs.

- The `grafana` service uses the `grafana/grafana:latest` image and exposes port `3000` to access the Grafana service.
