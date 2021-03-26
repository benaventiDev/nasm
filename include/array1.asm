%include "macros.asm"


section .data

	lex_state db 0, '$'
	lex_counter dw  0, '$'
	file_index dw  0, '$'
	parser_token db 99, '$'
	blankChar db 0, '$'
	decimalHelper db '99', 10, 13, '$'
	parserCaller db 0, '$'
	funtionIndexStack dw 0, '$'
	testChar dw 99, '$'
	tokenReady db 0, '$'
	register_id db 0, '$'
	current_Index_id dw 0, '$'
	current_id db 25 dup('$'), '$'
	newLine db 10, 13, '$'
	negativeSign db 32, '$'

	
	archivo dw 'cadena.arq', 00h, '$'

	msgError1 db 10, 13, 'Error : No se pudo abrir el archivo. $'
	msgError2 db 10, 13, 'Error : No se pudo leer el archivo. $'
	msg1 db 10,13 'Cargar Archivo.$'
	msg2 db 10,13 'Modo Calculadora.$'
	msg3 db 10,13 'Factorial.$'
	msg4 db 10,13 'Crear Reporte.$'
	msg5 db 10,13 'Salir.$'
	msg6 db 10,13 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA.$'
	msg7 db 10,13 'FACULTAD DE INGENIERIA$'
	msg8 db 10,13 'ESCUELA DE CIENCIAS Y SISTEMAS$'
	msg9 db 10,13 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 A$'
	msg10 db 10,13 'SECCION B$'
	msg11 db 10,13 'PRIMER SEMESTRE 2021$'
	msg13 db 10,13 'Benaventi Bernal Fuentes Roldan$'
	msg14 db 10,13 '201021212$'
	msg15 db 10,13 'Primera Practica Assembler$'


	lexError db 10, 13, 'Error Lexico. $'
	sintaxError db 10, 13, 'Error Sintactico. $'

	fragmento times 7000 db '$'
	reporteHTML times 1500 db '$'
	limpiar db 11 dup('$'), '$'
	funtionStack db 500 dup('$'), '$'
	reporteFile dw 'rep.html', 00h, '$'	

	
org 100h
section .text	
	abrir:







		 	 ; set ups the counter to 0

		;print msg3
		; abriendo un archivo
		mov ah, 3dh
		mov al, 0			; indicando que lo estoy abriendo en modo lectura/escritura
		;el handle se meuve a bx para leer. El handle es la posicion en donde me encuentro
		; del archivo
		mov dx, reporteFile		;especifico la ruta del archivo
		int 21h
		jc error1
		mov bx,ax			; handle del archivo lo copio a bx
		;jmp fin	
	leer:
		mov ah,3fh			;funcion para leer archivo
		mov dx, fragmento	; indico la var\iable en donde guardare lo leido
		mov cx,7000			; numero de bytes a leer
		int 21h
		jc error2
		mov ah,3eh	
		int 21h
		;jmp processFile
		
;0-9
R_:
mov si, lex_counter[0]
mov cx, 1500
mov bl, '$'
_for_cls_html:
mov reporteHTML[si], bl
inc si
dec cx
jnz _for_cls_html
mov si, 0


mov bl, 0
mov parserCaller[0], bl
jmp getNextToken  ; obtiene <operations>
parser_R_0: 

 ;##### pimer id on
mov bl, 1
mov register_id[0], bl

mov bl, 1
mov parserCaller[0], bl
jmp getNextToken  ; obtiene <open id>

parser_R_1: 
	;###### primer id off

	mov bx, 0
	mov current_Index_id[0], bx
	xor bx, bx
	mov bl, 0
	mov register_id[0], bl
	mov bl, '$'
	mov current_id[0], bl
	mov current_id[1], bl
	mov current_id[2], bl
	mov current_id[3], bl
	mov current_id[4], bl
	mov current_id[5], bl
	mov current_id[6], bl
	mov current_id[7], bl
	mov current_id[8], bl
	mov current_id[9], bl
	mov current_id[10], bl
	mov current_id[11], bl
	mov current_id[12], bl
	mov current_id[13], bl
	mov current_id[14], bl
	mov current_id[15], bl
	mov current_id[16], bl
	mov current_id[17], bl
	mov current_id[18], bl
	mov current_id[19], bl
	mov current_id[20], bl


	mov bl, parser_token[0]
	cmp bl, 12 			;si el token es 0 continua si TODO mandar a error:
	jz OPERATIONS_


parser_R_2: 
	;jmp print_current_token
	print_c 99
	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor dx,dx 
	mov ah, 3dh
	mov al, 1
	mov dx, reporteFile		;especifico la ruta del archivo
	int 21h
	jc error1
	mov bx, ax
	mov dx, msg15
	mov ah, 40h
	int 21h

jmp fin



OPERATIONS_:

mov bl, parser_token[0] ;<open id> o </operations>
cmp bl, 12         
jz isID ; si es id go ahead to operation then call itself si no regresar
jmp parser_R_2

isID:
; TODOdeberia de buscar el nombre del primer id
jmp OPERATION_
parser_OPERATIONS_0: ;3
jmp OPERATIONS_

