# Extend official Agent Zero image (already includes Node.js and Python)
FROM agent0ai/agent-zero:latest

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash

# Add Bun to PATH
ENV PATH="/root/.bun/bin:${PATH}"

# Verify installations
RUN node --version && npm --version && bun --version

# Expose port (Agent Zero serves on port 80 internally)
EXPOSE 80