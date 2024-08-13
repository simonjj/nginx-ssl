#!/bin/sh

# Check for the existence of required environment variables
if [ -z "$CONTAINER_APP_NAME" ] || [ -z "$CONTAINER_APP_ENV_DNS_SUFFIX" ] || [ -z "$BACKEND_APP" ]; then
  echo "Error: One or more required environment variables are not set."
  echo env | grep -E 'CONTAINER_APP_NAME|CONTAINER_APP_ENV_DNS_SUFFIX|BACKEND_APP'
  echo "Please set CONTAINER_APP_NAME, CONTAINER_APP_ENV_DNS_SUFFIX, and BACKEND_APP."
  exit 1
fi

# removing the template comments
sed -i '/^#/d' /etc/nginx/default.conf.template-only

# Set default values for optional environment variables
export EXTERNAL_HTTPS_PORT=${EXTERNAL_HTTPS_PORT:-8443}
export BACKEND_TIMEOUT=${BACKEND_TIMEOUT:-600}

# Substitute environment variables in the template file
envsubst < /etc/nginx/default.conf.template-only > /etc/nginx/conf.d/default.conf


echo "Nginx configuration file in use:"
echo "=========================================="
cat /etc/nginx/conf.d/default.conf
echo "=========================================="


# Start Nginx
nginx -g 'daemon off;'