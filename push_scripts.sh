#!/bin/sh

thinimaging='/Users/hcadmin/Documents/thinimaging'
deployment='/Volumes/Deployment'
webscripts='/Volumes/web/scripts'
webprefs='/Volumes/web/office-plists'

echo "Pushing DeployStudio scripts..."
echo "Pushing lab_restore.sh..."
cp $thinimaging/lab_restore.sh $deployment/scripts/lab_restore.sh

echo "Pushing LaunchAgents..."
echo "Pushing Office preferences LaunchAgent..."
cp $thinimaging/edu.uh.honors.curlofficeprefs.plist $webscripts/edu.uh.honors.curlofficeprefs.plist
echo "Pushing PaperCut LaunchAgent..."
cp $thinimaging/edu.uh.honors.papercut.plist $webscripts/edu.uh.honors.papercut.plist

echo "Pushing login scripts..."
echo "Pushing Office preferences script..."
cp $thinimaging/curl_office_plists.sh $webscripts/curl_office_plists.sh

echo "Copying DeployStudio workflows to git repo..."
cp $deployment/databases/workflows/AFBF7E72-9E14-4AEB-B417-7307E6E3B142.plist $thinimaging/workflows/AFBF7E72-9E14-4AEB-B417-7307E6E3B142.plist

echo "Done."

