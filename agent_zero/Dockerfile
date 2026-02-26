ARG BUILD_FROM
FROM $BUILD_FROM

# Install nginx for reverse proxy with URL rewriting
RUN apt-get update && apt-get install -y --no-install-recommends nginx && rm -rf /var/lib/apt/lists/*

# Create nginx configuration directory
RUN mkdir -p /etc/nginx/sites-available /etc/nginx/sites-enabled

# Copy nginx configuration
COPY nginx.conf /etc/nginx/sites-available/agent-zero
RUN ln -sf /etc/nginx/sites-available/agent-zero /etc/nginx/sites-enabled/

# Remove default nginx site
RUN rm -f /etc/nginx/sites-enabled/default

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Keep as root - Agent Zero base image expects root permissions
CMD ["/start.sh"]
