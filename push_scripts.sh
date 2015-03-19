#!/bin/sh

thinimaging='/Users/hcadmin/Documents/thinimaging'
deployment='/Volumes/Deployment'
webscripts='/Volumes/web/scripts'
webprefs='/Volumes/web/office-plists'
munki='/Volumes/web/munki'

echo "Pushing DeployStudio scripts..."
echo "Pushing lab_restore.sh..."
cp $thinimaging/lab_restore.sh $deployment/scripts/lab_restore.sh
echo "Pushing facultystaff_restore.sh..."
cp $thinimaging/facultystaff_restore.sh $deployment/scripts/facultystaff_restore.sh
echo "Pushing advisor_restore.sh..."
cp $thinimaging/advisor_restore.sh $deployment/scripts/advisor_restore.sh
echo "Pushing consulting_restore.sh..."
cp $thinimaging/consulting_restore.sh $deployment/scripts/consulting_restore.sh

echo "Pushing Munki plists..."
echo "Pushing lab_ManagedInstalls.plist..."
cp $thinimaging/lab_ManagedInstalls.plist $munki/lab_ManagedInstalls.plist
echo "Pushing facultystaff_ManagedInstalls.plist..."
cp $thinimaging/facultystaff_ManagedInstalls.plist $munki/facultystaff_ManagedInstalls.plist
echo "Pushing advisor_ManagedInstalls.plist..."
cp $thinimaging/advisor_ManagedInstalls.plist $munki/advisor_ManagedInstalls.plist
echo "Pushing consulting_ManagedInstalls.plist..."
cp $thinimaging/consulting_ManagedInstalls.plist $munki/consulting_ManagedInstalls.plist

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

