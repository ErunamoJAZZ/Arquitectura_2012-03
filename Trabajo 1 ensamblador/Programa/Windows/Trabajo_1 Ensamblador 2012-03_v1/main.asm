TITLE Trabajo 01 ensamblador - UnalMed 2012-03(main.asm)

; Description: Trabajo en ensamblador para el curso de
;              arquitectura de computadores 2012-03.
;
;              El programa pide siete valores enteros 
;              a los cuales realiza una comprobación 
;              para evitar divisiones por cero. Luego 
;              realiza una operación con ellos, mostrando 
;              paso a paso la realización hasta concluir 
;              con el resultado.
;              Finalmente, pregunta si se quiere salir 
;              del programa, en caso contrario, se pedirá 
;              al usuario nuevemente los siete valores 
;              para realizar nuevamente la operación.
;
; Autores: Carlos Daniel Sánchez Ramírez.
;          Santiago Pinzón Correa.
;
; Revision date:

INCLUDE Irvine32.inc
.data

	;== DEFINICIÓN DE STRINGS ==
	;Todas las variables que se usarán para mostrar mensajes.
	Comienzo BYTE "                             Bienvenido/a seas!",0dh,0ah,
				  "          ...::: Arquitectura de Computadores 2012-03 :::...",0dh,0ah,0dh,0ah,
				  "          Programa elaborado por: C. Daniel Sanchez R.",0dh,0ah,
				  "                                   Santiago Pinzon C.",0dh,0ah,0dh,0ah,0
	Bienvenida BYTE "Este programa le permitira calcular una operacion con aritmetica entera. ",0dh,0ah,0
	msg00 BYTE 0dh,0ah,"~Por favor, introduzca los valores de las siguientes variables: ",0dh,0ah,0
	msg01 BYTE " >Ingrese variable A: ",0
	msg02 BYTE " >Ingrese variable B: ",0
	msg03 BYTE " >Ingrese variable C: ",0
	msg04 BYTE " >Ingrese variable D: ",0
	msg05 BYTE " >Ingrese variable E: ",0
	msg06 BYTE " >Ingrese variable F: ",0
	msg07 BYTE " >Ingrese variable G: ",0
	msg08 BYTE "**ERROR**: La variable C genera divisiones por cero.",0dh,0ah,0
	msg09 BYTE "     --==[[ RESOLICION DEL PROBLEMA ]]==--",0dh,0ah,0
	conti BYTE "Desea continuar ? (y/n): ",0dh,0ah,0
	final BYTE "Gracias por usar el programa ^_^",0dh,0ah,0

	;Vatiables para mostrar la resolución del problema
	msg_op_01 BYTE "[1]    3*A = ",0
	msg_op_02 BYTE "[2]    3*A + 2*B = ",0
	msg_op_03 BYTE "[3]    5*C = ",0
	msg_op_04 BYTE "[4]    5*C - 2*D = ",0
	msg_op_05 BYTE "[5]    (3*A + 2*B) / (5*C - 2*D) = ",0

	msg_op_06 BYTE "[6]    2*E*F = ",0
	msg_op_07 BYTE "[7]    4*G = ",0
	msg_op_08 BYTE "[8]    4*G - 3 = ",0
	msg_op_09 BYTE "[9]    (2*E*F) / (4*G - 3) = ",0

	msg_op_10 BYTE "[FIN] (3*A+2*B)/(5*C-2*D) + (2*E*F)/(4*G-3) = ",0

	;== DEFINICIÓN DE ENTEROS CON SIGNO ==
	;Variables de los números enteros con signo.
	var_A SDWORD ?
	var_B SDWORD ?
	var_C SDWORD ?
	var_D SDWORD ?
	var_E SDWORD ?
	var_F SDWORD ?
	var_G SDWORD ?
	var_aux SDWORD ?



