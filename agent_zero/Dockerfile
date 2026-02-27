FROM node:18-alpine

# Install Bun
RUN npm install -g bun

# Install Agent Zero
RUN npm install -g @agent0ai/cli

# Create working directory
WORKDIR /app

# Copy existing configuration
COPY config.yaml /app/config.yaml
COPY DOCS.md /app/DOCS.md
COPY README.md /app/README.md
COPY translations/ /app/translations/

# Expose port
EXPOSE 50001

# Default command
CMD ["agent-zero", "--port", "80"]