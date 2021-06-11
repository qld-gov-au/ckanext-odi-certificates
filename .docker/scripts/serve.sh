#!/usr/bin/env sh
set -e

dockerize -wait tcp://postgres:5432 -timeout 1m
dockerize -wait tcp://solr:8983 -timeout 1m

sed -i "s@SITE_URL@${SITE_URL}@g" $CKAN_INI

if [ -f "${APP_DIR}/bin/ckan" ]; then
    ${APP_DIR}/bin/ckan -c ${CKAN_INI} run
else
    ${APP_DIR}/bin/paster serve ${CKAN_INI}
fi
