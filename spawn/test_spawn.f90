! 
! Example of communication with a subprocess via stdin/stdout
!
!     Adapted from the C++ program by Konstantin Tretyakov under MIT License
!
program test_spawn

   use command_mod
   implicit none

   type(command) :: cat
   type(c_string) :: argv(1)

   character(len=:), allocatable :: s

   argv(1) = c_string("./repeat")


   call cat%spawn(argv)


   print *, "Sent: 'Hello'"
   call cat%sendmsg('Hello')
   call cat%getrsp(s)
   print *, "Received: '", s, "'"

   print *, "Sent: 'World'"
   call cat%sendmsg('World')
   call cat%getrsp(s)
   print *, "Received: '", s, "'"


   call cat%send_eof()
   print *, "Waiting to terminate..."
   print *, "Status: ", cat%wait()


end program