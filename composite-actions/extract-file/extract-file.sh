#!/bin/bash
properties=$(jq -c '.' "$1")
if [ -n "$properties" ]; then
  echo "Extracted properties: $properties"
  keys=$(echo "$properties" | jq 'keys[]' | tr -d '\r')
  for key in $keys; do
    echo "Key to extract: .$key"
    value=$(echo "$properties" | jq ".$key")
    
    # Crear una variable para cada propiedad
    # ADVERTENCIA: Posible inyección de código malicioso
    echo "$key:$value"
    echo "$key=$value" >> $GITHUB_OUTPUT
  done

  # echo "properties=$properties" >> $GITHUB_OUTPUT
  # Iterar sobre las claves y valores del JSON
  # while IFS="," read -r key; do
  #   echo "START"
  #   echo "Key -- .$key finish"
  #   echo "Properties -- $properties"
  #   value=$(echo "$properties" | jq -r ".$key")
  #   # key=$(echo "$line" | jq -r keys_unsorted[])
    
  #   # Crear una variable para cada propiedad
  #   # ADVERTENCIA: Posible inyección de código malicioso
  #   echo "Key: $key = Value: $value"
  #   # eval "$key=\"$value\""
    
  # done <<< "$(echo "$properties" | jq -r 'keys[]')"
else
  echo "ERROR: $1 is not defined in repository"
  exit 1
fi