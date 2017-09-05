#!/usr/bin/perl
# ==============================================================================
#
# rtar 2.1.3 - create tar archives
# Copyright (C) 2008, 2009, 2013 Rui Carlos Gonçalves
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
# Version:      2.1.3
# Date:         July 20, 2013
#
# ==============================================================================
#
# Change Log
#
# Version 2.1.3
#   2013-07-20
#     * Minor changes.
#
# Version 2.1.2
#   2009-05-17
#     * Added some comments to source code.
#
# Version 2.1.1
#   2009-02-10
#     * Fixed bug (file names with special chars).
#
# Version 2.1
#   2008-08-29
#     * New version.
#
# ==============================================================================

use strict;
use warnings;

use utf8;

use Getopt::Std;
use POSIX;

$Getopt::Std::STANDARD_HELP_VERSION = 1;

sub main::VERSION_MESSAGE {
  print "rtar version 2.1.3, Copyright (C) 2008, 2009, 2013 Rui Carlos Goncalves\n";
  print "rtar comes with ABSOLUTELY NO WARRANTY.  This is free software, and\n";
  print "you are welcome to redistribute it under certain conditions.  See the GNU\n";
  print "General Public Licence for details.\n\n";
}

sub main::HELP_MESSAGE {
  print "Create tar archives.\n";
  print "\n";
  print "Usage:\n";
  print "  rtar [-d] [-v] directory ...\n";
  print "\n";
  print "Options:\n";
  print "  -d  append the current date to archive name\n";
  print "  -v  verbose mode\n";
}

# ==============================================================================
# processing options

my %options = (
  'd' => 0,
  'v' => 0
);

getopts('dv', \%options);

my $date = '';
$date = "-" . ((localtime)[5] + 1900) . strftime("%m%d", localtime) if $options{'d'};

my $verbose = '';
$verbose = 'v' if $options{'v'};

# ==============================================================================
# creating the tar archives

foreach my $dir (@ARGV) {
  if(-d $dir) {
    my $file = basename($dir);
    $file = $file . $date . '.tar.gz';
    my $cmd = "tar cz${verbose}f \"$file\" --exclude '.DS_Store' --exclude '.localized' \"$dir\"";
    
    if(system $cmd) {
      print "File '$file' successfully created.\n" if $verbose;
    }
    else {
      warn "rtar: Error executing tar.\n";
    }
  }
  else {
    warn "rtar: '$dir' is not a directory.\n";
  }
}

# ==============================================================================

# deletes any prefix ending with the last slash `/' character present in a given
#   path/string (similar to bash `basename' function).
sub basename {
  my $path = shift;

  $path =~ s/(\/)+/\//g;

  if ($path eq '/') {
    return $path;
  }
  else {
    $path =~ s/(.*)\/$/$1/;
    $path =~ s/^.*?([^\/]*)$/$1/;

    return $path;
  }
}


__DATA__

=head1 NAME

B<rtar> - create tar archives


=head1 SYNOPSIS

B<rtar> [B<-d>] [B<-v>] F<dir1> ...


=head1 DESCRIPTION

B<rtar> creates tar gz archives from the given directories.
It was created to simplify the usage of the F<tar> command in some
common scenarios.
For each directory, will be created a archive with the same name,
concatenated with extension F<.tar.gz>.
The files with name F<.DS_Store> and F<.localized> will be excluded
(usefull in OS X).


=head1 OPTIONS

=over 4

=item B<-d>

Append the current date to archive name.

=item B<-v>

Verbose mode.

=item B<--version>

Show version information and exit.

=item B<--help>

Show usage information and exit.

=back


=head1 AUTHOR

Rui Carlos Goncalves <rcgoncalves.pt@gmail.com>

http://rcgoncalves.pt


=head1 SEE ALSO

L<tar>(1), L<gzip>(1)


=cut
