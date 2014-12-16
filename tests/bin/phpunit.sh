#!/bin/sh
echo "Running as normal install"
echo WP_DEVELOP_DIR
WP_MULTISITE=0
phpunit

echo "Running as multisite"
echo WP_DEVELOP_DIR
WP_MULTISITE=1
phpunit