#!/bin/bash

# Define the paths
METADATA_FOLDER="DA-ESS-security-content-10-dev/metadata"
SOURCE_FOLDER="${WORKSPACE}"
SOURCE_FILE="$SOURCE_FOLDER/default_standard.meta"
DESTINATION_FILE="$METADATA_FOLDER/default.meta"
LOCAL_META_FILE="$METADATA_FOLDER/local.meta"

# Check if the source file exists
if [ -f "$SOURCE_FILE" ]; then
    echo "Replacing $DESTINATION_FILE with $SOURCE_FILE..."

    # Replace default.meta with default.meta_orig
    cp -f "$SOURCE_FILE" "$DESTINATION_FILE"

    # Check if the copy was successful
    if [ $? -eq 0 ]; then
        echo "File replaced successfully."
    else
        echo "Failed to copy the file."
        exit 1
    fi
else
    echo "Source file $SOURCE_FILE does not exist."
    exit 1
fi

# Check if local.meta exists and delete it
if [ -f "$LOCAL_META_FILE" ]; then
    echo "Deleting $LOCAL_META_FILE..."
    rm "$LOCAL_META_FILE"

    # Check if deletion was successful
    if [ $? -eq 0 ]; then
        echo "local.meta file deleted successfully."
    else
        echo "Failed to delete local.meta file."
        exit 1
    fi
else
    echo "local.meta file does not exist, nothing to delete."
fi