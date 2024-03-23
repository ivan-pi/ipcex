
#include <ISO_Fortran_binding.h>

#include <string>
#include <cstring>

#include "spawn.hpp"

extern "C" {

void * f_spawn(const char* argv[]) {
    return new spawn(argv);
}

void f_sendmsg(void *handle, CFI_cdesc_t *msg)
{
    auto cmd = static_cast<spawn *>(handle);
    std::string_view msg_{static_cast<char *>(msg->base_addr), (size_t ) msg->elem_len};

    cmd->stdin << msg_ << std::endl;

}

void f_getrsp(void *handle, CFI_cdesc_t *msg)
{

    auto cmd = static_cast<spawn *>(handle);

    std::string s;
    std::getline(cmd->stdout, s);

    CFI_allocate(msg,(CFI_index_t *)0, (CFI_index_t *)0, s.length());
    std::memcpy(msg->base_addr, s.data(), s.length());

}

void f_send_eof(void *handle)
{
    auto cmd = static_cast<spawn *>(handle);

    cmd->send_eof();
}

int f_wait(void *handle)
{
    auto cmd = static_cast<spawn *>(handle);
    return cmd->wait();
}

void f_close(void *handle)
{
    auto cmd = static_cast<spawn *>(handle);
    delete cmd;
}


} // extern "C"

