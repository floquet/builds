#! /usr/bin/perl -Wall
use English;
# No default "\n" at end of each print.
$\ = '';

%mpi_env_defaults = ();
$mpi_env_defaults{'MPI_BUFS_PER_HOST'} = 96;
$mpi_env_defaults{'MPI_BUFS_PER_PROC'} = 32;
$mpi_env_defaults{'MPI_BUFS_THRESHOLD'} = 64;
$mpi_env_defaults{'MPI_DEFAULT_SINGLE_COPY_BUFFER_MAX'} = 2000;
$mpi_env_defaults{'MPI_DEFAULT_SINGLE_COPY_OFF'} = 0;
$mpi_env_defaults{'MPI_IB_SINGLE_COPY_BUFFER_MAX'} = 32767;
$mpi_env_defaults{'MPI_IB_BUFFER_SIZE'} = 131072;

%vartoidx = ();
%idxtovar = ();
@keywords = keys(%mpi_env_defaults);
foreach $chiave (@keywords) {
    $vartoidx{$chiave} = {};
    $idxtovar{$chiave} = {};
}

%check_file_contents = ();
@outdir_list=('envtst01','envtst02','envtst03','envtst04');
%allsorted = ();
foreach $outdir (@outdir_list) {
    %rankings = ();
    for($i=0;$i<8;$i++) {
	for($j=0;$j<8;$j++) {
	    foreach $k (1,4,16) {
		foreach $m (1,4,16) {
		    %mpi_env_actual = ();
	   	    $filename = "$outdir" . '/' .
			"envtst_${i}_${j}_${k}_${m}.log";
		    $check_file_contents{$filename} = [];
		    $rayref = $check_file_contents{$filename};
		    open(INFILE,'<',$filename) ||
			die "unable to open $filename";
		    while(<INFILE>) {
			$line = $_;
			chomp($line);
			@keywords = keys(%mpi_env_defaults);
			foreach $chiave (@keywords) {
			    if($line =~ m/$chiave/) {
				($kw,$value) = split(/=/,$line);
				$mpi_env_actual{$kw} = $value;
				$hashref = $vartoidx{$kw};
				if( ! exists($$hashref{$value})) {
				    $largest_index = 0;
				    @keylist = keys(%$hashref);
				    foreach $validvalue (@keylist) {
					$idx = $$hashref{$validvalue};
					if($idx >= $largest_index) {
					    $largest_index = $idx + 1;
					}
				    }
				    $$hashref{$value} = $largest_index;
				}
			    } # if the line contains an MPI_ keyword
			}
		    }
		    $actual_values_href = {};
		    $check_href = {};
		    @keelist = keys(%mpi_env_actual);
		    foreach $kee (@keelist) {
			$val = $mpi_env_actual{$kee};
			# print "$kee $val\n";
			$$actual_values_href{$kee} = $val;
			$$check_href{$kee} = $val;
		    }
		    close(INFILE);
		    push @$rayref, $check_href; # actual mpi env
		    
		    $sum = 0.0;
		    $cnt = 0.0;
		    # print STDOUT "file $filename\n";
		    open(INFILE,'<',$filename) ||
			die "unable to open $filename";
		    $sum = 0.0;
		    $cnt = 0.0;
		    while(<INFILE>) {
			$line = $_;
			chomp($line);
			if($line =~ m/\|  PDGEMM/) {
			    # print STDOUT "$line\n";
			    $line =~ s/^.*PDGEMM\s*(\S.*)$/$1/;
			    ($a,$flops,$c,$d) = split(/\s+/,$line);
			    # print STDOUT "$flops\n";
			    $sum += $flops;
			    $cnt += 1.0;
			}
		    }
		    close(INFILE);
		    if($cnt != 8) { die "count not equal to 8"; }
		    $avg = $sum/$cnt;
		    $rankings{$filename} = [$avg, $actual_values_href];
		    push @$rayref, $avg; # average
		}
	    }
	}
    }

    @sorted = ();
    @sorted = sort { ${$rankings{$b}}[0] <=> ${$rankings{$a}}[0] } keys %rankings;
    $array_ref_sorted = [];
    foreach $item (@sorted) {
	push @$array_ref_sorted, [ $rankings{$item}, $item ];
    }
    $allsorted{$outdir} = $array_ref_sorted;
    # print "size = $#sorted\n";

} # foreach $outdir (@outdir_list)

