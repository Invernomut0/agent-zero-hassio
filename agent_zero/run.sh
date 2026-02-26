#!/bin/bash
set -e

# Read configuration from Home Assistant
CONFIG_PATH=/data/options.json

# Get options with defaults
API_PORT=$(jq -r '.api_port // "8000"' $CONFIG_PATH)
MODEL_PROVIDER=$(jq -r '.model_provider // "anthropic"' $CONFIG_PATH)
MODEL_NAME=$(jq -r '.model_name // "claude-3-5-sonnet-20241022"' $CONFIG_PATH)
CONTEXT_LENGTH=$(jq -r '.context_length // "200000"' $CONFIG_PATH)
USERNAME=$(jq -r '.username // "admin"' $CONFIG_PATH)
PASSWORD=$(jq -r '.password // ""' $CONFIG_PATH)
ROOT_PASSWORD=$(jq -r '.root_password // ""' $CONFIG_PATH)
MEMORY_RECALL=$(jq -r '.memory_recall // "true"' $CONFIG_PATH)
AGENT_PROFILE=$(jq -r '.agent_profile // "agent0"' $CONFIG_PATH)
API_KEY=$(jq -r '.api_key // ""' $CONFIG_PATH)

# Build environment variables
ENV_VARS=""
[ -n "$MODEL_PROVIDER" ] && ENV_VARS="$ENV_VARS -e A0_SET_chat_model_provider=$MODEL_PROVIDER"
[ -n "$MODEL_NAME" ] && ENV_VARS="$ENV_VARS -e A0_SET_chat_model_name=$MODEL_NAME"
[ -n "$CONTEXT_LENGTH" ] && ENV_VARS="$ENV_VARS -e A0_SET_chat_model_ctx_length=$CONTEXT_LENGTH"
[ -n "$USERNAME" ] && ENV_VARS="$ENV_VARS -e A0_SET_username=$USERNAME"
[ -n "$PASSWORD" ] && ENV_VARS="$ENV_VARS -e A0_SET_password=$PASSWORD"
[ -n "$ROOT_PASSWORD" ] && ENV_VARS="$ENV_VARS -e A0_SET_root_password=$ROOT_PASSWORD"
[ "$MEMORY_RECALL" = "true" ] && ENV_VARS="$ENV_VARS -e A0_SET_memory_recall_enabled=true" || ENV_VARS="$ENV_VARS -e A0_SET_memory_recall_enabled=false"
[ -n "$AGENT_PROFILE" ] && ENV_VARS="$ENV_VARS -e A0_SET_agent_profile=$AGENT_PROFILE"
[ -n "$API_KEY" ] && ENV_VARS="$ENV_VARS -e A0_SET_anthropic_api_key=$API_KEY"

# Pull latest image
echo "Pulling Agent Zero image..."
docker pull agent0ai/agent-zero:latest

# Stop existing container if running
docker rm -f agent_zero_addon 2>/dev/null || true

# Run Agent Zero
echo "Starting Agent Zero..."
exec docker run -d \
    --name agent_zero_addon \
    --restart unless-stopped \
    -p 80:80 \
    -p $API_PORT:8000 \
    -v /data:/a0/usr \
    -v /etc/localtime:/etc/localtime:ro \
    $ENV_VARS \
    agent0ai/agent-zero:latest
