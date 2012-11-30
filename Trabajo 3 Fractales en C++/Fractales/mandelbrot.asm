; ----------------------------------------------------------------------------
; Ejemplo tomado de http://cs.lmu.edu/~ray/notes/nasmexamples/
;  
;
; mandelbrot.asm sólo para 32bits.
;
;  Tenemos que:
;    datos = {x_inicial xi, rengón estático yi, x_incremento xincre}
;    *resultados es un vector int[pixeles^2]
;
;  void mandelbrot_renglon (double datos[], int pixeles, 
;                           int iteraciones, 
;                           int *resultados )
; ----------------------------------------------------------------------------  

;BITS 32                     ;modo de 32bits, pa no enredarnos con los registros

extern  _printf

global  _mandelbrot_renglon
global  mandelbrot_renglon
        
        
        
        ; Variables
        section .bss
        n:          resd    1; REServe 1 Double Word (int)
        pixeles:    resd    1
        iteraciones:resd    1
        
        xi:         resq    1; REServe 1 double precision float (double)
        yi:         resq    1
        xincre:     resq    1
        znx:        resq    1
        zny:        resq    1
        modu:       resq    1
        aux_X:      resq    1
        aux_Y:      resq    1
        

        ; Constantes
        section .data
        dos:        dq      2.0 ; se usa en algunas operaciones
        
        
        
        ; Código
        section .text
        
_mandelbrot_renglon:
mandelbrot_renglon:

        ;OJO, NO USAR LOS REGISTROS ebx, esi, edi, ebp, ds, es, ss
		finit
        mov     eax, [esp+4]            ; dirección del array datos[]
        fld     qword [eax]             ; se coloca el primer dato que es xi
		fstp    qword [xi]              ;
		fwait

		fld     qword [eax+8]           ; yi
		fstp    qword [yi]              ; 
		fwait
		
        fld     qword [eax+16]          ; xincre
        fstp    qword [xincre]          ;
		fwait
        
        
        mov     eax, [esp+8]            ; pixeles
        mov     [pixeles], eax
        
        mov     eax, [esp+12]           ; iteraciones
        mov     [iteraciones], eax		
		
		
		mov     edx, [esp+16]           ; Dirección del puntero de resultados,
                                        ; edx solo se usa para esta dirección.


        mov     ecx, 0 ;ecx es para el for!!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Este for es para cada pixel del renglón ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
for1:		

    ; n = 1
    mov [n], dword 1
    
    ;znx & zny en ceros
    fldz
    fst  qword [znx]
    fstp qword [zny]
    ;fwait
    
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Este while es para la cantidad de iteraciones ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    while1:
        ; ============ Se calcula el nuevo Zn ==============
        ; Para ello haremos los calculos discriminando 
        ; los calculos reales de los imaginarios, y 
        ; colocandolos en dos variabes auxiliares.
        ; Luego se comprueba el módulo para ver si se sobre
        ; pasa de 2.0.
        ; 
        ; Termina cuando se llega al máximo de iteraciones,
        ; o cuando el modulo es mayor que 2.0 [2.0 < mod].
        
        finit
        ;aux_X
        ; (znx*zxn) - (zny*zny) + xi 
        fld     qword [xi]
        fld     qword [zny]
        fmul    qword [zny]
        fld     qword [znx]
        fmul    qword [znx]
        fsubr   ;znx^2 - zny^2
        fadd    ; + xi
        ;listo aux_X
        fstp    qword [aux_X]
        ;fwait
		
        ;aux_Y
        ;(2*znx*zny) + yi
        fld     qword [znx]
        fmul    qword [zny]
        fmul    qword [dos]
        fadd    qword [yi]
        ;listo aux_Y
        fstp    qword [aux_Y]
        ;fwait
        
        ;calcular mod
        fld     qword [aux_Y]
        fmul    qword [aux_Y]
        fld     qword [aux_X]
        fmul    qword [aux_X]
        fadd
        fsqrt
        fstp    qword [modu]
		;fwait
		
		; http://www.website.masmforum.com/tutorials/fptute/fpuchap7.htm
		; comparando mod
		finit
		fld     qword [modu]    ;mod - 2
		fcomp   qword [dos]     
        fstsw   ax
        fwait
        sahf
        ;if 2<mod, terminar el while 
        ja fin_while1
        
        
        ;else
        finit
        fld     qword [aux_Y]
        fstp    qword [zny]
		fwait
        fld     qword [aux_X]
        fstp    qword [znx]
        ;fwait

    ;debe continuar? 
    inc dword [n]   ;n++

    mov eax, [n]
    cmp eax, [iteraciones]
    jle while1; if n <= iteraciones, seguir con el while1

    fin_while1:
    
    ;;;;;;;;;;;; Fin del while ;;;;;;;;;;;;;
    
    ;n--
    dec dword [n]
	
	
    ;AQUÍ VA LO DE GUARDAR n EN EL ARRAY
    mov eax, dword [n]  ;el valor de n va a eax,
    
    mov [edx], eax      ;y se guarda en la posisión actual de edx
    
    add edx, 4          ;corremos edx a la siguiente posición
    
    ;xi = xi + xincre
    fld     qword [xi]
    fadd    qword [xincre]
    fstp    qword [xi]
    ;fwait
	

inc ecx
cmp ecx, [pixeles]
jl for1 ; if ecx < pixeles, seguir con el for1.
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;

ret



