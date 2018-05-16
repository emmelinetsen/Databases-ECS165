#!/bin/bash

DB_NAME=hw2
SQL_SUFFIX=.sql
OUTPUT_DIR=your_output
OUTPUT_SUFFIX=.output.txt
CORRECT_OUTPUT_DIR=correct_output
CORRECT_OUTPUT_SUFFIX=.correct_output.txt

FILENAME="${1}"
BASE_NAME=$(basename "${FILENAME}" "${SQL_SUFFIX}")
OUTPUT_FILENAME="${OUTPUT_DIR}"/"${BASE_NAME}""${OUTPUT_SUFFIX}"
CORRECT_OUTPUT_FILENAME="${CORRECT_OUTPUT_DIR}"/"${BASE_NAME}""${CORRECT_OUTPUT_SUFFIX}"

mkdir -p "${OUTPUT_DIR}"

PGOPTIONS="--statement-timeout=5s" psql "${DB_NAME}" -q -t -f "${FILENAME}" > "${OUTPUT_FILENAME}" 2>&1

CONTAINS_ERROR=$(head -1 "${OUTPUT_FILENAME}" | grep "^psql:")

if [ -n "${CONTAINS_ERROR}" ]; then
    echo "* ${FILENAME} contains an ERROR:"
    echo "---"
    echo ""
    cat "${OUTPUT_FILENAME}"

    exit 1
fi

sort -u "${OUTPUT_FILENAME}" -o "${OUTPUT_FILENAME}"
DIFF_OUTPUT=$(diff -ibB "${OUTPUT_FILENAME}" "${CORRECT_OUTPUT_FILENAME}")

if [ -z "${DIFF_OUTPUT}" ]; then
    echo "* ${FILENAME} OK"
else
    echo "* ${FILENAME} does NOT match. Diff (yours is the '<', the correct output is the '>'):"
    echo "---"
    echo ""
    echo "${DIFF_OUTPUT}"
fi
