#!/bin/bash

NUM_FILES=0
NUM_OK=0

for i in a b c d
do
    FILENAME="p4q${i}.dl"
    let "NUM_FILES += 1"

    TEST_OUTPUT=$(./p4_test_one.sh "${FILENAME}" 2>&1)
    FIRST_LINE=$(echo "${TEST_OUTPUT}" | head -1)

    echo "${TEST_OUTPUT}"

    if [ "${FIRST_LINE}" == "* ${FILENAME} OK" ]; then
        let "NUM_OK += 1"
    else
        echo ""
    fi
done

echo "Number OK: ${NUM_OK} / ${NUM_FILES}"
