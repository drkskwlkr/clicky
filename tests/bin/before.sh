#!/usr/bin/env bash

if [ $# -lt 1 ]; then
	echo "usage: $0 [wp-version]"
	exit 1
fi

WP_VERSION=${1-master}
PLUGIN_SLUG=$(basename $(pwd))

git clone --depth=50 --branch="$WP_VERSION" git://develop.git.wordpress.org/ /tmp/wordpress
cd ..
cp -r "$PLUGIN_SLUG" "/tmp/wordpress/src/wp-content/plugins/$PLUGIN_SLUG"
cd /tmp/wordpress/
cp wp-tests-config-sample.php wp-tests-config.php
sed -i "s/youremptytestdbnamehere/wordpress_tests/" wp-tests-config.php
sed -i "s/yourusernamehere/travis/" wp-tests-config.php
sed -i "s/yourpasswordhere//" wp-tests-config.php
mysql -e "CREATE DATABASE wordpress_tests;" -uroot
git clone https://github.com/squizlabs/PHP_CodeSniffer.git phpcs
git clone -b master https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git wpcs
cd phpcs
scripts/phpcs --config-set installed_paths ../wpcs
cd "/tmp/wordpress/src/wp-content/plugins/$PLUGIN_SLUG"
phpenv rehash