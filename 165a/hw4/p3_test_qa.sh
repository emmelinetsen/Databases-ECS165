#!/bin/bash

# 0 for false, non-0 for true
LIMIT_DIFF_OUTPUT=0
LIMIT_DIFF_OUTPUT_LINES=20

DB_NAME=hw4
STATEMENT_TIMEOUT=30s
SQL_SUFFIX=.sql
OUTPUT_DIR=your_output
OUTPUT_SUFFIX=.output.txt
CORRECT_OUTPUT_DIR=correct_output
CORRECT_OUTPUT_SUFFIX=.correct_output.txt

FILENAME=p3qa.sql
BASE_NAME=$(basename "${FILENAME}" "${SQL_SUFFIX}")
OUTPUT_FILENAME="${OUTPUT_DIR}"/"${BASE_NAME}""${OUTPUT_SUFFIX}"
CORRECT_OUTPUT_FILENAME="${CORRECT_OUTPUT_DIR}"/"${BASE_NAME}""${CORRECT_OUTPUT_SUFFIX}"

mkdir -p "${OUTPUT_DIR}"

PGOPTIONS="--statement-timeout=${STATEMENT_TIMEOUT}" psql "${DB_NAME}" -q -c "DROP TABLE IF EXISTS BOM;" > /dev/null 2>&1
PGOPTIONS="--statement-timeout=${STATEMENT_TIMEOUT}" psql "${DB_NAME}" -q -f "${FILENAME}" > /dev/null 2>&1
PGOPTIONS="--statement-timeout=${STATEMENT_TIMEOUT}" psql "${DB_NAME}" -q -t -c "SELECT * FROM BOM;" > "${OUTPUT_FILENAME}" 2>&1

CONTAINS_ERROR=$(head -1 "${OUTPUT_FILENAME}" | grep "^psql:")

if [ -n "${CONTAINS_ERROR}" ]; then
    echo "* ${FILENAME} contains an ERROR:"
    echo "---"
    echo ""
    cat "${OUTPUT_FILENAME}"

    exit 1
fi

if [ "${LIMIT_DIFF_OUTPUT}" -ne 0 ]; then
    DIFF_OUTPUT=$(diff -ibB "${OUTPUT_FILENAME}" "${CORRECT_OUTPUT_FILENAME}" | head -"${LIMIT_DIFF_OUTPUT_LINES}" 2>&1)
else
    DIFF_OUTPUT=$(diff -ibB "${OUTPUT_FILENAME}" "${CORRECT_OUTPUT_FILENAME}" 2>&1)
fi

if [ -z "${DIFF_OUTPUT}" ]; then
    echo "* ${FILENAME} OK"
else
    echo "* ${FILENAME} does NOT match. Diff (yours is the '<', the correct output is the '>'):"

    if [ "${LIMIT_DIFF_OUTPUT}" -ne 0 ]; then
        echo "Note: only the first "${LIMIT_DIFF_OUTPUT_LINES}" line(s) of diff output shown"
    fi

    echo "---"
    echo ""
    echo "${DIFF_OUTPUT}"
fi
