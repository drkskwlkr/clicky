#!/bin/sh
echo "Running as normal install"
WP_MULTISITE=0
phpunit

echo "Running as multisite"
WP_MULTISITE=1
phpunit