#!/bin/bash

#file paths
ORIGINAL_FILE="savedSearch.conf"
MODIFIED_FILE="audit.logs"

#temporary file for storing changes
TMP_FILE=$(mktemp)

#backup the original file
cp "${ORIGINAL_FILE}" "${ORIGINAL_FILE}.bak"

#find the changes between the files
diff "${ORIGINAL_FILE}" "${MODIFIED_FILE}" | grep -E '^[<>]' | while read -r line; do
    # Extract the line type and content
    line_type="${line:0:1}"
    content="${line:2}"

    if [ "$line_type" == ">" ]; then
        # Add new lines from modified file
        echo "$content" >> "$TMP_FILE"
        cat $TMP_FILE
    fi
done