#!/bin/bash
#sudo cd /opt/splunk/var/run/splunk/deploy/apps
set -e
echo $PWD
echo "remove .bundle file from  /opt/splunk/var/run/splunk/deploy/apps"
sudo rm -f /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-*.bundle
sudo ls -l /opt/splunk/var/run/splunk/deploy/apps
echo "check the files in package"
sudo ls -l DA-ESS-security-content-10-dev
sudo ls -l DA-ESS-security-content-10-dev/default
sudo /opt/splunk/var/run/splunk/deploy/apps/slim validate /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-security-content-10-dev
sudo /opt/splunk/var/run/splunk/deploy/apps/slim package /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-security-content-10-dev
sudo ls -l /opt/splunk/var/run/splunk/deploy/apps