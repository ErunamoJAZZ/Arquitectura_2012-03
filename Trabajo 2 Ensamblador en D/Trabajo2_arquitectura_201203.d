import std.stdio; 


double[] arcsinh(double x, int N/*la precisión*/) {
    /*
    //Así es el pseudocódigo de esta función, si se
    // tienen las funciones "potencias" y "factorial".
    while (n<=N) {
        a1 = potencias(-1, n);
        a2 = factorial(2*n);
        b1 = potencias(4, n);
        b2 = potencias(factorial(n), 2);
        r = 2*n+1;
        c1 = potencias(x, r);
        
        respuesta[n] = ((a1*b1)/(b1*b2*r))*c1
    }
    */

    // Documentación sobre los Array Dinámicos:
    // http://dlang.org/arrays.html#dynamic-arrays
    double[] respuesta; //array dinámico.
    
    
    //Declaración de variables
    double a1;
    double a2;
    double b1;
    double b2;
    double c1;
    int r;//2n+1
    int n = 0;
    
    int aux_i;
    double aux_d;
    
    //Números auxiliares para pasar al coprocesador.
    double zero = 0;
    double one  = 1;
    double acum = 0;
    
    //**NOTA: El while no está en ensamblador, ya que en D no se
    //        pueden operar Arrays Dinámicos desde ensamblador.
    while(n<=N) {
        asm {
            finit;
            
            //Poner todo en cero (para no joder el calculo).
            fld zero;
            fst a1;
            fst a2;
            fst b1;
            fst b2;
            fst c1;
            fist r;
            fst aux_d;
            fistp aux_i;
            
            
            
            //**********************
            //a1 = potencias(-1, n);
            fld aux_d;
            fadd one;
            cmp n,0;//n es cero?
            jz FIN1;// .. entonces es 1.
            
            //sinó es cero
            fsub one;  //
            fsub one;  // todo para hacer el -1
            fstp aux_d;//
            
            fld one;//1 (* -1 *-1...)
            mov ECX, n;
            L1:
                fmul aux_d;
            loop L1;
            
            FIN1:
            fstp a1;
            //**********************
         
            
            finit;
            //**********************
            // a2 = factorial(2*n);
            mov aux_i, 2;
            fild n;
            fimul aux_i;
            fistp aux_i; //nuevo n ya multiplicado.
            
            fld one;
            mov ECX, aux_i;//contador del for L2
            cmp ECX, 0;
            jz FIN2;//si n es 0, entonces el factorial es 1
            
            L2:
                mov aux_i, ECX;
                fimul aux_i;
            loop L2;
            
            FIN2:
            fstp a2;
            //**********************
            
            
            
            finit;
            //**********************
            // b1 = potencias(4, n);
            fld one;
            cmp n, 0;//n es cero?
            jz FIN3;// .. entonces es 1.
            
            //sinó es cero
            fadd one;  //2...
            fadd one;  //3...
            fadd one;  //4!!!
            fstp aux_d;//
            
            fld one;//1 (* 4 * 4...)
            mov ECX, n;
            L3:
                fmul aux_d;
            loop L3;
            
            FIN3:
            fstp b1;
            //**********************
            
            
            finit;
            //*********************************
            // b2 = potencias(factorial(n), 2);
            //factorial(n);
            fld one;
            mov ECX, n;//contador del for L4
            cmp ECX, 0;// n es cero?
            jz CONTINUAR1;//si n es 0, entonces el factorial es 1
            
            L4:
                mov aux_i, ECX;
                fimul aux_i;
            loop L4;
            CONTINUAR1:
            fstp aux_d;//guarda el factorial de n
            
            //potencias(? , 2) => ?*? ;
            fld aux_d;
            fmul aux_d;
            fstp b2;
            //*********************************
            
            
            //**************
            // r = 2*n + 1
            mov EAX, 2;
            mul EAX, n;
            inc EAX;
            mov r, EAX; 
            //**************
            
            
            finit;
            //**********************
            // c1 = potencias(x, r);
            //  [r nunca es cero.]
            fld one;//1 (* x * x...)
            mov ECX, r;
            L5:
                fmul x;
            loop L5;
            fstp c1;
            //**********************
            
            
            finit;
            //============ Resolución ============
            //respuesta[n] = ((a1*a2)/(b1*b2*r))*c1
            fld a1;     // a1
            fld a2;     // a2, a1
            fmul;       // (a2*a1)
            fld b1;     // b1, (a2*a1)
            fld b2;     // b2, b1, (a2*a1)
            fild r;     // r, b2, b1, (a2*a1)
            fmul;       // (r*b2), b1, (a2*a1)
            fmul;       // (r*b2*b1), (a2*a1)
            fdiv;       // (a1*a2)/(b1*b2*r)
            fld c1;     // c1, (a1*a2)/(b1*b2*r)
            fmul;       // c1*((a1*a2)/(b1*b2*r))
            
            //Se guarda el resultado.
            fstp aux_d;
            
            
            finit;
            //== se suma al acumulado ==
            //      acum += aux_d;
            fld acum;
            fadd aux_d;
            fstp acum;
            
        }
        //writeln("entró ", a1," ",a2," ",b1," ",b2," ",c1," ",r," ",n-1," ",aux_d);
        
        respuesta.length++;// se aumenta el tamaño del array
        respuesta[n] = acum;
        
        n++;
    }
    return respuesta;
}



