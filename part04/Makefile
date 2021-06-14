all: hellos.img

test: hellos.img
	qemu-system-i386 -fda hellos.img

hellos.img:
	nasm -f bin hellos.asm -o hellos.img

clean:
	rm -f hellos.img
