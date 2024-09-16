#!/bin/bash

# Set IFS to a pipe character
IFS='|'

# Path to the audit log file
log_file="new_audit_text.logs"

# Check if the log file exists
if [ ! -f "$log_file" ]; then
    echo "Log file $log_file does not exist."
    exit 1
fi

# Read each line of the log file and parse fields
while read -r timestamp action user sourcetype details; do
    echo "Timestamp: $timestamp"
    echo "Action: $action"
    echo "User: $user"
    echo "Sourcetype: $sourcetype"
    echo "Details: $details"
done < "$log_file"