We now have Loki and Grafana configured and ready to go, but we need a way to ingest logs
from different applications into Loki.
Fortunately, a companion tool called [Promtail] does just that, allowing us to send logs from
all applications into Loki.
Unlike Loki and Grafana, Promtail can and should be deployed in all machines whose logs we
want to ingest.
An example of a real-world setup is this:

![Log flow in a real application](../assets/log-flow-complete.svg)

The arrows in the diagram indicate how the logs flow through the system.

For the purpose of this tutorial however, we will only reproduce a small part
of this setup, putting just a single application in the same host as Loki
and Grafana.
Therefore, you will be building this:

![Log flow in this tutorial](../assets/log-flow-tutorial.svg)

Now, you will add both Promtail and a sample application to your Docker Compose configuration.

1. In the `loki-grafana` directory, create a `config-promtail.yml` file:

   ```bash
   touch config-promtail.yml
   ```{{exec}}

2. Open this file (for simplicity, you can use KillerCoda's built-in text editor) and
   add the following configuration:

   ```yml
   clients:
     - url: http://loki:3100/loki/api/v1/push

   scrape_configs:
     - job_name: flog_scrape
       docker_sd_configs:
         - host: unix:///var/run/docker.sock
           refresh_interval: 5s
           filters:
             - name: label
               values: ["logging=promtail"]
       relabel_configs:
         - source_labels: ['__meta_docker_container_name']
           regex: '/(.*)'
           target_label: 'container'
   ```{{copy}}

   This configures Promtail to [get the logs from Docker][promtail-docker], and applies a small
   transformation to the containers' name to remove the leading slash (`/`).
   Using this configuration, the logs all containers annotated with the label `logging=promtail`
   will be ingested by Promtail.

3. Save and close the file.

4. Open the `docker-compose.yml` file that you created earlier (again, for simplicity, you can use
   KillerCoda's built-in text editor).

5. Under the `services` object, add Promtail:

   ```yml
     promtail:
       image: grafana/promtail:3.2.0
       volumes:
         - ./config-promtail.yml:/etc/promtail/config.yml:ro
         - /var/run/docker.sock:/var/run/docker.sock
       networks:
         - loki
   ```{{copy}}

   Here, we are mounting both the Promtail config that we just created and the socket for
   the Docker daemon, allowing Promtail to query logs from Docker.

6. Also under `services`, add a sample application:

   ```yml
     spoon-app:
       container_name: spoon-app
       image: ghcr.io/d-melita/devops-tutorial:edge
       labels:
         logging: "promtail"
   ```{{copy}}

   As mentioned, we configured Promtail to only fetch logs from containers with the
   `logging=promtail` label, so that must be set here.
   We are also assigning a name to the container to make it easier to filter logs by container.

   This application simply logs a message to stdout every few seconds.

7. Save and close the file.

<details>
<summary>Full contents of the docker-compose.yml file at this stage</summary>

If you have gotten lost in the previous steps, this is what the `docker-compose.yml` file
should look like at this point:

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

  promtail:
    image: grafana/promtail:3.2.0
    volumes:
      - ./config-promtail.yml:/etc/promtail/config.yml:ro
      - /var/run/docker.sock:/var/run/docker.sock
    networks:
      - loki

  spoon-app:
    container_name: spoon-app
    image: ghcr.io/d-melita/devops-tutorial:edge
    labels:
      logging: "promtail"

networks:
  loki:

volumes:
  grafana-storage:
  loki-storage:
```{{copy}}

</details>

You have now fully configured all the containers needed for this tutorial.
In the next step, you will start these containers and verify that they are working
correctly.

[Promtail]: https://grafana.com/docs/loki/latest/send-data/promtail/
[promtail-docker]: https://grafana.com/docs/loki/latest/send-data/promtail/configuration/#docker_sd_configs
