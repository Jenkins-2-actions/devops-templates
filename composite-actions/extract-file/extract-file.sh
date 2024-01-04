#!/bin/bash
properties=$(jq -c '.' "$1")
if [ -n "$properties" ]; then
  echo "Extracted properties: $properties"
  echo "properties=$properties" >> $GITHUB_OUTPUT
else
  echo "ERROR: $1 is not defined in repository"
  exit 1
fi