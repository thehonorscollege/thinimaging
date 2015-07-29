#! /bin/sh

# Set variables, including day of week, host name, backup path, and current user
dayofweek=$(date +%u)
host=`scutil --get LocalHostName`
backuppath="/Volumes/Backups/$host"
currentuser="$(whoami)"

# Determine and/or mount backup drive.
if mount | grep "hc-storage.cougarnet.uh.edu/Backups on /Volumes/Backups" > /dev/null;
then
	echo "Mounted."
else
	rm -rf /Volumes/Backups
	mkdir /Volumes/Backups
	#hcadmin doesn't exist on the server, so we need to use the generic backup user.
	if [ $currentuser = "hcadmin" ]
	then
		echo "Running as hcbackup..."
		/sbin/mount -t smbfs //hcbackup:backup@hc-storage.cougarnet.uh.edu/Backups /Volumes/Backups
	else
		echo "Running as $currentuser..."
		/sbin/mount -t smbfs //$currentuser@hc-storage.cougarnet.uh.edu/Backups /Volumes/Backups
	fi
fi

#Check if it's the weekend. If it's the weekend, do a full backup. If it's a weekday, do an incremental backup.
echo "Running incremental backup..."
rsync -rltDPh  --exclude=*/.Trash/* /Users $backuppath/
#in case of larry
if [ $host = "hc-fmp" ]
then
	echo "Backing up FileMaker..."
	rsync -rltDPh /Library/Filemaker\ Server $backuppath/Library
fi
umount /Volumes/Backups