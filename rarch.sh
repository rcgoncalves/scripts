#!/bin/bash
# ==============================================================================
# 
# rarch 1.0 - create encrypted DMG archives from folders
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
# Creates encrypted DMG archives from folders, using hdiutil software (available
# on OS X).
# Uses the default encryption scheme from hdiutil.  The password is asked for
# each folder to encrypt.
# The output file name is the result of appending the current date to the input
# folder name.
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

# if no arguments are provided, print help message and exit
if [ "$#" == "0" ]
then
    echo "rarch 1.0, Copyright (C) 2015 Rui Carlos Goncalves"
    echo "rarch comes with ABSOLUTELY NO WARRANTY.  This is free software, and"
    echo "you are welcome to redistribute it under certain conditions.  See the GNU"
    echo "General Public Licence for details."
    echo ""
    echo "Create encrypted DMG archives from folders using hdiutil."
    echo "Usage: rarch input-folder [...]"
    exit 0
fi

# otherwise process the input folders
for DIR in "$@"
do
    if [ "$DIR" == "/" ]
    then
        echo "WARNING: Cannot process the root folder (skipping it)."
    elif [ ! -d $DIR ]
    then
	echo "WARNING: Folder $DIR does not exist (skipping it)."
    else
        INFOLDER=`cd $DIR; pwd`
        FOLDERNAME=`basename $INFOLDER`
        OUTFILE=$FOLDERNAME-`date +%Y%m%d`.dmg

        echo "Archiving '$INFOLDER' to '$OUTFILE'..."
        hdiutil create -format UDZO -encryption AES-256 -stdinpass -srcfolder $INFOLDER $OUTFILE
        echo "Done."
    fi
done
