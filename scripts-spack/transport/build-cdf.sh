#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# $ source ${repo_scripts_spack}/transport/build-cdf.sh
export elapsed=${SECONDS}

source ${repos_scripts_spack}/shared/common-header.sh

# input parameters
# specify CDF version {in two format) and library folder
export cdfvunderscore="38_0"
export cdfvdots="3.8.0"

# contructed parameters
export dircdfInstall="${HOME}/apps/cdf-${cdfvdots}"
export CDF_LIB="${dircdfInstall}/lib"

new_step "mkdir -p ${dircdfInstall}"
          mkdir -p ${dircdfInstall}

new_step "Grab tarball and extract files"
sub_step_counter=0

    sub_step "cd ${HOME}/apps"
              cd ${HOME}/apps

    # for 3.7.1 use
    #   export dircdfInstall="${HOME}/apps/cdf-3.7.1
    #   wget https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf37_1/cdf-dist-all.tar.gz
    #   tar -xzf cdf-dist-all.tar.gz
    #   cd cdf37_1-dist/
    #   301 Moved Permanently 2022-03-10 09:39:37
    sub_step "wget https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf${cdfvunderscore}/linux/cdf${cdfvunderscore}-dist-all.tar.gz"
              wget https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf${cdfvunderscore}/linux/cdf${cdfvunderscore}-dist-all.tar.gz

    sub_step "tar -xzf cdf${cdfvunderscore}-dist-all.tar.gz"
              tar -xzf cdf${cdfvunderscore}-dist-all.tar.gz

    sub_step "cd cdf${cdfvunderscore}-dist"
              cd cdf${cdfvunderscore}-dist

new_step "Install cdf ${cdfvdots}"
sub_step_counter=0

    sub_step "make OS=linux ENV=gnu FORTRAN=no SHARED=yes all"
              make OS=linux ENV=gnu FORTRAN=no SHARED=yes all

    sub_step "make install INSTALLDIR=\${dircdfInstall}=${dircdfInstall}"
              make install INSTALLDIR=${dircdfInstall}

    sub_step "cd ${HOME}/apps"
              cd ${HOME}/apps

new_step "ENV variable \${CDF_LIB} = ${CDF_LIB}"
          echo 'export CDF_LIB=${CDF_LIB}'

new_step "rm cdf${cdfvunderscore}-dist-all.tar.gz"
          rm cdf${cdfvunderscore}-dist-all.tar.gz

new_step "rm -r cdf${cdfvunderscore}-dist/"
          rm -r cdf${cdfvunderscore}-dist/

new_step "print wall time used"
    export elapsed=$((${SECONDS}-${elapsed}))
    printf "time to build CDF ${cdfvdots}: %dh:%dm:%ds\n" $(($elapsed/3600)) $(($elapsed%3600/60)) $(($elapsed%60))

new_step "script completed at $(date)"

