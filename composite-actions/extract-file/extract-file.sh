#!/bin/bash
properties=$(jq -c '.' "$1")
if [ -n "$properties" ]; then
  echo "Extracted properties: $properties"
  keys=$(echo "$properties" | jq 'keys[]' | tr -d '\r' | tr -d '"')
  for key in $keys; do
    echo "Key to extract: .$key"
    value=$(echo "$properties" | jq ".$key")    
    # Crear una variable para cada propiedad
    echo "$key:$value"
    echo "$key=$value" >> $GITHUB_OUTPUT
  done
else
  echo "ERROR: $1 is not defined in repository"
  exit 1
fi