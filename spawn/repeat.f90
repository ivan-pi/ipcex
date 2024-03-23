program repeat_server

use, intrinsic :: iso_fortran_env
implicit none

character(len=256) :: str
integer :: stat

do
   read(input_unit,'(A256)',iostat=stat) str
   if (is_iostat_end(stat)) exit
   write(output_unit,'(A)') repeat(trim(str),2)
end do

end program