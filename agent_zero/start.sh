#!/bin/bash
set -e

# Configuration
AGENT_ZERO_PORT=50001
NGINX_PORT=80

echo "Starting Agent Zero addon for Home Assistant..."

# Ensure Agent Zero uses port 50001 (not port 80)
export WEB_UI_PORT=$AGENT_ZERO_PORT

# Start nginx in background (listens on port 80 for HA Ingress)
echo "Starting nginx reverse proxy on port $NGINX_PORT..."
nginx -g 'daemon off;' &
NGINX_PID=$!

# Give nginx a moment to start
sleep 1

# Check if nginx started successfully
if ! kill -0 $NGINX_PID 2>/dev/null; then
    echo "ERROR: nginx failed to start"
    exit 1
fi

echo "Nginx started (PID: $NGINX_PID)"

# Start Agent Zero
# The base image should handle starting the web UI on port 50001
echo "Starting Agent Zero on port $AGENT_ZERO_PORT..."

# Execute the original command from the base image
# This typically starts the full Agent Zero suite
exec /start.py "$@"
