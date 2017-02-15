#! /bin/bash

source /usr/share/modules/init/bash
module load compilers/intel11.1
module load mpi/sgi_mpi-1.26
module load compilers/mkl_10.1.0

cd /work/scheinin/scalapack/module_mkl/scalapack-1.8.0/TESTING

outdir=envtst01
for i in 0 1 2 3 4 5 6 7 ; do
   for j in 0 1 2 3 4 5 6 7 ; do
      for k in 1 4 16 ; do
	  for m in 1 4 16 ; do

      export MPI_BUFS_PER_HOST=96
      export MPI_BUFS_PER_PROC=32
      export MPI_BUFS_THRESHOLD=64
      export MPI_DEFAULT_SINGLE_COPY_BUFFER_MAX=2000
      export MPI_DEFAULT_SINGLE_COPY_OFF=0
      export MPI_IB_SINGLE_COPY_BUFFER_MAX=32767
      export MPI_IB_BUFFER_SIZE=131072

      if test $i == 1 ; then
         export MPI_BUFS_PER_HOST=$((256*$k))
      fi
      if test $i == 2 ; then
         export MPI_BUFS_PER_PROC=$((128*$k))
      fi
      if test $i == 3 ; then
         export MPI_BUFS_THRESHOLD=$((128*$k))
      fi
      if test $i == 4 ; then
         export MPI_DEFAULT_SINGLE_COPY_BUFFER_MAX=$((1000*$k))
      fi
      if test $i == 5 ; then
         export MPI_DEFAULT_SINGLE_COPY_OFF=1
      fi
      if test $i == 6 ; then
         export MPI_IB_SINGLE_COPY_BUFFER_MAX=65534
      fi
      if test $i == 7 ; then
         export MPI_IB_BUFFER_SIZE=$((65536/$k))
      fi

      if test $j == 1 ; then
         export MPI_BUFS_PER_HOST=$((256*$m))
      fi
      if test $j == 2 ; then
         export MPI_BUFS_PER_PROC=$((128*$m))
      fi
      if test $j == 3 ; then
         export MPI_BUFS_THRESHOLD=$((128*$m))
      fi
      if test $j == 4 ; then
         export MPI_DEFAULT_SINGLE_COPY_BUFFER_MAX=$((1000*$m))
      fi
      if test $j == 5 ; then
         export MPI_DEFAULT_SINGLE_COPY_OFF=1
      fi
      if test $j == 6 ; then
         export MPI_IB_SINGLE_COPY_BUFFER_MAX=65534
      fi
      if test $j == 7 ; then
         export MPI_IB_BUFFER_SIZE=$((65536/$m))
      fi

      outfile=${outdir}/envtst_${i}_${j}_${k}_${m}.log
      env | grep MPI_ > $outfile
      mpiexec_mpt -np 64 ./xdpblas3tim  2>&1 | tee -a $outfile
      sleep 3

   done
   done
   done
done

outdir=envtst02
for i in 7 6 5 4 3 2 1 0 ; do
   for j in 0 1 2 3 4 5 6 7 ; do
      for k in 1 4 16 ; do
	  for m in 16 4 1 ; do

      export MPI_BUFS_PER_HOST=96
      export MPI_BUFS_PER_PROC=32
      export MPI_BUFS_THRESHOLD=64
      export MPI_DEFAULT_SINGLE_COPY_BUFFER_MAX=2000
      export MPI_DEFAULT_SINGLE_COPY_OFF=0
      export MPI_IB_SINGLE_COPY_BUFFER_MAX=32767
      export MPI_IB_BUFFER_SIZE=131072

      if test $i == 1 ; then
         export MPI_BUFS_PER_HOST=$((256*$k))
      fi
      if test $i == 2 ; then
         export MPI_BUFS_PER_PROC=$((128*$k))
      fi
      if test $i == 3 ; then
         export MPI_BUFS_THRESHOLD=$((128*$k))
      fi
      if test $i == 4 ; then
         export MPI_DEFAULT_SINGLE_COPY_BUFFER_MAX=$((1000*$k))
      fi
      if test $i == 5 ; then
         export MPI_DEFAULT_SINGLE_COPY_OFF=1
      fi
      if test $i == 6 ; then
         export MPI_IB_SINGLE_COPY_BUFFER_MAX=65534
      fi
      if test $i == 7 ; then
         export MPI_IB_BUFFER_SIZE=$((65536/$k))
      fi

      if test $j == 1 ; then
         export MPI_BUFS_PER_HOST=$((256*$m))
      fi
      if test $j == 2 ; then
         export MPI_BUFS_PER_PROC=$((128*$m))
      fi
      if test $j == 3 ; then
         export MPI_BUFS_THRESHOLD=$((128*$m))
      fi
      if test $j == 4 ; then
         export MPI_DEFAULT_SINGLE_COPY_BUFFER_MAX=$((1000*$m))
      fi
      if test $j == 5 ; then
         export MPI_DEFAULT_SINGLE_COPY_OFF=1
      fi
      if test $j == 6 ; then
         export MPI_IB_SINGLE_COPY_BUFFER_MAX=65534
      fi
      if test $j == 7 ; then
         export MPI_IB_BUFFER_SIZE=$((65536/$m))
      fi

      outfile=${outdir}/envtst_${i}_${j}_${k}_${m}.log
      env | grep MPI_ > $outfile
      mpiexec_mpt -np 64 ./xdpblas3tim  2>&1 | tee -a $outfile
      sleep 3

   done
   done
   done
