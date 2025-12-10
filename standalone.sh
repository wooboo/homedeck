#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    # If running as root (e.g. in a container or minimal OS), ensure udev is ready
    if [ -x "/lib/systemd/systemd-udevd" ]; then
        /lib/systemd/systemd-udevd --daemon
    fi
    udevadm control --reload-rules
    udevadm trigger
fi

# Use venv if available
if [ -d ".venv" ]; then
    source .venv/bin/activate
fi

# Clear pycache to ensure fresh code is loaded
find . -type d -name "__pycache__" -exec rm -rf {} +

python server.py


