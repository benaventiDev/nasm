all:
	nasm -f elf arithmetic01.asm
	ld -m elf_i386 -s -o arithmetic01 arithmetic01.o
	nasm -f elf arithmetic_hardcode.asm
	ld -m elf_i386 -s -o arithmetic_hardcode arithmetic_hardcode.o
	nasm -f elf arithmetic_mul.asm
	ld -m elf_i386 -s -o arithmetic_mul arithmetic_mul.o

clean:
	rm -rf *.o
	rm -rf arithmetic01 arithmetic_mul arithmetic_hardcode
