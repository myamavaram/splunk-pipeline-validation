#!/bin/bash

# Variables
LOG_FILE="new_audit_test.logs"
CONF_FILE="search.conf"
TEMP_CONF_FILE="search_temp.conf"
# ARTIFACTORY_URL="https://artifactory.example.com/artifactory"
# ARTIFACTORY_REPO="path/to/repo"
# ARTIFACTORY_USERNAME="your_artifactory_username"
# ARTIFACTORY_PASSWORD="your_artifactory_password"

# Create a backup of the original configuration
cp $CONF_FILE $TEMP_CONF_FILE

# Process the audit log file
echo "Processing audit logs..."

while IFS='|' read -r timestamp action user sourcetype details; do
    if [[ "$action" == "edit" ]]; then
        echo "Applying edit changes..."
        # Example: Modify existing settings in the configuration
        # You might have more complex parsing logic here
        sed -i '/old_setting/c\new_setting = updated_value' search_temp.conf
        echo "cat search_temp.conf"
        cat search_temp.conf
    elif [[ "$action" == "add" ]]; then
        echo "Adding new settings..."
        # Add new settings
        echo "[new_stanza]" >> search_temp.conf
        echo "new_setting = added_value" >> search_temp.conf
        echo "cat search_temp.conf"
        cat search_temp.conf
    elif [[ "$action" == "delete" ]]; then
        echo "Removing old settings..."
        # Remove specific settings
        sed -i '/old_setting/d' search_temp.conf
        echo "cat search_temp.conf"
        cat search_temp.conf
    fi
done < new_audit_test.logs

# Replace the old configuration file with the updated one
mv search_temp.conf search.conf

echo "output search.conf data"
cat search_temp.conf

# Upload the updated file to Artifactory
echo "\n Uploading to Artifactory..."

#curl -u $ARTIFACTORY_USERNAME:$ARTIFACTORY_PASSWORD -T $CONF_FILE "$ARTIFACTORY_URL/$ARTIFACTORY_REPO/$(basename $CONF_FILE)"

echo "Process completed successfully."