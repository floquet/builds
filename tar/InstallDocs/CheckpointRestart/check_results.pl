#! /usr/bin/perl -Wall
use English;
# No default "\n" at end of each print.
$\ = '';

$tmpdir = '/work/scheinin/tmp';
$debug_firstpart = 0;
$debug_scratchread = 1;
$debug_finalpart = 1;
$keep_going = 1;

@old_lines = ();
$old_lines_size = 10;
for($i=0;$i<$old_lines_size;$i++) {
    $old_lines[$i] = '';
}

$paramsout = $tmpdir . '/runparams.out';
open(PARAMSOUT,"<",$paramsout) || die "unable to open $paramsout";
$line = <PARAMSOUT>;
$line =~ s/^\s*(\d.*)\s*$/$1/;
($num_cycles, $cycle_size, $numprocs) = split(/\s+/,$line);
if( $debug_firstpart == 1 ) {
    print STDOUT " num_cycles = $num_cycles, cycle_size = $cycle_size\n";
    print STDOUT " numprocs = $numprocs\n";
}
close(PARAMSOUT);

@numbers = ();
for($i=0;$i<$numprocs;$i++) {
#
	if($i < 10) { $suffix = '000' . $i; }
	elsif($i < 100) { $suffix = '00' . $i; }
	elsif($i < 1000) { $suffix = '0' . $i; }
	else { $suffix = $i; }
	$scratchfilename = "$tmpdir" . '/fort' . $suffix;
#
    if( -r $scratchfilename ) {
	if( $debug_firstpart == 1 ) {
	    print STDOUT "$scratchfilename\n";
	}
    }
    else {
	print STDOUT "$scratchfilename NOT FOUND !!!\n";
	$keep_going = 0;
    }
} # for($i=0;$i<$numprocs;$i++)
if($keep_going == 1) {
    for($i=0;$i<$numprocs;$i++) {
#
	if($i < 10) { $suffix = '000' . $i; }
	elsif($i < 100) { $suffix = '00' . $i; }
	elsif($i < 1000) { $suffix = '0' . $i; }
	else { $suffix = ''; }
	$scratchfilename = "$tmpdir" . '/fort' . $suffix;
#
	$numbers[$i] = { 'numprocs' => $i,
			 'filename' => $scratchfilename,
			 'status' => 'pending' };
	$hash_element_ref = $numbers[$i];
	if($debug_scratchread == 1) {
	    print STDOUT "Beginning read of $scratchfilename\n";
	}
	$keep_going_one_file = 1;
	open(SCRATCH, "<", $scratchfilename) ||
	    die "unable to open $scratchfilename";
	$first_value = $i + 1;
	$running_value = $first_value;
	while(<SCRATCH>) {
	    if($keep_going_one_file == 1) {
		$line = $_;
		chomp($line);
		for($k=($old_lines_size - 2);$k>=0;$k--) {
		    $old_lines[$k+1] = $old_lines[$k];
		}
		$old_lines[0] = $line;
		$value = $line;
		$value =~ s/^\s*\d+\s+(\d+).*$/$1/;
		if($value != $running_value) {
		    $keep_going_one_file = 0;
		    if($debug_scratchread == 1) {
			print STDOUT "Error in numerical sequence.\n";
			print STDOUT "\"$old_lines[1]\"\n";
			print STDOUT "\"$line\"\n";
		    }
		}
		if( ($running_value - $first_value) >= $numprocs*($cycle_size - 1) ) {
		    $running_value = $first_value;
		}
		else {
		    $running_value += $numprocs;
		}
	    } # if($keep_going_one_file == 1)
	}
	close(SCRATCH);
	if($keep_going_one_file == 1) {
	    $$hash_element_ref{'status'} = 'OK';
	}
	else {
	    $$hash_element_ref{'status'} = 'Error';
	}
    } # for($i=0;$i<$numprocs;$i++)
} # if($keep_going == 1)
else {
    exit 1;
}

if($debug_scratchread == 1) {
    for($i=0;$i<$numprocs;$i++) {
	$hash_element_ref = $numbers[$i];
	$name = $$hash_element_ref{'filename'};
	$status = $$hash_element_ref{'status'};
	if($debug_finalpart == 1) {
	    print STDOUT " file $name , status $status\n";
	}
	else {
	    if( $status ne 'OK' ) {
		print STDOUT " file $name , status $status\n";
	    }
	}
    } # for($i=0;$i<$numprocs;$i++)
} # if($debug_scratchread == 1)


exit 0;

__END__


