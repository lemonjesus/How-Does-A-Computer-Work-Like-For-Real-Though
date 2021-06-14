# Part Four: No More Kernels
Requires `nasm` and, to run, `qemu-system-i386`. The produced image should work in any VM, however. If you're feeing really saucy, you can write it to disk and boot it on a real computer! But why?

To build the hellOS, run
```
make
```
It'll produce `hellos.img` which will boot. You can do it in `qemu-system-i386` with
```
make test
```
