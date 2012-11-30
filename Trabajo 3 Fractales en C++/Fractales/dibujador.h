
//#ifndef _DIBUJADOR_H__INCLUDED_
//#define _DIBUJADOR_H__INCLUDED_

#include "wx/wx.h"
#include "wx/sizer.h"
#include "wx/gdicmn.h"
#include "wx/string.h"
#include "wx/image.h"
#include "wx/bitmap.h"

#include "algoritmo.h"


class BasicDrawPane : public wxPanel {
	
	
protected:
	void julia( int *respuesta, int zoom, double centro[], double c[], int iteraciones, int pixeles);
	void mandelbrot( int *respuesta, int zoom, double centro[], int iteraciones, int pixeles);
public:
    wxPoint centro;
	wxImage fractal;
	wxBitmap pre_fractal;
	

    BasicDrawPane(wxFrame* parent);
    
    void paintEvent(wxPaintEvent & evt);
    void paintNow();
    
    void render(wxDC& dc);
    
	void SetFractal();
 
    DECLARE_EVENT_TABLE()
};