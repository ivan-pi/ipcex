program b

   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit
   implicit none
   
   character(len=10) :: request

   character(len=*), parameter :: greet = "Hello from b"
   real :: a(5)


   do

      read(input_unit,'(A10)') request

      select case(request)
      case('GREET')
         write(output_unit,'(I0,",",I0)') 1, len(greet)
         writE(output_unit,'(A)') greet
      case('RAND ')
         call random_number(a)
         write(output_unit,'(I0,", ", I0)') 2, size(a)
         write(output_unit,'(*(G0,:,",",1X))') a
      case('EXIT ')
         write(output_unit,*) -1, -1
         print *, "Program b is exiting"
         exit
      end select
   end do

end program