subroutine openscratch(iunit, myrank)
  implicit none
  character(len=*),parameter :: &
       tmpdir = "/work/scheinin/tmp"
  character(len=128) :: scratchfile
  integer :: iunit, myrank
  integer i
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
  ! write(*,"(a,a)") " scratchfile = ", scratchfile
  open(iunit, file=scratchfile, status='unknown')
  return
end subroutine openscratch
subroutine writescratch(iunit, jcycle, msgout)
  implicit none
  integer :: iunit, jcycle
  integer, dimension(10) :: msgout
  write(iunit,"(1x,i8,i10)") jcycle, msgout(1)
  return
end subroutine writescratch
subroutine closescratch(iunit)
  implicit none
  integer :: iunit
  close(iunit)
  return
end subroutine closescratch
