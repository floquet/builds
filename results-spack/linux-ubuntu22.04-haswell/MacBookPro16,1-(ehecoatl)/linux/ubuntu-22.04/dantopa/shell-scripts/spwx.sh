#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

spack install doxygen ^python@3.10.2
spack install petsc +fftw +mpfr +mumps +scalapack +strumpack +suitesparse +superlu-dist ^python@3.10.2 ^openmpi@4.1.2
spack install llvm ^python@3.10.2
spack install valgrind ^python@3.10.2
spack install scalapack ^openmpi@4.1.2
spack install eigen
spack install xerces-c
spack install zoltan ^openmpi@4.1.2
spack install py-tqdm ^python@3.10.2
spack install py-urllib3 ^python@3.10.2
spack install beautifulsoup4 ^python@3.10.2
spack install gdb ^python@3.10.2
spack install py-h5py  ^python@3.10.2 ^openmpi@4.1.2

spack install parallel-netcdf ^openmpi@4.1.2
spack install netcdf-fortran ^openmpi@4.1.2
spack install netcdf-cxx4 ^openmpi@4.1.2

