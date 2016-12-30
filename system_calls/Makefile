all:
	nasm -f elf main.asm
	ld -m elf_i386 -s -o demo *.o

clear:
	rm -v -rf *.o demo
