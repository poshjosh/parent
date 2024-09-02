#!/usr/bin/env bash

set -euo pipefail

SETTINGS_FILE=${SETTINGS_FILE:-~/dev_looseboxes/.m2/settings.xml}
DEBUG=${DEBUG:-true}
INCLUDE_SUB_MODULES=${INCLUDE_SUB_MODULES:-false}
GPG_PASS=${GPG_PASS:-}

cd .. || exit 1

if [ "${INCLUDE_SUB_MODULES}" = "true" ] || [ "$INCLUDE_SUB_MODULES" = true ]; then
    INCLUDE_SUB_MODULES=
    # Some sub-modules require Java 17
    export JAVA_HOME=~/.sdkman/candidates/java/17
else
    INCLUDE_SUB_MODULES="--non-recursive"
    export JAVA_HOME=~/.sdkman/candidates/java/8
fi

if [ "${DEBUG}" = "true" ] || [ "$DEBUG" = true ]; then
    DEBUG="-X -e"
    echo "SETTINGS_FILE=$SETTINGS_FILE"
    echo "DEBUG=$DEBUG"
    echo "INCLUDE_SUB_MODULES=$INCLUDE_SUB_MODULES"
    echo "JAVA_HOME=$JAVA_HOME"
else
    DEBUG=
fi

# shellcheck disable=SC2086
# We disable the need for double quotes here, as using double quotes caused errors.
if [ -z ${GPG_PASS+x} ] || [ "$GPG_PASS" = "" ]; then
    mvn -s "$SETTINGS_FILE" clean install $DEBUG $INCLUDE_SUB_MODULES
    echo "Install SUCCESSFUL"
else
    mvn -s "$SETTINGS_FILE" clean deploy $DEBUG $INCLUDE_SUB_MODULES -P release -Dgpg.passphrase=$GPG_PASS
    echo "Release SUCCESSFUL"
    echo "Please browse to https://s01.oss.sonatype.org/#stagingRepositories and manually confirm the release."
fi

