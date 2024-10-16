In this step, we will add a new panel to the Grafana dashboard to visualize only the warning
and error logs.

### Adding a new panel to the dashboard

1. In the Dashboard view, click on `Add` and then select `Visualization`, as shown below:

   ![](../assets/add-new-visualization.png)

2. Once again make sure the visualization type is of type `Logs` and add a title and a
   description to the panel.

   ![](../assets/spoon-error-logs.png)

3. To filter logs by their level, the process to write the query is similar to the previous step.
   However, this time we will add a filter to only show logs that have level `warning` or `error`.
   You can use the following query to do exactly that, writing it in the `Code` tab:

   ```
   {container="spoon-app"} | logfmt | level =~ `warning|error`
   ```{{copy}}

   Alternatively, you can use the `Builder` tab to select the right container and add the
   filter for the log levels. You can do this as shown below:

   ![](../assets/query-builder-error.png)

   This query will filter logs of the specified container to only show those of level
   warning or error.

4. Click on `Run query` to see the logs that match the filter.
   It should look like the image below.
   If so, click on `Apply` to save the query.

   ![](../assets/query-results-error.png)

5. Now, let's save the dashboard. To do so, click on the file icon, as shown below.

   ![](../assets/save-dashboard.png)

   Provide a name for the dashboard. You can also add a description if you want.
   Finally, click on `Save` to save the dashboard.

   ![](../assets/save-dashboard-button.png)

Now your dashboard will not only display a panel with all logs but also a panel that
filters logs for warnings/errors.
You can further customize the dashboard by adding more panels, queries, and visualizations.

Your dashboard should now look similar to the following:

![](../assets/dashboard-logs.png)

In the next step, we will set up alerts in Grafana to notify you when specific log messages are detected.
