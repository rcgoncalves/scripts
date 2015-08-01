#!/bin/bash
# ==============================================================================
# 
# rcrypt 1.0 - encrypt files
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
# Encrypts or decrypts the contents of a given file, using openssl software.
# Uses the AES-256 CBC scheme for encryption and decryption.
# If an output file name is provided, it is used to store the encrypted data.
# Otherwise the encrypted data is sent to the standard output.
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
    echo "rcrypt 1.0, Copyright (C) 2015 Rui Carlos Goncalves"
    echo "rcrypt comes with ABSOLUTELY NO WARRANTY.  This is free software, and"
    echo "you are welcome to redistribute it under certain conditions.  See the GNU"
    echo "General Public Licence for details."
    echo ""
    echo "Encrypt/decrypt files."
    echo "Usage: rcrypt (END|DEC) input-file [output-file]"
    exit 0
fi

# encrypt or decrypt?
if [ "$1" == "ENC" ]
then
    OPTS="enc -aes-256-cbc"
elif [ "$1" == "DEC" ]
then
    OPTS="enc -d -aes-256-cbc"
else
    echo "ERROR: invalid operation mode!"
    exit 1
fi

# input file
if [ -z $2 ]
then
    echo "ERROR: no input file provided!"
    exit 2
elif [ ! -f $2 ]
then
    echo "ERROR: input file does not exist!"
    exit 3
else
    INFILE="-in $2"
fi

# output file
if [ -z $3 ]
then
    OUTFILE=""
elif [ ! -f $3 ]
then
    OUTFILE="-out $3"
else
    echo "ERROR: output file already exists!"
    exit 4
fi

openssl $OPTS $INFILE $OUTFILE
