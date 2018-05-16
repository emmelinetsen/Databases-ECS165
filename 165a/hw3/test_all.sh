#!/bin/bash

NUM_FILES=0
NUM_OK=0
NUM_ERRORS=0

for i in 01 02a 02b 03 04 05 06 07
do
    FILENAME="p1q${i}.sql"
    let "NUM_FILES += 1"

    TEST_OUTPUT=$(./test_one.sh "${FILENAME}" 2>&1)
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

NUM_EC_FILES=0
NUM_EC_OK=0
NUM_EC_ERRORS=0

for i in a b
do
    FILENAME="p2q${i}.sql"
    if [ -s "${FILENAME}" ]; then
        let "NUM_EC_FILES += 1"

        TEST_OUTPUT=$(./test_one.sh "${FILENAME}" 2>&1)
        FIRST_LINE=$(echo "${TEST_OUTPUT}" | head -1)

        echo "${TEST_OUTPUT}"

        if [ "${FIRST_LINE}" == "* ${FILENAME} OK" ]; then
            let "NUM_EC_OK += 1"
        elif [ "${FIRST_LINE}" == "* ${FILENAME} contains an ERROR:" ]; then
            let "NUM_EC_ERRORS += 1"
            echo ""
        else
            echo ""
        fi
    fi
done

if [ "${NUM_EC_FILES}" -gt 0 ]; then
    echo "Number Extra Credit OK: ${NUM_EC_OK} / ${NUM_EC_FILES}"

    if [ "${NUM_EC_ERRORS}" -gt 0 ]; then
        echo "Number of Extra Credit Errors: ${NUM_EC_ERRORS}"
    fi
else
    echo "No Extra Credit Files."
fi
