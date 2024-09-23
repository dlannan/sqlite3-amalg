
#include <errno.h>
#include <stdint.h>
#include <sys/mman.h>
#include <unistd.h>

// #ifdef __ANDROID__
// extern void*  __mmap2(void *, size_t, int, int, int, off_t);
// void *mmap64(void *addr, size_t length, int prot, int flags, int fd, off64_t offset)
// {
//     return __mmap2(addr, length, prot, flags, fd, offset >> 12);
// }
// #endif
