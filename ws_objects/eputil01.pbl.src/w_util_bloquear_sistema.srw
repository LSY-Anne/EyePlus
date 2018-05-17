$PBExportHeader$w_util_bloquear_sistema.srw
forward
global type w_util_bloquear_sistema from Window
end type
type sle_3 from singlelineedit within w_util_bloquear_sistema
end type
type st_4 from statictext within w_util_bloquear_sistema
end type
type st_3 from statictext within w_util_bloquear_sistema
end type
type st_2 from statictext within w_util_bloquear_sistema
end type
type sle_2 from singlelineedit within w_util_bloquear_sistema
end type
type cb_cancelar from uo_cbcancelar within w_util_bloquear_sistema
end type
type cb_aceptar from uo_cbaceptar within w_util_bloquear_sistema
end type
end forward

global type w_util_bloquear_sistema from Window
int X=1056
int Y=484
int Width=1358
int Height=800
boolean TitleBar=true
string Title="Acceso Restringido"
long BackColor=80269524
WindowType WindowType=response!
sle_3 sle_3
st_4 st_4
st_3 st_3
st_2 st_2
sle_2 sle_2
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
end type
global w_util_bloquear_sistema w_util_bloquear_sistema

type variables
String ls_ok='0'
end variables

on w_util_bloquear_sistema.create
this.sle_3=create sle_3
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.sle_2=create sle_2
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.Control[]={this.sle_3,&
this.st_4,&
this.st_3,&
this.st_2,&
this.sle_2,&
this.cb_cancelar,&
this.cb_aceptar}
end on

on w_util_bloquear_sistema.destroy
destroy(this.sle_3)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_2)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
end on

event open;f_CenterWindow( This )
sle_3.Text = gs_usuario
end event

event closequery;If ls_ok='1' Then
	Return 0
End If

Return 1
end event

type sle_3 from singlelineedit within w_util_bloquear_sistema
int X=393
int Y=220
int Width=910
int Height=92
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_util_bloquear_sistema
int X=101
int Y=228
int Width=283
int Height=76
boolean Enabled=false
string Text="&Usuario"
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

type st_3 from statictext within w_util_bloquear_sistema
int X=41
int Y=36
int Width=1271
int Height=120
boolean Enabled=false
string Text="Para poder continuar con el proceso seleccionado debera ingresar la contraseña de acceso"
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

type st_2 from statictext within w_util_bloquear_sistema
int X=101
int Y=412
int Width=283
int Height=76
boolean Enabled=false
string Text="&Contraseña"
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

type sle_2 from singlelineedit within w_util_bloquear_sistema
int X=393
int Y=404
int Width=910
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Accelerator=99
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancelar from uo_cbcancelar within w_util_bloquear_sistema
int X=955
int Y=384
int TabOrder=30
boolean Visible=false
end type

event clicked;If IsValid( w_app_frame ) Then
	Close( w_app_frame ) 
End If

Close( Parent )
end event

type cb_aceptar from uo_cbaceptar within w_util_bloquear_sistema
int X=960
int Y=568
int TabOrder=20
string Text="Desbloquear"
end type

event clicked;DateTime	ld_hoy
Long		ll_count
String	ls_pass, ls_error, ls_pcname


Select	v_passwo_usu
Into 	  :ls_pass
From		assusuario
Where		c_codigo_usu = :gs_usuario;
If SqlCa.SqlCode <> 0 Then
	MessageBox( Title, 'Acceso Denegado. Reintente.', Exclamation!)
	sle_2.SetFocus( )
	Return
End If

If Upper( f_Trim( ls_pass ) ) <> Upper( f_Trim( sle_2.Text ) ) Then
	MessageBox( Title, 'Acceso Denegado. Reintente.', Exclamation!)
	sle_2.SetFocus( )
	Return
End If

ls_ok='1'

CloseWithReturn( Parent, '1' )


end event