# $ . cdf-install.sh
# Tue Feb  1 14:29:23 MST 2022, cdf-install.sh
#
# 2022-02-01 14:29: Step 1: mkdir -p /home/dantopa/apps/cdf-3.8.0
#
# 2022-02-01 14:29: Step 2: Grab tarball and extract files
#
#  2.1: cd /home/dantopa/apps
#
#  2.2: wget https://spdf.sci.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_0/linux/cdf38_0-dist-all.tar.gz
# --2022-02-01 14:29:23--  https://spdf.sci.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_0/linux/cdf38_0-dist-all.tar.gz
# Resolving spdf.sci.gsfc.nasa.gov (spdf.sci.gsfc.nasa.gov)... 169.154.154.63, 2001:4d0:2418:121::63
# Connecting to spdf.sci.gsfc.nasa.gov (spdf.sci.gsfc.nasa.gov)|169.154.154.63|:443... connected.
# HTTP request sent, awaiting response... 301 Moved Permanently
# Location: https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_0/linux/cdf38_0-dist-all.tar.gz [following]
# --2022-02-01 14:29:24--  https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_0/linux/cdf38_0-dist-all.tar.gz
# Resolving spdf.gsfc.nasa.gov (spdf.gsfc.nasa.gov)... 169.154.154.63, 2001:4d0:2418:121::63
# Connecting to spdf.gsfc.nasa.gov (spdf.gsfc.nasa.gov)|169.154.154.63|:443... connected.
# HTTP request sent, awaiting response... 200 OK
# Length: 2263743 (2.2M) [application/x-gzip]
# Saving to: ‘cdf38_0-dist-all.tar.gz.1’
#
# 100%[==========================================================================================================================================================================================>] 2,263,743   2.33MB/s   in 0.9s
#
# 2022-02-01 14:29:26 (2.33 MB/s) - ‘cdf38_0-dist-all.tar.gz.1’ saved [2263743/2263743]
#
#
#  2.3: tar -xzf cdf38_0-dist-all.tar.gz
#
#  2.4: cd cdf38_0-dist
#
# 2022-02-01 14:29: Step 3: Install cdf 3.8.0
#
#  3.1: make OS=linux ENV=gnu FORTRAN=no SHARED=yes all
#
#  3.2: make install INSTALLDIR=${dircdfInstall}=/home/dantopa/apps/cdf-3.8.0
# cp src/definitions/definitions.C /home/dantopa/apps/cdf-3.8.0/bin
# cp src/definitions/definitions.K /home/dantopa/apps/cdf-3.8.0/bin
# cp src/definitions/definitions.B /home/dantopa/apps/cdf-3.8.0/bin
# Modifying the definition file /home/dantopa/apps/cdf-3.8.0/bin/definitions.B ..
# Modifying the definition file /home/dantopa/apps/cdf-3.8.0/bin/definitions.C ..
# Modifying the definition file /home/dantopa/apps/cdf-3.8.0/bin/definitions.K ..
# cp src/include/cdf.h /home/dantopa/apps/cdf-3.8.0/include
# cp src/include/cdf.inc /home/dantopa/apps/cdf-3.8.0/include
# cp src/include/cdflib.h /home/dantopa/apps/cdf-3.8.0/include
# cp src/include/cdflib64.h /home/dantopa/apps/cdf-3.8.0/include
# cp src/include/cdfdist.h /home/dantopa/apps/cdf-3.8.0/include
# cp src/include/cdfconfig.h /home/dantopa/apps/cdf-3.8.0/include
# cp src/lib/libcdf.a /home/dantopa/apps/cdf-3.8.0/lib
# cp src/lib/libcdf.so /home/dantopa/apps/cdf-3.8.0/lib
# cp src/tools/cdfedit /home/dantopa/apps/cdf-3.8.0/bin/cdfedit
# cp src/tools/cdfxp /home/dantopa/apps/cdf-3.8.0/bin/cdfexport
# cp src/tools/cdfcvt /home/dantopa/apps/cdf-3.8.0/bin/cdfconvert
# cp src/tools/skt2cdf /home/dantopa/apps/cdf-3.8.0/bin/skeletoncdf
# cp src/tools/cdf2skt /home/dantopa/apps/cdf-3.8.0/bin/skeletontable
# cp src/tools/cdfinq /home/dantopa/apps/cdf-3.8.0/bin/cdfinquire
# cp src/tools/cdfstats /home/dantopa/apps/cdf-3.8.0/bin/cdfstats
# cp src/tools/cdfcmp /home/dantopa/apps/cdf-3.8.0/bin/cdfcompare
# cp src/tools/cdfdump /home/dantopa/apps/cdf-3.8.0/bin/cdfdump
# cp src/tools/cdfirsdump /home/dantopa/apps/cdf-3.8.0/bin/cdfirsdump
# cp src/tools/cdfmerge /home/dantopa/apps/cdf-3.8.0/bin/cdfmerge
# cp src/tools/cdfvalidate /home/dantopa/apps/cdf-3.8.0/bin/cdfvalidate
# cp src/tools/cdfleapsecondsinfo /home/dantopa/apps/cdf-3.8.0/bin/cdfleapsecondsinfo
# cp src/tools/cdfdir.unix /home/dantopa/apps/cdf-3.8.0/bin/cdfdir
# cp src/help/cdfedit.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfeditj.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfedit.ilh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfbrow.ilh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfxp.ilh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfcvt.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfcvtj.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfcmp.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfcmpj.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdf2skt.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdf2sktj.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/skt2cdf.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/skt2cdfj.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfstats.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfstatsj.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfdump.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfdumpj.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfirsdump.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfirsdumpj.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfinq.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfinqj.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfdirj.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfmerge.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfmergej.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfvalidate.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfvalidatej.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfleaptableinfo.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
# cp src/help/cdfleaptableinfoj.olh /home/dantopa/apps/cdf-3.8.0/lib/cdf/help
#
# Installation completed!
#
# **********
# *  NOTE  *
# **********
# If you want to use any of the CDF command-line utilitites (e.g. cdfedit,
# cdfexport, etc.), we strongly encourage you to set the CDF environment
# variables defined in the CDF definition files.  Once the environment variables
# defined, you can invoke the CDF utility of interest just by typing the utility
# name. Otherwise, you'll have to specify the full path of the utility.
#
# If you use TCSH or CSH, run the following command:
#
#     source /home/dantopa/apps/cdf-3.8.0/bin/definitions.C
#
#
# If you use BASH or BSH, run the following command:
#
#     . /home/dantopa/apps/cdf-3.8.0/bin/definitions.B
#
#
# If you use KSH, run the following command:
#
#     . /home/dantopa/apps/cdf-3.8.0/bin/definitions.K
#
#
# 2022-02-01 14:29: Step 4: ENV variable ${CDF_LIB} = /home/dantopa/apps/cdf-3.8.0/lib
#
# 2022-02-01 14:29: Step 5: print wall time used
# time to build CDF:
# 2022-02-01 14:29: Step 6: script completed at Tue Feb  1 14:29:28 MST 2022
