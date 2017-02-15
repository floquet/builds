program smalltest
  implicit none
  include "mpif.h"
  character(len=*),parameter :: &
       runparamsout = "/work/scheinin/tmp/runparams.out"
  integer :: ierror, myrank, numprocs
  integer :: iunit, exmode
  integer :: i, j, k, icycle, jcycle
  integer ::  num_cycles, cycle_size
  integer, dimension(10) :: msgin, msgout
  integer status(MPI_STATUS_SIZE)
  !  
  call MPI_Init(ierror)
  call MPI_Comm_Rank(MPI_COMM_WORLD, myrank, ierror)
  call MPI_Comm_Size (MPI_COMM_WORLD, numprocs, ierror)
  !
  !num_cycles = 16
  !cycle_size = 262144
  num_cycles = 4
  cycle_size = 65536
  !
  if(myrank .EQ. 0) then
     open(19, file=runparamsout, status='unknown')
     write(19,"(1x,i8,i10,i8)") num_cycles, cycle_size, numprocs
     write(19,*) " num_cycles  cycle_size  numprocs"
     close(19)
  endif
  !
  iunit = 20 + myrank
  call openscratch(iunit, myrank)
  do jcycle = 1, num_cycles
     do icycle = 1, cycle_size
        if((icycle .EQ. 1).AND.(myrank .EQ. 0)) then
           exmode = 1
           msgin(1) = 1
           call exchange(myrank, numprocs, msgin, msgout, exmode)
           call writescratch(iunit, jcycle, msgout)
        else
           if((icycle .EQ. cycle_size).AND.(myrank .EQ. (numprocs - 1))) then
              exmode = 2
              call exchange(myrank, numprocs, msgin, msgout, exmode)
              call writescratch(iunit, jcycle, msgout)
           else
              exmode = 3
              call exchange(myrank, numprocs, msgin, msgout, exmode)
              call writescratch(iunit, jcycle, msgout)
           endif
        endif
     enddo
  enddo
  !
  call closescratch(iunit)
  call MPI_Finalize(ierror)
  stop
end program smalltest

