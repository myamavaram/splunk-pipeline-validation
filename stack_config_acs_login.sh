acs config add-stack transunion-dev --target-sh sh-i-0c5c6de335a7eccb0
acs config use-stack transunion-dev --target-sh sh-i-0c5c6de335a7eccb0
.dev_es.sh
acs login
app_package=$(/usr/bin/find /opt/splunk/var/run/splunk/deploy/apps -type f -name 'DA-ESS*' -print0 | xargs -0 ls -1t | head -n 1 | xargs -n 1 basename)
echo $app_package
#acs apps install private --app-package $app_package --acs-legal-ack=Y