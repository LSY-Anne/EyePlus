$PBExportHeader$wa_response.srw
forward
global type wa_response from Window
end type
type dw_list from uo_dw_list within wa_response
end type
type dw_1 from datawindow within wa_response
end type
type cb_cancelar from uo_cbcancelar within wa_response
end type
type cb_aceptar from uo_cbaceptar within wa_response
end type
end forward

global type wa_response from Window
int X=1056
int Y=484
int Width=1783
int Height=808
boolean TitleBar=true
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
dw_list dw_list
dw_1 dw_1
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
end type
global wa_response wa_response

type variables
s_parm istr_parm

end variables

forward prototypes
public subroutine wf_imprimir ()
public subroutine wf_colenabled (string as_acol[], boolean ab_enabled)
public function boolean wf_postopen ()
end prototypes

public subroutine wf_imprimir ();Return
end subroutine

public subroutine wf_colenabled (string as_acol[], boolean ab_enabled);Integer	i

For i = 1 To UpperBound( as_acol[] )
	f_ColEnabled( dw_1, as_acol[i], ab_enabled )
Next

end subroutine

public function boolean wf_postopen ();Return True
end function

on wa_response.create
this.dw_list=create dw_list
this.dw_1=create dw_1
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.Control[]={this.dw_list,&
this.dw_1,&
this.cb_cancelar,&
this.cb_aceptar}
end on

on wa_response.destroy
destroy(this.dw_list)
destroy(this.dw_1)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
end on

event open;
f_CenterWindow( This )


end event

type dw_list from uo_dw_list within wa_response
int X=64
int Y=532
int Width=283
int Height=156
int TabOrder=40
end type

type dw_1 from datawindow within wa_response
int X=64
int Y=44
int Width=1605
int Height=472
int TabOrder=10
boolean Border=false
boolean LiveScroll=true
end type

event constructor;SetTransObject( SqlCa )
end event

event editchanged;If Not cb_aceptar.Enabled Then
	cb_aceptar.Enabled = True
End If
end event

event itemchanged;If Not cb_aceptar.Enabled Then
	cb_aceptar.Enabled = True
End If
end event

type cb_cancelar from uo_cbcancelar within wa_response
int X=1321
int Y=548
int TabOrder=30
end type

type cb_aceptar from uo_cbaceptar within wa_response
int X=942
int Y=548
int TabOrder=20
boolean Enabled=false
end type

