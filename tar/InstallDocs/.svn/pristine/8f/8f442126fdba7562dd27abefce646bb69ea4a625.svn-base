#!/bin/csh
#
#!/bin/csh
#PBS -q debug
#PBS -l ncpus=128
#PBS -l walltime=00:30:00
#PBS -N grph
#PBS -j oe
#PBS -A ARLAP32123088
#
## End of preamble, beginning of shell script ##

# set the path to the tmp directory
setenv TMPZ $WORKDIR/$PBS_JOBID
# set the executable binary

cd $PBS_O_WORKDIR

if (! -e $WORKDIR/$PBS_JOBID) mkdir -p $WORKDIR/$PBS_JOBID

cd $WORKDIR/$PBS_JOBID
#==================
setenv EXEDIR $HOME/bin
setenv EXE cp2k.popt
setenv INFILE grph-md.inp
setenv JOBTAR job.$PBS_JOBID.tar
setenv RESTAR res.$PBS_JOBID.tar
setenv LOGFILE log.$PBS_JOBID
#setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/opt/fftw/2.1.5/cnos/lib
echo $LD_LIBRARY_PATH
if (! -e $TMPZ) mkdir -p $TMPZ
if (! -e $TMPZ/run) mkdir -p $TMPZ/run
if (! -e $TMPZ/bin) mkdir -p $TMPZ/bin

cd  $HOME/work/graphene
cp  $INFILE         $TMPZ/run/
cp ../POTENTIAL  $TMPZ/run
cp ../BASIS_SET $TMPZ/run
cp $EXEDIR/$EXE $TMPZ/bin

cd $TMPZ/run
#cp ../../2065.pbs/run/RDX-dc-GEO_OPT-2-RESTART.wfn rdx.wfn
#cp ../../2065.pbs/run/RDX-dc-GEO_OPT-2-1.restart rdx.restart
set mybin = `cd ../bin; pwd`
setenv PATH $mybin":"$PATH
setenv OMP_NUM_THREADS 1
limit stacksize unlimited

#module purge
#module add fftw/2.1.5
date > times.log
aprun -n 32 -N 4  ../bin/$EXE  -i $INFILE  >& $LOGFILE

date >> times.log

cd


