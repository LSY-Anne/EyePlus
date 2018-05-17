$PBExportHeader$wa_mant_edit.srw
$PBExportComments$Ancestro, Ventana de Edicion
forward
global type wa_mant_edit from window
end type
type dw_1 from datawindow within wa_mant_edit
end type
type cb_cancelar from uo_cbcancelar within wa_mant_edit
end type
type cb_aceptar from uo_cbaceptar within wa_mant_edit
end type
end forward

global type wa_mant_edit from window
integer x = 1056
integer y = 484
integer width = 1783
integer height = 808
boolean titlebar = true
long backcolor = 81254359
dw_1 dw_1
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
end type
global wa_mant_edit wa_mant_edit

type variables
s_parm istr_parm
String is_ts, is_cols[]
wa_mant iw_mant
end variables

forward prototypes
public function integer wf_aceptar ()
public function boolean wf_validareg ()
public function boolean wf_checkaction ()
public function boolean wf_checkactioni ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactiona ()
public subroutine wf_imprimir ()
public subroutine wf_colenabled (string as_acol[], boolean ab_enabled)
public function integer wf_postupdate ()
public function long wf_retrievelist ()
public function boolean wf_postopen ()
public function boolean wf_valkeyenter ()
end prototypes

public function integer wf_aceptar ();Long		ll_row
String	ls_msg

ll_row = dw_1.GetRow( )
If ll_row = 0 Then ll_row = dw_1.RowCount( )

dw_1.AcceptText( )

If istr_parm.s_cad[1] = 'I' Or istr_parm.s_cad[1] = 'M' Then
	If KeyDown( KeyEnter! ) Then
		If Not wf_ValKeyEnter( ) Then
			dw_1.SetFocus( )
			Return 0
		End If
	End If
End If

If Not wf_ValidaReg( ) Then
	Return 0
End If

If istr_parm.s_cad[1] = 'I' Then
	dw_1.Object.c_codigo_usu[ll_row] = gs_usuario
	//Appeon comment bengin
	//dw_1.Object.d_creacion[ll_row] = DateTime(Today( ))
	//dw_1.Object.d_creacion[ll_row] = DateTime(date(Today( )),time(now()))
	dw_1.Object.d_creacion[ll_row] = DateTime(date(string(Today( ),'dd/mm/yyyy')),time(now()))
	//appeon comment end	
	dw_1.Object.c_activo[ll_row] = '1'
Else
	dw_1.Object.c_usumod[ll_row] = gs_usuario
	//
	//dw_1.Object.d_modifi[ll_row] = DateTime(Today( ))
	dw_1.Object.d_modifi[ll_row] = DateTime(date(string(Today( ),'dd/mm/yyyy')),time(now()))
	//
	If istr_parm.s_cad[1] = 'E' Then
		dw_1.Object.c_activo[ll_row] = '0'
	ElseIf istr_parm.s_cad[1] = 'R' Then
		dw_1.Object.c_activo[ll_row] = '1'
	End If	
End If	

dw_1.AcceptText( )

If dw_1.Update( ) = 1 Then
	Choose Case istr_parm.s_cad[1]
		Case 'A' 
			ls_msg = 'autorizado'
		Case 'I'
			ls_msg = 'insertado'
		Case 'M'
			ls_msg = 'modificado'
		Case 'E'
			ls_msg = 'eliminado'
		Case 'R'
			ls_msg = 'recuperado'
	End Choose
	If wf_PostUpdate( ) = 1 Then
		Commit Using SqlCa ;
		wf_Imprimir( )
		If wf_RetrieveList( ) > 0 Then
			istr_parm.dw_dat[1].ScrollToRow( istr_parm.n_num[1] )
		End If
		MessageBox( Title, 'El registro ha sido ' + ls_msg + '.' )
	Else
		RollBack Using SqlCa ;
		MessageBox( Title, 'wf_PostUpdate: El registro no ha sido guardado.', StopSign! )
	End If
Else
	RollBack Using SqlCa ;
	MessageBox( Title, 'El registro no ha sido guardado.', StopSign! )
End If


Close( This )
Return 1
end function

public function boolean wf_validareg ();Return True
end function

public function boolean wf_checkaction ();/* wf_CheckAction( ) */
Boolean lb_ret

Choose Case istr_parm.s_cad[1] 
	Case 'I' /* Inserta */
		lb_ret = wf_CheckActionI( )
	Case 'M' /* Modifica */
		lb_ret = wf_CheckActionM( )
	Case 'E' /* Elimina */
		lb_ret = wf_CheckActionE( )
	Case 'R' /* Recupera */
		lb_ret = wf_CheckActionR( )
	Case 'A' /* Autorizar */
		lb_ret = wf_CheckActionA( )