# Always use envkeys as canonical order.
@envkeys = keys(%mpi_env_defaults);
foreach $chiave (@envkeys) {
    # print "$chiave\n";
    $hashref1 = $vartoidx{$chiave};
    $hashref2 = $idxtovar{$chiave};
    @keylist = keys(%$hashref1);
    foreach $value (@keylist) {
	$idx = $$hashref1{$value};
	$$hashref2{$idx} = $value;
	# print "      $value $idx\n";
    }
}

foreach $outdir (@outdir_list) {
    $array_ref_sorted = $allsorted{$outdir};
    $a_ref_sorted = [];
    $order = 0;
    foreach $pair (@$array_ref_sorted) {
	$filename = ${$pair}[1];
	$a_ref = ${$pair}[0];
	$avg = ${$a_ref}[0];
	$the_rest = ${$a_ref}[1];
	$rayref = $check_file_contents{$filename};
	push @$rayref, $order; # order within directory
	$order++;
	# Check whether every file has every mpi_env.
	$gotall = 1;
	foreach $possible (@envkeys) {
	    if( ! exists($$the_rest{$possible})) {
		$gotall = 0;
		$$the_rest{$possible} = $mpi_env_defaults{$possible};
		print "Adding $possible\n";
	    }
	    else {
		if( ! defined($$the_rest{$possible})) {
		    $gotall = 0;
		    $$the_rest{$possible} = $mpi_env_defaults{$possible};
		    print "Adding $possible\n";
		}
	    }
	}
	if($gotall == 0) {
	    print "Missing above mpi_env(s) in file $filename\n";
	}
	$coded_env = "";
	foreach $chiave (@envkeys) {
	    $hashref1 = $vartoidx{$chiave};
	    $value = $$the_rest{$chiave};
	    $idx = $$hashref1{$value};
	    $coded_env = $coded_env . "$idx" . '_';
	}
	push @$rayref, $coded_env; # encoding of mpi environment
	$actual_values_href = {};
	foreach $chiave (@envkeys) {
	    $value = $$the_rest{$chiave};
	    $$actual_values_href{$chiave} = $value;
	}
	push @$a_ref_sorted,
	[$avg, $coded_env, $actual_values_href, $filename];

    } # foreach $pair (@$array_ref_sorted)    
    $allsorted{$outdir} = $a_ref_sorted
}

