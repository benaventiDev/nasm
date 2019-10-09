all:
	nasm -f elf logical01.asm
	ld -m elf_i386 -s -o logical01 logical01.o
	nasm -f elf logical02.asm
	ld -m elf_i386 -s -o logical02 logical02.o

clean:
	rm -v -rf *.o
	rm -v -rf logical01 logical02
