#!/bin/sh

sudo sed -i 7q /etc/hosts
curl -s "https://divested.dev/hosts" | sudo tee -a /etc/hosts