#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source ${repo_scripts_spack}/environment/build-environment.sh

export dirInfo="${SPACK_ROOT}/${USER}/info"
export dirInstall="${SPACK_ROOT}/${USER}/install"

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
spack info go                  > ${dirInfo}/go.txt  2>&1 &
spack info julia               > ${dirInfo}/julia.txt  2>&1 &
spack info h5cpp               > ${dirInfo}/h5cpp.txt  2>&1 &
spack info h5part              > ${dirInfo}/h5part.txt  2>&1 &
spack info h5z-zfp             > ${dirInfo}/h5z-zfp.txt  2>&1 &
spack info lua                 > ${dirInfo}/lua.txt  2>&1 &
spack info meson               > ${dirInfo}/meson.txt  2>&1 &
spack info netcdf-c            > ${dirInfo}/netcdf-c.txt  2>&1 &
spack info netcdf-fortran      > ${dirInfo}/netcdf-fortran.txt  2>&1 &
spack info netcdf-cxx4         > ${dirInfo}/netcdf-cxx4.txt  2>&1 &
spack info netlib-scalapack    > ${dirInfo}/netlib-scalapack.txt  2>&1 &
spack info opencoarrays        > ${dirInfo}/opencoarrays.txt  2>&1 &
spack info parallel-netcdf     > ${dirInfo}/parallel-netcdf.txt  2>&1 &
spack info r                   > ${dirInfo}/r.txt  2>&1 &
spack info rust                > ${dirInfo}/rust.txt  2>&1 &
spack info ruby                > ${dirInfo}/ruby.txt  2>&1 &
spack info scala               > ${dirInfo}/scala.txt  2>&1 &
spack info tau                 > ${dirInfo}/tau.txt  2>&1 &
spack info valgrind            > ${dirInfo}/valgrind.txt  2>&1 &
spack info zoltan              > ${dirInfo}/zoltan.txt  2>&1 &

spack install alglib  ${myCompiler}              | tee ${SPACK_ROOT}/${USER}/alglib.txt 2>&1
spack install armadillo  ${myCompiler}           | tee ${SPACK_ROOT}/${USER}/armadillo.txt 2>&1
spack install blitz  ${myCompiler} ${myPython}   | tee ${SPACK_ROOT}/${USER}/blitz.txt 2>&1
spack install chapel ${myCompiler}               | tee ${SPACK_ROOT}/${USER}/chapel.txt 2>&1
spack install charmpp ${myCompiler} ${myOpenMPI} | tee ${SPACK_ROOT}/${USER}/charmpp.txt 2>&1
spack install eigen ${myCompiler}                | tee ${SPACK_ROOT}/${USER}/eigen.txt 2>&1
spack install environment-modules ${myCompiler}  | tee ${SPACK_ROOT}/${USER}/environment-modules.txt 2>&1
spack install fftw ${myCompiler}                 | tee ${SPACK_ROOT}/${USER}/fftw.txt 2>&1
spack install gdb ${myCompiler} ${myPython}      | tee ${SPACK_ROOT}/${USER}/gdb.txt 2>&1
spack install go  ${myCompiler}                  | tee ${SPACK_ROOT}/${USER}/go.txt 2>&1
spack install julia ${myCompiler} ${myLLVM}      | tee ${SPACK_ROOT}/${USER}/julia.txt 2>&1

spack install h5bench ${myCompiler} ${myOpenMPI}          | tee ${SPACK_ROOT}/${USER}/h5bench.txt  2>&1
spack install h5cpp ${myCompiler} ${myOpenMPI}            | tee ${SPACK_ROOT}/${USER}/h5cpp.txt  2>&1
spack install h5hut ${myCompiler} ${myOpenMPI}            | tee ${SPACK_ROOT}/${USER}/h5hut.txt  2>&1
spack install h5part ${myCompiler} ${myOpenMPI}           | tee ${SPACK_ROOT}/${USER}/h5part.txt  2>&1
spack install h5z-zfp ${myCompiler}                       | tee ${SPACK_ROOT}/${USER}/h5z-zfp.txt  2>&1

spack install lua ${myCompiler}                           | tee ${SPACK_ROOT}/${USER}/lua.txt  2>&1
spack install meson ${myCompiler} ${myPython}             | tee ${SPACK_ROOT}/${USER}/meson.txt  2>&1

spack install netcdf-c ${myCompiler} ${myOpenMPI}         | tee ${SPACK_ROOT}/${USER}/netcdf-c.txt 2>&1
spack install netcdf-fortran ${myCompiler}                | tee ${SPACK_ROOT}/${USER}/netcdf-fortran.txt 2>&1
spack install netcdf-cxx4 ${myCompiler} ${myPython}       | tee ${SPACK_ROOT}/${USER}/netcdf-cxx4.txt 2>&1
spack install netlib-scalapack ${myCompiler} ${myOpenMPI} | tee ${SPACK_ROOT}/${USER}/netlib-scalapack.txt  2>&1

spack install opencoarrays ${myCompiler} ${myOpenMPI}     | tee ${SPACK_ROOT}/${USER}/opencoarrays.txt 2>&1
spack install parallel-netcdf ${myCompiler} ${myOpenMPI}  | tee ${SPACK_ROOT}/${USER}/parallel-netcdf.txt 2>&1
spack install petsc +fftw +mpfr +mumps +scalapack +strumpack +suite-sparse +superlu-dist ${myCompiler} ${myPython} ${myOpenMPI} | tee ${SPACK_ROOT}/${USER}/petsc.txt 2>&1
spack install r ${myCompiler}                             | tee ${SPACK_ROOT}/${USER}/r.txt 2>&1
spack install ruby ${myCompiler}                          | tee ${SPACK_ROOT}/${USER}/ruby.txt 2>&1
spack install rust ${myCompiler} ${myPython}              | tee ${SPACK_ROOT}/${USER}/rust.txt 2>&1
spack install scala ${myCompiler}                         | tee ${SPACK_ROOT}/${USER}/scala.txt 2>&1
spack install tau  ${myCompiler} ${myPython} ${myOpenMPI} | tee ${SPACK_ROOT}/${USER}/tau.txt 2>&1
spack install valgrind ${myCompiler} ${myOpenMPI}         | tee ${SPACK_ROOT}/${USER}/valgrind.txt 2>&1
spack install zoltan ${myCompiler} ${myOpenMPI}           | tee ${SPACK_ROOT}/${USER}/zoltan.txt 2>&1

spack install llvm@13.0.0 ${myCompiler} ${myPython} | tee ${SPACK_ROOT}/${USER}/llvm@13.0.0.txt 2>&1
spack install llvm@12.0.1 ${myCompiler} ${myPython} | tee ${SPACK_ROOT}/${USER}/llvm@12.0.1.txt 2>&1
spack install llvm@11.1.0 ${myCompiler} ${myPython} | tee ${SPACK_ROOT}/${USER}/llvm@11.1.0.txt 2>&1
