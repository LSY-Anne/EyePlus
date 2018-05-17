$PBExportHeader$w_util_parametro.srw
forward
global type w_util_parametro from wa_mant_edit
end type
type cb_aplicar from uo_cbother within w_util_parametro
end type
type cb_adicionar from uo_cbother within w_util_parametro
end type
type st_nota from statictext within w_util_parametro
end type
type p_nota from picture within w_util_parametro
end type
type gb_1 from groupbox within w_util_parametro
end type
type cb_1 from uo_cbother within w_util_parametro
end type
end forward

global type w_util_parametro from wa_mant_edit
int Width=2235
int Height=1368
WindowType WindowType=response!
boolean TitleBar=true
string Title="Opciones"
long BackColor=79741120
boolean ControlMenu=true
cb_aplicar cb_aplicar
cb_adicionar cb_adicionar
st_nota st_nota
p_nota p_nota
gb_1 gb_1
cb_1 cb_1
end type
global w_util_parametro w_util_parametro

type variables
datetime id_fec
end variables

forward prototypes
public function boolean wf_aplicar ()
public function integer wf_aceptar ()
end prototypes

public function boolean wf_aplicar ();Integer	i
datetime ld_fec, ld_nvafec, ld_fecvja
String	ls_valor, ls_mess, ls_par, ls_fecnva
long ll_mov
dw_1.AcceptText()
For i = 1 To dw_1.RowCount( )
	ls_valor = f_Trim( dw_1.Object.v_valor_par[ i] )
	Choose Case String( Long(dw_1.Object.c_codigo_par[ i]), '000')
		Case '001'
		Case '002'
			If ls_valor <> 'N' And ls_valor <> 'E' Then
				ls_mess = 'Mercado Default debe ser "E" o "N"'
			End If
		Case '003'
			If Long(ls_valor) <=0 Then
				ls_mess = 'Codigo de Empresa debe ser un numero entero.'
			End If
		Case '004'
			If f_Trim(ls_valor) = '' Then
				ls_mess = 'Debe Ingresar el Nombre de Empresa.'
			End If
		Case '013'
			If Not IsNumber(f_Trim(ls_valor)) Then
				ls_mess = 'Este Dato debe ser numerico.'
			End If
		Case '015'
			If Not IsNumber(f_Trim(ls_valor)) Then
				ls_mess = 'Este Dato debe ser numerico.'
			End If
		Case '016'
			If Not IsNumber(f_Trim(ls_valor)) Then
				ls_mess = 'Este Dato debe ser numerico.'
			End If
		Case '020'
			Select v_valor_par
			Into  :ls_par
			From   nomparametro
			Where  c_codigo_par = '017'
			Using  SqlCa;
			
			If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla nomparametro.' ) = -1 Then
				Return False
			End If
			
			If ls_par <> 'M' Then  //calculo regresivo para TERRAMARA
				If Not id_fec = f_stringtodate(f_Trim(ls_valor)) then
			  		ld_nvafec =	f_stringtodate(f_Trim(ls_valor))
					
					select d_inicio_tem
					into :ld_fecvja
					from t_temporada (nolock)
					where c_activo_tem = 1
					Using  SqlCa;
			
					If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_temporada.' ) = -1 Then
						Return False
					End If
					
					if ld_nvafec > ld_fecvja then
						
						select count(p.d_empaque_pal)
						into :ll_mov
						from t_palet p (nolock),
							  t_temporada t (nolock)
						where p.d_empaque_pal between t.d_inicio_tem and t.d_fin_tem
						and   t.c_activo_tem = '1'
						using sqlca;
						
						If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_palet (select).' ) = -1 Then
							Return False
						End If
						  
						if f_zero(ll_mov) <> 0 then
							MessageBox( Title, 'La Fecha de Operacion No Puede Ser Cambiada.', StopSign! )
							dw_1.Object.v_valor_par[ i] = String( Date(id_fec), 'dd/mm/yyyy')
							dw_1.AcceptText()
							Return False
						Else
							MessageBox( Title, 'La Fecha de Operacion se ha cambiado.', exclamation! )
							ls_fecnva = string(f_stringtodate(f_trim(ls_valor)), 'dd/mm/yyyy')
							dw_1.Object.v_valor_par[ i] = ls_fecnva
							dw_1.AcceptText()
							
							update t_parametro
							set v_valor_par = :ls_fecnva
							where c_codigo_par = '020'
							using sqlca;
						
							If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_parametro (update).' ) = -1 Then
								Return False
							End If
							
							Return true
						End if
					Else
						MessageBox( Title, 'La Fecha de Operacion No Puede Ser menor que la fecha de inicio de la temporada activa.', StopSign! )
						dw_1.Object.v_valor_par[ i] = String( Date(id_fec), 'dd/mm/yyyy')
						dw_1.AcceptText()
						Return False
					End if	
			 	End If
			Else
			 	If id_fec > f_stringtodate(f_Trim(ls_valor)) then
			  		MessageBox( Title, 'La Fecha de Operacion No Puede Ser Menor.', StopSign! )
			  		dw_1.Object.v_valor_par[i] = String( Date(id_fec), 'dd/mm/yyyy')
			  		dw_1.AcceptText()
			  	Return False
			 	End If
			End If
	End Choose
