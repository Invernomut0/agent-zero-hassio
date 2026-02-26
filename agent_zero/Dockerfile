ARG BUILD_FROM
FROM $BUILD_FROM

# Install nginx for reverse proxy with URL rewriting
RUN apt-get update && apt-get install -y --no-install-recommends nginx && rm -rf /var/lib/apt/lists/*

# Patch Agent Zero startup script in SOURCE directory (before runtime copy)
# The initialization copies from /git/agent-zero to /a0, so we must patch the source
RUN if [ -f /git/agent-zero/run_A0.sh ]; then \
        sed -i 's/--port=80/--port=${WEB_UI_PORT:-80}/' /git/agent-zero/run_A0.sh; \
    fi && \
    if [ -f /exe/run_A0.sh ]; then \
        sed -i 's/--port=80/--port=${WEB_UI_PORT:-80}/' /exe/run_A0.sh; \
    fi

# Create nginx configuration directory and remove default site
RUN mkdir -p /etc/nginx/sites-available /etc/nginx/sites-enabled && \
    rm -f /etc/nginx/sites-enabled/default

# Copy nginx configuration
COPY nginx.conf /etc/nginx/sites-available/agent-zero
RUN ln -sf /etc/nginx/sites-available/agent-zero /etc/nginx/sites-enabled/

# Copy custom supervisord config that includes nginx
COPY supervisord-nginx.conf /etc/supervisor/conf.d/nginx.conf

# Ensure main supervisord config includes conf.d directory
RUN grep -q "files.*conf.d/\*\.conf" /etc/supervisor/supervisord.conf || \
    echo -e "\n[include]\nfiles = /etc/supervisor/conf.d/*.conf" >> /etc/supervisor/supervisord.conf

# Override ENTRYPOINT (not CMD) since base image uses ENTRYPOINT
ENTRYPOINT ["/exe/initialize.sh"]
