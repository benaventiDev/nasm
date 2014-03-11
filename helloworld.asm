section	.text
    global _start   ;must be declared for linker (ld)
_start:	            ;tells linker entry point

    mov ebx, 1
    mov eax, 4
    mov edx, len1
    int 0x80

    mov	edx,len     ;message length
    mov	ecx,msg     ;message to write
    mov	ebx,1       ;file descriptor (stdout)
    mov	eax,4       ;system call number (sys_write)
    int	0x80        ;call kernel

    mov	eax,1       ;system call number (sys_exit)
    int	0x80        ;call kernel

section	.data
msg db 'Hello, world fuck you !!!!!!!!!!!!', 0xa  ;our dear string
len equ $ - msg              ;length of our dear string
len1 equ $
