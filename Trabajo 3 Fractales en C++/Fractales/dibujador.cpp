//#include "dibujador.h"
//#include "algoritmo.h"
#include "wx/string.h"
#include "stdio.h"
#include "gui.h"

//Eventos de dibujo
BEGIN_EVENT_TABLE(BasicDrawPane, wxPanel)
	EVT_PAINT(BasicDrawPane::paintEvent)
END_EVENT_TABLE()


//Constructor
BasicDrawPane::BasicDrawPane(wxFrame* parent):wxPanel(parent) {
	//centro = new wxPoint::wxPoint(256,256);
	fractal.Create(512,512);
	
	//SetFractal(500,6,-0.5,-0.55);
}

//Eventos de  de dibujar
void BasicDrawPane::paintEvent(wxPaintEvent & evt) {
	wxPaintDC dc(this);
	render(dc);
}
void BasicDrawPane::paintNow() {
	wxClientDC dc(this);
	render(dc);
}


//Render
void BasicDrawPane::render(wxDC&  dc)
{
	pre_fractal = wxBitmap(fractal);
	dc.DrawBitmap(pre_fractal, 0, 0, false);
	// draw some text
	dc.DrawText(wxT("Testing Fractal"), 1, 1);
	
}



/* Este metodo, re-calcula y re-dibuja el fractal, convirtiendolo en
 * una imagen tipo wxImage, la cual es la que se muestra.
 */
void BasicDrawPane::SetFractal( ) 
{
	MainFrameBase * vent = (MainFrameBase *)this->GetParent();
	int zoom = 1;
	const int pixeles = 512;
	int aux = pixeles*pixeles;
	
	//matriz de calculos de iteraciones
	 int *matriz_fractal;
	matriz_fractal = new int[aux];
	
	//calcular centro
	double centro[2] = { 0.0, 0.0 };
	//double z0[2] = { z0x, z0yi}; //para mandelbrot es z0=0+0i
	
	//¿cual fractal?

		int iteraciones = vent->getIteraciones();
		
		if(vent->getBotonMandelbrot()){
			mandelbrot( matriz_fractal, zoom, centro, iteraciones, pixeles );
		}
		if(vent->getBotonJulia()){
			double tipo_julia[2]={vent->getReal(),vent->getImaginario()};
			julia( matriz_fractal, zoom, centro, tipo_julia, iteraciones, pixeles );
		}

	//
	
	
	//printf("entre");
	//convertir la matriz de iteraciones en una matriz RGB
	//aux = aux*3;
	unsigned char *matriz_RGB;
	matriz_RGB = (unsigned char*)malloc(aux*3* sizeof(unsigned char));
	
	for (int i=0 ; i<aux ; i++ ) {
		unsigned short porcent = matriz_fractal[i]%10;
		int j = 3*i;
		
		//Se colorea según el valor del residuo:
		switch(porcent){
			case 0:
				matriz_RGB[j]=50; matriz_RGB[j+1]=65; matriz_RGB[j+2]=105;
				break;
			case 1:
				matriz_RGB[j]=255; matriz_RGB[j+1]=89; matriz_RGB[j+2]=60;
				break;
			case 2:
				matriz_RGB[j]=255; matriz_RGB[j+1]=154; matriz_RGB[j+2]=65;
				break;
			case 3:
				matriz_RGB[j]=255; matriz_RGB[j+1]=226; matriz_RGB[j+2]=65;
				break;
			case 4:
				matriz_RGB[j]=190; matriz_RGB[j+1]=254; matriz_RGB[j+2]=66;
				break;
			case 5:
				matriz_RGB[j]=68; matriz_RGB[j+1]=250; matriz_RGB[j+2]=100;
				break;
			case 6:
				matriz_RGB[j]=66; matriz_RGB[j+1]=254; matriz_RGB[j+2]=190;
				break;
			case 7:
				matriz_RGB[j]=65; matriz_RGB[j+1]=101; matriz_RGB[j+2]=255;
				break;
			case 8:
				matriz_RGB[j]=255; matriz_RGB[j+1]=66; matriz_RGB[j+2]=254;
				break;
			case 9:
				matriz_RGB[j]=252; matriz_RGB[j+1]=68; matriz_RGB[j+2]=90;
				break;
		}
	}
	
	//se actualiza la imagen ya pintada
	fractal.SetData(matriz_RGB, false);
	//se pinta de nuevo
	wxClientDC dc(this);
	this->render(dc);
}


