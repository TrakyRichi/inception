#!/bin/bash

# Source the .env file if it exists
if [ -f ".env" ]; then
  export $(cat ".env" | grep -v '#' | awk '/=/ {print $1}')
fi

# Ensure the environment variables are available
: "${DB_NAME:?Need to set DB_NAME}"
: "${DB_USER:?Need to set DB_USER}"
: "${DB_PASS:?Need to set DB_PASS}"
: "${DB_HOST:?Need to set DB_HOST}"
: "${WP_URL:?Need to set WP_URL}"
: "${WP_TITLE:?Need to set WP_TITLE}"
: "${WP_ADMIN_USER:?Need to set WP_ADMIN_USER}"
: "${WP_ADMIN_PASSWORD:?Need to set WP_ADMIN_PASSWORD}"
: "${WP_ADMIN_EMAIL:?Need to set WP_ADMIN_EMAIL}"

cd /var/www
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

./wp-cli.phar core download --allow-root

./wp-cli.phar config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --dbhost="$DB_HOST" --allow-root

./wp-cli.phar core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root

php-fpm8.2 -F
