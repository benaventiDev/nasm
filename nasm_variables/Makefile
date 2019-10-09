all:
	nasm -f elf variable01.asm
	ld -m elf_i386 -s -o variable01 variable01.o
	nasm -f elf variable02.asm
	ld -m elf_i386 -s -o variable02 variable02.o

clean:
	rm -rf *.o
	rm -rf variable01 variable02
