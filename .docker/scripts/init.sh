#!/usr/bin/env sh
##
# Initialise CKAN instance.
#
set -e

CKAN_USER_NAME="${CKAN_USER_NAME:-admin}"
CKAN_DISPLAY_NAME="${CKAN_DISPLAY_NAME:-Administrator}"
CKAN_USER_PASSWORD="${CKAN_USER_PASSWORD:-Password123!}"
CKAN_USER_EMAIL="${CKAN_USER_EMAIL:-admin@localhost}"

${APP_DIR}/bin/ckan_cli db clean
${APP_DIR}/bin/ckan_cli db init
${APP_DIR}/bin/ckan_cli user add "${CKAN_USER_NAME}"\
 fullname="${CKAN_DISPLAY_NAME}"\
 email="${CKAN_USER_EMAIL}"\
 password="${CKAN_USER_PASSWORD}"
${APP_DIR}/bin/ckan_cli sysadmin add "${CKAN_USER_NAME}"

