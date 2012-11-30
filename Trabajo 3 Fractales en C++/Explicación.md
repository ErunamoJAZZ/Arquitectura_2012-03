#Programa de fractales
Aunque el profesor dijo que lo hicieramos en VisualStudio 2010, solo exigió
que estuviera en C++... y no necesariamente con win32.

Para este trabajo usamos la biblioteca para GUIs wxWidgets en su versión 2.9.4.
El proyecto está hecho usando el IDE CodeLite en su versión 4.1.

Aunque no borré el código que escribí en ensamblador (para nasm de 32bit), 
este no funciona en plataformas de 64bits, por lo que decidí no hacerlo 
ejecutable, solo dejé las versiones en C++ al ser más compatibles.


##Cómo compilarlo
Para hacerlo deberías bajar el CodeLite, y tener las bibliotecas de desarrollo
de wxWidgets 3.0. Creas un nuevo "Workspace", y desde este abres el proyecto 
"Fractales.project", le das compilar, y ruega porque funcione xD

jajaja, bahh, funcionará ;D

##Una imagen para antojar
![Fractal de Julia][julia.png]

Ojo, los números se escriben con coma (,).
Por ejemplo en la imagen se ve el fractal `C = 0,285 + 0,01i`.
