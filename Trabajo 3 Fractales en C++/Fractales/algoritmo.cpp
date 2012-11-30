#include "algoritmo.h"
#include "math.h"
#include "stdio.h"


//extern "C" void mandelbrot_renglon(double[], int, int, int*);
/*  ================== MANDELBROT ==================
 * datos = {rengón estático yi, x_inicial, x_incremento}
 * resultados es un vector  int[pixeles^2]
 * ¡¡esto es lo que va en ensamblador.!!
 * ASM
 */
void mandelbrot_renglon (double datos[], int pixeles, 
				     int iteraciones, 
					 int *resultados ) 
{
	double xi = datos[0];
	
	for (int i=0 ; i<pixeles ; i++){
		 int n = 1; //no constante
		const double yi = datos[1];
		const double xincre = datos[2];
		double znx = 0.0; //Z0x
		double zny = 0.0; //Z0yi
		double mod;
		double aux_X;
		double aux_Y;
		
		while(n<=iteraciones){
			//Calcula el nuevo Zn
			aux_X = (znx*znx) - (zny*zny) + xi;
			aux_Y = (2*znx*zny) + yi;
			
			//revisa el modulo, y termina las iteaciones si es mayor que 2.
			mod = sqrt( (aux_X*aux_X) + (aux_Y*aux_Y) );
			
			if (2.0 < mod)
				{break;}
			
			znx = aux_X;
			zny = aux_Y;
			n++;
		}
		resultados[i] = n-1; //guarda el número de iteraciones que resultaron
		
		//se incrementa el nuevo punto de x
		xi = xi + xincre;
	}
}


//extern "C" void julia_renglon(double[], int, int, int*);
/*  ================== JULIA ==================
 * datos = {rengón estático yi, x_inicial, x_incremento, cx, cyi}
 * resultados es un vector  int[pixeles^2]
 * ¡¡esto es lo que va en ensamblador.!!
 * ASM
 */

void julia_renglon (double datos[], int pixeles, 
				     int iteraciones, 
					 int *resultados ) 
{
	double xi = datos[0];
	
	for (int i=0 ; i<pixeles ; i++){
		 int n = 1;
		double yi = datos[1];
		double xincre = datos[2];
		double cx = datos[3];
		double cyi = datos[4];
		double mod;
		double aux_X;
		double aux_Y;
		
		//Se inicializa el Z0
		double znx = (xi*xi) - (yi*yi) + cx; //Z0x
		double zny = (2*xi*yi) + cyi; //Z0yi
		
		//printf("%f %f %f %f %f \n",yi, xi,xincre ,znx , zny );
		while(n<=iteraciones){
			//Calcula el nuevo Zn
			aux_X = (znx*znx) - (zny*zny) + cx;
			aux_Y = (2*znx*zny) + cyi;
			
			//printf("%f, %f \n",aux_X ,aux_Y );
			//revisa el modulo, y termina las iteaciones si es mayor que 2.
			mod = sqrt( (aux_X*aux_X) + (aux_Y*aux_Y) );
			
			//printf("%f ", mod);
			if (mod > 2.0)
				{break;}
			
			znx = aux_X;
			zny = aux_Y;
			n++;
		}
		resultados[i] = n-1; //guarda el número de iteraciones que resultaron
		
		//se incrementa el nuevo punto de x
		xi = xi + xincre;
	}
}

////////////////////////////////////////////////////////////////////////////////////////////
