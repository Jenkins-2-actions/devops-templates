#!/bin/bash

# Leer el contenido del archivo JSON
properties=$(jq -c '.' "$1")

# Verificar que el contenido del archivo no esté vacio
if [ -n "$properties" ]; then
  echo "Extracted properties: $properties"

  # Extraer las claves del objeto JSON al tiempo que se eliminan las comillas y los retornos de carro
  keys=$(echo "$properties" | jq 'keys[]' | tr -d '\r' | tr -d '"')

  # Iterar sobre las claves del objeto JSON y obtener sus respectivos valores
  for key in $keys; do
    echo "Key to extract: .$key"
    value=$(echo "$properties" | jq ".$key" | tr -d '"')

    # Imprimir y asignar cada propiedad como variable de salida para el workflow
    echo "$key:$value"
    echo "$key=$value" >> $GITHUB_OUTPUT
  done

# Error en caso de que el archivo JSON de entrada este vacio o sea inválido
else
  echo "ERROR: $1 is not defined in repository"
  exit 1
fi