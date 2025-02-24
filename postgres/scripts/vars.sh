cd "$( cd "$( dirname "${BASH_SOURCE[0]:-${(%):-%x}}" )" >/dev/null 2>&1 && pwd )"
cd ..

export POSTGRES_VERSION=14.4
export POSTGRES_CONTAINER_NAME=snb-interactive-postgres
export POSTGRES_PASSWORD=mysecretpassword
export POSTGRES_DATABASE=ldbcsnb
export POSTGRES_USER=postgres
export POSTGRES_DATA_DIR=`pwd`/scratch/data
export POSTGRES_PORT=5432

export POSTGRES_CSV_DIR=`pwd`/test-data/

if [[ `uname -m` == "arm64" ]]; then
    export POSTGRES_DOCKER_PLATFORM_FLAG="--platform linux/arm64"
else
    export POSTGRES_DOCKER_PLATFORM_FLAG=""
fi
