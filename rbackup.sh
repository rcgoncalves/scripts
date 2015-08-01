#!/bin/bash
# ==============================================================================
# 
# rbackup 1.1 - create and maintain folder backups
# Copyright (C) 2013, 2015 Rui Carlos Gonçalves
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
# Version:	1.1
# Date:		August 1, 2015
#
# ==============================================================================
#
# ABOUT THIS SCRIPT:
#
# Creates daily backups with the files changed in the last 3 days.
# Creates weekly and monthly full backups.
# User can specify the maximum number of days to keep each backup. By default,
# daily backups are deleted after 7 days, weekly backups after 20 days, and
# monthly backups after 90 days.
#
# ==============================================================================
#
# Change Log
#
# Version 1.1
#   2015-08-01
#     * Changed backup file names.
#
# Version 1.0.1
#   2013-03-21
#     * Minor bug fixed.
#
# Version 1.0
#   2011-09-24
#     * First version.
#
# ==============================================================================

# ==============================================================================
# SCRIPT CONFIGURATION PARAMETERS
# ==============================================================================
# Tar compression (e.g., z, j, ...)
COMP=

# Folder to backup
DIR=/folder/to/backup
# Directory to store the backup
BDIR=/backup/dest/folder

# Number of days to keep the daily backups
DDAYS=7
# Number of days to keep the weekly backups
WDAYS=20
# Number of days to keep the monthly backups
MDAYS=90
# ==============================================================================

# ==============================================================================
# Backups file names
DNAME=backup-d-`date +%Y-%m-%d`.tar
WNAME=backup-w-`date +%Y-%U`.tar
MNAME=backup-m-`date +%Y-%m`.tar

# Create the daily backup file
find $DIR -mtime -3 -type f -exec tar -c$COMP -f $BDIR/$DNAME {} \;
echo "Incremental daily backup created"

# Create weekly (full) backup if there is no weekly backup for current week
if [ ! -f $BDIR/$WNAME ]; then
  tar -c$COMP -f $BDIR/$WNAME $DIR
  echo "Full weekly backup created"
fi

# Create monthly (full) backup if there is no monthly backup for current month
if [ ! -f $BDIR/$MNAME ]; then
  tar -c$COMP -f $BDIR/$MNAME $DIR
  echo "Full monthly backup created"
fi

# Delete old backups
find $BDIR -name 'backup-d-*' -mtime +$DDAYS -delete
find $BDIR -name 'backup-w-*' -mtime +$WDAYS -delete
find $BDIR -name 'backup-m-*' -mtime +$MDAYS -delete
