# Scripts

This repository contains some Perl and Bash scripts to automate some tasks, mainly related with backups, encryption of files, and managing compressed archives.

## License
This scripts are licensed under GNU General Public License version 2.

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
  
* `incbackup.pl`

  Creates incremental backups of each given source directory using *rsync*.
  At each backup, only new files are copied.  The backups will be stored in a given target directory.

  The option `-d` can be used to delete old backups.
  This will only keep all backups for the past 24 hours, daily backups for the past 30 days, and weekly backups when oldest than 30 days.

  The file system where backups are stored must support symbolic links.
  
* `rbackup.sh`

  Creates daily backups with the files changed in the last 3 days.
  Creates weekly and monthly full backups.
  Users can specify the maximum number of days to keep each backup.
  By default, daily backups are deleted after 7 days, weekly backups after 20 days, and monthly backups after 90 days.

* `rarch`
  
  Creates encrypted TAR archives from directories, using GnuPG public key encryption.

* `gexport.pl`

  Creates compressed archives from Git repositories.
  
  A compressed archive will be created for the Git repository contained in the current directory.
  The desired branch and output file names can be specified as arguments.
  If no file name is provided, the name of the current folder, concatenated with the extension `.zip` or `.tar.gz`, will be used.

* `rtar.pl`
  
  Creates tar gz archives from the given directories.

  It was created to simplify the usage of the `tar` command in some common scenarios.

  For each directory, will be created a archive with the same name, concatenated with extension `.tar.gz`.
  
  The files with name `.DS_Store` and `.localized` will be excluded (usefull in OS X).
