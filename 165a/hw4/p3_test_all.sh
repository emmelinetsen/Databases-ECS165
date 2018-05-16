#!/bin/bash

NUM_FILES=0
NUM_OK=0
NUM_ERRORS=0

for i in a b c
do
    FILENAME="p3q${i}.sql"
    let "NUM_FILES += 1"

    TEST_OUTPUT=$("./p3_test_q${i}.sh" 2>&1)
    FIRST_LINE=$(echo "${TEST_OUTPUT}" | head -1)

    echo "${TEST_OUTPUT}"

    if [ "${FIRST_LINE}" == "* ${FILENAME} OK" ]; then
        let "NUM_OK += 1"
    elif [ "${FIRST_LINE}" == "* ${FILENAME} contains an ERROR:" ]; then
        let "NUM_ERRORS += 1"
        echo ""
    else
        echo ""
    fi
done

echo "Number OK: ${NUM_OK} / ${NUM_FILES}"

if [ "${NUM_ERRORS}" -gt 0 ]; then
    echo "Number of Errors: ${NUM_ERRORS}"
fi
