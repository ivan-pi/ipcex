module command_mod
use, intrinsic :: iso_c_binding
implicit none
private

public :: c_string
public :: command

type :: c_string
   character(len=:), allocatable :: str
end type

interface c_string 
   module procedure :: new_c_string
end interface

type :: command
   type(c_ptr) :: ptr = c_null_ptr
contains
   procedure :: spawn
   procedure :: sendmsg
   procedure :: getrsp
   procedure :: send_eof
   procedure :: wait
   procedure :: destroy
   final :: close
end type

interface
   ! void * f_spawn(const char* argv[])
   function f_spawn(argv) bind(c,name="f_spawn")
      import c_ptr
      type(c_ptr), intent(in) :: argv(*)
      type(c_ptr) :: f_spawn
   end function

   ! void f_sendmsg(void *handle, CFI_cdesc_t *msg)
   subroutine f_sendmsg(handle, msg) bind(c,name="f_sendmsg")
      import c_ptr, c_char
      type(c_ptr), value :: handle
      character(len=*,kind=c_char), intent(in) :: msg
   end subroutine

   ! void f_getrsp(void *handle, CFI_cdesc_t *msg)
   subroutine f_getrsp(handle, msg) bind(c,name="f_getrsp")
      import c_ptr, c_char
      type(c_ptr), value :: handle
      character(len=:,kind=c_char), intent(out), allocatable :: msg
   end subroutine

   ! void f_send_eof(void *handle)
   subroutine f_send_eof(handle) bind(c,name="f_send_eof")
      import c_ptr
      type(c_ptr), value :: handle
   end subroutine

   ! int f_wait(void *handle)
   function f_wait(handle) bind(c,name="f_wait")
      import c_ptr, c_int
      type(c_ptr), value :: handle
      integer(c_int) :: f_wait
   end function

   ! void f_close(void *handle)
   subroutine f_close(handle) bind(c,name="f_close")
      import c_ptr
      type(c_ptr), value :: handle
   end subroutine

end interface


contains

   function new_c_string(str) result(string)
      character(len=*), intent(in) :: str
      character(len=:,kind=c_char), allocatable :: cstr
      type(c_string) :: string

      allocate(character(len_trim(str) + 1) :: cstr)
      
      cstr(1:) = str(1:len_trim(str))//c_null_char

      call move_alloc(from=cstr,to=string%str)

   end function


   subroutine spawn(cmd, cmdlist)
      class(command), intent(out) :: cmd
      type(c_string), intent(in), target :: cmdlist(:)

      type(c_ptr) :: ptr_list(size(cmdlist) + 1)
      integer :: i 

      do i = 1, size(cmdlist)
         ptr_list(i) = c_loc(cmdlist(i)%str)
      end do
      ptr_list(i) = c_null_ptr

      cmd%ptr = f_spawn(ptr_list)

   end subroutine

   subroutine sendmsg(cmd,msg)
      class(command), intent(inout) :: cmd
      character(len=*), intent(in) :: msg
      call f_sendmsg(cmd%ptr,trim(msg))
   end subroutine



   subroutine getrsp(cmd,msg)
      class(command), intent(inout) :: cmd
      character(len=:), intent(out), allocatable :: msg
      call f_getrsp(cmd%ptr,msg)
   end subroutine


   subroutine send_eof(cmd)
      class(command), intent(inout) :: cmd
      call f_send_eof(cmd%ptr)
   end subroutine

   integer function wait(cmd)
      class(command), intent(inout) :: cmd
      wait = f_wait(cmd%ptr)
   end function

   subroutine destroy(cmd)
      class(command), intent(inout) :: cmd

      call close(cmd)
   end subroutine



   subroutine close(cmd)
      type(command), intent(inout) :: cmd

      if (c_associated(cmd%ptr)) then
         call f_close(cmd%ptr)
         cmd%ptr = c_null_ptr
      end if

   end subroutine

end module