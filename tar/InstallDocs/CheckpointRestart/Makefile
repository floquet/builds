
all: small.exe

#smalltest.o: smalltest.F90
#	ftn -c smalltest.F90

#smalltest.exe: smalltest.o
#	ftn -o smalltest.exe smalltest.o

small_main.o: small_main.F90
	ifort -c small_main.F90

small_mpi.o: small_mpi.F90
	ifort -c small_mpi.F90

small_io.o: small_io.F90
	ifort -c small_io.F90

small.exe: small_main.o small_mpi.o small_io.o
	ifort -o small.exe small_main.o small_mpi.o small_io.o -lmpi


clean:
	/bin/rm -f *.o *.exe
