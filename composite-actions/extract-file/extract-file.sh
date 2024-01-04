#!/bin/bash
properties=$(jq -c '.' "$1")
if [ -n "$properties" ]; then
  echo "Extracted properties: $properties"
  # echo "properties=$properties" >> $GITHUB_OUTPUT
  # Iterar sobre las claves y valores del JSON
  while IFS= read -r line; do
    key=$(echo "$line" | jq -r keys_unsorted[])
    value=$(echo "$line" | jq -r ".$key")
    
    # Crear una variable para cada propiedad
    # ADVERTENCIA: Posible inyección de código malicioso
    eval "$key=\"$value\""
    
    echo "$key: $value"
  done <<< "$properties"
else
  echo "ERROR: $1 is not defined in repository"
  exit 1
fi