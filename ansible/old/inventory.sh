#!/usr/bin/env bash

if [ "$1" == "--list" ] ; then
cat "inventory.json"
else
  echo "{}"
fi
