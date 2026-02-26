#!/bin/bash
set -e

# Configuration
AGENT_ZERO_PORT=50001
NGINX_PORT=8099

echo "Starting Agent Zero addon for Home Assistant..."

# Ensure Agent Zero uses port 50001 internally
export WEB_UI_PORT=$AGENT_ZERO_PORT
export WEB_UI_HOST="127.0.0.1"

# Test nginx configuration first
echo "Testing nginx configuration..."
nginx -t
if [ $? -ne 0 ]; then
    echo "ERROR: nginx configuration test failed"
    exit 1
fi

# Start nginx in background (listens on port 8099 for HA Ingress)
echo "Starting nginx reverse proxy on port $NGINX_PORT..."
nginx -g 'daemon off;' &
NGINX_PID=$!

# Give nginx time to bind to port
sleep 2

# Check if nginx started successfully
if ! kill -0 $NGINX_PID 2>/dev/null; then
    echo "ERROR: nginx failed to start"
    cat /var/log/nginx/error.log 2>/dev/null || echo "No nginx error log available"
    exit 1
fi

echo "Nginx started successfully (PID: $NGINX_PID)"

# Start Agent Zero on internal port 50001
echo "Starting Agent Zero on port $AGENT_ZERO_PORT..."

# Execute the original entrypoint from the base image
# This starts the full Agent Zero suite
exec /start.py "$@"
