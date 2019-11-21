#!/usr/bin/perl
# ==============================================================================
#
# gexport 2.0 - create compressed archives from git repositories
# Copyright (C) 2013 Rui Carlos Gonçalves
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
# Author:       Rui Carlos Gonçalves <rcgoncalves.pt@gmail.com>
# Version:      2.0
# Date:         July 22, 2013
#
# ==============================================================================
#
# Change Log
#
# Version 2.0
#   2013-07-22
#     * Added support for compressed tar archives.
#     * Changed default archive name.
#     * Added a prefix to filenames in the archive.
#
# Version 1.0
#   2013-07-20
#     * Initial version.
#
# ==============================================================================

use strict;
use warnings;

use utf8;

use Getopt::Std;
use POSIX;
use Cwd;
use File::Basename;
use File::Spec;

$Getopt::Std::STANDARD_HELP_VERSION = 1;

sub main::VERSION_MESSAGE {
  print "gexport 1.0, Copyright (C) 2013 Rui Carlos Goncalves\n";
  print "gexport comes with ABSOLUTELY NO WARRANTY.  This is free software, and\n";
  print "you are welcome to redistribute it under certain conditions.  See the GNU\n";
  print "General Public Licence for details.\n\n";
}

sub main::HELP_MESSAGE {
  print "Create compressed archives from GIT repositories.\n";
  print "\n";
  print "Usage:\n";
  print "  gexport [-v] [-f] [-t|-z] branch [archive-name]\n";
  print "\n";
  print "Options:\n";
  print "  -v  verbose mode\n";
  print "  -f  overwrite existing files\n";
  print "  -t  create a compressed tar archive\n";
  print "  -z  create a zip archive (default, overrides -t)\n";
}

# ==============================================================================
# processing options

my %options = (
  'f' => 0,
  'v' => 0,
  't' => 0,
  'z' => 0
);

getopts('fvtz', \%options);

my $verbose = 0;
$verbose = 1 if $options{'v'};

my $force = 0;
$force = 1 if $options{'f'};

my $type;
if($options{'t'} and $options{'z'}) {
  print "Both -t and -z options present.  Zip format will be used.\n"
      if $verbose;
  $type = 0;
}
if($options{'t'}) {
  $type = 1;
}
else {
  $type = 0;
}

if($#ARGV < 0) {
  die "You have to specify the branch.";
}
my $branch = $ARGV[0];
print "Using '$branch' branch.\n" if $verbose;

# ==============================================================================
# Archive name and prefix

my $base = basename(cwd());
if($base eq '/') {
  $base = 'archive';
}

my $file;
if($#ARGV < 1) {
  if($type) {
    $file = $base . '.tar.gz';
  }
  else {
    $file = $base . '.zip';
  }
}
else {
  $file = $ARGV[1];
}
$base = $base . '/';

# ==============================================================================
# final checks

if(not -d ".git") {
  die "This directory do not appear to be a GIT repository.";
}

if((-f $file or -d $file)) {
  if(not $options{'f'}) {
    die "Archive '$file' already exists (use -f to overwrite).";
  }
  else {
    print "Archive '$file' already exists.  It will be overriten.\n"
        if $verbose;
  }
}

# ==============================================================================
# creating the archive

my $cmd = "";
if($type) {
  $cmd = "git archive --format=tar --prefix=\"$base\" \"$branch\" | gzip > \"$file\"";
}
else {
  $cmd = "git archive --format=zip --prefix=\"$base\" --output \"$file\" \"$branch\"";
}
if(not system $cmd) {
  print "Archive '$file' successfully created.\n" if $verbose;
}
else {
  die "gexport: Error executing git.\n";
}


__DATA__

=head1 NAME

B<gexport> - create compressed archives from GIT repositories


=head1 SYNOPSIS

B<gexport> [B<-f>] [B<-v>] [B<-t>|B<-z>] F<branch> [F<archive-name>]


=head1 DESCRIPTION

B<gexport> creates compressed archives from GIT repositories.
A compressed archive will be created for the GIT repository
contained in the current directory.  F<branch> specifies the
desired branch, and F<archive-name> (optional) the name of the
file to be created.  If no file name is provided, the name of the
current folder, concatenated with the extension F<.zip> or
F<.tar.gz>, will be used.


=head1 OPTIONS

=over 4

=item B<-f>

Overwrite existing files.

=item B<-v>

Verbose mode.

=item B<-t>

Create a compressed tar archive

=item B<-z>

Create a zip archive (default, overrides B<-t>)

=item B<--version>

Show version information and exit.

=item B<--help>

Show usage information and exit.

=back


=head1 AUTHOR

Rui Carlos Goncalves <rcgoncalves.pt@gmail.com>

http://rcgoncalves.pt


=head1 SEE ALSO

L<git>(1), L<zip>(1), L<tar>(1)


=cut
