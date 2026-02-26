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

**⚠️ System Requirements:**
- Minimum 2GB RAM available for the addon
- Recommended 4GB+ RAM for optimal performance
- If running on low-memory systems (< 4GB total), you may need to increase swap space

1. Add this repository to Home Assistant: `https://github.com/Invernomut0/agent-zero-hassio`
2. Go to Settings > Add-ons > Add-on Store
3. Find "Agent Zero" and click Install
4. Configure the addon (see Configuration section)
5. Start the addon
6. Access via the Home Assistant sidebar

**Note:** Initial startup may take 1-2 minutes as Agent Zero initializes.

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

### Addon keeps restarting / OOM errors

If you see `exit status 137` or processes being killed in logs:

1. **Check available memory:** The addon requires ~1-2GB RAM during operation
2. **Increase system memory:** If your HA system has < 4GB total RAM, consider:
   - Increasing VM/system RAM allocation
   - Adding swap space (see [HA swap guide](https://community.home-assistant.io/t/how-to-increase-the-swap-file-size-on-home-assistant-os/272226))
   - Stopping other heavy addons temporarily
3. **Wait for initialization:** First startup can take 2-3 minutes - be patient

### Black screen when opening addon

1. Check addon logs for "Agent Zero is running" message
2. Wait 2-3 minutes for full initialization
3. Try refreshing the browser page
4. Check browser console (F12) for errors

### Other Issues

- **Container won't start:** Check Docker is running and ports aren't conflicting
- **Authentication issues:** Verify username/password in addon configuration
- **API key errors:** Ensure your LLM provider API key is correctly set

## License

MIT License