#!/bin/sh

free --mebi | awk '(NR == 2) {print $3}'
