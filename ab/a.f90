program a

   use iso_fortran_env, only: output_unit, input_unit
   implicit none

   character(len=10) :: requests(3) = ['GREET','RAND ','EXIT ']
   integer :: i 

   integer :: type, n
   character(len=:), allocatable :: greeting
   real, allocatable :: array(:)


   i = 1
   do

      write(output_unit,'(A)') requests(i)
      read(input_unit, *) type, n 

      select case(type)
      case(1)
         allocate(character(n+10) :: greeting)
         read(input_unit, * ) greeting
         print *, "Received greeting: "//trim(greeting)
      case(2)
         allocate(array(n))
         read(input_unit, *) array
         print *, "Received array: ", array 
      case(-1)
         print *, "Program b has exited and so will program a"
         exit
         ! Do nothing
      end select

      i = i + 1

      if (allocated(greeting)) deallocate(greeting)
      if (allocated(array)) deallocate(array)

   end do

end program