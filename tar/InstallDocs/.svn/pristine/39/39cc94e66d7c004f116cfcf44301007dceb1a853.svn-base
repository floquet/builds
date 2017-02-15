      program smalltest
      include "mpif.h"
      character(len=*),parameter :: &
           tmpdir = "/work/scheinin/tmp"
      integer :: ierror, myrank, numprocs
      character(len=128) :: scratchfile
      integer :: iunit
      integer :: i, j, k, icycle, jcycle
      integer ::  num_cycles, cycle_size
      integer :: prev_node, next_node
      integer, dimension(10) :: msgin, msgout
      integer :: tag
      integer status(MPI_STATUS_SIZE)
      
      call MPI_Init(ierror)
      call MPI_Comm_Rank(MPI_COMM_WORLD, myrank, ierror)
      call MPI_Comm_Size (MPI_COMM_WORLD, numprocs, ierror)
      iunit = 20 + myrank
      scratchfile = " "
      do i = 1, 128
         scratchfile(i:i) = " "
      enddo
      if(myrank<10) then
         write(scratchfile,"(a,'/fort000',i1)") tmpdir,myrank
      else
         if(myrank<100) then
            write(scratchfile,"(a,'/fort00',i2)") tmpdir,myrank
         else
            if(myrank<1000) then
               write(scratchfile,"(a,'/fort0',i3)") tmpdir,myrank
            else
               write(scratchfile,"(a,'/fort',i4)") tmpdir,myrank
            endif
         endif
      endif
      num_cycles = 16
      cycle_size = 262144
      tag = 1
      write(*,"(a,a)") " scratchfile = ", scratchfile
      open(iunit, file=scratchfile, status='unknown')
      next_node = myrank + 1
      if(next_node .GE. numprocs) then
         next_node = 0
      endif
      prev_node = myrank - 1
      if(prev_node .LT. 0) then
         prev_node = numprocs - 1
      endif
      do jcycle = 1, num_cycles
         do icycle = 1, cycle_size
            if((icycle .EQ. 1).AND.(myrank .EQ. 0)) then
               msgout(1) = 1
               write(iunit,"(1x,i8,i10)") jcycle, msgout(1)
               call MPI_Send(msgout, 1, MPI_INTEGER, next_node, tag, &
                    MPI_COMM_WORLD, ierror)
            else
               if((icycle .EQ. cycle_size).AND.(myrank .EQ. (numprocs - 1))) then
                  call MPI_Recv(msgin, 1, MPI_INTEGER, prev_node, tag, &
                       MPI_COMM_WORLD, status, ierror)
                  msgout(1) = msgin(1) + 1
                  write(iunit,"(1x,i8,i10)") jcycle, msgout(1)
               else
                  call MPI_Recv(msgin, 1, MPI_INTEGER, prev_node, tag, &
                       MPI_COMM_WORLD, status, ierror)
                  msgout(1) = msgin(1) + 1
                  write(iunit,"(1x,i8,i10)") jcycle, msgout(1)
                  call MPI_Send(msgout, 1, MPI_INTEGER, next_node, tag, &
                       MPI_COMM_WORLD, ierror)
               endif
            endif
         enddo
      enddo
      close(iunit)
      call MPI_Finalize(ierror)

      stop
      end program

!      cycle_size = 4
!      num_cycles = 2
! fort0000 has 8 1's and other file has nothing
! generic output is 7 of rank 0 and one each of other rank.
