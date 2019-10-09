all:
	nasm -f elf register.asm 
	sleep 1
	ld -m elf_i386 -s -o demo *.o

clean:
	rm -rfv *.o demo
