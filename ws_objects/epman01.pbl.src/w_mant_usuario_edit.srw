$PBExportHeader$w_mant_usuario_edit.srw
forward
global type w_mant_usuario_edit from wa_mant_edit
end type
end forward

global type w_mant_usuario_edit from wa_mant_edit
int Width=2002
int Height=688
boolean TitleBar=true
string Title="Usuario - "
long BackColor=79741120
end type
global w_mant_usuario_edit w_mant_usuario_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function integer wf_aceptar ()
end prototypes

public function boolean wf_validareg ();String	ls_codigo, ls_newcod


ls_codigo = f_trim( dw_1.Object.c_codigo_usu[ 1])
dw_1.AcceptText( )

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el codigo ingresado no exista */
	If ls_codigo <> '' Then
		Select	v_nombre_usu
		Into 		:ls_newcod
		From		t_usuario
		Where		c_codigo_usu = :ls_codigo ;
		If f_Trim( ls_newcod ) <> '' Then
			ls_codigo = ''
			MessageBox( Title, 'Identificador de usuario ingresado ya existe.' + &
									'~n~rPertenece a ' + ls_newcod + '.', Exclamation!)
		End If
	Else
		MessageBox( Title, 'Debe ingresar el Identificador de usuario .' , Exclamation!)
	End If
	If ls_codigo = '' Then
		Return False
	End If
End If

/* Validamos que campos mandatorios esten ingresados */
/* Descripcion */
If f_Trim( dw_1.Object.v_nombre_usu[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar nombre del usuario.', Exclamation!)
	Return False
End If

If f_Trim( dw_1.Object.v_passwo_usu[ 1]) <> f_Trim( dw_1.Object.v_passw2_usu[ 1]) Then
	MessageBox( Title, 'Password de confirmación es incorrecto.', Exclamation!)
	Return False
End If

If istr_parm.s_cad[ 1] = 'E' Then	/* insertar */
	If f_Trim( dw_1.Object.c_admin_usu[ 1])= '1' Then
		MessageBox( Title, 'El registro de un admisnistrador no puede ser eliminado.', Exclamation!)
		Return False
	End If
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo_usu' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'c_codigo_usu', 'v_nombre_usu', 'v_passwo_usu', 'v_passw2_usu' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();String	ls_acol[]

ls_acol[] = { 'c_codigo_eti', 'v_nombre_eti' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function integer wf_aceptar ();Long		ll_row
String	ls_msg

ll_row = dw_1.GetRow( )
If ll_row = 0 Then ll_row = dw_1.RowCount( )

dw_1.AcceptText( )

If Not wf_ValidaReg( ) Then
	Return 0
End If

If istr_parm.s_cad[1] = 'I' Then
	dw_1.Object.c_codcre_usu[ll_row] = gs_usuario
	dw_1.Object.d_creacion[ll_row] = Today( )
	dw_1.Object.c_activo[ll_row] = '1'
Else
	dw_1.Object.c_usumod[ll_row] = gs_usuario
	dw_1.Object.d_modifi[ll_row] = Today( )
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

on w_mant_usuario_edit.create
call super::create
end on

on w_mant_usuario_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_usuario_edit
int X=0
int Y=0
int Width=1979
string DataObject="d_mant_usuario_edit"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "cag_tipcag"
		If data = "P" Then				/* Tipo de Comision Porcentual */
			Object.Cag_Minimo[ 1] = 0	/* Montos Minimo */
			Object.Cag_Maximo[ 1] = 0	/* Montos Maximo */
		End If
	Case "cag_restri"
		If data = "0" Then				/* No restringido */
			Object.Cag_MonPro[ 1] = ""	/* Moneda de Restriccion */
		End If
End Choose
end event

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_usuario_edit
int X=1586
int Y=476
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_usuario_edit
int X=1211
int Y=476
end type