;deberia de buscar el nombre del primer id y buscar el siguiente token para
;ver que tipo de operation es + - * /	




; 10 - 19
OPERATION_:
;TODO es un buen lugar para comenzar la pila
;en algun punto debe regresar a operations
mov bl, 10
mov parserCaller[0], bl
jmp getNextToken 		;aqui se obtine <tipo operacion + - * / >
parser_OPERATION_0: 	; TODO label

jmp OPERATION_1_
parser_OPERATION_1: ; 5

; TODO revisar token 13 de cierre

;aqui se obtiene el id  ########### ON
mov bl, 1
mov register_id[0], bl

mov bl, 12
mov parserCaller[0], bl
jmp getNextToken
parser_OPERATION_2: ; 5
	
	mov bl, 32
	mov negativeSign[0], bl
	pop ax
	mov bl, al
	mov ch, ah ; solo es para saber si es negativo
	convertNumber_ bl
	cmp ch, 1
	jz PRINT_NEG
	PRINT_NUM:

	mov di, 0
	mov cx, 0
	mov di, file_index[0]
	
	mov dl, 60
	mov reporteHTML[di], dl	
	inc di
	mov dl, 72
	mov reporteHTML[di], dl
	inc di
	mov dl, 49
	mov reporteHTML[di], dl
	inc di
	mov dl, 62
	mov reporteHTML[di], dl
	inc di

	
	WRITE_NAME:
	mov dl, current_id[0]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[1]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[2]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[3]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[4]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[5]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[6]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[7]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[8]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[9]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[10]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[11]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[12]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[13]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[14]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[15]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[16]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[17]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	mov dl, current_id[18]	
	cmp dl, $
	je FIRST_TAG
	mov reporteHTML[di], dl
	inc di

	

	FIRST_TAG:
	mov dl, 59
	mov reporteHTML[di], dl
	inc di
	mov dl, 32
	mov reporteHTML[di], dl
	inc di
	mov reporteHTML[di], bh		
	inc di
	mov reporteHTML[di], bl
	inc di

	mov dl, 60
	mov reporteHTML[di], dl	
	inc di
	mov dl, 47
	mov reporteHTML[di], dl
	inc di
	mov dl, 72
	mov reporteHTML[di], dl
	inc di
	mov dl, 49
	mov reporteHTML[di], dl
	inc di
	mov dl, 62
	mov reporteHTML[di], dl
	inc di
	mov dl, 10
	mov reporteHTML[di], dl
	inc di
	




	
;aqui se obtiene el id  ########### OFF

mov bx, 0
mov current_Index_id[0], bx
xor bx, bx
mov bl, 0
mov register_id[0], bl
mov bl, '$'
mov current_id[0], bl
mov current_id[1], bl
mov current_id[2], bl
mov current_id[3], bl
mov current_id[4], bl
mov current_id[5], bl
mov current_id[6], bl
mov current_id[7], bl
mov current_id[8], bl
mov current_id[9], bl
mov current_id[10], bl
mov current_id[11], bl
mov current_id[12], bl
mov current_id[13], bl
mov current_id[14], bl
mov current_id[15], bl
mov current_id[16], bl
mov current_id[17], bl
mov current_id[18], bl
mov current_id[19], bl
mov current_id[20], bl


jmp parser_OPERATIONS_0

PRINT_NEG:
	mov ch, 45
	mov negativeSign[0], ch
	jmp PRINT_NUM


;20-29
OPERATION_1_:
mov bl, parser_token[0]
cmp bl, 2
jz parser_OPERATION_1_0
cmp bl, 4
jz parser_OPERATION_1_1
cmp bl, 6
jz parser_OPERATION_1_2
cmp bl, 8
jz parser_OPERATION_1_3



parser_OPERATION_1_0:
	mov cl, 25
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl
	jmp SUM_
	

parser_OPERATION_1_1:
	mov cl, 25
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl
	jmp RES_

parser_OPERATION_1_2:
	mov cl, 25
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl
	jmp DIV_

parser_OPERATION_1_3:
	mov cl, 25		
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl
	jmp MUL_

parser_OPERATION_1_5:
jmp parser_OPERATION_1