# cutoff top 1/5 1/4 1/3 1/2
$cutoff = 0.5;
%averages = ();
foreach $outdir (@outdir_list) {
    $a_ref_sorted = $allsorted{$outdir};
    @sordid = @$a_ref_sorted;
    $limit = int( ($#sordid)*($cutoff) );
    $order = 0;
    foreach $a_ref (@$a_ref_sorted) {
	$avg = ${$a_ref}[0];
	$coded_env = ${$a_ref}[1];
	$actual_values_href = ${$a_ref}[3];
	$filename = ${$a_ref}[3];
	# print "$avg $filename $coded_env\n";
	$rayref = $check_file_contents{$filename};
	($check_href, $check_avg, $check_order, $check_coded) = @$rayref;
	if( $order != $check_order ) { die "out of order\n"; }
	if( $avg != $check_avg ) { die "average does not match\n"; }
	if( $coded_env ne $check_coded ) { die "inconsistent encoding\n"; }
	@pieces = split(/_/,$coded_env);
	$i = 0;
	%env_in_file = ();
	foreach $chiave (@envkeys) {
	    $hashref2 = $idxtovar{$chiave};
	    $idx = $pieces[$i] ; $i++;
	    $specific_value = $$hashref2{$idx};
	    $env_in_file{$chiave} = $specific_value;
	}

	open(INFILE,'<',$filename) ||
	    die "unable to open $filename";
	# print "compare $filename\n";
	while(<INFILE>) {
	    $line = $_;
	    chomp($line);
	    @keywords = keys(%mpi_env_defaults);
	    foreach $chiave_tmp (@keywords) {
		if($line =~ m/$chiave_tmp/) {
		    ($kw,$value_tmp) = split(/=/,$line);
		    $value_cmp = $env_in_file{$chiave_tmp};
		    if($value_tmp ne $value_cmp) {
			die "file $filename not accurately represented";
		    }
		} # if the line contains an MPI_ keyword
	    }
	} # while(<INFILE>)
	if($order < $limit) {
	    if(exists($averages{$coded_env})) {
		if(defined($averages{$coded_env})) {
		    $avg_list_ref = $averages{$coded_env};
		    push @$avg_list_ref, $avg;
		}
	    }
	    else {
		$averages{$coded_env} = [$avg];
	    }




	}
	$order++;
    }
}

%combined = ();
@tipekeys = keys %averages;
%count = ();
foreach $tipe (@tipekeys) {
    $sum = 0.0;
    $cnt = 0.0;
    $ref = $averages{$tipe};
    foreach $value (@$ref) {
	$sum += $value;
	$cnt += 1.0;
    }
    $avg = $sum/$cnt;
    $combined{$tipe} = $avg;
    $count{$tipe} = $cnt;
}
@sorted_combined =
    sort { $combined{$b} <=> $combined{$a} } keys %combined;

$min_num_cases = 6;
print "MFLOPS PDGEMM\n";
print "Cutoff of $cutoff\n";
print "Minimum number of cases = $min_num_cases\n";
foreach $k (@sorted_combined) {
    # print "$k $combined{$k} ($count{$k})\n";
    if($count{$k} >= $min_num_cases) {
	print " $combined{$k} WALL MFLOPS ($count{$k})\n";
	@pieces = split(/_/,$k);
	$i = 0;
	$print_count = 0;
	foreach $chiave (@envkeys) {
	    $hashref2 = $idxtovar{$chiave};
	    $idx = $pieces[$i] ; $i++;
	    $specific_value = $$hashref2{$idx};
	    $default_value = $mpi_env_defaults{$chiave};
	    if($specific_value != $default_value) {
		print "      $chiave   $specific_value ($default_value)\n";
		$print_count++;
	    }
	}
	if($print_count == 0) { print "      All defaults.\n"; }
    }
}

		    # push @$rayref, $check_href; # actual mpi env
		    # push @$rayref, $avg; # average
	# push @$rayref, $order; # order within directory
	# push @$rayref, $coded_env; # encoding of mpi environment

    exit 0;
__END__

# Note, need to change below because the average value is not in the list pair,
# but further down.

# cutoff top 1/5 1/4 1/3 1/2
$cutoff = 0.5;
%averages = ();
foreach $outdir (@outdir_list) {
    $array_ref_sorted = $allsorted{$outdir};
    @sordid = @$array_ref_sorted;
    $limit = int( ($#sordid)*($cutoff) );
    $i = 0;
    foreach $pair (@sordid) {
	$i++;
	if($i < $limit) {
	    $file = $pair->[1];
	    $value = $pair->[0];
	    ($junk,$type) = split(/\//,$file);
	    $type =~ s/^envtst_(.*)\.log$/$1/;
	    ($idx1,$idx2,$idx3) = split(/_/,$type);
	    if($idx1 < $idx2) {
		$tipe = $idx1 . '_' . $idx2;
	    }
	    else {
		$tipe = $idx2 . '_' . $idx1;
	    }
	    # print "$file $value $type $tipe\n";
	    if(exists($averages{$tipe})) {
		if(defined($averages{$tipe})) {
		    $ref = $averages{$tipe};
		    push @$ref, $value;
		}
	    }
	    else {
		$averages{$tipe} = [$value];
	    }
	}
    }
}
%combined = ();
@tipekeys = keys %averages;
%count = ();
foreach $tipe (@tipekeys) {
    $sum = 0.0;
    $cnt = 0.0;
    $ref = $averages{$tipe};
    foreach $value (@$ref) {
	$sum += $value;
	$cnt += 1.0;
    }
    $avg = $sum/$cnt;
    $combined{$tipe} = $avg;
    $count{$tipe} = $cnt;
}
@sorted_combined =
    sort { $combined{$b} <=> $combined{$a} } keys %combined;

print "Cutoff of $cutoff\n";
foreach $k (@sorted_combined) {
    print "$k $combined{$k} ($count{$k})\n";
}

exit 0;

__END__
    
