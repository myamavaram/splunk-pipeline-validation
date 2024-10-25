echo "git commands"
git init
git checkout -b feature/splunk-app-package-${BUILD_NUMBER}
git add .
git commit -m "Automatic changes commiting"
git push https://myamavaram@bitbucket.org/harness-test-repo/splunk-cloud-pipeline.git feature/splunk-app-package-${BUILD_NUMBER}
