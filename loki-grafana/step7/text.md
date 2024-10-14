In this step our main focus is to create an alert based on a log pattern.
We will create an alert in Grafana that will trigger when a specific log pattern is detected
in the logs stored in Loki.
This will help us to quickly identify issues and take action when necessary.

1. First of all, we will start by adding a Contact Point.
   To do so, click on the menu icon on the left sidebar and select `Alerting`,
   then `Contact points`, and finally click on `Add contact point`.

   ![](../assets/add-contact-point.png)

2. There are multiple integrations available in Grafana, such as Slack, Discord, Email, and more.
   For the purpose of this tutorial, we will use the `Webhook` integration as a proof-of-concept.
   Start by naming the contact point as you want and then, on the `Integration` field,
   select `Webhook` (should be at the bottom of the list).
   If you prefer, you are free to instead use another integration of your choosing.

   ![](../assets/webhook.png)

3. Then, for the URL field, go to [webhook.site](https://webhook.site/) and copy
   `Your unique URL` (by clicking on it) to the `URL` field in Grafana.
   Again, this is simply for the purpose of this tutorial; in a real world deployment you might
   want to pick a different integration.

   If you want, you can test if it is working by clicking on `Test` and then
   `Send test notification`.
   A green pop-up should appear confirming that the notification was sent and you should see
   a request on the Webhook site.
   Finally, to save this contact point, click on `Save contact point`.

4. To create a new alert rule, click on the menu icon on the left sidebar and select `Alerting`,
   then `Alert rules`, and finally click on `New alert rule`, as shown below.

   ![](../assets/new-alert-rule.png)

5. Let's create an alert that will trigger when more than 5 errors (not warnings) are detected
   in the logs in a given time range.
   Start by giving a name to the alert.

   ![](../assets/more-than-five.png)

6. Next, change the query type to `Code` and write the following query:

   ```
   count(rate({container="spoon-app"} | logfmt | level = `error` [5m]))
   ```{{copy}}

   Alternatively, you can use the `Builder` tab to select the right container and
   add the various operations, as shown below:

   ![](../assets/query-super-error.png)

7. Click on `Run queries` to visualize the query, making sure that it looks as intended.

8. Next, we need to set the `Expressions`. Set the threshold to the desired value
   (in this case, 5), as shown below.
   This means that the alert will trigger when more than 5 errors are detected in the logs
   in the last 5 minutes.

   ![](../assets/five.png)

   By clicking on `Preview` you can see how the alert would behave.
   It can either be `Firing`, as in the image, or `Normal`.

9. To set the evaluation behavior, start by creating a folder for where the alert will be stored.

   ![](../assets/new-folder.png)

10. For the evaluation group and interval, create a new one and set the `Evaluation Interval` to `10s`. The pending period should be set to `None` so the alert is triggered as soon as the condition is met. Your `Evaluation behavior` should look like this:

    ![](../assets/evaluation.png)

11. For `Configuring Labels and Notifications`, set the `Contact Point` to the Webhook previously created.

    ![](../assets/contact-point.png)

12. On `Add annotations`, set it as you want. You can add a description, a summary, and more.

    ![](../assets/annotations.png)

13. Finally, click on the blue `Save rule and exit` button on the top right to save the alert.

14. By now, there must be more than 5 errors in the logs.
    Therefore, if you wait a few seconds, the alert's state should change to `Firing`.

    ![](../assets/firing.png)

    Additionally, you can check the Webhook site to see the notification being sent,
    and it should look like this:

    ![](../assets/webhook-request.png)

Congratulations!
You have successfully created an alert in Grafana that triggers when more than
5 errors are detected in the logs stored in Loki (in the last 5 minutes).
This will help you to quickly identify issues and take action when necessary.
You can further customize the alert by adding more conditions,
notifications, and actions.
You can either create more alerts or customize the existing one to better suit your needs.
