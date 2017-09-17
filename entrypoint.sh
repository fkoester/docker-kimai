#!/usr/bin/env bash

KIMAI_REMOVE_INSTALLATION=${KIMAI_REMOVE_INSTALLATION:0}

if [ "${KIMAI_REMOVE_INSTALLATION}" == "1" ]
then
  echo -n "=> Remove Kimai installation directory ... "
  rm -rf /var/www/html/installer
  echo "done"
fi

echo -n "=> Fixing permissions on autoconf.php and auth.php ... "

# Permissions on autoconf.php
chown www-data: /var/www/html/includes/autoconf.php
chmod 750 /var/www/html/includes/autoconf.php

# Permissions on auth.php
chown www-data: /var/www/html/includes/auth.php
chmod 750 /var/www/html/includes/auth.php

echo "done"

KIMAI_AUTHENTICATOR=${KIMAI_AUTHENTICATOR:="kimai"}

echo -n "=> Set up Kimai authenticator (${KIMAI_AUTHENTICATOR}) ... "

MATCH=$(egrep '^\$authenticator.*"'${KIMAI_AUTHENTICATOR}'"' /var/www/html/includes/autoconf.php)
if [ "$?" != "0" ]
then
  # Match not found. This means we need to add the current selected authenticator

  # Fixme: It would be nice to comment the $authenticator line. Unfortunately gives me an "Device or resource busy" error.
  # sed -i "s/\$authenticator/# \$authenticator/" /var/www/html/includes/autoconf.php
  echo "\$authenticator = '${KIMAI_AUTHENTICATOR}';" >> /var/www/html/includes/autoconf.php
fi

echo "done"

# Run app
exec "$@"