void main() {
    int n;
    double x;
    double[] resp;
    
    
    
    version(Windows){
    //TEXTO SIN TÍLDES (que windows no las muestra, que basura u.u)
        string bienvenida ="\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"~
                           "   =============== Bienvenido/a al programa de Arquitectura de ===============\n"~
                           "          ========= computadores para el entregable2, 2012-03 =========\n\n"~
                           "   Este programa hara el seno hiperbolico inverso (arcsinh) de un x, usando \n"~
                           "   sentencias del coprocesador matematico para la arquitecura x86 de 32bits.\n\n"~
                           "       Elaborado por: Carlos Daniel Sanchez R.\n"~
                           "                      Santiago Pinzon C.\n\n\n";
        string pregunta1 = "Escriba un numero x tal que: |x| < 1 (un numero decimal [ejm -0.43]): ";
        string pregunta2 = "¿Hasta qué precision desea? (maximo 85): ";
    }
    else {
    //TEXTO CON TÍLDES (para los demás, es decir, Linux o Mac o lo que sea :D )
        string bienvenida ="\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"~
                           "   =============== Bienvenido/a al programa de Arquitectura de ===============\n"~
                           "          ========= computadores para el entregable2, 2012-03 =========\n\n"~
                           "   Este programa hará el seno hiperbólico inverso (arcsinh) de un x, usando \n"~
                           "   sentencias del coprocesador matemático para la arquitecura x86 de 32bits.\n\n"~
                           "       Elaborado por: Carlos Daniel Sánchez R.\n"~
                           "                      Santiago Pinzón C.\n\n\n";
        string pregunta1 = "Escriba un número x tal que: |x| < 1 (un número decimal [ejm -0.43]): ";
        string pregunta2 = "¿Hasta qué precisión desea? (máximo 85): ";
    }
    
    
    
    // ¡¡¡¡¡¡¡¡AQUÍ INICIA EL PROGRAMA!!!!!!!!
    //Bienvenida
    writeln( bienvenida );
    
    //leer X y n
    do {
        write( pregunta1 );
        scanf("%lf", &x);
        write( pregunta2 );
        scanf("%d", &n);
        
      //si el valor absoluto de x es mayor que 1, ó si n es negativo 
      //o mayor que 85 (hasta ahí va la presición) entonces...
    } while(x>1 || x<-1 || n<0 || n>85);//error con x ó n;
    
    //Calcular el desarrollo.
    resp = arcsinh(x, n);
    
    //Imprime la secuencia de la sumatoria, con una 
    //presición de 15 decimales.
    for (int i = 0 ; i < resp.length ; i++) {
        printf("\t >> S%d: %5.15lf \n",i, resp[i]);
        
    }
    writeln("\n\t\tGracias por ejecutar este programa. :) \n");
    
}



