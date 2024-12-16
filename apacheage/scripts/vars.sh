cd "$( cd "$( dirname "${BASH_SOURCE[0]:-${(%):-%x}}" )" >/dev/null 2>&1 && pwd )"
cd ..

export POSTGRES_VERSION=release_PG14_1.5.0
export POSTGRES_CONTAINER_NAME=snb-interactive-apache-age-postgres
export POSTGRES_PASSWORD=mysecretpassword
export POSTGRES_DATABASE=ldbcsnb
export POSTGRES_USER=postgres
export POSTGRES_DATA_DIR=`pwd`/scratch/data
export POSTGRES_PORT=5433
export POSTGRES_DOCKER_IMAGE=apache/age
export POSTGRES_CSV_DIR=`pwd`/test-data/vanilla/
export POSTGRES_CUSTOM_CONFIGURATION=`pwd`/config/postgresql.conf

export AGE_CONVERTED_CSV_DIR=`pwd`/test-data/age-converted/


if [[ `uname -m` == "arm64" ]]; then
    export POSTGRES_DOCKER_PLATFORM_FLAG="--platform linux/arm64"
else
    export POSTGRES_DOCKER_PLATFORM_FLAG=""
fi
