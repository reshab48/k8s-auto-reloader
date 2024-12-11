#!/bin/bash

LATEST_LINK="/app/latest"
FLASK_PID=0
LAST_TARGET=""

start_flask_app_and_monitor() {
    echo "Starting Flask app..."
    python -m flask run --host=0.0.0.0 &
    FLASK_PID=$!

    # Monitor the latest symlink for changes
    echo "Monitoring $LATEST_LINK for changes..."
    while true; do
        CURRENT_TARGET=$(readlink "$LATEST_LINK")
        if [ "$CURRENT_TARGET" != "$LAST_TARGET" ]; then
            echo "Sync detected. Latest points to $CURRENT_TARGET"
            LAST_TARGET=$CURRENT_TARGET
            reload_flask_app
        fi
        sleep 2
    done
}

reload_flask_app() {
    echo "Changes detected. Reloading Flask app..."
    if [ $FLASK_PID -ne 0 ]; then
        kill -HUP $FLASK_PID
        wait $FLASK_PID
    fi
    start_flask_app_and_monitor
}

# Ensure the latest symlink exists
echo "Waiting for $LATEST_LINK to be created..."
while [ ! -L "$LATEST_LINK" ]; do
    echo "Symlink $LATEST_LINK not found. Retrying in 2 seconds..."
    sleep 2
done
echo "Symlink $LATEST_LINK is ready."
LAST_TARGET=$(readlink "$LATEST_LINK")

# Initialize
start_flask_app_and_monitor
