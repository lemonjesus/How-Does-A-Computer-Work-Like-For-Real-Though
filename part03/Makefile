all: hello hellnokernel

hello: hello.o
	gcc hello.o -o hello

hellnokernel: hellnokernel.o
	gcc hellnokernel.o -o hellnokernel

hello.o: hello.asm
	nasm -f elf hello.asm

hellnokernel.o: hellnokernel.asm
	nasm -f elf hellnokernel.asm

clean:
	rm -f *.o hellnokernel hello
