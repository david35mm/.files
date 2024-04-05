#!/bin/sh

if [ "$(whoami)" = root ]; then
  sed -i 7q /etc/hosts
  curl -fsSL "https://divested.dev/hosts" >> /etc/hosts
else
  printf '%b\n' "\n\t\033[0;31m\033[1m●  Error! \033[0m You must run this script as the \033[0;31mroot\033[0m user\n"
  exit 1
fi