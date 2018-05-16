#!/bin/bash

DES_PATH=~cs165a/public/datalog/des/des
DES_TIMEOUT=90
DES_INPUT_FILENAME=p4_des_input.txt
DES_OUTPUT_FILENAME=p4_des_output.txt

# 0 for false, non-0 for true
DELETE_DES_INPUT_FILE_WHEN_DONE=1
DELETE_DES_OUTPUT_FILE_WHEN_DONE=1
LIMIT_DIFF_OUTPUT=0

LIMIT_DIFF_OUTPUT_LINES=20

DL_SUFFIX=.dl
DATA_DIR=data
FACTS_FILENAME=hw4-EC-family.dl
OUTPUT_DIR=your_output
OUTPUT_SUFFIX=.output.txt
CORRECT_OUTPUT_DIR=correct_output
CORRECT_OUTPUT_SUFFIX=.correct_output.txt

FILENAME="${1}"
BASE_NAME=$(basename "${FILENAME}" "${DL_SUFFIX}")
OUTPUT_FILENAME="${OUTPUT_DIR}"/"${BASE_NAME}""${OUTPUT_SUFFIX}"
CORRECT_OUTPUT_FILENAME="${CORRECT_OUTPUT_DIR}"/"${BASE_NAME}""${CORRECT_OUTPUT_SUFFIX}"

mkdir -p "${OUTPUT_DIR}"

# remove any existing DES input and output files
rm -f "${DES_INPUT_FILENAME}" > /dev/null 2>&1
rm -f "${DES_OUTPUT_FILENAME}" > /dev/null 2>&1

# create the DES input file
echo "/log ${DES_OUTPUT_FILENAME}" > "${DES_INPUT_FILENAME}"
echo "/consult ${DATA_DIR}"/"${FACTS_FILENAME}" >> "${DES_INPUT_FILENAME}"
echo "/reconsult ${FILENAME}" >> "${DES_INPUT_FILENAME}"

case "${BASE_NAME}" in
    p4qa) echo "grandparent(C, G)." >> "${DES_INPUT_FILENAME}" ;;
    p4qb) echo "ancestor(C, A)." >> "${DES_INPUT_FILENAME}" ;;
    p4qc) echo "samegen(X, Y)." >> "${DES_INPUT_FILENAME}" ;;
    p4qd) echo "lca(C, D, A)." >> "${DES_INPUT_FILENAME}" ;;
esac

echo "/nolog" >> "${DES_INPUT_FILENAME}"

# send the contents of the DES input file to DES
cat "${DES_INPUT_FILENAME}" | timeout "${DES_TIMEOUT}" "${DES_PATH}" > /dev/null 2>&1

# get the rows from the query (they're between "{" and "}")
sed -n '/^{/,/^}/p' "${DES_OUTPUT_FILENAME}" > "${OUTPUT_FILENAME}" 2>&1

if [ "${DELETE_DES_INPUT_FILE_WHEN_DONE}" -ne 0 ]; then
    rm -f "${DES_INPUT_FILENAME}" > /dev/null 2>&1
fi

if [ "${DELETE_DES_OUTPUT_FILE_WHEN_DONE}" -ne 0 ]; then
    rm -f "${DES_OUTPUT_FILENAME}" > /dev/null 2>&1
fi

if [ "${LIMIT_DIFF_OUTPUT}" -ne 0 ]; then
    DIFF_OUTPUT=$(diff "${OUTPUT_FILENAME}" "${CORRECT_OUTPUT_FILENAME}" 2>&1 | head -"${LIMIT_DIFF_OUTPUT_LINES}")
else
    DIFF_OUTPUT=$(diff "${OUTPUT_FILENAME}" "${CORRECT_OUTPUT_FILENAME}" 2>&1)
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