;30-39
SUM_:

	mov bl, 30
	mov parserCaller[0], bl
	jmp getNextToken ;devuelve la etiqueta <valor>
	parser_SUM_0:


	mov cl, 31
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl




	jmp VAL_
	parser_SUM_1:

	mov cl, 32
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl

	jmp VAL_
	parser_SUM_2:

	mov bl, 33
	mov parserCaller[0], bl
	jmp getNextToken ;devuelve la etiqueta </id> o cierre de op padre
	parser_SUM_3:
	;########## OPERACION ARITMETICA
	pop ax
	mov bl, al
	mov dl, ah
	pop ax
	mov bh, al
	mov dh, ah




	cmp dl, 1
	jz SUM_NEG
	SUM_POS:
	cmp dh, 1
	jz SUM_POS_NEG
	jmp SUM_POS_POS

	SUM_NEG:

	cmp dh, 1
	jz SUM_NEG_NEG
	jmp SUM_NEG_POS


	SUM_POS_NEG:
	cmp bl, bh
	je SUM_ZERO
	jg SUM_A
	jmp SUM_B
	

	SUM_POS_POS:
	xor ax, ax
	add bl, bh
	mov al, bl
	mov ah, 0
	push ax
	jmp returnFunction


	SUM_NEG_NEG:
	xor ax, ax
	add bl, bh
	mov al, bl
	mov ah, 1
	push ax
	jmp returnFunction

	SUM_NEG_POS:
	cmp bl, bh
	je SUM_ZERO
	jg SUM_C
	jmp SUM_D



	SUM_ZERO:
		xor ax, ax	
		mov ah, 0
		mov al, 0
		push ax
		jmp returnFunction
	SUM_A: ; positive is greater

		xor ax, ax
		sub bl, bh
		mov al, bl
		mov ah, 0
		push ax
		jmp returnFunction

	SUM_B:

		xor ax, ax
		sub bh, bl
		mov al, bh
		mov ah, 1
		push ax
		jmp returnFunction


	SUM_C: ; positive is greater

		xor ax, ax
		sub bl, bh
		mov al, bl
		mov ah, 1
		push ax
		jmp returnFunction

	SUM_D:

		xor ax, ax
		sub bh, bl
		mov al, bh
		mov ah, 0
		push ax
		jmp returnFunction






;40-49
RES_:
	mov bl, 40
	mov parserCaller[0], bl
	jmp getNextToken ;devuelve la etiqueta <valor>
	parser_RES_0:


	mov cl, 41
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl




	jmp VAL_
	parser_RES_1:

	mov cl, 42
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl

	jmp VAL_
	parser_RES_2:

	mov bl, 43
	mov parserCaller[0], bl
	jmp getNextToken ;devuelve la etiqueta </id> o cierre de op padre
	parser_RES_3:
	;########## OPERACION ARITMETICA
	pop ax
	mov bl, al
	mov dl, ah
	pop ax
	mov bh, al
	mov dh, ah

	cmp dh, 1
	jz RES_NEG
	RES_POS:
	cmp dl, 1
	jz RES_POS_NEG
	jmp RES_POS_POS


	RES_NEG:
	cmp dl, 1
	jz RES_NEG_NEG 
	jmp RES_NEG_POS


	RES_NEG_POS:
	xor ax, ax
	add bl, bh
	mov al, bl
	mov ah, 1
	push ax
	jmp returnFunction

	RES_POS_NEG:
	xor ax, ax
	add bl, bh
	mov al, bl
	mov ah, 0
	push ax
	jmp returnFunction	
	
	RES_NEG_NEG:
	xor ax, ax
	cmp bh, bl
	jz RES_ZERO
	jg RES_A
	jmp RES_B

	
	RES_POS_POS:
	xor ax, ax
	cmp bh, bl
	jz RES_ZERO
	jg RES_C
	jmp RES_D



	RES_ZERO:
		mov ah, 0
		mov al, 0
		push ax
		jmp returnFunction
	
	RES_A:
		sub bh, bl
		mov al, bh
		mov ah, 1
		push ax
		jmp returnFunction
	
	RES_B:
		sub bl, bh
		mov al, bl
		mov ah, 0
		push ax
		jmp returnFunction
	
	RES_C:
		sub bh, bl
		mov al, bh
		mov ah, 0
		push ax
		jmp returnFunction
	RES_D:
		sub bl, bh
		mov al, bl
		mov ah, 1
		push ax
		jmp returnFunction

;50-59
DIV_:
	mov bl, 50
	mov parserCaller[0], bl
	jmp getNextToken ;devuelve la etiqueta <valor>
	parser_DIV_0:


	mov cl, 51
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl




	jmp VAL_
	parser_DIV_1:

	mov cl, 52
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl

	jmp VAL_
	parser_DIV_2:

	mov bl, 53
	mov parserCaller[0], bl
	jmp getNextToken ;devuelve la etiqueta </id> o cierre de op padre
	parser_DIV_3:
	;########## OPERACION ARITMETICA
	pop ax
	mov bl, al
	mov dl, ah
	pop ax
	mov bh, al
	mov dh, ah
	xor ax, ax
	mov al, bh
	div bl

	cmp dh, dl
	je DIV_POS
	DIV_NEG:
	mov	ah, 1
	push ax
	jmp returnFunction
	
	DIV_POS:
	mov	ah, 0
	push ax
	jmp returnFunction




;60-69
MUL_:
	mov bl, 60
	mov parserCaller[0], bl
	jmp getNextToken ;devuelve la etiqueta <valor>
	parser_MUL_0:


	mov cl, 61
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl




	jmp VAL_
	parser_MUL_1:

	mov cl, 62
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl

	jmp VAL_
	parser_MUL_2:

	mov bl, 63
	mov parserCaller[0], bl
	jmp getNextToken ;devuelve la etiqueta </id> o cierre de op padre
	parser_MUL_3:
	;########## OPERACION ARITMETICA
	pop ax
	mov bl, al
	mov dl, ah
	pop ax
	mov bh, al
	mov dh, ah
	xor ax, ax
	mov al, bl
	mul bh

	cmp dh, dl
	je MUL_POS
	MUL_NEG:
	mov	ah, 1
	push ax
	jmp returnFunction
	
	MUL_POS:
	mov	ah, 0
	push ax
	jmp returnFunction


