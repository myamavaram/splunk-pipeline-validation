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
for section in $sections; do
    section_content=$(extract_section "$MODIFIED_FILE" "$section")
    if [ -n "$section_content" ]; then
        # Check if the section already exists in the original file
        if grep -q "^\[$section\]" "$ORIGINAL_FILE"; then
            echo "Updating section [$section] in $ORIGINAL_FILE"
            # Comment out the existing section and replace it with the new content
            awk -v section="[$section]" '
                /^\[/{if (found && $0 ~ /^\[/) exit}
                $0 ~ section {found = 1}
                found {print "# " $0}
                /^$/ {print; if (found) exit}
                !found {print}
            ' "$ORIGINAL_FILE" > "$TMP_FILE"
            cat <<EOF >> "$TMP_FILE"
$section_content

EOF
            mv "$TMP_FILE" "$ORIGINAL_FILE"
        else
            echo "Appending new section [$section] to $ORIGINAL_FILE"
            echo "$section_content" >> "$ORIGINAL_FILE"
            echo "final output $ORIGINAL_FILE"
        fi
    fi
done

# Clean up
rm "$TMP_FILE"

echo "Update completed. Backup of the original file is saved as ${ORIGINAL_FILE}.bak"