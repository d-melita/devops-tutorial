# Real-Time Log Monitoring with Loki and Grafana

### Motivation and Background

In modern software development and operations, monitoring logs from various services is essential
to ensure everything is running smoothly.
By using Loki and Grafana for real-time log monitoring, teams can quickly identify issues,
improve collaboration, automate responses, and support continuous improvement, all of which
are of utmost importance for maintaining reliable system performance.

### Tutorial Overview

In this tutorial, you will set up a real-time log monitoring solution using Loki for
log aggregation and Grafana for visualization.
This tutorial will teach you how to install and configure Loki, integrate it with Grafana,
and create dashboards to visualize logs.
Additionally, you will write queries to extract insights and set up alerts based on log patterns.

At the end, you will be given additional steps to can take to deepen your knowledge in the topic.

### Prerequisites

While there are no hard requirements for following this tutorial, the tutorial will
assume (i.e., these will not be explained) that the user is familiar with basic
terminal commands, as well as Docker Compose.

If you are not familiar with Docker and/or Docker Compose, you are still free to take
this tutorial, but you might want to learn more about it afterwards.

### Intended Learning Outcomes

By the end of this tutorial, you are expected to be able to:

- explain what Loki, Grafana and Promtail are and their role in the log
  monitoring pipeline;
- use Docker Compose to deploy these 3 services;
- use Promtail to send logs to Loki;
- configure Promtail to read logs from the Docker socket;
- connect Loki to Grafana;
- add a dashboard to Grafana;
- add a "Logs" visualization to a Grafana dashboard, with or without filters;
- setup contact points for Grafana;
- setup alerts on Grafana based on certain conditions (e.g., log counts).

![Grafana Loki](./assets/lokiGrafana.png)