;70-79
VAL_:
mov bl, 70
mov parserCaller[0], bl
jmp getNextToken ;devuelve la etiqueta <open op> o numero
parser_VAL_0:

; todo eleminar 14
jmp VAL_1
parser_VAL_1:

mov bl, 72
mov parserCaller[0], bl
jmp getNextToken ;devuelve la etiqueta </close op> o <valor>
parser_VAL_2:
jmp returnFunction




;80-89
VAL_1:; debe devolver la etiqueta cerrada de valor
mov bl, parser_token[0]
cmp bl, 14
jz parser_VAL_1_10
cmp bl, 15
jz parser_VAL_1_11
cmp bl, 2
jz parser_VAL_1_12
cmp bl, 4
jz parser_VAL_1_13
cmp bl, 6
jz parser_VAL_1_14
cmp bl, 8
jz parser_VAL_1_15


parser_VAL_1_10:
;;AQUI
push dx
mov bl, 80
mov parserCaller[0], bl
jmp getNextToken ;devuelve la etiqueta <open op> o numero
parser_VAL_1_0:

jmp parser_VAL_1

parser_VAL_1_11:
;;AQUI
push dx
mov bl, 81
mov parserCaller[0], bl
jmp getNextToken ;devuelve la etiqueta <open op> o numero
parser_VAL_1_1:
jmp parser_VAL_1

parser_VAL_1_12: ;
	mov cl, 86
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl
	jmp SUM_

parser_VAL_1_13: ; -
	mov cl, 86
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl
	jmp RES_

parser_VAL_1_14: ; *
	mov cl, 86
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl
	jmp DIV_

parser_VAL_1_15: ; /
	mov cl, 86
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov funtionStack[bx], cl 
	xor bx, bx
	mov bl, 1
	add funtionIndexStack[0], bl
	jmp MUL_

parser_VAL_1_16: ; return to val 86
jmp parser_VAL_1



returnFunction:

	mov bl, 1
	sub funtionIndexStack[0], bl
	xor bx, bx
	mov bx, funtionIndexStack[0]
	mov cl, funtionStack[bx]
	xor bx, bx
	
	cmp cl, 25
	jz parser_OPERATION_1_5
	cmp cl, 31
	jz parser_SUM_1
	cmp cl, 32
	jz parser_SUM_2
	cmp cl, 41
	jz parser_RES_1
	cmp cl, 42
	jz parser_RES_2
	cmp cl, 51
	jz parser_DIV_1
	cmp cl, 52
	jz parser_DIV_2
	cmp cl, 61
	jz parser_MUL_1
	cmp cl, 62
	jz parser_MUL_2
	
	cmp cl, 86
	jz parser_VAL_1_16









returnParser:
	mov bl, parserCaller[0]
	cmp bl, 0
	jz parser_R_0
	cmp bl, 1
	jz parser_R_1

	cmp bl, 10
	jz parser_OPERATION_0
	cmp bl, 12
	jz parser_OPERATION_2
	cmp bl, 30
	jz parser_SUM_0
	cmp bl, 33
	jz parser_SUM_3

	cmp bl, 40
	jz parser_RES_0
	cmp bl, 43
	jz parser_RES_3
	cmp bl, 50
	jz parser_DIV_0
	cmp bl, 53
	jz parser_DIV_3
	cmp bl, 60
	jz parser_MUL_0
	cmp bl, 63
	jz parser_MUL_3


	cmp bl, 70
	jz parser_VAL_0
	cmp bl, 72
	jz parser_VAL_2
	cmp bl, 80
	jz parser_VAL_1_0
	cmp bl, 81
	jz parser_VAL_1_1
	jmp fin; TODO Delete


print_current_token:
	mov bl, parser_token[0]
	registerToDec_ bl
	mov decimalHelper[0], bh
	mov decimalHelper[1], bl
	print_arr decimalHelper
	ret



getNextToken:
		;limpiar el token
		mov bl, 99 
		mov parser_token[0], bl
		mov cx, 50 ; read up to 7000 chars		
		
		_for_gnt:
			mov al, fragmento[si]
			cmp al, '$'
			jz fin ;TODO quitarlo o modificarlo
			jmp getToken
			returnFromGetToken:
			; increase counter check if token flag ready is on
			; su no lo esta continuar, si si lo esta cambiar la flag a no listo e imprimir token
			inc si
			mov bl, tokenReady[0]
			cmp bl, 0; si el token no esta listo continuar el ciclo
			
			jz tokenNotReady

			;**************Token ready**************
			
			mov bl, 0
			mov tokenReady[0], bl ; set the token as not ready again	
			;1) Regresar al metodo que me llamo 
			

			jmp returnParser


			tokenNotReady:
			
			dec cx
			jnz _for_gnt
			jmp fin; TODO quitar, si ya no hay mas toquens que termine
		













getToken:


checkIfBlank_ al
cmp bl, 0					;si ah es 0 regresar a getNextToken
jz returnFromGetToken  		; if is blank return 



