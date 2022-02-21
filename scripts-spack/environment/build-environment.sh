#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source ${repo_scripts_spack}/environment/build-environment.sh

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

spack install alglib  ${myCompiler}              | tee ${mySpackLogs}/alglib.txt 2>&1
spack install armadillo  ${myCompiler}           | tee ${mySpackLogs}/armadillo.txt 2>&1
spack install blitz  ${myCompiler} ${myPython}   | tee ${mySpackLogs}/blitz.txt 2>&1
spack install chapel ${myCompiler}               | tee ${mySpackLogs}/chapel.txt 2>&1
spack install charmpp ${myCompiler} ${myOpenMPI} | tee ${mySpackLogs}/charmpp.txt 2>&1
spack install eigen ${myCompiler}                | tee ${mySpackLogs}/eigen.txt 2>&1
spack install environment-modules ${myCompiler}  | tee ${mySpackLogs}/environment-modules.txt 2>&1
spack install fftw ${myCompiler}                 | tee ${mySpackLogs}/fftw.txt 2>&1
spack install gdb ${myCompiler} ${myPython}      | tee ${mySpackLogs}/gdb.txt 2>&1
spack install go  ${myCompiler}                  | tee ${mySpackLogs}/go.txt 2>&1
spack install julia ${myCompiler} ${myLLVM}      | tee ${mySpackLogs}/julia.txt 2>&1

spack install h5bench ${myCompiler} ${myOpenMPI}          | tee ${mySpackLogs}/h5bench.txt  2>&1
spack install h5cpp ${myCompiler} ${myOpenMPI}            | tee ${mySpackLogs}/h5cpp.txt  2>&1
spack install h5hut ${myCompiler} ${myOpenMPI}            | tee ${mySpackLogs}/h5hut.txt  2>&1
spack install h5part ${myCompiler} ${myOpenMPI}           | tee ${mySpackLogs}/h5part.txt  2>&1
spack install h5z-zfp ${myCompiler}                       | tee ${mySpackLogs}/h5z-zfp.txt  2>&1

spack install lua ${myCompiler}                           | tee ${mySpackLogs}/lua.txt  2>&1
spack install meson ${myCompiler} ${myPython}             | tee ${mySpackLogs}/meson.txt  2>&1

spack install netcdf-c ${myCompiler} ${myOpenMPI}         | tee ${mySpackLogs}/netcdf-c.txt 2>&1
spack install netcdf-fortran ${myCompiler}                | tee ${mySpackLogs}/netcdf-fortran.txt 2>&1
spack install netcdf-cxx4 ${myCompiler} ${myPython}       | tee ${mySpackLogs}/netcdf-cxx4.txt 2>&1
spack install netlib-scalapack ${myCompiler} ${myOpenMPI} | tee ${mySpackLogs}/netlib-scalapack.txt  2>&1

spack install opencoarrays ${myCompiler} ${myOpenMPI}     | tee ${mySpackLogs}/opencoarrays.txt 2>&1
spack install parallel-netcdf ${myCompiler} ${myOpenMPI}  | tee ${mySpackLogs}/parallel-netcdf.txt 2>&1
spack install petsc +fftw +mpfr +mumps +scalapack +strumpack +suite-sparse +superlu-dist ${myCompiler} ${myPython} ${myOpenMPI} | tee ${mySpackLogs}/petsc.txt 2>&1
spack install r ${myCompiler}                             | tee ${mySpackLogs}/r.txt 2>&1
spack install ruby ${myCompiler}                          | tee ${mySpackLogs}/ruby.txt 2>&1
spack install rust ${myCompiler} ${myPython}              | tee ${mySpackLogs}/rust.txt 2>&1
spack install scala ${myCompiler}                         | tee ${mySpackLogs}/scala.txt 2>&1
spack install tau  ${myCompiler} ${myPython} ${myOpenMPI} | tee ${mySpackLogs}/tau.txt 2>&1
spack install valgrind ${myCompiler} ${myOpenMPI}         | tee ${mySpackLogs}/valgrind.txt 2>&1
spack install zoltan ${myCompiler} ${myOpenMPI}           | tee ${mySpackLogs}/zoltan.txt 2>&1

spack install llvm@13.0.0 ${myCompiler} ${myPython} | tee ${mySpackLogs}/llvm@13.0.0.txt 2>&1
spack install llvm@12.0.1 ${myCompiler} ${myPython} | tee ${mySpackLogs}/llvm@12.0.1.txt 2>&1
spack install llvm@11.1.0 ${myCompiler} ${myPython} | tee ${mySpackLogs}/llvm@11.1.0.txt 2>&1
