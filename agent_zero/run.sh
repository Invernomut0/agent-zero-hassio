#!/usr/bin/with-contenv bashio

# Fix file descriptor limit issue (HA OS 10+)
ulimit -n 1048576

# Get configuration from HA
export A0_SET_model_provider="$(bashio::config 'model_provider')"
export A0_SET_model_name="$(bashio::config 'model_name')"
export A0_SET_api_key="$(bashio::config 'api_key')"
export A0_SET_context_length="$(bashio::config 'context_length')"
export AUTH_LOGIN="$(bashio::config 'username')"
export AUTH_PASSWORD="$(bashio::config 'password')"
export A0_SET_memory_enabled="$(bashio::config 'memory_recall')"
export A0_SET_agent_profile="$(bashio::config 'agent_profile')"

# Set host/port for HA ingress
export WEB_UI_HOST="${WEB_UI_HOST:-0.0.0.0}"
export WEB_UI_PORT="${WEB_UI_PORT:-80}"

# Disable heavy services to reduce memory usage
export A0_SET_searxng_server_enabled="${A0_SET_searxng_server_enabled:-false}"
export A0_SET_cloudflare_tunnel_enabled="${A0_SET_cloudflare_tunnel_enabled:-false}"

bashio::log.info "Starting Agent Zero..."
bashio::log.info "Model: ${A0_SET_model_provider}/${A0_SET_model_name}"

# The base image has its own entrypoint - we exec into it
exec /exe/run.sh