;********************** SAVING ID ******************
mov bl, register_id[0]
cmp bl, 0 ; id is OFF
jz start_Lex_Analisis
	mov bl, '<'
	cmp bl, al
	jz start_Lex_Analisis
	mov bl, '>'
	cmp bl, al
	jz start_Lex_Analisis

	mov cl, al
	xor bx, bx
	mov bx, current_Index_id[0]
	mov current_id[bx], cl 
	xor bx, bx
	mov bl, 1
	add current_Index_id[0], bl




start_Lex_Analisis:

mov bh, lex_state[0]

;************** STATE 0 *******************
cmp bh, 0
jz lex_state_0

;************** STATE 1 *******************
cmp bh, 1
jz lex_state_1

;************** STATE 2 *******************
cmp bh, 2
jz lex_state_2

;************** STATE 3 *******************
cmp bh, 3
jz lex_state_3

;************** STATE 4 *******************
cmp bh, 4
jz lex_state_4

;************** STATE 5 *******************
cmp bh, 5
jz lex_state_5

;************** STATE 6 *******************
cmp bh, 6
jz lex_state_6

;************** STATE 7 *******************
cmp bh, 7
jz lex_state_7

;************** STATE 8 *******************
cmp bh, 8
jz lex_state_8

;************** STATE 9 *******************
cmp bh, 9
jz lex_state_9

;************** STATE 10 *******************
cmp bh, 10
jz lex_state_10

;************** STATE 11 *******************
cmp bh, 11
jz lex_state_11

;************** STATE 12 *******************
cmp bh, 12
jz lex_state_12

;************** STATE 13 *******************
cmp bh, 13
jz lex_state_13

;************** STATE 14 *******************
cmp bh, 14
jz lex_state_14

;************** STATE 15 *******************
cmp bh, 15
jz lex_state_15

;************** STATE 16 *******************
cmp bh, 16
jz lex_state_16

;************** STATE 17 *******************
cmp bh, 17
jz lex_state_17

;************** STATE 18 *******************
cmp bh, 18
jz lex_state_18

;************** STATE 19 *******************
cmp bh, 19
jz lex_state_19

;************** STATE 20 *******************
cmp bh, 20
jz lex_state_20

;************** STATE 21 *******************
cmp bh, 21
jz lex_state_21

;************** STATE 22 *******************
cmp bh, 22
jz lex_state_22

;************** STATE 23 *******************
cmp bh, 23
jz lex_state_23

;************** STATE 24 *******************
cmp bh, 24
jz lex_state_24

;************** STATE 25 *******************
cmp bh, 25
jz lex_state_25

;************** STATE 26 *******************
cmp bh, 26
jz lex_state_26

;************** STATE 27 *******************
cmp bh, 27
jz lex_state_27

;************** STATE 28 *******************
cmp bh, 28
jz lex_state_28

;************** STATE 29 *******************
cmp bh, 29
jz lex_state_29

;************** STATE 30 *******************
cmp bh, 30
jz lex_state_30

;************** STATE 31 *******************
cmp bh, 31
jz lex_state_31

;************** STATE 32 *******************
cmp bh, 32
jz lex_state_32

;************** STATE 33 *******************
cmp bh, 33
jz lex_state_33

;************** STATE 34 *******************
cmp bh, 34
jz lex_state_34

;************** STATE 35 *******************
cmp bh, 35
jz lex_state_35

;************** STATE 36 *******************
cmp bh, 36
jz lex_state_36

;************** STATE 37 *******************
cmp bh, 37
jz lex_state_37

;************** STATE 38 *******************
cmp bh, 38
jz lex_state_38

;************** STATE 39 *******************
cmp bh, 39
jz lex_state_39

;************** STATE 40 *******************
cmp bh, 40
jz lex_state_40

;************** STATE 41 *******************
cmp bh, 41
jz lex_state_41

;************** STATE 42 *******************
cmp bh, 42
jz lex_state_42

;************** STATE 43 *******************
cmp bh, 43
jz lex_state_43

;************** STATE 44 *******************
cmp bh, 44
jz lex_state_44

;************** STATE 45 *******************
cmp bh, 45
jz lex_state_45

;************** STATE 46 *******************
cmp bh, 46
jz lex_state_46

;************** STATE 47 *******************
cmp bh, 47
jz lex_state_47

;************** STATE 48 *******************
cmp bh, 48
jz lex_state_48

;************** STATE 49 *******************
cmp bh, 49
jz lex_state_49

;************** STATE 50 *******************
cmp bh, 50
jz lex_state_50

;************** STATE 51 *******************
cmp bh, 51
jz lex_state_51

;************** STATE 52 *******************
cmp bh, 52
jz lex_state_52

;************** STATE 53 *******************
cmp bh, 53
jz lex_state_53

;************** STATE 54 *******************
cmp bh, 54
jz lex_state_54

;************** STATE 55 *******************
cmp bh, 55
jz lex_state_55

;************** STATE 56 *******************
cmp bh, 56
jz lex_state_56

;************** STATE 57 *******************
cmp bh, 57
jz lex_state_57

;************** STATE 58 *******************
cmp bh, 58
jz lex_state_58

;************** STATE 59 *******************
cmp bh, 59
jz lex_state_59

;************** STATE 60 *******************
cmp bh, 60
jz lex_state_60

