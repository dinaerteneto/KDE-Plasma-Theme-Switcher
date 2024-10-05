#!/bin/bash

# Check if the .config directory exists
if [ ! -d "$HOME/.config" ]; then
  mkdir -p "$HOME/.config"
fi

# Move the config file to ~/.config
cp theme_config "$HOME/.config/theme_config"

echo "Configuration file installed to ~/.config/theme_config"
