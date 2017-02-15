subroutine exchange(myrank, numprocs, msgin, msgout, exmode)
  implicit none
  include "mpif.h"
  integer :: ierror, myrank, numprocs, exmode
  integer, dimension(10) :: msgin, msgout
  !
  integer :: prev_node, next_node
  integer :: tag
  integer status(MPI_STATUS_SIZE)
  !    
  tag = 1
  next_node = myrank + 1
  if(next_node .GE. numprocs) then
     next_node = 0
  endif
  prev_node = myrank - 1
  if(prev_node .LT. 0) then
     prev_node = numprocs - 1
  endif
  if(exmode .EQ. 1) then
     msgout(1) = msgin(1)
     call MPI_Send(msgout, 1, MPI_INTEGER, next_node, tag, &
          MPI_COMM_WORLD, ierror)
  else
     if(exmode .EQ. 2) then
        call MPI_Recv(msgin, 1, MPI_INTEGER, prev_node, tag, &
             MPI_COMM_WORLD, status, ierror)
        msgout(1) = msgin(1) + 1
     else
        call MPI_Recv(msgin, 1, MPI_INTEGER, prev_node, tag, &
             MPI_COMM_WORLD, status, ierror)
        msgout(1) = msgin(1) + 1
        call MPI_Send(msgout, 1, MPI_INTEGER, next_node, tag, &
             MPI_COMM_WORLD, ierror)
     endif
  endif
  return
end subroutine exchange
