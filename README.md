# ipcex

Some experiments with IPC

## ab 

Launching two processes connected by pipes

```
~/ipcex/ab$ make
~/ipcex/ab$ ./launch.sh
```

## spawn

A wrapper of the C++ example by Konstantin Tretyakov
https://gist.github.com/konstantint/d49ab683b978b3d74172

A compiler supporting the Fortran 2018 `ISO_Fortran_binding.h` is needed.


```
~/ipcex/spawn$ make
~/ipcex/spawn$ ./test_spawn
```

