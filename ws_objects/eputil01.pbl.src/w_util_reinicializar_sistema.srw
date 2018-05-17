$PBExportHeader$w_util_reinicializar_sistema.srw
forward
global type w_util_reinicializar_sistema from wa_response
end type
type st_1 from statictext within w_util_reinicializar_sistema
end type
type gb_1 from groupbox within w_util_reinicializar_sistema
end type
type cbx_1 from checkbox within w_util_reinicializar_sistema
end type
type cbx_2 from checkbox within w_util_reinicializar_sistema
end type
type cbx_3 from checkbox within w_util_reinicializar_sistema
end type
type cbx_4 from checkbox within w_util_reinicializar_sistema
end type
type cbx_5 from checkbox within w_util_reinicializar_sistema
end type
type cbx_6 from checkbox within w_util_reinicializar_sistema
end type
type cbx_7 from checkbox within w_util_reinicializar_sistema
end type
type cbx_8 from checkbox within w_util_reinicializar_sistema
end type
type cbx_9 from checkbox within w_util_reinicializar_sistema
end type
type cbx_10 from checkbox within w_util_reinicializar_sistema
end type
type cbx_11 from checkbox within w_util_reinicializar_sistema
end type
type p_2 from picture within w_util_reinicializar_sistema
end type
end forward

global type w_util_reinicializar_sistema from wa_response
int Width=1399
int Height=1540
boolean TitleBar=true
string Title="Reinicializar EyePlus"
long BackColor=81324524
st_1 st_1
gb_1 gb_1
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
cbx_5 cbx_5
cbx_6 cbx_6
cbx_7 cbx_7
cbx_8 cbx_8
cbx_9 cbx_9
cbx_10 cbx_10
cbx_11 cbx_11
p_2 p_2
end type
global w_util_reinicializar_sistema w_util_reinicializar_sistema

on w_util_reinicializar_sistema.create
int iCurrent
call super::create
this.st_1=create st_1
this.gb_1=create gb_1
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.cbx_5=create cbx_5
this.cbx_6=create cbx_6
this.cbx_7=create cbx_7
this.cbx_8=create cbx_8
this.cbx_9=create cbx_9
this.cbx_10=create cbx_10
this.cbx_11=create cbx_11
this.p_2=create p_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.cbx_1
this.Control[iCurrent+4]=this.cbx_2
this.Control[iCurrent+5]=this.cbx_3
this.Control[iCurrent+6]=this.cbx_4
this.Control[iCurrent+7]=this.cbx_5
this.Control[iCurrent+8]=this.cbx_6
this.Control[iCurrent+9]=this.cbx_7
this.Control[iCurrent+10]=this.cbx_8
this.Control[iCurrent+11]=this.cbx_9
this.Control[iCurrent+12]=this.cbx_10
this.Control[iCurrent+13]=this.cbx_11
this.Control[iCurrent+14]=this.p_2
end on

on w_util_reinicializar_sistema.destroy
call super::destroy
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.cbx_5)
destroy(this.cbx_6)
destroy(this.cbx_7)
destroy(this.cbx_8)
destroy(this.cbx_9)
destroy(this.cbx_10)
destroy(this.cbx_11)
destroy(this.p_2)
end on

event open;call super::open;
If f_ContarVentanas( ) > 0 Then
	MessageBox( Title, 'Debe cerrar todas las ventanas para poder continuar.', Exclamation! )
	Close( This )
	Return
End If
end event

type dw_list from wa_response`dw_list within w_util_reinicializar_sistema
int X=50
int Y=1364
int Width=142
int Height=100
int TabOrder=50
boolean Visible=false
end type

type dw_1 from wa_response`dw_1 within w_util_reinicializar_sistema
int X=247
int Y=1368
int Width=142
int Height=92
boolean Visible=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_util_reinicializar_sistema
int X=951
int Y=1316
int TabOrder=40
end type