;************** STATE 61 *******************
cmp bh, 61
jz lex_state_61

;************** STATE 62 *******************
cmp bh, 62
jz lex_state_62

;************** STATE 63 *******************
cmp bh, 63
jz lex_state_63






LexicalError:

	print_arr lexError
jmp fin

lex_state_0:
	
	xor dx, dx

	cmp al, '<'
	jz lex_state_0_1
	cmp al, '-'
	jz lex_state_0_2
	isNumber_ al	
	cmp bl, 1
	jz lex_state_0_3
	;else If anything else comes
	jmp lex_state_0_4
	lex_state_0_1:
	mov bl, 1
	mov lex_state[0], bl
	jmp returnFromGetToken

	lex_state_0_2:
	mov dh, 00000001b
	mov bl, 61
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_0_3:
	mov bl, al
	setNumberUnit_ bl
	mov bl, 63
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_0_4:
	jmp LexicalError


lex_state_1:

	


	cmp al, '/'
	jz lex_state_1_0
	cmp al, 'o'
	jz lex_state_1_1
	cmp al, 's'
	jz lex_state_1_2
	cmp al, 'r'
	jz lex_state_1_3
	cmp al, 'd'
	jz lex_state_1_4
	cmp al, 'm'
	jz lex_state_1_5
	cmp al, 'v'
	jz lex_state_1_6
	;else If anything else comes
	jmp lex_state_1_7




	lex_state_1_0:
	mov bl, 2
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_1_1:
	mov bl, 3
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_1_2:
	mov bl, 14
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_1_3:
	mov bl, 17
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_1_4:
	mov bl, 20
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_1_5:
	mov bl, 23
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_1_6:
	mov bl, 26
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_1_7:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken
	
	
lex_state_2:
	
	cmp al, 'o'
	jz lex_state_2_0
	cmp al, 's'
	jz lex_state_2_1
	cmp al, 'r'
	jz lex_state_2_2
	cmp al, 'd'
	jz lex_state_2_3
	cmp al, 'm'
	jz lex_state_2_4
	cmp al, 'v'
	jz lex_state_2_5
	;else If anything else comes
	jmp lex_state_2_6
	




	lex_state_2_0:
	mov bl, 32
	mov lex_state[0], bl
	jmp returnFromGetToken

	lex_state_2_1:
	mov bl, 43
	mov lex_state[0], bl
	jmp returnFromGetToken

	lex_state_2_2:
	mov bl, 46
	mov lex_state[0], bl
	jmp returnFromGetToken

	lex_state_2_3:
	mov bl, 49
	mov lex_state[0], bl
	jmp returnFromGetToken

	lex_state_2_4:
	mov bl, 52
	mov lex_state[0], bl
	jmp returnFromGetToken

	lex_state_2_5:

	mov bl, 55
	mov lex_state[0], bl
	jmp returnFromGetToken

	lex_state_2_6:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken



lex_state_3:
	cmp al, 'p'
	jz lex_state_3_0
	jmp lex_state_3_1

	lex_state_3_0:
	mov bl, 4
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_3_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken



lex_state_4:
	cmp al, 'e'
	jz lex_state_4_0
	jmp lex_state_4_1

	lex_state_4_0:
	mov bl, 5
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_4_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_5:
	cmp al, 'r'
	jz lex_state_5_0
	jmp lex_state_5_1

	lex_state_5_0:
	mov bl, 6
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_5_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_6:

	cmp al, 'a'
	jz lex_state_6_0
	jmp lex_state_6_1

	lex_state_6_0:
	mov bl, 7
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_6_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_7:
	cmp al, 'c'
	jz lex_state_7_0
	jmp lex_state_7_1

	lex_state_7_0:
	mov bl, 8
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_7_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_8:
	cmp al, 'i'
	jz lex_state_8_0
	jmp lex_state_8_1

	lex_state_8_0:
	mov bl, 9
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_8_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_9:
	cmp al, 'o'
	jz lex_state_9_0
	jmp lex_state_9_1

	lex_state_9_0:
	mov bl, 10
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_9_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_10:
	cmp al, 'n'
	jz lex_state_10_0
	jmp lex_state_10_1

	lex_state_10_0:
	mov bl, 11
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_10_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_11:
	cmp al, 'e'
	jz lex_state_11_0
	jmp lex_state_11_1

	lex_state_11_0:
	mov bl, 12
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_11_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_12:
	cmp al, 's'
	jz lex_state_12_0
	jmp lex_state_12_1

	lex_state_12_0:
	mov bl, 13
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_12_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_13:

	cmp al, '>'
	jz lex_state_13_0
	jmp lex_state_13_1

	lex_state_13_0:
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 0
	mov parser_token[0], bl 
	jmp returnFromGetToken
	lex_state_13_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_14:
	cmp al, 'u'
	jz lex_state_14_0
	jmp lex_state_14_1

	lex_state_14_0:
	mov bl, 15
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_14_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_15:
	cmp al, 'm'
	jz lex_state_15_0
	jmp lex_state_15_1

	lex_state_15_0:
	mov bl, 16
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_15_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_16:
	cmp al, '>'
	jz lex_state_16_0
	jmp lex_state_16_1

	lex_state_16_0:
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 2
	mov parser_token[0], bl 
	jmp returnFromGetToken
	lex_state_16_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_17:
	cmp al, 'e'
	jz lex_state_17_0
	jmp lex_state_17_1

	lex_state_17_0:
	mov bl, 18
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_17_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_18:
	cmp al, 's'
	jz lex_state_18_0
	jmp lex_state_18_1

	lex_state_18_0:
	mov bl, 19
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_18_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken
lex_state_19:
	cmp al, '>'
	jz lex_state_19_0
	jmp lex_state_19_1

	lex_state_19_0:
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 4
	mov parser_token[0], bl 
	jmp returnFromGetToken
	lex_state_19_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_20:
	cmp al, 'i'
	jz lex_state_20_0
	jmp lex_state_20_1

	lex_state_20_0:
	mov bl, 21
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_20_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_21:
	cmp al, 'v'
	jz lex_state_21_0
	jmp lex_state_21_1

	lex_state_21_0:
	mov bl, 22
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_21_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_22:
	cmp al, '>'
	jz lex_state_22_0
	jmp lex_state_22_1

	lex_state_22_0:
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 6
	mov parser_token[0], bl 
	jmp returnFromGetToken
	lex_state_22_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_23:
	cmp al, 'u'
	jz lex_state_23_0
	jmp lex_state_23_1

	lex_state_23_0:
	mov bl, 24
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_23_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_24:
	cmp al, 'l'
	jz lex_state_24_0
	jmp lex_state_24_1

	lex_state_24_0:
	mov bl, 25
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_24_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_25:
	cmp al, '>'
	jz lex_state_25_0
	jmp lex_state_25_1

