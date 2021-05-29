#!/bin/sh

free --mebi | sed '1d;3d;s/ \+/ /g' | cut -d' ' -f3
