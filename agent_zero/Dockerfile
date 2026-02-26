ARG BUILD_FROM=agent0ai/agent-zero:latest
FROM $BUILD_FROM

# Install nginx for reverse proxy with URL rewriting
RUN apt-get update && apt-get install -y --no-install-recommends nginx && rm -rf /var/lib/apt/lists/*

# Patch initialize.sh to use WEB_UI_PORT environment variable
# The UI is launched by /exe/initialize.sh with python /a0/run_ui.py --port=80
RUN sed -i 's/--port=80/--port=${WEB_UI_PORT:-80}/' /exe/initialize.sh

# Create nginx configuration directory and remove default site
RUN mkdir -p /etc/nginx/sites-available /etc/nginx/sites-enabled && \
    rm -f /etc/nginx/sites-enabled/default

# Copy nginx configuration
COPY nginx.conf /etc/nginx/sites-available/agent-zero
RUN ln -sf /etc/nginx/sites-available/agent-zero /etc/nginx/sites-enabled/

# Copy custom supervisord config that includes nginx
COPY supervisord-nginx.conf /etc/supervisor/conf.d/nginx.conf

# Ensure main supervisord config includes conf.d directory
# The main config is at /etc/supervisor/conf.d/supervisord.conf
RUN grep -q "\[include\]" /etc/supervisor/conf.d/supervisord.conf || \
    echo -e "\n[include]\nfiles = /etc/supervisor/conf.d/*.conf" >> /etc/supervisor/conf.d/supervisord.conf

# Override ENTRYPOINT (not CMD) since base image uses ENTRYPOINT
ENTRYPOINT ["/exe/initialize.sh"]
