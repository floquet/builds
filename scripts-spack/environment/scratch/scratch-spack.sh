spack install chapel ${myCompiler}  | tee -a ${mySpackLogs}/chapel.txt 2>&1
spack install environment-modules ${myCompiler}  | tee -a ${mySpackLogs}/environment-modules.txt 2>&1
spack install gsl ${myCompiler}  | tee -a ${mySpackLogs}/gsl.txt 2>&1
spack install xcalc ${myCompiler}  | tee -a ${mySpackLogs}/xcalc.txt 2>&1
spack install xerces-c ${myCompiler}  | tee -a ${mySpackLogs}/xerces-c.txt 2>&1

spack install doxygen           ${myCompiler} ${myPython}  | tee -a ${mySpackLogs}/doxygen.txt 2>&1
spack install gdb               ${myCompiler} ${myPython}  | tee -a ${mySpackLogs}/gdb.txt 2>&1
spack install py-astropy+extras ${myCompiler} ${myPython}  | tee -a ${mySpackLogs}/py-astropy.txt
spack install py-seaborn        ${myCompiler} ${myPython}  | tee -a ${mySpackLogs}/py-seaborn.txt 2>&1
spack install py-tqdm           ${myCompiler} ${myPython}  | tee -a ${mySpackLogs}/py-tqdm.txt 2>&1
spack install py-urllib3        ${myCompiler} ${myPython}  | tee -a ${mySpackLogs}/py-urllib3.txt 2>&1


spack install petsc +fftw +mpfr +mumps +scalapack +strumpack +suite-sparse +superlu-dist ${myCompiler} ${myPython} ${myOpenMPI}  | tee -a ${mySpackLogs}/petsc.txt 2>&1
spack install tau                                                                        ${myCompiler} ${myPython} ${myOpenMPI}  | tee -a ${mySpackLogs}/tau.txt 2>&1

spack install netcdf-fortran  ${myCompiler} ${myOpenMPI}  | tee -a ${mySpackLogs}/netcdf-fortran.txt 2>&1
spack install netcdf-cxx4     ${myCompiler} ${myOpenMPI}  | tee -a ${mySpackLogs}/netcdf-cxx4.txt 2>&1
spack install opencoarrays    ${myCompiler} ${myOpenMPI}  | tee -a ${mySpackLogs}/opencoarrays.txt 2>&1
spack install parallel-netcdf ${myCompiler} ${myOpenMPI}  | tee -a ${mySpackLogs}/parallel-netcdf.txt 2>&1
spack install valgrind        ${myCompiler} ${myOpenMPI}  | tee -a ${mySpackLogs}/valgrind.txt 2>&1


spack install julia ${myCompiler} ${myLLVM}  | tee -a ${mySpackLogs}/julia.txt 2>&1

spack install octave +arpack +fftw +gnuplot +hdf5 +llvm +qhull +suitesparse +zlib ${myCompiler} ${myPython} ${myLLVM}  | tee -a ${mySpackLogs}/octave.txt