type cb_aceptar from wa_response`cb_aceptar within w_util_reinicializar_sistema
int X=571
int Y=1316
int TabOrder=30
boolean Enabled=true
end type

event cb_aceptar::clicked;If Not MessageBox( Title, 'Este proceso eliminará la información de los ' + &
						'archivos marcados.~r~r¿Confirma reinicializar el sistema?', + &
						Exclamation!, YesNo!, 2 ) = 1 Then
	Return
End If

If cbx_1.Checked Then
	cbx_1.Enabled = False
	Delete From t_acumulado ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_acumulado' ) = -1 Then
		Return
	End If
	Delete From t_acumulado_empaque ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_acumulado_empaque' ) = -1 Then
		Return
	End If
End If

If cbx_2.Checked Then
	cbx_2.Enabled = False
	Delete From t_acumulado_empaque_diario ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_acumulado_empaque_diario' ) = -1 Then
		Return
	End If
	Delete From t_acumulado_producto_diario ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_acumulado_producto_diario' ) = -1 Then
		Return
	End If
End If

If cbx_3.Checked Then
	cbx_3.Enabled = False
	Delete From t_acumulado_producto_costo ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_acumulado_producto_costo' ) = -1 Then
		Return
	End If
End If

If cbx_4.Checked Then
	cbx_4.Enabled = False
	Delete From t_acumulado_mano_obra ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_acumulado_mano_obra' ) = -1 Then
		Return
	End If
End If

If cbx_5.Checked Then
	cbx_5.Enabled = False
	Delete From t_manifiesto ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_manifiesto' ) = -1 Then
		Return
	End If
End If

If cbx_6.Checked Then
	cbx_6.Enabled = False
	Delete From t_palet ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_palet' ) = -1 Then
		Return
	End If
End If
	
If cbx_7.Checked Then
	cbx_7.Enabled = False
	Delete From t_control_cierre ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_control_cierre' ) = -1 Then
		Return
	End If
End If

If cbx_8.Checked Then
	cbx_8.Enabled = False
	Delete From t_cultivo_acarreo ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_cultivo_acarreo' ) = -1 Then
		Return
	End If
	Delete From t_acarreo_general ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_acarreo_general' ) = -1 Then
		Return
	End If
End If

If cbx_9.Checked Then
	cbx_9.Enabled = False
	Delete From t_mano_obra ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_mano_obra' ) = -1 Then
		Return
	End If
	Delete From t_mano_obra_general ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_mano_obra_general' ) = -1 Then
		Return
	End If
End If

If cbx_10.Checked Then
	cbx_10.Enabled = False
	Delete From t_otro_movimiento ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_otro_movimiento' ) = -1 Then
		Return
	End If
End If

If cbx_11.Checked Then
	cbx_11.Enabled = False
	Delete From t_produccion_campo ;
	If f_SqlError( SqlCa, 'No se pudo eliminar información de la tabla t_produccion_campo' ) = -1 Then
		Return
	End If
End If

cb_cancelar.SetFocus( )
end event

type st_1 from statictext within w_util_reinicializar_sistema
int X=229
int Y=64
int Width=1093
int Height=108
boolean Enabled=false
boolean BringToTop=true
string Text="Este proceso es Irreversible y puede tardar, las demás sesiones de EyePlus deberán cerrarse"
boolean FocusRectangle=false
long TextColor=255
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_util_reinicializar_sistema
int X=41
int Y=20
int Width=1298
int Height=184
int TabOrder=20
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

type cbx_1 from checkbox within w_util_reinicializar_sistema
int X=96
int Y=236
int Width=1225
int Height=80
boolean BringToTop=true
string Text="Acumulado de Empaque y Embarque"
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

type cbx_2 from checkbox within w_util_reinicializar_sistema
int X=96
int Y=332
int Width=1225
int Height=80
boolean BringToTop=true
string Text="Acumulado de Costos"
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

type cbx_3 from checkbox within w_util_reinicializar_sistema
int X=96
int Y=428
int Width=1225
int Height=80
boolean BringToTop=true
string Text="Histórico de Costos (Archivo Diario)"
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

type cbx_4 from checkbox within w_util_reinicializar_sistema
int X=96
int Y=524
int Width=1225
int Height=80
boolean BringToTop=true
string Text="Acumulado de Mano de Obra"
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

type cbx_5 from checkbox within w_util_reinicializar_sistema
int X=96
int Y=620
int Width=1225
int Height=80
boolean BringToTop=true
string Text="Archivo de Manifiesto"
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

type cbx_6 from checkbox within w_util_reinicializar_sistema
int X=96
int Y=716
int Width=1225
int Height=80
boolean BringToTop=true
string Text="Archivo de Pallets"
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

type cbx_7 from checkbox within w_util_reinicializar_sistema
int X=96
int Y=812
int Width=1225
int Height=80
boolean BringToTop=true
string Text="Control de Cierres Diarios"
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

type cbx_8 from checkbox within w_util_reinicializar_sistema
int X=96
int Y=908
int Width=1225
int Height=80
boolean BringToTop=true
string Text="Archivo de Acarreo"
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

type cbx_9 from checkbox within w_util_reinicializar_sistema
int X=96
int Y=1004
int Width=1225
int Height=80
boolean BringToTop=true
string Text="Archivo de Mano de Obra"
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

type cbx_10 from checkbox within w_util_reinicializar_sistema
int X=96
int Y=1100
int Width=1225
int Height=80
boolean BringToTop=true
string Text="Archivo de Otros Movimientos (Sobrantes, Mermas)"
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

type cbx_11 from checkbox within w_util_reinicializar_sistema
int X=96
int Y=1196
int Width=1225
int Height=80
boolean BringToTop=true
string Text="Archivo de Producción de Campo"
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

type p_2 from picture within w_util_reinicializar_sistema
int X=69
int Y=52
int Width=142
int Height=128
boolean BringToTop=true
string PictureName="bwarning.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