void BasicDrawPane::mandelbrot( int *respuesta, int zoom, double centro[], int iteraciones, int pixeles = 512){
	
	//Comprobación del zoom.
	if(zoom < 1)
		zoom=1;
	
	//Hace el zoom y centra el cuadrante
	double extremox1 = (-2.0/zoom)+centro[0];//izquierda
	double extremox2 = (2.0/zoom)+centro[0];//dechecha
	//double extremoy1 = (-2.0/zoom)+centro[1];//abajo //no se usa :P
	double extremoy2 = (2.0/zoom)+centro[1];//arriba  
	
	//printf("entre");
	//esto se mide: ancho del plano virtual (inicialmente 4.0 [-2, 2] )
	//dividos los pixeles.
	double incrementos = (extremox2 - extremox1)/pixeles;
	
	//posisión más a la izquierda
	double renglonY = extremoy2;
	
	double datos[3] = {extremox1, renglonY, incrementos};
	
	//AQUÍ VA EL CÓDIGO DE ACTUALIZAR LA BARRA DE CARGA.
	MainFrameBase * vent = (MainFrameBase *)this->GetParent();
	wxGauge * carg = vent->getCargador();
		
	for (int i=0; i<pixeles ; i++){
		//Asignación de valores en un renglón a la vez
		mandelbrot_renglon(datos, pixeles, iteraciones, &respuesta[i*pixeles]);
		
		renglonY -= incrementos; // baja un renglón
		datos[1] = renglonY; //lo asigna para continuación en el for
		
		int a = (i/511)*100;
		carg->SetValue(a);
	}
}

/* ================== JULIA ==================
 * respuesta es un vector: respuesta[pixeles^2]
 * int pixeles: siempre asumimos imágenes cuadradas.
 * centro, tiene el x real & el y imaginario del plano.
 * c = cx + cyi, la constante del fractal.
 */
void BasicDrawPane::julia( int *respuesta, int zoom, double centro[], double c[], int iteraciones, int pixeles = 512){
	
	//Comprobación del zoom.
	if(zoom < 1)
		zoom=1;
	
	//Hace el zoom y centra el cuadrante
	double extremox1 = (-2.0/zoom)+centro[0];//izquierda
	double extremox2 = (2.0/zoom)+centro[0];//dechecha
	//double extremoy1 = (-2.0/zoom)+centro[1];//abajo //no se usa :P
	double extremoy2 = (2.0/zoom)+centro[1];//arriba  
	
	//printf("entre");
	//esto se mide: ancho del plano virtual (inicialmente 4.0 [-2, 2] )
	//dividos los pixeles.
	double incrementos = (extremox2 - extremox1)/pixeles;
	
	//posisión más a la izquierda
	double renglonY = extremoy2;
	
	double datos[5] = {extremox1, renglonY, incrementos, c[0], c[1]};
	
	//AQUÍ VA EL CÓDIGO DE ACTUALIZAR LA BARRA DE CARGA.
	MainFrameBase * vent = (MainFrameBase *)this->GetParent();
	wxGauge * carg = vent->getCargador();
		
	for (int i=0; i<pixeles ; i++){
		//Asignación de valores en un renglón a la vez
		julia_renglon(datos, pixeles, iteraciones, &respuesta[i*pixeles]);

		renglonY -= incrementos; // baja un renglón
		datos[1] = renglonY; //lo asigna para continuación en el for

		//Cambiar posición
		int a = (i/511)*100;
		carg->SetValue(a);
	}
}