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
python -c "import urllib.request; print(urllib.request.urlopen('http://127.0.0.1:8000/gen_captcha.php').read())"
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_second_process: $status"
  exit $status
fi
