#!/bin/bash
# ==============================================================================
# 
# get-backups 1.0 - download and maintain versioned backup files
# Copyright (C) 2015 Rui Carlos Gonçalves
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#
# ==============================================================================
#
# Author:	Rui Carlos Gonçalves <rcgoncalves.pt@gmail.com>
# Version:	1.0
# Date:		August 1, 2015
#
# ==============================================================================
#
# ABOUT THIS SCRIPT:
#
# Downloads backups archives from a remote machine, and stores those files in a
# local folder.
# It is prepared to preserve multiple versions of the backup files.  Thus, the
# local folder where the backups are store contains date information in its
# name.
# The first backups downloaded in a month are saved in a folder with name format
# "backup-m-<YEAR>-<MONTH>".  The first backups downloaded in a week are saved
# in a folder with name format "backup-w-<YEAR>-<WEEK>".  The remaining backups
# are saved in a folder with name format "backup-d-<YEAR>-<MONTH>-<DAY>" (which
# at most one backup is saved per day).
# It also deletes the old backup files after a configurable period of time.
# This period of time can be different for monthly, weekly and daily backups.
#
# ==============================================================================
#
# Change Log
#
# Version 1.0
#   2015-08-01
#     * First version.
#
# ==============================================================================

# ==============================================================================
# SCRIPT CONFIGURATION PARAMETERS
# ==============================================================================
# Remote IP/URL
IP=remote-url
# Remote user
USER=remote-user
# Remote directory
REMOTEDIR=/remote/directory
# SSH key file
SSHKEYFILE=/ssh/key/file/id_rsa

# Base local backup directory
BASE=/local/backup/dir

# Number of days to keep the daily backups
DDAYS=7
# Number of days to keep the weekly backups
WDAYS=20
# Number of days to keep the monthly backups
MDAYS=90
# ==============================================================================

# ==============================================================================
# Backup directories names
DNAME=$BASE/backup-d-`date +%Y-%m-%d`
WNAME=$BASE/backup-w-`date +%Y-%U`
MNAME=$BASE/backup-m-`date +%Y-%m`

# Create local temporary backup directory
DST=$BASE/tmp
mkdir -p $DST

# Download backups
echo "Downloading backups..."
scp -i $SSHKEYFILE $USER@$IP:$REMOTEDIR/* $DST
echo "Done."

# Backup rotation:
if [ ! -d $MNAME ] # if there is no monthly backup, make this the monthly backup
then
  echo "Creating monthly backup..."
  mv $DST $MNAME
  echo "Done."
elif [ ! -d $WNAME ] # otherwise, if there is no weekly backup, make this the weekly backup
then
  echo "Creating weekly backup..."
  mv $DST $WNAME
  echo "Done."
else # otherwise, make this a daily backup
  echo "Creating daily backup..."
  mv $DST $DNAME
  echo "Done."
fi

# Delete old backups
echo "Cleaning up..."
find $BASE -depth -type d -name 'backup-d-*' -mtime +$DDAYS -exec rm -r {} \;
find $BASE -depth -type d -name 'backup-w-*' -mtime +$WDAYS -exec rm -r {} \;
find $BASE -depth -type d -name 'backup-m-*' -mtime +$MDAYS -exec rm -r {} \;
echo "Done."
