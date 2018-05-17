$PBExportHeader$w_util_acumulador.srw
$PBExportComments$Programa ke kuenta los productos emp. y emb.
forward
global type w_util_acumulador from wa_response
end type
type cbx_1 from checkbox within w_util_acumulador
end type
type cbx_2 from checkbox within w_util_acumulador
end type
type cb_1 from uo_cbother within w_util_acumulador
end type
end forward

global type w_util_acumulador from wa_response
int Width=2432
int Height=1548
cbx_1 cbx_1
cbx_2 cbx_2
cb_1 cb_1
end type
global w_util_acumulador w_util_acumulador

on w_util_acumulador.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cbx_2
this.Control[iCurrent+3]=this.cb_1
end on

on w_util_acumulador.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cb_1)
end on

type dw_list from wa_response`dw_list within w_util_acumulador
int X=32
int Y=728
int Width=2313
int Height=504
string DataObject="d_util_acumulador"
end type

type dw_1 from wa_response`dw_1 within w_util_acumulador
int X=18
int Y=540
int Width=462
int Height=160
end type

type cb_cancelar from wa_response`cb_cancelar within w_util_acumulador
int X=1568
int Y=372
end type

type cb_aceptar from wa_response`cb_aceptar within w_util_acumulador
int X=1189
int Y=372
end type

type cbx_1 from checkbox within w_util_acumulador
int X=82
int Y=60
int Width=928
int Height=80
boolean BringToTop=true
string Text="Información de la fecha del sistema"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_2 from checkbox within w_util_acumulador
int X=82
int Y=156
int Width=928
int Height=80
boolean BringToTop=true
string Text="Información de la temporada"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from uo_cbother within w_util_acumulador
int X=1563
int Y=92
int TabOrder=10
boolean BringToTop=true
string Text="&Acumular"
boolean Default=true
end type

event clicked;dw_list.Retrieve( gd_sys, gd_sys )
end event

