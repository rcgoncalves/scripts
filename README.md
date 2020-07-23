# Scripts

## About
This project provides some Perl and Bash scripts to automate some tasks, mainly related with backups, encryption of files, and managing compressed archives.


## List of Scripts
* `get-backups`

  Downloads backup archives from a remote machine, and stores those archives in a local folder.

  It is prepared to preserve multiple versions of the backup files.  Thus, the local folder where the backups are stored contains date information in its name.

  The first backups downloaded in a month are saved in a folder with name format `backup-m<YEAR><MONTH>`.
  The first backups downloaded in a week are saved in a folder with name format `backup-w<YEAR><WEEK>`.
  The remaining backups are saved in a folder with name format `backup-d<YEAR><MONTH><DAY>` (which means at most one backup is saved per day).

  It also deletes the old backup files after a configurable period of time.
  **Note:** the files to delete are determined according to the modification time provided by the file system.
  Thus, those timestamps should not be changed after the creation of the backups.
  
* `incbackup`

  Creates incremental backups of each given source directory using *rsync*.
  At each backup, only new files are copied.  The backups will be stored in a given target directory.

  The option `-d` can be used to delete old backups.
  This will only keep all backups for the past 24 hours, daily backups for the past 30 days, and weekly backups when oldest than 30 days.

  The file system where backups are stored must support symbolic links.
  
* `rbackup`
  
  Creates and maintains versioned folder backups.
  
  The first backups created in a month are saved in a folder with name format `backup-m<YEAR><MONTH>`.
  The first backups created in a week are saved in a folder with name format `backup-w<YEAR><WEEK>`.
  The remaining backups are saved in a folder with name format `backup-d<YEAR><MONTH><DAY>`.
  
  Monthly and weekly backups are full, whereas daily backups only store the changes of the past five days.
  Daily backups append files to the daily archive.  If multiple daily backups are made, duplicated files are likely to appear in the backup archive.
  
  It also deletes the old backup files after a configurable period of time.
  **Note:** the files to delete are determined according to the modification time provided by the file system.
  Thus, those timestamps should not be changed after the creation of the backups.

* `rarch`
  
  Creates encrypted TAR archives from directories, using GnuPG public key encryption.

* `rtar`
  
  Creates TAR GZ archives from the given directories.
  
  It was created to simplify the usage of the `tar` command in some common scenarios.
  
  For each directory, it creates an archive with the same name, concatenated with extension `.tar.gz`.
  
  It can optionally append the current date to the archive name (before the extension).
  
  The files with name `.DS_Store` and `.localized` are be excluded (useful in MacOS).


## Links
* [Downloads](https://github.com/rcgoncalves/scripts/releases/latest)
* [Issues](https://github.com/rcgoncalves/scripts/issues)


## License
Copyright (C) 2008-2020 Rui Carlos Gonçalves

These scripts are free software; you can redistribute them and/or modify them under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with these scripts.
If not, see <[https://www.gnu.org/licenses/](https://www.gnu.org/licenses/)>.
