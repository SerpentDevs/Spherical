#!/bin/bash

# Start the service
service php7.0-fpm start
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start PHP 7.0 FPM: $status"
  exit $status
fi

# Start the first process
nginx
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start nginx: $status"
  exit $status
fi

# Start the second process
python entrypoint.py
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start API V1: $status"
  exit $status
fi
