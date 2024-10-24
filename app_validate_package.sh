#!/bin/bash
set -e
#cd /opt/splunk/var/run/splunk/deploy/apps
rm -f /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-*.bundle
echo "running splim validation command"
slim validate /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-security-content-10-dev
slim package /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-security-content-10-dev -o /opt/splunk/var/run/splunk/deploy/apps
echo "running splunk-appinspect"
splunk-appinspect inspect /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-security-content-10-dev-1.0.1.tar.gz --included-tags cloud --included-tags self-service --excluded-tags splunk-app

#sudo chmod -R 757 /opt/splunk/var/run/splunk/deploy

#sudo chmod -R 775 /opt/splunk/var/run/splunk/deploy/apps

#cd /opt/splunk/var/run/splunk/deploy/apps

#echo $PWD

#rm -f /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-*.bundle

#sudo ls -l /opt/splunk/var/run/splunk/deploy/apps

#echo "running splim validation command"

#sudo ls -l DA-ESS-security-content-10-dev

#sudo ls -l DA-ESS-security-content-10-dev/default 

#slim validate /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-security-content-10-dev

#slim package /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-security-content-10-dev -o /opt/splunk/var/run/splunk/deploy/apps

#sudo ls -l /opt/splunk/var/run/splunk/deploy/apps

#echo "running splunk-appinspect"

#sudo splunk-appinspect inspect /opt/splunk/var/run/splunk/deploy/apps/DA-ESS-security-content-10-dev-1.0.1.tar.gz --included-tags cloud --included-tags self-service --excluded-tags splunk-app