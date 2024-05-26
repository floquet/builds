#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# called from ${repo_scripts_spack}/environment/master-spack.sh

export spack=${SECONDS}

# # #   INFO
spack info alglib              > ${dirInfo}/alglib.txt  2>&1 &
spack info armadillo           > ${dirInfo}/armadillo.txt  2>&1 &
spack info blitz               > ${dirInfo}/blitz.txt  2>&1 &
spack info charmpp             > ${dirInfo}/charmpp.txt  2>&1 &
spack info chapel              > ${dirInfo}/chapel.txt  2>&1 &
spack info eigen               > ${dirInfo}/eigen.txt  2>&1 &
spack info environment-modules > ${dirInfo}/environment-modules.txt  2>&1 &
spack info fftw                > ${dirInfo}/fftw.txt  2>&1 &
spack info gdb                 > ${dirInfo}/gdb.txt  2>&1 &
spack info gh                  > ${dirInfo}/go.txt  2>&1 &
spack info go                  > ${dirInfo}/go.txt  2>&1 &
spack info gsl                 > ${dirInfo}/gsl.txt  2>&1 &
spack info julia               > ${dirInfo}/julia.txt  2>&1 &
spack info h5cpp               > ${dirInfo}/h5cpp.txt  2>&1 &
spack info h5part              > ${dirInfo}/h5part.txt  2>&1 &
spack info h5z-zfp             > ${dirInfo}/h5z-zfp.txt  2>&1 &
spack info librsb              > ${dirInfo}/librsb.txt  2>&1 &
spack info lua                 > ${dirInfo}/lua.txt  2>&1 &
spack info meson               > ${dirInfo}/meson.txt  2>&1 &
spack info netcdf-c            > ${dirInfo}/netcdf-c.txt  2>&1 &
spack info netcdf-fortran      > ${dirInfo}/netcdf-fortran.txt  2>&1 &
spack info netcdf-cxx4         > ${dirInfo}/netcdf-cxx4.txt  2>&1 &
spack info netlib-scalapack    > ${dirInfo}/netlib-scalapack.txt  2>&1 &
spack info ntl                 > ${dirInfo}/ntl.txt  2>&1 &
spack info opencoarrays        > ${dirInfo}/opencoarrays.txt  2>&1 &
spack info parallel-netcdf     > ${dirInfo}/parallel-netcdf.txt  2>&1 &
spack info r                   > ${dirInfo}/r.txt  2>&1 &
spack info rust                > ${dirInfo}/rust.txt  2>&1 &
spack info ruby                > ${dirInfo}/ruby.txt  2>&1 &
spack info scala               > ${dirInfo}/scala.txt  2>&1 &
spack info sprng               > ${dirInfo}/sprng.txt  2>&1 &
spack info tau                 > ${dirInfo}/tau.txt  2>&1 &
spack info valgrind            > ${dirInfo}/valgrind.txt  2>&1 &
spack info xtensor             > ${dirInfo}/xtensor.txt  2>&1 &
spack info zoltan              > ${dirInfo}/zoltan.txt  2>&1 &

# # #   INSTALL
spack install alglib % ${myCompiler}               | tee ${dirInstall}/alglib.txt 2>&1
spack install armadillo % ${myCompiler}            | tee ${dirInstall}/armadillo.txt 2>&1
spack install blitz % ${myCompiler} ${myPython}    | tee ${dirInstall}/blitz.txt 2>&1
spack install chapel % ${myCompiler}               | tee ${dirInstall}/chapel.txt 2>&1
spack install charmpp % ${myCompiler} ${myOpenMPI} | tee ${dirInstall}/charmpp.txt 2>&1
spack install eigen % ${myCompiler}                | tee ${dirInstall}/eigen.txt 2>&1
spack install environment-modules % ${myCompiler}  | tee ${dirInstall}/environment-modules.txt 2>&1
spack install fftw % ${myCompiler}                 | tee ${dirInstall}/fftw.txt 2>&1
spack install gdb % ${myCompiler} ${myPython}      | tee ${dirInstall}/gdb.txt 2>&1
spack install gh % ${myCompiler}                   | tee ${dirInstall}/gh.txt 2>&1
spack install go % ${myCompiler}                   | tee ${dirInstall}/go.txt 2>&1
spack install gsl % ${myCompiler}                  | tee ${dirInstall}/gsl.txt 2>&1
spack install julia % ${myCompiler} ${myLLVM}      | tee ${dirInstall}/julia.txt 2>&1

