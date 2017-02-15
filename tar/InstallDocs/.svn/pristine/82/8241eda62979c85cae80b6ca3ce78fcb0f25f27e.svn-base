#! /usr/bin/perl -Wall

use strict;
use English;

$\ = ""; # No extra carriage return.

my ($infilename, $outfilename) = ($ARGV[0], $ARGV[1]);

# print "$infilename , $outfilename\n";

local *INFILE;
local *OUTFILE;

open(INFILE,'<',$infilename) ||
    die "unable to open for reading $infilename";

my ($line, $cleanline, $oneline);
$oneline = "";
while(<INFILE>) {
    $line = $_;
    chomp($line);
    $cleanline = $line;
    $cleanline =~ s/exec_vnode = //;
    $cleanline =~ s/\s//g;
    $oneline .= $cleanline;
} # while(<INFILE>)

close(INFILE);

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


open(OUTFILE,'>',$outfilename) ||
    die "unable to open for reading $outfilename";

my $node_count = 0;
foreach $item (@noextra) {
    $node_count++;
#    print stdout "$node_count $item\n";
    print OUTFILE "$item\n";
}

close(OUTFILE);

exit 0;

__END__

./clean_nodelist.pl exec_vnode.in exec_vnode.out
Job Id: 74455.topaz10
 resources_used.ncpus = 33696
936 nodes

continuation lines use tabs
initial line uses
four initial spaces
