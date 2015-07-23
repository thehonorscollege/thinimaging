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
if [ $dayofweek -lt "6" ]
then
	echo "Running incremental backup..."
	rm -rf $backppath/daily.$dayofweek
	rsync -rltDPh  --exclude=*/.Trash/* --link-dest=$backuppath/weekly /Users $backuppath/daily.$dayofweek
	#in case of larry
	if [ $host = "hc-fmp" ]
	then
		echo "Backing up FileMaker..."
		rsync -rltDPh --link-dest=$backuppath/current/Library/ /Library/Filemaker\ Server $backuppath/daily.$dayofweek/Library
	fi
	rm -f $backuppath/current
	ln -s daily.$dayofweek $backuppath/current
else
	rsync -rltDPhu --exclude=*/.Trash/* /Users $backuppath/weekly
	rm -f $backuppath/current
	ln -s weekly $backuppath/current
fi

umount /Volumes/Backups