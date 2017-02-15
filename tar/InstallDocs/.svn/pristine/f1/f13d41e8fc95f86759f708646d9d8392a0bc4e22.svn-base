#!/bin/bash

#
# Build Quantum Espresso with CCE
# E. Kornkven, January 2013
#
# We don't use the Espresso "configure --prefix" so this directory structure 
# is a little different:
#
# espresso
#   --> 5.0.2
#       --> wrk
#           --> espresso-5.0.2.tgz
#           --> build scripts (this one)
#       --> espresso-5.0.2 (created by build process)
#
# This script should run from the wrk directory.
#

PKG=espresso
V=5.0.2
BUILDV=${V}-cce

#
# Base location for this installation
#ROOT=/usr/local/usp/${PKG}/${BUILDV}
    ROOT=..     
    echo ""
    echo "***"
    echo "*** Using test installation dir: $ROOT !!!"
    echo "***"
    echo ""
cd $ROOT
INSTALL=$(pwd)

#
# Untar source files
cd $INSTALL
tar -xvf wrk/${PKG}-${V}.tar.gz
cd ${INSTALL}/${PKG}-${V}

# We use Cray compilers.
. /opt/modules/default/init/bash
module switch $(module -t list 2>&1 | grep PrgEnv) PrgEnv-cray

#
# Configure doesn't work with CCE so we bring our own make.sys.
cp ../wrk/make.sys.cce make.sys
echo "TOPDIR = $(pwd -P)" >> make.sys
  # Else,
  # Need to change env to compile serial codes for login node (as in configure).
  # module unload xt-mpich2
  # module switch xtpe-interlagos xtpe-barcelona
  # ./configure --prefix=$ROOT --enable-parallel ARCH=crayxt4 2>&1 | tee configure.log
  # module switch xtpe-barcelona xtpe-interlagos
  # module load xt-mpich2

#
# Build.
make all 2>&1 | tee make.log

#
# Copy in the environment edited for this machine
cp ../wrk/environment_variables.cce environment_variables

exit

