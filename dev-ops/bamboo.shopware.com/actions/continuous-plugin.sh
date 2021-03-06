#!/usr/bin/env bash

docker exec -u __USERKEY__ __APP_ID__ /usr/local/bin/wait-for-it.sh --timeout=60 mysql:3306
docker exec -u __USERKEY__ __APP_ID__ ./psh.phar bamboo:init --PLATFORM_BRANCH="master"
docker exec -u __USERKEY__ __APP_ID__ php bin/console plugin:update
docker exec -u __USERKEY__ __APP_ID__ php bin/console plugin:install --activate __PLUGIN__
docker exec -u __USERKEY__ __APP_ID__ ./psh.phar init-test-database
docker exec -u __USERKEY__ __APP_ID__ ./psh.phar bamboo:unit-plugin --PLUGIN="__PLUGIN__"