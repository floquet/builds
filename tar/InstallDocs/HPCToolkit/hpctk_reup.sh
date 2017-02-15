#!/bin/bash

# script must be sourced for module commands to work :
#
# $ source hpctk_reup.sh

## parent directory for hpctoolkit and externals source directories
srcdir=$HOME/pub/src

## return to this directory at the end of the script
curdir=`pwd`

## install hpctoolkit in this prefix
installdir=$HOME/pub/src/install-sandbox

dorun="y"

## Check to see if PrgEnv-gnu is loaded
if [[ ! "$LOADEDMODULES" =~ "PrgEnv-gnu" ]] ; then
  echo "Please load PrgEnv-gnu before using this script"
  dorun="n"
fi

if [ "$dorun" == "y" ] ; then

## set which module gets loaded for the HPCToolkit build
## also set the corresponding location of the papi libraries
papimod=papi
#papimod=perftools
papidir=/opt/cray/papi/4.3.0.1/perf_events/no-cuda

#papimod=xt-papi
#papidir=/opt/cray/perftools/papi/3.7.2.0.5/v23/


## HPCToolkit and externals tarball locations
tkver=5.2.1-r3646
tktar=hpctoolkit-${tkver}.tar.gz
tktar_url=https://outreach.scidac.gov/frs/download.php/698/${tktar}

exver=5.2.1-r3646
extar=hpctoolkit-externals-${exver}.tar.gz
extar_url=https://outreach.scidac.gov/frs/download.php/699/${extar}


## HPCToolkit and externals svn locations
tksvn_repo=https://outreach.scidac.gov/svn/hpctoolkit/trunk
tksvn_dir=hpctoolkit-svn

exsvn_repo=https://outreach.scidac.gov/svn/hpctoolkit/externals
exsvn_dir=hpctoolkit-externals-svn


## Begin main function

cd $srcdir
echo "Putting source,build directories here :"
pwd

read -p "Remove build directories for rebuild? (y/n)? : " donuke

read -p "Build from svn (y/n)? : " usesvn

if [ "$usesvn" == "y" ] ; then
  export HPCTK_EXT=$exsvn_dir    
  export HPCTK_SRC=$tksvn_dir
else
  export HPCTK_EXT=hpctoolkit-externals-${exver}
  export HPCTK_SRC=hpctoolkit-${tkver}
fi

read -p "Rebuild HPCToolkit Externals (y/n)? : " exredo

read -p "Rebuild HPCToolkit (y/n)? : " tkredo

if [ "$exredo" == "y" ] ; then

  read -p "Remove externals install directory (y/n)? : " dounin

  cd $srcdir

  if [ "$usesvn" == "y" ] ; then

    if [ ! -d "$HPCTK_EXT" ]; then
      echo "Doing initial svn checkout for externals..."
      svn co $exsvn_repo $HPCTK_EXT
    fi

    cd $HPCTK_EXT

    echo "Updating externals from svn..."
    svn up
    svn info 2>&1 | tee svn.BUILD.info

  else

    if [ ! -d "$HPCTK_EXT" ] ; then
      echo "Fetching externals tarball..."

      wget $extar_url
      tar xfvz $extar
    fi
    
    cd $HPCTK_EXT
  fi


  if [ "$donuke" == "y" ] ; then
    rm -rf BUILD
  fi

  if [ "$dounin" == "y" ] ; then
    rm -rf x86_64-linux
  fi

  mkdir -p BUILD
  cd BUILD

  export CC="gcc"
  export CXX="g++"

  ../configure CC="gcc" CXX="g++" \
  --prefix=$srcdir/$HPCTK_EXT/x86_64-linux 2>&1 | tee configure.out

  make install 2>&1 | tee make.install.out 
  make distclean

  export CC="cc"
  export CXX="CC"

fi

if [ "$tkredo" == "y" ] ; then

  cd $srcdir

  if [ "$usesvn" == "y" ] ; then

    if [ ! -d "$HPCTK_SRC" ] ; then
       echo "Doing initial svn checkout for hpctoolkit..."
       svn co $tksvn_repo $HPCTK_SRC
    fi

    cd $HPCTK_SRC

    echo "Updating HPCToolkit from svn..."
    svn up
    svn info 2>&1 | tee svn.BUILD.info
  
  else

    if [ ! -d "$HPCTK_SRC" ] ; then
      echo "Fetching HPCToolkit tarball..."

      wget $tktar_url
      tar xfvz $tktar
    fi

    cd $HPCTK_SRC
  fi
    
  if [ "$donuke" == "y" ] ; then
    rm -rf BUILD
  fi

  mkdir -p BUILD
  cd BUILD

  module load $papimod

  export CC="gcc"
  export CXX="g++"
  
  ../configure MPIF77="ftn" MPICC="cc" MPICXX="CC" \
  HPC_LT_LDFLAGS="-all-static -L../../lib/stubs-gcc_s" \
  --prefix=$installdir \
  --with-externals=$srcdir/$HPCTK_EXT/x86_64-linux \
  --with-papi=$papidir \
  2>&1 | tee configure.out

  make install 2>&1 | tee make.install.out

  export CC="cc"
  export CXX="cxx"

fi


cd $curdir

fi