End Choose

If lb_ret Then
	lb_ret = wf_PostOpen( )
End If

Return lb_ret
end function

public function boolean wf_checkactioni ();Return True
end function

public function boolean wf_checkactione ();Return True
end function

public function boolean wf_checkactionr ();Return True
end function

public function boolean wf_checkactionm ();Return True
end function

public function boolean wf_checkactiona ();Return True
end function

public subroutine wf_imprimir ();Return
end subroutine

public subroutine wf_colenabled (string as_acol[], boolean ab_enabled);Integer	i

For i = 1 To UpperBound( as_acol[] )
	f_ColEnabled( dw_1, as_acol[i], ab_enabled )
Next

end subroutine

public function integer wf_postupdate ();/* wf_PostUpdate( ) */

Return 1
end function

public function long wf_retrievelist ();If UpperBound( istr_parm.dw_dat[ ] ) > 0 Then
	Return istr_parm.dw_dat[ 1].Retrieve( gs_codtem)
End If

Return 0



end function

public function boolean wf_postopen ();Return True
end function

public function boolean wf_valkeyenter ();/* wf_ValKeyEnter( ) */

Return True
end function

on wa_mant_edit.create
this.dw_1=create dw_1
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.Control[]={this.dw_1,&
this.cb_cancelar,&
this.cb_aceptar}
end on

on wa_mant_edit.destroy
destroy(this.dw_1)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
end on

event open;window iw_mant2
String	ls_title

istr_parm = Message.PowerObjectParm

f_CenterWindow( This )

If Not IsValid( istr_parm ) Then
	MessageBox( Title, 'No se pudo obtener valores del parámetro.', StopSign!)
	Close( This )
	Return
End If

Choose Case istr_parm.s_cad[1] 
	Case 'I' /* Inserta */
		dw_1.InsertRow( 0 )
		ls_title = 'Adicionar'
	Case 'M' /* Modifica */
		dw_1.Retrieve( istr_parm.s_cad[2] )
		f_ColEnabled( dw_1, 'codigo', False )
		ls_title = 'Modificar'
	Case 'E' /* Elimina */
		dw_1.Retrieve( istr_parm.s_cad[2] )
		dw_1.Enabled = False
		ls_title = 'Eliminar'
		If Not cb_aceptar.Enabled Then
			cb_aceptar.Enabled = True
		End If
	Case 'R' /* Recupera */
		dw_1.Retrieve( istr_parm.s_cad[2] )
		dw_1.Enabled = False
		ls_title = 'Recuperar'
		If Not cb_aceptar.Enabled Then
			cb_aceptar.Enabled = True
		End If
	Case 'A' /* Autorizar */
		dw_1.Retrieve( istr_parm.s_cad[2] )
		dw_1.Enabled = False
		ls_title = 'Autorizar'
		If Not cb_aceptar.Enabled Then
			cb_aceptar.Enabled = True
		End If
	Case Else
		MessageBox( Title, 'Valor del parámetro desconocido.', StopSign!)
		Close( This )
		Return
End Choose

Title = Title + ls_title


iw_mant2 = gw_frame.GetActiveSheet( )

wf_CheckAction( )
end event

event close;
/* Restablece control de ventana-lista que invoca */
If UpperBound( istr_parm.w_win[ ] ) > 0 Then
	istr_parm.w_win[ 1].Enabled = True
End If

end event

type dw_1 from datawindow within wa_mant_edit
integer x = 64
integer y = 44
integer width = 1605
integer height = 472
integer taborder = 10
boolean border = false
boolean livescroll = true
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

event dberror;//Row changed between retrieve and update

s_parm	lstr_parm


lstr_parm.s_cad[1] = SqlCa.DataBase
lstr_parm.s_cad[2] = DataObject
lstr_parm.s_cad[3] = String( SqlDBCode )
lstr_parm.s_cad[4] = SqlErrText + '~r~n~r~nSQL Syntax: ' + sqlsyntax

RollBack ;
OpenWithParm( w_sqlerror, lstr_parm )

Return 1

end event

type cb_cancelar from uo_cbcancelar within wa_mant_edit
integer x = 1321
integer y = 548
integer taborder = 30
end type

event clicked;If UpperBound( istr_parm.w_win[ ] ) > 0 Then
	istr_parm.w_win[1].Enabled = True
End If
Close( Parent )
end event

type cb_aceptar from uo_cbaceptar within wa_mant_edit
integer x = 942
integer y = 548
integer taborder = 20
boolean enabled = false
end type

event clicked;wf_Aceptar( )

end event

