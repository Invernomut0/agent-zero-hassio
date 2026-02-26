#!/usr/bin/with-contenv bashio
set -e

bashio::log.info "Starting Agent Zero Home Assistant Addon..."

# Install nginx if not present
if ! command -v nginx &> /dev/null; then
    bashio::log.info "Installing nginx..."
    apk add --no-cache nginx
fi

# Create nginx configuration for URL rewriting
bashio::log.info "Configuring nginx reverse proxy..."
cat > /etc/nginx/http.d/agent-zero.conf <<'EOF'
server {
    listen 8099;
    server_name localhost;

    location / {
        proxy_pass http://127.0.0.1:50001;
        
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        proxy_buffering off;
        proxy_request_buffering off;
        
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }

    # URL rewriting for static assets
    sub_filter_once off;
    sub_filter_types text/html text/css application/javascript application/json;
    sub_filter 'href="/' 'href="./';
    sub_filter 'src="/' 'src="./';
    sub_filter 'url(/' 'url(./';
}
EOF

# Start nginx in background
bashio::log.info "Starting nginx on port 8099..."
nginx
if [ $? -ne 0 ]; then
    bashio::log.error "Failed to start nginx"
    exit 1
fi

# Pull Agent Zero image if not present
bashio::log.info "Checking for Agent Zero Docker image..."
if ! docker image inspect agent0ai/agent-zero:latest &> /dev/null; then
    bashio::log.info "Pulling agent0ai/agent-zero:latest..."
    docker pull agent0ai/agent-zero:latest
fi

# Stop and remove existing Agent Zero container if it exists
if docker ps -a | grep -q agent-zero-instance; then
    bashio::log.info "Removing existing Agent Zero container..."
    docker stop agent-zero-instance || true
    docker rm agent-zero-instance || true
fi

# Start Agent Zero container
bashio::log.info "Starting Agent Zero on internal port 50001..."
docker run -d \
    --name agent-zero-instance \
    --network host \
    -e WEB_UI_HOST=127.0.0.1 \
    -e WEB_UI_PORT=50001 \
    -e A0_SET_searxng_server_enabled=false \
    -e A0_SET_cloudflare_tunnel_enabled=false \
    -v /data/agent-zero:/data \
    agent0ai/agent-zero:latest

if [ $? -ne 0 ]; then
    bashio::log.error "Failed to start Agent Zero container"
    exit 1
fi

bashio::log.info "Agent Zero addon started successfully!"
bashio::log.info "Access via Home Assistant Ingress on port 8099"

# Keep the script running and monitor both services
trap "bashio::log.info 'Shutting down...'; docker stop agent-zero-instance; nginx -s stop; exit 0" SIGTERM SIGINT

# Monitor loop
while true; do
    # Check if nginx is running
    if ! pgrep nginx > /dev/null; then
        bashio::log.error "Nginx stopped unexpectedly"
        exit 1
    fi
    
    # Check if Agent Zero container is running
    if ! docker ps | grep -q agent-zero-instance; then
        bashio::log.error "Agent Zero container stopped unexpectedly"
        exit 1
    fi
    
    sleep 10
done
