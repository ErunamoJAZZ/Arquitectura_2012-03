#ifndef ALGORITMO_H
#define ALGORITMO_H

//Algoritmo que calcula las iteraciones de Mandelbrot
void mandelbrot_renglon (double datos[], int pixeles, int iteraciones, int *resultados );

//Algoritmo que calcula las iteraciones de Julia para un c=cx+cyi
void julia_renglon (double datos[], int pixeles, int iteraciones, int *resultados );

#endif // ALGORITMO_H
