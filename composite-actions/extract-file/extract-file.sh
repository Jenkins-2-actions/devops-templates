properties=$(jq -c '.' ${{ inputs.file-path }})
if [[ $properties ]]; then
  echo "Extracted properties: $properties"
  echo "properties=$properties" >> $GITHUB_OUTPUT
else
  echo "ERROR:  ${{ inputs.file-path }} is not defined in repository"
  exit 1
fi