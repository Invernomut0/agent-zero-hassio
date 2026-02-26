# Custom Sidebar Configuration for Agent Zero

Add this configuration to your Custom Sidebar configuration file (typically `<config directory>/www/sidebar-config.yaml`).

## Configuration

```yaml
order:
  - new_item: true
    item: 'Agent Zero'
    name: 'Agent Zero'
    icon: 'mdi:robot'
    href: 'http://YOUR_HA_IP:50001'
    target: '_blank'
    order: 10
```

**Important:** Replace `YOUR_HA_IP` with your actual Home Assistant IP address (e.g., `192.168.1.100`).

## Configuration Options Explained

- `new_item: true` - Creates a new sidebar item
- `item: 'Agent Zero'` - Unique identifier for the item
- `name: 'Agent Zero'` - Display name in the sidebar
- `icon: 'mdi:robot'` - Material Design Icon (robot icon)
- `href: 'http://YOUR_HA_IP:50001'` - URL to Agent Zero
- `target: '_blank'` - Opens in new tab/window
- `order: 10` - Position in sidebar (adjust as needed)

## Alternative: Open in Same Tab

If you prefer to open Agent Zero in the same tab (embedded in HA interface), remove the `target` line:

```yaml
order:
  - new_item: true
    item: 'Agent Zero'
    name: 'Agent Zero'
    icon: 'mdi:robot'
    href: 'http://YOUR_HA_IP:50001'
    order: 10
```

## Steps to Apply

1. Open your Custom Sidebar configuration file
2. Add the above configuration to the `order:` section
3. Replace `YOUR_HA_IP` with your actual IP
4. Save the file
5. Refresh your Home Assistant browser page (Ctrl+F5 or Cmd+Shift+R)

## Troubleshooting

If the item doesn't appear:
1. Check Custom Sidebar is installed and enabled
2. Verify the configuration file path is correct
3. Check browser console for errors (F12)
4. Make sure Agent Zero addon is running and accessible on port 50001

## Other Icon Options

You can use different icons from [Material Design Icons](https://pictogrammers.com/library/mdi/):

- `mdi:robot` - Robot icon (default)
- `mdi:account-voice` - Voice/AI icon
- `mdi:brain` - Brain icon
- `mdi:chat` - Chat icon
- `mdi:android` - Android icon
- `mdi:robot-happy` - Happy robot icon
