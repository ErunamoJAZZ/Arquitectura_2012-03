///////////////////////////////////////////////////////////////////////////
// C++ code generated with wxFormBuilder (version Oct  8 2012)
// http://www.wxformbuilder.org/
//
// PLEASE DO "NOT" EDIT THIS FILE!
///////////////////////////////////////////////////////////////////////////

#ifndef __GUI_H__
#define __GUI_H__

#include <wx/artprov.h>
#include <wx/xrc/xmlres.h>
#include <wx/intl.h>
#include <wx/panel.h>
#include <wx/gdicmn.h>
#include <wx/font.h>
#include <wx/colour.h>
#include <wx/settings.h>
#include <wx/string.h>
#include <wx/radiobut.h>
#include <wx/stattext.h>
#include <wx/textctrl.h>
#include <wx/sizer.h>
#include <wx/spinctrl.h>
#include <wx/button.h>
#include <wx/gauge.h>
#include <wx/statbox.h>
#include <wx/frame.h>

#include "dibujador.h"

///////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
/// Class MainFrameBase
///////////////////////////////////////////////////////////////////////////////
class MainFrameBase : public wxFrame 
{
	private:
	
	protected:

	
	public:
		
		BasicDrawPane* panelFractal; //Este es el que dibuja el fractal
		wxRadioButton* m_radioBtn1;
		wxRadioButton* m_radioBtn2;
		wxStaticText* m_staticText1;
		wxTextCtrl* m_textCtrl1;
		wxStaticText* m_staticText2;
		wxTextCtrl* m_textCtrl2;
		wxStaticText* m_staticText3;
		wxSpinCtrl* m_spinCtrl1;
		wxButton* boton_renderizar;
		wxGauge* cargador;
		
		// Virtual event handlers, overide them in your derived class
		virtual void OnCloseFrame( wxCloseEvent& event ) { event.Skip(); }
		//virtual void renderizar_fractal( wxCommandEvent& event ) { event.Skip(); }
		virtual wxGauge * getCargador() {return cargador;}
		virtual bool getBotonMandelbrot() {return m_radioBtn1->GetValue();}
		virtual bool getBotonJulia() {return m_radioBtn2->GetValue();}
		virtual double getReal(){ double r; m_textCtrl1->GetValue().ToDouble(&r);  return r;}
		virtual double getImaginario(){double r; m_textCtrl2->GetValue().ToDouble(&r);  return r;}
		virtual int getIteraciones(){return m_spinCtrl1->GetValue();}
			
		MainFrameBase( wxWindow* parent, wxWindowID id = wxID_ANY, const wxString& title = wxT("Práctica N°3 Arquitectura 2012-3 - C.Daniel Sanchez, Santiago Pinzón."), const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxSize( 720,600 ), long style = wxCLOSE_BOX|wxDEFAULT_FRAME_STYLE|wxTAB_TRAVERSAL|wxMAXIMIZE_BOX );
		
		~MainFrameBase();
	
		void renderizar_fractal(wxCommandEvent& event);
		
};

#endif //__GUI_H__
