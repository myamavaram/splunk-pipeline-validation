#!/bin/bash

set -e

# File paths
ORIGINAL_FILE="savedSearch.conf"
MODIFIED_FILE="audit.logs"
TMP_FILE=$(mktemp)

# Backup the original file
cp "$ORIGINAL_FILE" "${ORIGINAL_FILE}.bak"

# Function to extract a section from the file
echo "running extract section"
extract_section() {
    local file="$1"
    local section="$2"
    sed -n "/^\[$section\]/,/^\[/p" "$file" | sed '$d'
}

echo "function to check if a section exist in a file"
section_exists() {
    local file="$1"
    local section="$2"
    grep -q "^\[$section\]" "$file"
}

echo "Get the list of sections from the modified file"
sections=$(grep -oP '^\[\K[^\]]+' "$MODIFIED_FILE")

# Extract sections from the modified file and append to the original file
# Process each section
for section in $sections; do
    # Extract content of the section from the modified file
    section_content=$(extract_section "$MODIFIED_FILE" "$section")

    if [ -n "$section_content" ]; then
        if section_exists "$ORIGINAL_FILE" "$section"; then
            echo "Updating section [$section] in $ORIGINAL_FILE"

            # Comment out the existing section and its content
            sed -e "/^\[$section\]/,/^\[/ { /^\[/!d; s/^/# / }" "$ORIGINAL_FILE" > "$TMP_FILE"

            # Append the new section content
            echo "$section_content" >> "$TMP_FILE"
            mv "$TMP_FILE" "$ORIGINAL_FILE"
            echo "print modified file"
            cat $ORIGINAL_FILE
        else
            echo "Appending new section [$section] to $ORIGINAL_FILE"
            echo "$section_content" >> "$ORIGINAL_FILE"
            cat $ORIGINAL_FILE
        fi
    fi
done

# Clean up
rm "$TMP_FILE"

echo "Update completed. Backup of the original file is saved as ${ORIGINAL_FILE}.bak"