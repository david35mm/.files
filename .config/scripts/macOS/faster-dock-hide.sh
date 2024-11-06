#!/bin/sh

defaults write com.apple.dock autohide-delay -int 0
# defaults write com.apple.dock autohide-time-modifier -int 1
killall Dock
