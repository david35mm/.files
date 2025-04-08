#!/bin/sh

find "$HOME" \
  -type d -exec chmod 700 {} + \
  -o -type f \( -iname "*.sh" -o -iname "*.appimage" \) -exec chmod 700 {} + \
  -o -type f -exec chmod 600 {} +
chmod -R 700 "$HOME"/.local/share/flatpak