Next

dw_1.AcceptText( )
If dw_1.Update( ) = 1 Then
	Commit Using SqlCa ;
Else
	RollBack Using SqlCa ;
	MessageBox( Title, 'Los cambios no han sido guardados.', StopSign! )
	Return False
End If

cb_aplicar.Enabled = False

Return True
end function

public function integer wf_aceptar ();If wf_Aplicar( ) Then
	Close( This )
	Return 1
Else
	Return -1
End If
end function

on w_util_parametro.create
int iCurrent
call super::create
this.cb_aplicar=create cb_aplicar
this.cb_adicionar=create cb_adicionar
this.st_nota=create st_nota
this.p_nota=create p_nota
this.gb_1=create gb_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aplicar
this.Control[iCurrent+2]=this.cb_adicionar
this.Control[iCurrent+3]=this.st_nota
this.Control[iCurrent+4]=this.p_nota
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.cb_1
end on

on w_util_parametro.destroy
call super::destroy
destroy(this.cb_aplicar)
destroy(this.cb_adicionar)
destroy(this.st_nota)
destroy(this.p_nota)
destroy(this.gb_1)
destroy(this.cb_1)
end on

event open;
istr_parm.w_win[1] = gw_frame

f_CenterWindow( This )

dw_1.SetTransObject( SqlCa )
dw_1.Retrieve( )

id_fec = f_stringtodate(f_getparmvalue('020'))
end event

event closequery;SetProfileString( gs_ini, 'System', 'CerrarModoPrevio', f_GetParmValue('25') )


gw_frame.wf_GetDefault( )
end event

type dw_1 from wa_mant_edit`dw_1 within w_util_parametro
int X=32
int Y=24
int Width=2149
int Height=940
string DataObject="d_util_parametro"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

event dw_1::itemchanged;call super::itemchanged;/* Validar que no se cambie la fecha */
//datetime ld_fec

//ld_fec = f_stringtodate(f_Trim( dw_1.Object.v_valor_par[ 019] ))
//If Not id_fec = ld_fec then
//	MessageBox( Title, 'La Fecha de Operacion No Puede Ser Cambiada.', StopSign! )
//   cb_aplicar.enabled = False
//	Return
//End If
/* Asigna el usuario activo */
If f_Trim( This.Object.c_codigo_usu[row] ) = '' Then
	This.Object.c_codigo_usu[row] = gs_usuario
	This.Object.d_creacion_par[row] = DateTime( Today( ) )
	This.Object.c_activo_par[row] = '1'
Else
	This.Object.c_usumod_par[row] = gs_usuario
	This.Object.d_modifi_par[row] = DateTime( Today( ) )
	This.Object.c_activo_par[row] = '1'
End If


end event

event dw_1::editchanged;call super::editchanged;
cb_aceptar.Enabled = True
cb_aplicar.Enabled = True
end event

type cb_cancelar from wa_mant_edit`cb_cancelar within w_util_parametro
int X=1829
int Y=1004
int TabOrder=60
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_util_parametro
int X=1097
int Y=1004
int TabOrder=40
end type

type cb_aplicar from uo_cbother within w_util_parametro
int X=1463
int Y=1004
int TabOrder=50
boolean Enabled=false
boolean BringToTop=true
string Text="&Aplicar"
end type

event clicked;
wf_Aplicar( )
end event

type cb_adicionar from uo_cbother within w_util_parametro
int X=366
int Y=1004
int TabOrder=20
boolean BringToTop=true
string Text="A&dicionar"
end type

event clicked;dw_1.InsertRow(0)
dw_1.SetFocus( )
dw_1.SetRow( dw_1.RowCount() )
dw_1.ScrollToRow( dw_1.RowCount() )
end event

type st_nota from statictext within w_util_parametro
int X=151
int Y=1152
int Width=1911
int Height=80
boolean Enabled=false
string Text="Después de realizar los cambios debe cerrar y reiniciar el sistema para que se efectuen"
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

type p_nota from picture within w_util_parametro
int X=69
int Y=1148
int Width=73
int Height=56
string PictureName="nota.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type gb_1 from groupbox within w_util_parametro
int X=37
int Y=1104
int Width=2139
int Height=136
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

type cb_1 from uo_cbother within w_util_parametro
int X=731
int Y=1004
int TabOrder=30
boolean BringToTop=true
string Text="A&vanzada..."
end type

event clicked;Open( w_util_configuracion_avanzada )
end event

