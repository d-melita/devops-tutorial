Now, we will run a simple bash script that generates log messages. This script will write log messages to a file, which will be picked up by Promtail and sent to Loki for storage.

1. Create a new file named `log-generator.sh` using the following command:

```bash
touch log-generator.sh
```{{execute}}

2. Open the `log-generator.sh` file in a text editor:

```bash
nano log-generator.sh
```{{execute}}

3. Add the following content to the `log-generator.sh` file:

```bash
#!/bin/bash

# Log file location
LOG_FILE="/var/log/spoon.log"

# Create the log file if it does not exist
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

# Function to log the message
log_message() {
    # Generate a random number between 1 and 100
    RANDOM_NUMBER=$(( RANDOM % 100 ))

    # Determine the message and status based on probabilities
    if (( RANDOM_NUMBER < 10 )); then
        MESSAGE="spoon is not the best"
        STATUS="super error"
    elif (( RANDOM_NUMBER < 30 )); then
        MESSAGE="spoon is not the best"
        STATUS="error"
    else
        MESSAGE="spoon is the best"
        STATUS="success"
    fi

    # Write the log entry to the log file
    echo "$MESSAGE | $STATUS" >> "$LOG_FILE"
}

# Run the logging function every 5 seconds in the background
while true; do
    log_message
    sleep 5
done &
```

4. Save the file and exit the text editor.

5. Make the script executable using the following command:

```bash
chmod +x log-generator.sh
```{{execute}}

Now, the `log-generator.sh` script is ready to generate log messages that will be picked up by Promtail and stored in Loki. Let's run the script in the background so that it continues to generate log messages.

6. Run the script in the background:

```bash
.sudo /log-generator.sh &
```{{execute}}

The script will start generating log messages every 5 seconds. These log messages will be stored in the `spoon.log` file located in the `/var/log` directory. Promtail will collect these log messages and send them to Loki for storage and visualization in Grafana.
