#!/usr/bin/env bash

# Log a random message (spoon-themed)
log_message() {
    # Generate a random number between 1 and 100
    RANDOM_NUMBER=$(( RANDOM % 100 ))

    # Get the current timestamp
    TIMESTAMP=$(date +"%Y-%m-%dT%H:%M:%S%z")

    # Determine the message and status based on probabilities
    if (( RANDOM_NUMBER < 10 )); then
        MESSAGE="spoon is the worst"
        STATUS="error"
    elif (( RANDOM_NUMBER < 30 )); then
        MESSAGE="spoon is ok, but there are better tools"
        STATUS="warning"
    else
        MESSAGE="spoon is the best"
        STATUS="success"
    fi

    # Output the log entry to stdout
    echo "time=$TIMESTAMP level=$STATUS msg=\"$MESSAGE\""
}

# Run the logging function every 1-6 seconds (randomly picked)
while true; do
    log_message
    sleep "$(( 1 + (RANDOM % 6) ))"
done
