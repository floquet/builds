#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source ${repo_scripts_spack}/environment/build-environment.sh

export    dirUser="${SPACK_ROOT}/${USER}"
export    dirInfo="${dirUser}/info"
export dirInstall="${dirUser}/install"

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

spack install alglib  ${myCompiler}              | tee ${dirUser}/alglib.txt 2>&1
spack install armadillo  ${myCompiler}           | tee ${dirUser}/armadillo.txt 2>&1
spack install blitz  ${myCompiler} ${myPython}   | tee ${dirUser}/blitz.txt 2>&1
spack install chapel ${myCompiler}               | tee ${dirUser}/chapel.txt 2>&1
spack install charmpp ${myCompiler} ${myOpenMPI} | tee ${dirUser}/charmpp.txt 2>&1
spack install eigen ${myCompiler}                | tee ${dirUser}/eigen.txt 2>&1
spack install environment-modules ${myCompiler}  | tee ${dirUser}/environment-modules.txt 2>&1
spack install fftw ${myCompiler}                 | tee ${dirUser}/fftw.txt 2>&1
spack install gdb ${myCompiler} ${myPython}      | tee ${dirUser}/gdb.txt 2>&1
spack install go  ${myCompiler}                  | tee ${dirUser}/go.txt 2>&1
spack install julia ${myCompiler} ${myLLVM}      | tee ${dirUser}/julia.txt 2>&1

spack install h5bench ${myCompiler} ${myOpenMPI}          | tee ${dirUser}/h5bench.txt  2>&1
spack install h5cpp ${myCompiler} ${myOpenMPI}            | tee ${dirUser}/h5cpp.txt  2>&1
spack install h5hut ${myCompiler} ${myOpenMPI}            | tee ${dirUser}/h5hut.txt  2>&1
spack install h5part ${myCompiler} ${myOpenMPI}           | tee ${dirUser}/h5part.txt  2>&1
spack install h5z-zfp ${myCompiler}                       | tee ${dirUser}/h5z-zfp.txt  2>&1

spack install lua ${myCompiler}                           | tee ${dirUser}/lua.txt  2>&1
spack install meson ${myCompiler} ${myPython}             | tee ${dirUser}/meson.txt  2>&1

spack install netcdf-c ${myCompiler} ${myOpenMPI}         | tee ${dirUser}/netcdf-c.txt 2>&1
spack install netcdf-fortran ${myCompiler}                | tee ${dirUser}/netcdf-fortran.txt 2>&1
spack install netcdf-cxx4 ${myCompiler} ${myPython}       | tee ${dirUser}/netcdf-cxx4.txt 2>&1
spack install netlib-scalapack ${myCompiler} ${myOpenMPI} | tee ${dirUser}/netlib-scalapack.txt  2>&1

spack install opencoarrays ${myCompiler} ${myOpenMPI}     | tee ${dirUser}/opencoarrays.txt 2>&1
spack install parallel-netcdf ${myCompiler} ${myOpenMPI}  | tee ${dirUser}/parallel-netcdf.txt 2>&1
spack install petsc +fftw +mpfr +mumps +scalapack +strumpack +suite-sparse +superlu-dist ${myCompiler} ${myPython} ${myOpenMPI} | tee ${dirUser}/petsc.txt 2>&1
spack install r ${myCompiler}                             | tee ${dirUser}/r.txt 2>&1
spack install ruby ${myCompiler}                          | tee ${dirUser}/ruby.txt 2>&1
spack install rust ${myCompiler} ${myPython}              | tee ${dirUser}/rust.txt 2>&1
spack install scala ${myCompiler}                         | tee ${dirUser}/scala.txt 2>&1
spack install tau  ${myCompiler} ${myPython} ${myOpenMPI} | tee ${dirUser}/tau.txt 2>&1
spack install valgrind ${myCompiler} ${myOpenMPI}         | tee ${dirUser}/valgrind.txt 2>&1
spack install zoltan ${myCompiler} ${myOpenMPI}           | tee ${dirUser}/zoltan.txt 2>&1

spack install llvm@16.0.6 ${myCompiler} ${myPython} | tee ${dirUser}/llvm@16.0.6.txt 2>&1
spack install llvm@15.0.6 ${myCompiler} ${myPython} | tee ${dirUser}/llvm@15.0.6.txt 2>&1
spack install llvm@14.0.6 ${myCompiler} ${myPython} | tee ${dirUser}/llvm@14.0.6.txt 2>&1
