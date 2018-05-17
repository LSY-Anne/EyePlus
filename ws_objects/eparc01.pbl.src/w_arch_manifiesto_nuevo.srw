$PBExportHeader$w_arch_manifiesto_nuevo.srw
forward
global type w_arch_manifiesto_nuevo from wa_response
end type
type cbx_1 from checkbox within w_arch_manifiesto_nuevo
end type
type cb_abrir from uo_cbother within w_arch_manifiesto_nuevo
end type
type rb_1 from radiobutton within w_arch_manifiesto_nuevo
end type
type rb_2 from radiobutton within w_arch_manifiesto_nuevo
end type
type st_1 from statictext within w_arch_manifiesto_nuevo
end type
end forward

global type w_arch_manifiesto_nuevo from wa_response
int Width=1586
int Height=488
boolean TitleBar=true
string Title="Manifiesto Nuevo"
boolean ControlMenu=false
cbx_1 cbx_1
cb_abrir cb_abrir
rb_1 rb_1
rb_2 rb_2
st_1 st_1
end type
global w_arch_manifiesto_nuevo w_arch_manifiesto_nuevo

on w_arch_manifiesto_nuevo.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.cb_abrir=create cb_abrir
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cb_abrir
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.st_1
end on

on w_arch_manifiesto_nuevo.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cb_abrir)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_1)
end on

event open;call super::open;String	ls_ant

/* Segun el valor 2, si esta en E, es mercado extranjero o N nacional */
gs_mercado = f_GetParmValue( '2' )

If Not gs_mercado = 'N' Then rb_1.Checked = True Else rb_2.Checked = True 

/* Segun el valor 18, si esta en S, tomar los datos del manifiesto anterior */
ls_ant = f_GetParmValue( '18' )
If ls_ant = 'S' Then
	cbx_1.Checked = True
End If
end event

type dw_list from wa_response`dw_list within w_arch_manifiesto_nuevo
int X=69
int Y=216
int TabOrder=50
boolean Visible=false
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean VScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_arch_manifiesto_nuevo
int X=18
int Y=188
int Width=160
int Height=96
boolean Visible=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_arch_manifiesto_nuevo
int X=1115
int Y=264
int TabOrder=40
end type

type cb_aceptar from wa_response`cb_aceptar within w_arch_manifiesto_nuevo
int X=389
int Y=264
boolean Enabled=true
end type

event cb_aceptar::clicked;String	ls_mer = 'E'

If rb_2.Checked Then ls_mer = 'N' 

If cbx_1.Checked Then
	CloseWithReturn( Parent, 'S' + ls_mer )
Else
	CloseWithReturn( Parent, 'N' + ls_mer )
End If	
	
end event

type cbx_1 from checkbox within w_arch_manifiesto_nuevo
int X=114
int Y=148
int Width=1381
int Height=88
boolean BringToTop=true
string Text="&Copiar los datos del manifiesto anterior al manifiesto nuevo"
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

type cb_abrir from uo_cbother within w_arch_manifiesto_nuevo
int X=754
int Y=264
int TabOrder=30
boolean BringToTop=true
string Text="&Abrir"
end type

event clicked;CloseWithReturn( Parent, 'OPEN' )

end event

type rb_1 from radiobutton within w_arch_manifiesto_nuevo
int X=727
int Y=60
int Width=411
int Height=76
boolean BringToTop=true
string Text="&Extranjero"
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

type rb_2 from radiobutton within w_arch_manifiesto_nuevo
int X=1175
int Y=60
int Width=293
int Height=76
boolean BringToTop=true
string Text="&Nacional"
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

type st_1 from statictext within w_arch_manifiesto_nuevo
int X=114
int Y=64
int Width=603
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Manifiesto para el mercado:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

