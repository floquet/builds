#!/bin/bash

# Installation of Quantum Espresso 5.0.2 on Copper/Chugach.
# E. Kornkven
# January 8, 2013

PKG=espresso
V=5.0.2
BUILDV=${V}-pgi

#
# Base location for this installation
ROOT=/usr/local/usp/${PKG}/${BUILDV}
    #ROOT=..     
    #echo ""
    #echo "***"
    #echo "*** Using test installation dir: $ROOT !!!"
    #echo "***"
    #echo ""
cd $ROOT
INSTALL=$(pwd)

#
# Untar source files
cd $INSTALL
tar -xvf wrk/${PKG}-${V}.tar.gz
cd ${INSTALL}/${PKG}-${V}


# 1) load modules
. /opt/modules/default/init/bash
module load PrgEnv-pgi
module switch $(module -t list 2>&1 | grep "^pgi") pgi/12.8.0
#module unload atp

# 2) Use the pre-generated make.sys instead of 3a) and 3b) below
cp ../wrk/make.sys.pgi make.sys
echo "TOPDIR = $(pwd -P)" >> make.sys

    # Else
    #./configure ARCH=crayxt --enable-openmp --enable-parallel --with-scalapack 
    #CFLAGS = -Minfo=all -Mneginfo=all -O3 -fastsse -Mipa=fast,inline $(DFLAGS) $(IFLAGS)
    #F90FLAGS = -Minfo=all -Mneginfo=all -O3 -fastsse -Mipa=fast,inline \
               #-Mcache_align -r8 -Mpreprocess -mp $(FDFLAGS) $(IFLAGS) $(MODFLAGS)
    #FFLAGS = -Minfo=all -Mneginfo=all -O3 -fastsse -Mipa=fast,inline -r8 -mp

# 4) make
make all 2>&1 | tee make.log


exit 0      # <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