lex_state_25_0:
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 8
	mov parser_token[0], bl 
	jmp returnFromGetToken
	lex_state_25_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_26:
	cmp al, 'a'
	jz lex_state_26_0
	jmp lex_state_26_1

	lex_state_26_0:
	mov bl, 27
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_26_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_27:
	cmp al, 'l'
	jz lex_state_27_0
	jmp lex_state_27_1

	lex_state_27_0:
	mov bl, 28
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_27_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_28:
	cmp al, 'o'
	jz lex_state_28_0
	jmp lex_state_28_1

	lex_state_28_0:
	mov bl, 29
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_28_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_29:
	cmp al, 'r'
	jz lex_state_29_0
	jmp lex_state_29_1

	lex_state_29_0:
	mov bl, 30
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_29_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_30:
	cmp al, '>'
	jz lex_state_30_0
	jmp lex_state_30_1

	lex_state_30_0:
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 10
	mov parser_token[0], bl 
	jmp returnFromGetToken
	lex_state_30_1:
	mov bl, 31
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_31:
	cmp al, '>'
	jz lex_state_31_0
	jmp lex_state_31_1
	
	lex_state_31_0:
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 12
	mov parser_token[0], bl 
	jmp returnFromGetToken
	lex_state_31_1:
	;TODO aqui hacer el codigo para agregar el char 
	jmp returnFromGetToken


lex_state_32:
	cmp al, 'p'
	jz lex_state_32_0
	jmp lex_state_32_1

	lex_state_32_0:
	mov bl, 33
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_32_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_33:
	cmp al, 'e'
	jz lex_state_33_0
	jmp lex_state_33_1

	lex_state_33_0:
	mov bl, 34
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_33_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_34:
	cmp al, 'r'
	jz lex_state_34_0
	jmp lex_state_34_1

	lex_state_34_0:
	mov bl, 35
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_34_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_35:
	cmp al, 'a'
	jz lex_state_35_0
	jmp lex_state_35_1

	lex_state_35_0:
	mov bl, 36
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_35_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_36:
	cmp al, 'c'
	jz lex_state_36_0
	jmp lex_state_36_1

	lex_state_36_0:
	mov bl, 37
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_36_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_37:
	cmp al, 'i'
	jz lex_state_37_0
	jmp lex_state_37_1

	lex_state_37_0:
	mov bl, 38
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_37_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_38:
	cmp al, 'o'
	jz lex_state_38_0
	jmp lex_state_38_1

	lex_state_38_0:
	mov bl, 39
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_38_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_39:
	cmp al, 'n'
	jz lex_state_39_0
	jmp lex_state_39_1

	lex_state_39_0:
	mov bl, 40
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_39_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_40:
	cmp al, 'e'
	jz lex_state_40_0
	jmp lex_state_40_1

	lex_state_40_0:
	mov bl, 41
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_40_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_41:
	cmp al, 's'
	jz lex_state_41_0
	jmp lex_state_41_1

	lex_state_41_0:
	mov bl, 42
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_41_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_42:
	cmp al, '>'
	jz lex_state_42_0
	jmp lex_state_42_1

	lex_state_42_0:
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 1
	mov parser_token[0], bl 
	jmp returnFromGetToken
	lex_state_42_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_43:
	cmp al, 'u'
	jz lex_state_43_0
	jmp lex_state_43_1

	lex_state_43_0:
	mov bl, 44
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_43_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_44:
	cmp al, 'm'
	jz lex_state_44_0
	jmp lex_state_44_1

	lex_state_44_0:
	mov bl, 45
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_44_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_45:
	cmp al, '>'
	jz lex_state_45_0
	jmp lex_state_45_1

	lex_state_45_0:
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 3
	mov parser_token[0], bl 
	jmp returnFromGetToken
	lex_state_45_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_46:
	cmp al, 'e'
	jz lex_state_46_0
	jmp lex_state_46_1

	lex_state_46_0:
	mov bl, 47
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_46_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_47:
	cmp al, 's'
	jz lex_state_47_0
	jmp lex_state_47_1

	lex_state_47_0:
	mov bl, 48
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_47_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken


