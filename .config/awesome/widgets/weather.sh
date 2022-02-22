#!/bin/sh

weather() {
  curl wttr.in/~"$1"\?format="%C%20%t%20%w"
}

weather "$1"
