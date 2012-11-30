#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
El propósito de este progrma, es de servir como base (pseudo código)
para un programa en ensamblador del curso de Arquitectura de computadores, 
UnalMed, 2012-03.
Este código será despues traducido a ensamblador con MASM(win), y NASM(Linux).

@author: C. Daniel Sanchez R. <ErunamoJAZZ>
@date: jue 11 oct 2012 21:37:34 COT 
'''

#Flag para el ciclo infinito del programa.
ciclo = True

#Mensaje de bienvenida.
print "Hola, este es el programa para ensamblasdor, pero escrito en python."
print "Bienvenido/a :D"
print "\n\n"


#inicio del ciclo.
while(ciclo):
    print "Introduzca los valores de las siguientes variables: "
    
    #Captura de variables desde el teclado.
    A=int(raw_input(" >Ingrese variable A: "))
    B=int(raw_input(" >Ingrese variable B: "))
    C=int(raw_input(" >Ingrese variable C: "))
    D=int(raw_input(" >Ingrese variable D: "))
    E=int(raw_input(" >Ingrese variable E: "))
    F=int(raw_input(" >Ingrese variable F: "))
    G=int(raw_input(" >Ingrese variable G: "))

    #comprovación para evitar divisiones por cero
    while 5*C-2*D == 0 :
        C=int(raw_input("** La variable C genera divisiones por cero.\
        Ingresela nuevamente: "))

    #Realmente, eso jamás será cero con aritmetica entera.
    #while 4*G-3 == 0 :
    #    G=int(raw_input("** La variable G genera divisiones por cero.\
    #    Ingresela nuevamente: "))

    print "\n"

    #Empieza la calculadera ~_~
    print "\t3*A=",3*A
    print "\t3*A+2*B=",3*A+2*B
    print "\t5*C=",5*C
    print "\t5*C-2*D=", 5*C-2*D
    print "\t(3*A+2*B)/(5*C-2*D)=",(3*A+2*B)/(5*C-2*D)

    print "\t2*E*F=",2*E*F
    print "\t4*G=",4*G
    print "\t4*G-3=",4*G-3
    print "\t(2*E*F)/(4*G-3)=",(2*E*F)/(4*G-3)

    print "\t(3*A+2*B)/(5*C-2*D) + (2*E*F)/(4*G-3)",\
            (3*A+2*B)/(5*C-2*D) + (2*E*F)/(4*G-3)
    #Fin de la calculadera *^_^*
    
    print "\n"
    aux= raw_input("desea continuar ? (y/n): ")
    if aux == "n":
        print "Gracias por usar el programa ^_^"
        ciclo = False
    print "\n"


