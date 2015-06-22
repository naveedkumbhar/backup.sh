#!/bin/bash
#Author: Naveed
#Script purpose: Create backup locally and transfer it to remote server
# Version 2.0

#Scheduling task
echo "0 9,13 * * * /bin/bash /home/niddu/Desktop/test/backup.sh" > task.txt
crontab task.txt

echo "creating backup dir in /tmp"
sleep 1
mkdir -p /tmp/backup

BACKUPHOST=niddu@192.168.164.131:/home/niddu/Desktop/
BACKUPDIR=/tmp/backup/
data=/var/www/*
BACKUPFILE=backup.`date +%F`.tar.gz

# Creating backup in /tmp/backup directory with name along with date 
tar -czvf $BACKUPDIR/$BACKUPFILE -P $data 1>/dev/null
echo "Creating backup... Please wait"
sleep 1

scp $BACKUPDIR/$BACKUPFILE $BACKUPHOST
if [ $? == 0 ];then
echo "Back up has been created successfully" >> /tmp/backup/back-up-notification.txt
echo "Back up has been created successfully"
else
echo "backup failed"
fi

#END
