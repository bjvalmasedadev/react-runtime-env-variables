#!/bin/sh

# Check if directory path is provided
if [ "$1" == "" ]; then
  echo "Error: No directory path provided."
  exit 1
fi

# Define the directory path from the first script argument
dir_path=$1

# Recreate config file
rm -rf $dir_path/env-config.js
touch $dir_path/env-config.js

# Add assignment
echo "window._env_ = {" >> $dir_path/env-config.js

# If .env file exists, read each line, otherwise use environment variables
if [ -f .env ]; then
  grep ^APP_REACT_ .env | while read -r line || [ -n "$line" ];
  do
    # Split env variables by character `=`
    varname=$(printf '%s\n' "$line" | sed -e 's/=.*//')
    varvalue=$(printf '%s\n' "$line" | sed -e 's/^[^=]*=//')

    # Append configuration property to JS file
    echo "  $varname: \"$varvalue\"," >> $dir_path/env-config.js
  done
else
  env | grep ^APP_REACT_ | while read -r line || [ -n "$line" ];
  do
    # Split env variables by character `=`
    varname=$(printf '%s\n' "$line" | sed -e 's/=.*//')
    varvalue=$(printf '%s\n' "$line" | sed -e 's/^[^=]*=//')

    # Append configuration property to JS file
    echo "  $varname: \"$varvalue\"," >> $dir_path/env-config.js
  done
fi

echo "}" >> $dir_path/env-config.js
