#!/bin/bash

set -eu
set -o pipefail

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ..

. scripts/vars.sh

docker exec -i ${POSTGRES_CONTAINER_NAME} dropdb --if-exists ${POSTGRES_DATABASE} --username=${POSTGRES_USER}
docker exec -i ${POSTGRES_CONTAINER_NAME} createdb ${POSTGRES_DATABASE} --username=${POSTGRES_USER} --template template0 --locale "POSIX"
docker exec -i ${POSTGRES_CONTAINER_NAME} psql -d ${POSTGRES_DATABASE} --username=${POSTGRES_USER} -c "CREATE EXTENSION IF NOT EXISTS age; LOAD 'age'; SET search_path TO ag_catalog; SELECT create_graph('agload_ldbc_graph');"
