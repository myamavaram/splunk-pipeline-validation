#!/bin/bash

# Define the file path
FILE="DA-ESS-security-content-10-dev/default/app.conf"

# Remove the [install] section
#sed -i '/\[install\]/,/^\[/d' "$FILE"
sed -i '/^\[install\]/,/^\[/{/^\[ui\]/!d}' "$FILE"

# Extract the current version
current_version=$(grep -Po '(?<=version = )[\d.]*' "$FILE")

# Increment the version number
if [[ $current_version =~ ([0-9]+)\.([0-9]+)\.([0-9]+) ]]; then
    major=${BASH_REMATCH[1]}
    minor=${BASH_REMATCH[2]}
    patch=${BASH_REMATCH[3]}
    new_version="$major.$minor.$((patch + 1))"
    
    # Update the version number in the file
    sed -i "s/version = $current_version/version = $new_version/" "$FILE"
    echo "Version updated from $current_version to $new_version"
else
    echo "Failed to find version number in the correct format."
fi