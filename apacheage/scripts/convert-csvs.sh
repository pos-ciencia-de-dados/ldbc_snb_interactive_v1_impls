#!/bin/bash

set -eu
set -o pipefail

echo "Starting preprocessing CSV files"

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ..

. scripts/vars.sh

# create converted directory / cleanup if it exists
rm -rf ${AGE_CONVERTED_CSV_DIR}/*
mkdir -p ${AGE_CONVERTED_CSV_DIR}/{static,dynamic}/

# exec java app
java -jar scripts/sql-converter-0.0.1-jar-with-dependencies.jar "${POSTGRES_CSV_DIR}" "${AGE_CONVERTED_CSV_DIR}"

echo "Finished preprocessing CSV files"
