$PBExportHeader$w_util_temporada_inicia.srw
forward
global type w_util_temporada_inicia from wa_response
end type
type cb_fin from uo_cbdate within w_util_temporada_inicia
end type
type em_fin from uo_editmask within w_util_temporada_inicia
end type
type st_2 from statictext within w_util_temporada_inicia
end type
type cb_ini from uo_cbdate within w_util_temporada_inicia
end type
type em_ini from uo_editmask within w_util_temporada_inicia
end type
type st_1 from statictext within w_util_temporada_inicia
end type
end forward

global type w_util_temporada_inicia from wa_response
int Width=1723
int Height=628
boolean TitleBar=true
string Title="Iniciar Temporada"
cb_fin cb_fin
em_fin em_fin
st_2 st_2
cb_ini cb_ini
em_ini em_ini
st_1 st_1
end type
global w_util_temporada_inicia w_util_temporada_inicia

on w_util_temporada_inicia.create
int iCurrent
call super::create
this.cb_fin=create cb_fin
this.em_fin=create em_fin
this.st_2=create st_2
this.cb_ini=create cb_ini
this.em_ini=create em_ini
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_fin
this.Control[iCurrent+2]=this.em_fin
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.cb_ini
this.Control[iCurrent+5]=this.em_ini
this.Control[iCurrent+6]=this.st_1
end on

on w_util_temporada_inicia.destroy
call super::destroy
destroy(this.cb_fin)
destroy(this.em_fin)
destroy(this.st_2)
destroy(this.cb_ini)
destroy(this.em_ini)
destroy(this.st_1)
end on

event open;call super::open;dw_1.InsertRow(0)
end event

type dw_list from wa_response`dw_list within w_util_temporada_inicia
int X=41
int Y=544
int TabOrder=60
boolean Visible=false
end type

type dw_1 from wa_response`dw_1 within w_util_temporada_inicia
int X=0
int Y=0
int Width=1275
int Height=264
string DataObject="d_util_temporada_inicia"
end type

event dw_1::itemchanged;call super::itemchanged;cb_aceptar.Enabled = True
end event

type cb_cancelar from wa_response`cb_cancelar within w_util_temporada_inicia
int Y=156
int TabOrder=50
end type

event cb_cancelar::clicked;CloseWithReturn( Parent, '0' )
end event

type cb_aceptar from wa_response`cb_aceptar within w_util_temporada_inicia
int X=1321
int Y=36
int TabOrder=40
end type

event cb_aceptar::clicked;String	ls_newcod, ls_mdo 


dw_1.AcceptText( )

dw_1.SetFocus( )

If f_Trim( dw_1.Object.v_nombre_tem[1] ) = '' Then
	MessageBox( Parent.Title, 'Debe ingresar el nombre/descripción de la nueva temporada.', Exclamation! )
	Return
End If
	
ls_mdo = f_Trim( dw_1.Object.c_mercado[1] )
If ls_mdo = '' Then
	MessageBox( Parent.Title, 'Debe seleccionar el mercado por default de a temporada.', Exclamation! )
	Return
End If

em_ini.SetFocus( )

dw_1.Object.d_inicio_tem[1] = f_StringToDate( em_ini.Text )
dw_1.Object.d_fin_tem[1] = f_StringToDate( em_fin.Text )
If Year( Date(dw_1.Object.d_inicio_tem[1]) ) = 1900 Then
	MessageBox( Parent.Title, 'La fecha de inicio y/o fin de temporada es incorrecta.', Exclamation! )
	Return
End If
	
If ( dw_1.Object.d_fin_tem[1] ) > ( dw_1.Object.d_fin_tem[1] ) Then
	MessageBox( Parent.Title, 'El inicio de la nueva temporada no puede ser mayor al fin.', Exclamation! )
	Return
End If

If MessageBox( Parent.Title, 'Esta seguro de realizar el proceso?', Question!, YesNo! ) <> 1 Then
	Return
End If

Beep(1)
Beep(1)
Beep(1)
If MessageBox( Parent.Title, 'Este proceso generara una nueva temporada ' + &
					'quedando la anterior solo de consulta~r~n~r~n' + &
					'Confirma continuar?', Question!, YesNo! ) <> 1 Then
	Return
End If

Select	Max( c_codigo_tem )
Into 		:ls_newcod
From		t_temporada ;

ls_newcod = f_Trim( ls_newcod )
ls_newcod = Right( '00' + f_Trim( String( Integer( ls_newcod ) + 1 )), 2 )
dw_1.Object.c_codigo_tem[ 1] = ls_newcod 
		
		

dw_1.Object.c_codigo_usu[1] = gs_usuario
dw_1.Object.d_creacion_tem[1] = Today( )
dw_1.Object.c_activo_tem[1] = '1' /* Establece la temporada vigente */

dw_1.AcceptText( )

Update	t_temporada
Set		c_activo_tem = '0' ;
If f_SqlError( SqlCa, 'No se puede actualizar tabla t_temporada' ) <> 1 Then Return

Update	t_parametro
Set		v_valor_par = :ls_newcod
Where		c_codigo_par = '001' ;
If f_SqlError( SqlCa, 'No se puede actualizar tabla t_parametro codigo 001' ) <> 1 Then Return

Update	t_parametro
Set		v_valor_par = :ls_mdo
Where		c_codigo_par = '002' ;
If f_SqlError( SqlCa, 'No se puede actualizar tabla t_parametro codigo 001' ) <> 1 Then Return

If dw_1.Update( ) = 1 Then
	Commit ;
Else
	RollBack ;
	MessageBox( Parent.Title, 'No se pudo generar nueva temporada.', Exclamation! )
	Return
End If

gs_codtem = ls_newcod
gs_temporada = dw_1.Object.v_nombre_tem[1]
cb_cancelar.Text = 'Cerrar'
cb_cancelar.SetFocus( )
This.Enabled = False

wf_ColEnabled( { 'v_nombre_tem', 'c_mercado' }, False )
em_ini.Enabled = False
em_fin.Enabled = False
cb_ini.Enabled = False
cb_fin.Enabled = False

MessageBox( Parent.Title, 'El sistema se cerrará para terminar de actualizar los registros.', Exclamation! )
Halt Close

end event

type cb_fin from uo_cbdate within w_util_temporada_inicia
int X=622
int Y=424
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type em_fin from uo_editmask within w_util_temporada_inicia
int X=274
int Y=420
int TabOrder=30
end type

type st_2 from statictext within w_util_temporada_inicia
int X=50
int Y=424
int Width=73
int Height=76
boolean Enabled=false
string Text="Al:"
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

type cb_ini from uo_cbdate within w_util_temporada_inicia
int X=622
int Y=292
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type em_ini from uo_editmask within w_util_temporada_inicia
int X=274
int Y=288
int TabOrder=20
end type

type st_1 from statictext within w_util_temporada_inicia
int X=50
int Y=292
int Width=119
int Height=76
boolean Enabled=false
string Text="Del:"
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

