# Agent Zero - Home Assistant Addon

## Overview

Agent Zero is an open-source AI agent framework designed as a personal, organic, and dynamically growing assistant. It operates on a prompt-based architecture where the entire behavior is guided by system prompts.

### Key Features

- Multi-agent hierarchy
- Persistent memory
- Full transparency and customizability
- Skills system (SKILL.md standard)
- MCP Support
- A2A Protocol

## Installation

1. Copy the `agent_zero` folder to your Home Assistant addons directory
2. Restart Home Assistant
3. Go to Settings > Add-ons > Add-on Store
4. Find "Agent Zero" and click Install
5. Configure and start the addon

## Configuration

### Required Options

- **model_provider**: LLM provider (anthropic, openai, ollama, openrouter, aws)
- **model_name**: Model name (e.g., claude-3-5-sonnet-20241022)
- **password**: Web UI password

### Optional Options

- **port**: Web UI port (default: 8080)
- **api_port**: API port (default: 8000)
- **context_length**: Context window size (default: 200000)
- **username**: Web UI username (default: admin)
- **memory_recall**: Enable memory (default: true)
- **agent_profile**: Profile to use (default: agent0)

## Security

WARNING: This addon has significant capabilities including code execution, terminal access, and file system access. Use with caution.

## Troubleshooting

- Container won't start: Check Docker is running
- Port conflicts: Change port in configuration
- Authentication issues: Verify credentials

## License

MIT License