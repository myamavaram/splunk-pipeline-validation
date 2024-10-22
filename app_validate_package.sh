#!/bin/bash
#sudo cd /opt/splunk/var/run/splunk/deploy/apps
set -e
#sudo chmod -R 757 /opt/splunk/var/run/splunk/deploy
#sudo chmod -R 775 /opt/splunk/var/run/splunk/deploy/apps
#cd /opt/splunk/var/run/splunk/deploy/apps
#echo $PWD
echo "remove .bundle file from  /opt/splunk/var/run/splunk/deploy/apps"
sudo rm -f /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-*.bundle
sudo ls -l /opt/splunk/var/run/splunk/deploy/apps
echo "check the files in package"
sudo ls -l DA-ESS-security-content-10-dev
sudo ls -l DA-ESS-security-content-10-dev/default
sudo slim validate /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-security-content-10-dev
sudo slim package /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-security-content-10-dev -o /opt/splunk/var/run/splunk/deploy/apps
sudo ls -l /opt/splunk/var/run/splunk/deploy/apps
echo "running splunk-appinspect"
sudo splunk-appinspect inspect /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-security-content-10-dev-1.0.1.tar.gz --included-tags cloud --included-tags self-service --excluded-tags splunk-app