lex_state_48:
	cmp al, '>'
	jz lex_state_48_0
	jmp lex_state_48_1

	lex_state_48_0:
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 5
	mov parser_token[0], bl 
	jmp returnFromGetToken
	lex_state_48_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_49:
	cmp al, 'i'
	jz lex_state_49_0
	jmp lex_state_49_1

	lex_state_49_0:
	mov bl, 50
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_49_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_50:
	cmp al, 'v'
	jz lex_state_50_0
	jmp lex_state_50_1

	lex_state_50_0:
	mov bl, 51
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_50_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_51:
	cmp al, '>'
	jz lex_state_51_0
	jmp lex_state_51_1

	lex_state_51_0:
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 7
	mov parser_token[0], bl 
	jmp returnFromGetToken
	lex_state_51_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_52:
	cmp al, 'u'
	jz lex_state_52_0
	jmp lex_state_52_1

	lex_state_52_0:
	mov bl, 53
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_52_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_53:
	cmp al, 'l'
	jz lex_state_53_0
	jmp lex_state_53_1

	lex_state_53_0:
	mov bl, 54
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_53_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_54:
	cmp al, '>'
	jz lex_state_54_0
	jmp lex_state_54_1

	lex_state_54_0:
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 9
	mov parser_token[0], bl 
	jmp returnFromGetToken
	lex_state_54_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_55:
	cmp al, 'a'
	jz lex_state_55_0
	jmp lex_state_55_1

	lex_state_55_0:
	mov bl, 56
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_55_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_56:
	cmp al, 'l'
	jz lex_state_56_0
	jmp lex_state_56_1

	lex_state_56_0:
	mov bl, 57
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_56_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_57:
	cmp al, 'o'
	jz lex_state_57_0
	jmp lex_state_57_1

	lex_state_57_0:
	mov bl, 58
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_57_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_58:
	cmp al, 'r'
	jz lex_state_58_0
	jmp lex_state_58_1

	lex_state_58_0:
	mov bl, 59
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_58_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_59:
	cmp al, '>'
	jz lex_state_59_0
	jmp lex_state_59_1

	lex_state_59_0:
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 11
	mov parser_token[0], bl 
	jmp returnFromGetToken
	lex_state_59_1:
	mov bl, 60
	mov lex_state[0], bl
	jmp returnFromGetToken

lex_state_60:
	cmp al, '>'
	jz lex_state_60_0
	jmp lex_state_60_1
	
	lex_state_60_0:
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 13
	mov parser_token[0], bl 
	jmp returnFromGetToken
	lex_state_60_1:
	;TODO aqui hacer el codigo para agregar el char 
	jmp returnFromGetToken

lex_state_61:
	isNumber_ al	
	cmp bl, 1
	jz lex_state_61_0
	jmp lex_state_61_1

	lex_state_61_0:
	mov bl, al
	setNumberUnit_ bl
	mov bl, 62
	mov lex_state[0], bl
	jmp returnFromGetToken
	lex_state_61_1:
	jmp LexicalError

lex_state_62:

	isNumber_ al	
	cmp bl, 1
	jz lex_state_62_0
	jmp lex_state_62_1

	lex_state_62_0: ; aqui si hay numero asi que agregar
	mov bl, al
	setNumberDecenas_ bl
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 14
	mov parser_token[0], bl 
	jmp returnFromGetToken

	lex_state_62_1: ; aqui NO hay numero, no hacer nada
	mov bl, 1;
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 14
	mov parser_token[0], bl 
	jmp returnFromGetToken

lex_state_63:

	isNumber_ al	
	cmp bl, 1
	jz lex_state_63_0
	jmp lex_state_63_1

	lex_state_63_0: ; aqui si hay numero asi que agregar
	mov bl, al
	setNumberDecenas_ bl

	
	mov bl, 0
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 15
	mov parser_token[0], bl 
	jmp returnFromGetToken

	lex_state_63_1: ; aqui NO hay numero, no hacer nada

	mov bl, 1;
	mov lex_state[0], bl
	mov bl, 1
	mov tokenReady[0], bl
	mov bl, 15
	mov parser_token[0], bl 
	jmp returnFromGetToken


	
	



sintError:
	print_arr sintaxError
	jmp fin

error1:
	print_arr msgError1
	mov bl, al
	convertNumber_ bl
	print_c bl
	mov bl, ah
	convertNumber_ bl
	print_c bl

	jmp fin

error2:
	print_arr msgError2
	jmp fin


fin:
	;cerrar el archivo
	mov ah,3eh	
	int 21h
	mov ah, 4ch ;Esta linea es para terminar el programa
	int 21h


;0000001000001001