done

outdir=envtst03
for i in 0 1 2 3 4 5 6 7 ; do
   for j in 7 6 5 4 3 2 1 0 ; do
      for k in 1 4 16 ; do
	  for m in 1 4 16 ; do

      export MPI_BUFS_PER_HOST=96
      export MPI_BUFS_PER_PROC=32
      export MPI_BUFS_THRESHOLD=64
      export MPI_DEFAULT_SINGLE_COPY_BUFFER_MAX=2000
      export MPI_DEFAULT_SINGLE_COPY_OFF=0
      export MPI_IB_SINGLE_COPY_BUFFER_MAX=32767
      export MPI_IB_BUFFER_SIZE=131072

      if test $i == 1 ; then
         export MPI_BUFS_PER_HOST=$((256*$k))
      fi
      if test $i == 2 ; then
         export MPI_BUFS_PER_PROC=$((128*$k))
      fi
      if test $i == 3 ; then
         export MPI_BUFS_THRESHOLD=$((128*$k))
      fi
      if test $i == 4 ; then
         export MPI_DEFAULT_SINGLE_COPY_BUFFER_MAX=$((1000*$k))
      fi
      if test $i == 5 ; then
         export MPI_DEFAULT_SINGLE_COPY_OFF=1
      fi
      if test $i == 6 ; then
         export MPI_IB_SINGLE_COPY_BUFFER_MAX=65534
      fi
      if test $i == 7 ; then
         export MPI_IB_BUFFER_SIZE=$((65536/$k))
      fi

      if test $j == 1 ; then
         export MPI_BUFS_PER_HOST=$((256*$m))
      fi
      if test $j == 2 ; then
         export MPI_BUFS_PER_PROC=$((128*$m))
      fi
      if test $j == 3 ; then
         export MPI_BUFS_THRESHOLD=$((128*$m))
      fi
      if test $j == 4 ; then
         export MPI_DEFAULT_SINGLE_COPY_BUFFER_MAX=$((1000*$m))
      fi
      if test $j == 5 ; then
         export MPI_DEFAULT_SINGLE_COPY_OFF=1
      fi
      if test $j == 6 ; then
         export MPI_IB_SINGLE_COPY_BUFFER_MAX=65534
      fi
      if test $j == 7 ; then
         export MPI_IB_BUFFER_SIZE=$((65536/$m))
      fi

      outfile=${outdir}/envtst_${i}_${j}_${k}_${m}.log
      env | grep MPI_ > $outfile
      mpiexec_mpt -np 64 ./xdpblas3tim  2>&1 | tee -a $outfile
      sleep 3

   done
   done
   done
done

outdir=envtst04
for i in 7 6 5 4 3 2 1 0 ; do
   for j in 7 6 5 4 3 2 1 0 ; do
      for k in 1 4 16 ; do
	  for m in 16 4 1 ; do

      export MPI_BUFS_PER_HOST=96
      export MPI_BUFS_PER_PROC=32
      export MPI_BUFS_THRESHOLD=64
      export MPI_DEFAULT_SINGLE_COPY_BUFFER_MAX=2000
      export MPI_DEFAULT_SINGLE_COPY_OFF=0
      export MPI_IB_SINGLE_COPY_BUFFER_MAX=32767
      export MPI_IB_BUFFER_SIZE=131072

      if test $i == 1 ; then
         export MPI_BUFS_PER_HOST=$((256*$k))
      fi
      if test $i == 2 ; then
         export MPI_BUFS_PER_PROC=$((128*$k))
      fi
      if test $i == 3 ; then
         export MPI_BUFS_THRESHOLD=$((128*$k))
      fi
      if test $i == 4 ; then
         export MPI_DEFAULT_SINGLE_COPY_BUFFER_MAX=$((1000*$k))
      fi
      if test $i == 5 ; then
         export MPI_DEFAULT_SINGLE_COPY_OFF=1
      fi
      if test $i == 6 ; then
         export MPI_IB_SINGLE_COPY_BUFFER_MAX=65534
      fi
      if test $i == 7 ; then
         export MPI_IB_BUFFER_SIZE=$((65536/$k))
      fi

      if test $j == 1 ; then
         export MPI_BUFS_PER_HOST=$((256*$m))
      fi
      if test $j == 2 ; then
         export MPI_BUFS_PER_PROC=$((128*$m))
      fi
      if test $j == 3 ; then
         export MPI_BUFS_THRESHOLD=$((128*$m))
      fi
      if test $j == 4 ; then
         export MPI_DEFAULT_SINGLE_COPY_BUFFER_MAX=$((1000*$m))
      fi
      if test $j == 5 ; then
         export MPI_DEFAULT_SINGLE_COPY_OFF=1
      fi
      if test $j == 6 ; then
         export MPI_IB_SINGLE_COPY_BUFFER_MAX=65534
      fi
      if test $j == 7 ; then
         export MPI_IB_BUFFER_SIZE=$((65536/$m))
      fi

      outfile=${outdir}/envtst_${i}_${j}_${k}_${m}.log
      env | grep MPI_ > $outfile
      mpiexec_mpt -np 64 ./xdpblas3tim  2>&1 | tee -a $outfile
      sleep 3

   done
   done
   done
done

exit 0;
