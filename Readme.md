#Trabajo ensamblador.

Para el semestre 3 de 2012, en el curso de Arquitectura de computadores 
se desarrollaron varios programas en lenguaje ensamblador.

Este es el repositorio con el código y con cosas interesantes.

##Primer trabajo
Por cuestiones de la vida, tuve que usar el compilador de microsoft MASM, 
ya que el profesor se negó a revisar los algoritmos en linux.
Sin embargo, eso no quita que hiciera los ports para Linux usando NASM.

###Windows
Se necesita tener Visual Express 2010 C++, o el Visial Studio 2010, 
también tener la biblioteca Irvine32, desdecargable desde 
http://www.asmirvine.com/ 

Luego la carpeta de "Trabajo Ensamblador 2012-03..." se copia a 
la sección de ejemplos donde se haya descomprimido el Irvine32.
Se abre la solución Proyect.sln y se compila.

###Linux64
Se debe tener instalado el Along32 (https://sourceforge.net/projects/along32/), 
el nasm, y por supueto gcc, o más fácil instalar el build-essential.
Dejo un .deb del Along32 para los sistemas de 64bit que son los más 
extendidos ahora.

El script build.sh tiene las instrucciones para compilar "automaticamente".




##Segundo trabajo
Para el segundo trabajo, en vez de usar el VisualC++ para hacer el código
"Inline Assembler", mejor usé el lenguaje de programación D, que me dejó
hacer lo mismo, pero multiplataforma y multi arquitectura: 
http://dlang.org/iasm.html 

###Compilarlo
Para compilarlo, se debe bajar el compilador DMD desde la página oficial del
lenguaje D, y simplemente escribir:

 `dmd Trabajo2_arquitectura_201203.d`




##Tercer trabajo
Para el tercer trabajo, hacer un sistema de ventanas que mostrara un fractal,
Terminamos usando WxWidgets, y al exigirnos que tenía que estar en código en
ensamblador, lo mezclamos con NASM, usando estas guías como ejemplo para
llamar código en ensamblador desde C++ como funciones:
http://cs.lmu.edu/~ray/notes/nasmexamples/

La explicación de cómo se dibujan los fractales está en el PDF que dejé en 
la carpeta correspondiente.


Aunque al final el código aquí presente no usa nasm, ya que el código 
no funciona en 64bits.
Casualmente, las funciones en C++ son más rapidas que las que escribí en 
ensambaldor... quizás por usar internamente registros de 64bits... vaya uno 
a saber u.u

###Compilarlo
Dejé una explicación más detallada en la misma carpeta.