.code
main PROC
	call Clrscr
	
	;Mensajes de bienvenida
	mov	 edx,OFFSET Comienzo
	call WriteString
	mov	 edx,OFFSET Bienvenida
	call WriteString

	;Aquí comienza el while del programa para repetirlo si se desea.
	;-------------------
	;   while(a):
	;	   ...
	;	   ...
	;-------------------

	ciclo_while_principal:
		
		;Mensaje inicial para pedir los datos.
		mov	 edx,OFFSET msg00
		call WriteString
		call crlf

		;======= LECTURA DE VARIABLES =======
		;   Para cada lectura imprime un 
		;   mensaje que pide un valor 
		;   numérico con signo.
		;   Luego guarda en la variable
		;   correspondiente el valor dado.
		;------------------------------------

		;Leer la variable A
		mov	 edx,OFFSET msg01
		call WriteString
		call ReadInt
		mov  var_A,eax
		call crlf
		
		;Leer la variable B
		mov	 edx,OFFSET msg02
		call WriteString
		call ReadInt
		mov  var_B,eax
		call crlf

		;Leer la variable C
		mov	 edx,OFFSET msg03
		call WriteString
		call ReadInt
		mov  var_C,eax
		call crlf

		;Leer la variable D
		mov	 edx,OFFSET msg04
		call WriteString
		call ReadInt
		mov  var_D,eax
		call crlf
	
		;Leer la variable E
		mov	 edx,OFFSET msg05
		call WriteString
		call ReadInt
		mov  var_E,eax
		call crlf

		;Leer la variable F
		mov	 edx,OFFSET msg06
		call WriteString
		call ReadInt
		mov  var_F,eax
		call crlf

		;Leer la variable G
		mov	 edx,OFFSET msg07
		call WriteString
		call ReadInt
		mov  var_G,eax
		call crlf
		;===============================



		;===== Comprobación recurrente de las =====
		;====== posibles divisiones por cero ======
		;   Aquí se comprueba la única posible
		;   divisón por cero que puede dar el 
		;   programa (variables C y D).
		;   Sólo se comprueba una de las dos
		;   divisiónes ya que se asume que se 
		;   trabaja SOLO con números enteros.
		;------------------------------------------
		comprobar_c:
			;Realiza la operación
			mov ecx, var_C
			imul ecx, 5; C*5
			mov edx, var_D
			imul edx, 2; D*2

			;¿Es [C*5-D*2] igual a 0?
			cmp  ecx, edx 
			jz error_c ;salta si es 0
			jmp no_error_c ;continua si no es cero.

		error_c:
			;muestra el aviso de error.
			mov	 edx,OFFSET msg08
			call WriteString

			;Leer de nuevo la variable C
			mov	 edx,OFFSET msg03
			call WriteString
			call ReadInt
			mov  var_C,eax
			call crlf

			;Salta para comprobar nuevamente C y D.
			jmp comprobar_c
		

		;En caso de estar todo bien, desde aquí se continúa 
		; con la ejecución normal del programa.
		no_error_c: 
			;Titulo de la resolución.
			mov	 edx,OFFSET msg09
			call WriteString
			
			;Y... a partir de aquí, empieza la ¡CALCULADERA! ~_~
			
			;============ Cálculo del programa ============
			;   La idea aquí es mostrar cómo se soluciona
			;   el problema paso a paso. Mostrando el paso 
			;   realizado, y su resultado, hasta llegar al
			;   final y mostrar la solución completa.
			;   Cabe recordar que se hacen calculos para
			;   números con signo, por lo que se muestra 
			;   un + ó un - (cortesía de la biblioteca de
			;   Irvine32).
			;-----------------------------------------------

			;---- Lado IZQUIERDO ----
			mov eax, var_A
			imul eax, 3 ; (3*A)
			mov	 edx,OFFSET msg_op_01
			call WriteString
			call WriteInt
			call crlf

			mov ebx, var_B
			imul ebx, 2 ;  (2*B)
			add eax, ebx ; (3*A+2*B)
			mov	 edx,OFFSET msg_op_02
			call WriteString
			call WriteInt
			call crlf

			;Se guarda el lado de arriba (3*A+2*B),
			; en ECX para la división posterior.
			mov ecx, eax

			mov eax, var_C
			imul eax, 5 ; (5*C)
			mov	 edx,OFFSET msg_op_03
			call WriteString
			call WriteInt
			call crlf

			mov ebx, var_D
			imul ebx, 2 ;  (2*D)
			sub eax, ebx ; (5*C-2*D)
			mov	 edx,OFFSET msg_op_04
			call WriteString
			call WriteInt
			call crlf

			;Ordenamos las variables en los
			; registros apropiados para dividir.
			mov ebx, eax
			mov eax, ecx
			cdq ; extiende EAX hacia EDX (para la división)
			idiv ebx ; (3*A+2*B)/(5*C-2*D)

			;Salvamos el lado izquierdo en la variable auxiliar.
			mov var_aux, eax 
			mov	 edx,OFFSET msg_op_05
			call WriteString
			call WriteInt
			call crlf
			call crlf


			;---- Lado DERECHO ----
			mov eax, var_E
			imul eax, 2 ;    (2*E)
			mov ebx, var_F
			imul eax, ebx ; (2*E*F)
			mov	 edx,OFFSET msg_op_06
			call WriteString
			call WriteInt
			call crlf
			;Salvamos el lado de arriba en ECX.
			mov ecx, eax 

			mov eax, var_G
			imul eax, 4 ; (4*G)
			mov	 edx,OFFSET msg_op_07
			call WriteString
			call WriteInt
			call crlf

			sub eax, 3 ; (4*G-3)
			mov	 edx,OFFSET msg_op_08
			call WriteString
			call WriteInt
			call crlf

			;Ordenamos las variables en los
			; registros apropiados para dividir.
			mov ebx, eax
			mov eax, ecx
			cdq ; extiende EAX hacia EDX (para la división)
			idiv ebx ;(2*E*F)/(4*G-3)

			mov	 edx,OFFSET msg_op_09
			call WriteString
			call WriteInt
			call crlf
			call crlf

			;Y finalmente....
			; recuperamos el lado izquierdo.
			mov ebx, var_aux

			; Y sumamos para terminar.
			add eax, ebx ; (3*A+2*B)/(5*C-2*D) + (2*E*F)/(4*G-3)
			mov	 edx,OFFSET msg_op_10
			call WriteString
			call WriteInt
			call crlf
			call crlf
			call crlf
			;===============================================


		continuar_o_no:
			;========= MENSAJE DE CONTINUACIÓN =========
			;  Aquí preguntaremos de forma semindefinida
			;  al usuario si desea continuar o terminar 
			;  con el programa. 
			;  Hasta que el usuario teclee y[Y] ó n[N].
			;-------------------------------------------
			mov	 edx,OFFSET conti ;¿Mensaje de continuación?
			call WriteString
			
			call ReadChar
			mov ah, "n"
			cmp ah, al ;Compara si el caracter es n
			je terminar_programa

			mov ah, "N"
			cmp ah, al ;Compara si el caracter es N
			je terminar_programa

			mov ah, "y"
			cmp ah, al ;Compara si el caracter es y
			je ciclo_while_principal

			mov ah, "Y"
			cmp ah, al ;Compara si el caracter es y
			je ciclo_while_principal

			;Si es cualquier otro, pregunta de nuevo
			jmp continuar_o_no
			;=========================================


		terminar_programa:
			;Se acabó u.u
			; muestra el mensaje de despedida y finaliza.
			call crlf
			mov edx, OFFSET final 
			call WriteString
			call crlf

	exit
main ENDP

END main