spack install h5bench % ${myCompiler} ${myOpenMPI}          | tee ${dirInstall}/h5bench.txt  2>&1
spack install h5cpp % ${myCompiler} ${myOpenMPI}            | tee ${dirInstall}/h5cpp.txt  2>&1
spack install h5hut % ${myCompiler} ${myOpenMPI}            | tee ${dirInstall}/h5hut.txt  2>&1
spack install h5part% ${myCompiler} ${myOpenMPI}            | tee ${dirInstall}/h5part.txt  2>&1
spack install h5z-zfp % ${myCompiler}                       | tee ${dirInstall}/h5z-zfp.txt  2>&1

spack install librsb % ${myCompiler}                        | tee ${dirInstall}/librsb.txt  2>&1
spack install lua % ${myCompiler}                           | tee ${dirInstall}/lua.txt  2>&1
spack install meson % ${myCompiler} ${myPython}             | tee ${dirInstall}/meson.txt  2>&1

spack install netcdf-c % ${myCompiler} ${myOpenMPI}         | tee ${dirInstall}/netcdf-c.txt 2>&1
spack install netcdf-fortran % ${myCompiler}                | tee ${dirInstall}/netcdf-fortran.txt 2>&1
spack install netcdf-cxx4 % ${myCompiler} ${myPython}       | tee ${dirInstall}/netcdf-cxx4.txt 2>&1
spack install netlib-scalapack % ${myCompiler} ${myOpenMPI} | tee ${dirInstall}/netlib-scalapack.txt  2>&1
spack install ntl % ${myCompiler}                           | tee ${dirInstall}/ntl.txt 2>&1

spack install opencoarrays % ${myCompiler} ${myOpenMPI}     | tee ${dirInstall}/opencoarrays.txt 2>&1
spack install parallel-netcdf % ${myCompiler} ${myOpenMPI}  | tee ${dirInstall}/parallel-netcdf.txt 2>&1
spack install petsc +fftw +mpfr +mumps +scalapack +strumpack +suite-sparse +superlu-dist % ${myCompiler} ${myPython} ${myOpenMPI} | tee ${dirInstall}/petsc.txt 2>&1
spack install r % ${myCompiler}                             | tee ${dirInstall}/r.txt 2>&1
spack install ruby % ${myCompiler}                          | tee ${dirInstall}/ruby.txt 2>&1
spack install rust % ${myCompiler} ${myPython}              | tee ${dirInstall}/rust.txt 2>&1
spack install scala % ${myCompiler}                         | tee ${dirInstall}/scala.txt 2>&1
spack install sprng % ${myCompiler}                         | tee ${dirInstall}/sprng.txt 2>&1
spack install tau % ${myCompiler} ${myPython} ${myOpenMPI}  | tee ${dirInstall}/tau.txt 2>&1
spack install valgrind % ${myCompiler} ${myOpenMPI}         | tee ${dirInstall}/valgrind.txt 2>&1
spack install xtensor % ${myCompiler}                       | tee ${dirInstall}/xtensor.txt 2>&1
spack install zoltan % ${myCompiler} ${myOpenMPI}           | tee ${dirInstall}/zoltan.txt 2>&1

spack install llvm@16.0.6 % ${myCompiler} ${myPython} | tee ${dirInstall}/llvm@16.0.6.txt 2>&1
#spack install llvm@15.0.7 ${myCompiler} ${myPython} | tee ${dirInstall}/llvm@15.0.7.txt 2>&1
#spack install llvm@14.0.6 ${myCompiler} ${myPython} | tee ${dirInstall}/llvm@16.0.6.txt 2>&1

new_step "print wall time used"
    export spack=$((${SECONDS}-${spack}))
    printf 'time for extended builds: %dh:%dm:%ds\n' $((${spack}/3600)) $((${spack}%3600/60)) $((${spack}%60))
