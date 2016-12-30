all:
	nasm -f elf main.asm
	ld -m elf_i386 -s -o demo *.o

clean:
	rm -v -rf *.o demo
