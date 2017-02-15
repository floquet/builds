#! /usr/bin/perl -Wall

@blas_tests = ('xzpblas3tim',
	       'xzpblas2tim',
	       'xzpblas1tim',
	       'xcpblas3tim',
	       'xcpblas2tim',
	       'xcpblas1tim',
	       'xdpblas3tim',
	       'xdpblas2tim',
	       'xdpblas1tim',
	       'xspblas3tim',
	       'xspblas2tim',
	       'xspblas1tim',
	       'xzpblas3tst',
	       'xzpblas2tst',
	       'xzpblas1tst',
	       'xcpblas3tst',
	       'xcpblas2tst',
	       'xcpblas1tst',
	       'xdpblas3tst',
	       'xdpblas2tst',
	       'xdpblas1tst',
	       'xspblas3tst',
	       'xspblas2tst',
	       'xspblas1tst');

@other_tests = ('xzevc',
		'xznep',
		'xzgsep',
		'xzsep',
		'xzbrd',
		'xztrd',
		'xzhrd',
		'xcevc',
		'xcnep',
		'xcgsep',
		'xcsep',
		'xcbrd',
		'xctrd',
		'xchrd',
		'xdsvd',
		'xdnep',
		'xdgsep',
		'xdsep',
		'xdbrd',
		'xdtrd',
		'xdhrd',
		'xssvd',
		'xsnep',
		'xsgsep',
		'xssep',
		'xsbrd',
		'xstrd',
		'xshrd',
		'xzls',
		'xzqr',
		'xzinv',
		'xzptllt',
		'xzpbllt',
		'xzllt',
		'xzgblu',
		'xzdtlu',
		'xzdblu',
		'xzlu',
		'xcls',
		'xcqr',
		'xcinv',
		'xcptllt',
		'xcpbllt',
		'xcllt',
		'xcgblu',
		'xcdtlu',
		'xcdblu',
		'xclu',
		'xdls',
		'xdqr',
		'xdinv',
		'xdptllt',
		'xdpbllt',
		'xdllt',
		'xdgblu',
		'xddtlu',
		'xddblu',
		'xdlu',
		'xsls',
		'xsqr',
		'xsinv',
		'xsptllt',
		'xspbllt',
		'xsllt',
		'xsgblu',
		'xsdtlu',
		'xsdblu',
		'xslu',
		'xztrmr',
		'xzgemr',
		'xctrmr',
		'xcgemr',
		'xdtrmr',
		'xdgemr',
		'xstrmr',
		'xsgemr',
		'xitrmr',
		'xigemr');

@all_tests = (@blas_tests, @other_tests);

@num_proc_list = (4,16,64);

$the_wd = `pwd`;
chomp($the_wd);
$testdir = 'unknown';
if ($the_wd eq '/work/scheinin/scalapack/compiler_mkl/scalapack-1.8.0/TESTING') {
    $testdir = 'compiler_mkl';
}
elsif ($the_wd eq '/work/scheinin/scalapack/alan_scalapack/scalapack-1.8.0/TESTING') {
    $testdir = 'alan_scalapack';
}
elsif ($the_wd eq '/work/scheinin/scalapack/module_mkl/scalapack-1.8.0/TESTING') {
    $testdir = 'module_mkl';
}
else {
    die "unknown test directory";
}
print STDOUT "Working on case $testdir\n";

$check_files = 1;
if($check_files) {
    foreach $test_name (@all_tests) {
	if( -x $test_name ) {
	    print STDOUT "Found $test_name\n";
	}
	else {
	    print STDERR "Error, did not find $test_name\n";
	}
    }
    exit 0;
}

$lim = 0;
foreach $np (@num_proc_list) {
    foreach $test_name (@all_tests) {
	$lim++;
# Use $lim for limiting the number of tests.
#	if($lim > 2) { exit 0; }
	$cmd = 'mpiexec_mpt -np ' . $np . ' ./' . $test_name;
	print STDOUT "Starting $cmd\n";
        $begin_time = time();
	system($cmd);
        $total_time = time() - $begin_time;
        print STDOUT "Wallclock time = $total_time seconds\n";
	print STDOUT "Done $cmd\n";
    }
}

exit 0;

__END__
