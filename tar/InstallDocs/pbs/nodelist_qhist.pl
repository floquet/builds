#! /usr/bin/perl -Wall

use strict;
use English;
use Getopt::Long;

sub show_usage;

$\ = ""; # No extra carriage return.

my $QHIST = "/app/unsupported/local/bin/qhist";
my $qhist_back = -1;
my $infilename = "";
my $outfilename = "";
my $jobid = 0;
my $help = undef;
my $verbose_opt = undef;

GetOptions('help' => \$help,
	   'verbose' => \$verbose_opt,
	   'infile=s' => \$infilename,
	   'n=i' => \$qhist_back,
	   'jobid=i' => \$jobid,
	   'outfile=s' => \$outfilename);

if( defined($help) ) {
  show_usage();
  exit 0;
}
my $verbose = 0;
if( defined($verbose_opt) ) { $verbose = 1; }

local *INFILE;
local *OUTFILE;

my @file_lines = ();
my @qhist_output;
my ($linetmp, $line);
my $cmd;
if($infilename eq "") {
    if(($qhist_back == -1) || ($jobid == 0)) {
	print STDERR "Error: missing information needed by qhist\n";
	print STDERR "qhist_back = $qhist_back\n";
	print STDERR "jobid = $jobid\n";
	show_usage();
	exit 1;
    }
    else {
	$cmd = $QHIST . ' -n ' . $qhist_back . ' ' . $jobid;
	if($verbose) {
	    print STDERR "info: qhist command: $cmd\n";
	}
	@qhist_output = `$cmd`;
	foreach $linetmp (@qhist_output) {
	    $line = $linetmp;
	    chomp($line);
	    push @file_lines, $line;
	}
    }
}
else {
    if($verbose) {
	print STDERR "info: reading input from: $infilename\n";
    }
    open(INFILE,'<',$infilename) ||
	die "unable to open for reading $infilename";
    while(<INFILE>) {
	$line = $_;
	chomp($line);
	push @file_lines, $line;
    } # while(<INFILE>)
    close(INFILE);
}


my @lines_of_interest = ();
my $in_nodelist = 0;
foreach $line (@file_lines) {
    if($line =~ m/^    exec_vnode = /) {
	$in_nodelist = 1;
    }
    else {
	if($in_nodelist) {
	    if($line =~ m/^    [A-Za-z]/) {
		# continue lines begin with a tab rather than four spaces.
		$in_nodelist = 0;
	    }
	}
    }
    if($in_nodelist) {
	push @lines_of_interest, $line;
    }
}

my ($cleanline, $oneline);
$oneline = "";
foreach $line (@lines_of_interest) {
    $cleanline = $line;
    $cleanline =~ s/exec_vnode = //;
    $cleanline =~ s/\s//g;
    $oneline .= $cleanline;
}

# print STDOUT "|$oneline|\n";
my @nodelist_raw;
@nodelist_raw = split(/\+/, $oneline);
my @noextra = ();
my ($item, $clean_item);
foreach $item (@nodelist_raw)  {
    $clean_item = $item;
    $clean_item =~ s/\(//;
    $clean_item =~ s/\)//;
    $clean_item =~ s/^(r.*)\:ncpus.*$/$1/;
    push @noextra, $clean_item;
}

my $node_count = 0;
if($outfilename eq "") {
    foreach $item (@noextra) {
	print STDOUT "$item\n";
    }
}
else {
    if($verbose) {
	print STDERR "info: writing to file $outfilename\n";
    }
    if( -e $outfilename ) {
	die "will not overwrite file $outfilename\n";
    }
    open(OUTFILE,'>',$outfilename) ||
	die "unable to open for reading $outfilename";

    foreach $item (@noextra) {
	$node_count++;
	# print stdout "$node_count $item\n";
	print OUTFILE "$item\n";
    }

    close(OUTFILE);
} # $outfilename not empty string

exit 0;

sub show_usage() {
  print STDOUT "SYNOPSIS\n";
  print STDOUT "     $PROGRAM_NAME [options]\n";
  print STDOUT "DESCRIPTION\n";
  print STDOUT "     Generates a node list.\n";
  print STDOUT "     If an infile is given, then the infile is parsed.\n";
  print STDOUT "     The infile is typically from qhist or qstat -f jobid.\n";
  print STDOUT "     If no infile is given, then qhist is used.\n";
  print STDOUT "     For qhist, the -n <days> option must be given,\n";
  print STDOUT "     as well as the jobid.\n";
  print STDOUT "     The node list is written to STDOUT, unless\n";
  print STDOUT "     an outfile is specified.\n";
  print STDOUT "OPTIONS\n";
  print STDOUT "     -h  --help\n";
  print STDOUT "           show this message\n";
  print STDOUT "     -v  --verbose\n";
  print STDOUT "           verbose runtime information\n";
  print STDOUT "     -i  --infile filename\n";
  print STDOUT "           input file with exec_vnode list\n";
  print STDOUT "     -n days\n";
  print STDOUT "           integer number of days to look back\n";
  print STDOUT "     -j  --jobid JobID\n";
  print STDOUT "           integer ID of job\n";
  print STDOUT "     -o  --outfile filename\n";
  print STDOUT "           output file in which to write node list\n";
}

__END__



continuation lines use tabs
initial line uses
four initial spaces

