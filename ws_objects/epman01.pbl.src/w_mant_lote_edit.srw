$PBExportHeader$w_mant_lote_edit.srw
forward
global type w_mant_lote_edit from wa_mant_edit
end type
end forward

global type w_mant_lote_edit from wa_mant_edit
int Width=2322
int Height=1488
boolean TitleBar=true
string Title="Lote - "
long BackColor=79741120
end type
global w_mant_lote_edit w_mant_lote_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function boolean wf_checkactioni ()
end prototypes

public function boolean wf_validareg ();String	ls_codigo, ls_newcod, ls_cul


dw_1.AcceptText( )
ls_codigo = f_trim( dw_1.Object.c_codigo_lot[ 1])
ls_cul = f_trim( dw_1.Object.c_codigo_cul[ 1])
If ls_cul = '' Then
	MessageBox( Title, 'Debe seleccionar el cultivo.', Exclamation!)
	Return False
End If


If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	dw_1.Object.c_codigo_tem[ 1] = gs_codtem 
	/* validamos que el codigo ingresado no exista */
	If ls_codigo <> '' Then
		Select	v_nombre_lot
		Into 		:ls_newcod
		From		t_lote
		Where		c_codigo_lot = :ls_codigo
		And		c_codigo_tem = :gs_codtem ;
		If f_Trim( ls_newcod ) <> '' Then
			ls_codigo = ''
			MessageBox( Title, 'Código ingresado ya existe.~n~rPertenece a ' + ls_newcod + &
									'~r~n~r~nEl sistema generará el código en base al cultivo.', Exclamation!)
		End If
	Else
		MessageBox( Title, 'Debe ingresar el código.' + &
							'~r~n~r~nEl sistema generará el código en base al cultivo.', Exclamation!)
	End If
	If ls_codigo = '' Then
		Select	Max( c_codigo_lot )
		Into 		:ls_newcod
		From		t_lote
		Where		c_codigo_tem = :gs_codtem 
		And		c_codigo_cul = :ls_cul ;
		ls_newcod = Right( f_Trim( ls_newcod ), 2 )
		ls_newcod = ls_cul + Right( '00' + String( Integer( ls_newcod ) + 1 ), 2 )
		dw_1.Object.c_codigo_lot[ 1] = ls_newcod 
		Return False
	End If
End If

/* Validamos que campos mandatorios esten ingresados */
/* Descripcion */
If f_trim( dw_1.Object.v_nombre_lot[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar nombre/descripción.', Exclamation!)
	Return False
End If

If f_trim( dw_1.Object.c_tipo_lot[ 1])= '' Then
	MessageBox( Title, 'Debe seleccionar el tipo de lote.', Exclamation!)
	Return False
End If

If f_trim( dw_1.Object.c_codigo_eta[ 1])= '' Then
	MessageBox( Title, 'Debe seleccionar la etapa.', Exclamation!)
	Return False
End If

If dw_1.Object.d_inicio_lot[ 1] > dw_1.Object.d_cierre_lot[ 1] Then
	MessageBox( Title, 'La fecha de inicio no puede ser mayor a la fecha de cierre.', Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo_lot' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = {	'c_codigo_lot', 'v_nombre_lot', 'c_tipo_lot', 'n_superf_lot', &
					'c_codigo_cul', 'c_codigo_eta', 'd_inicio_lot', 'd_cierre_lot', &
					'd_1ercor_lot', 'n_bulhae_lot', 'n_bulhan_lot', 'd_planteo_lot', &
					'n_pladiasini_lot', 'n_pladiascor_lot', 'n_diascorcie_lot', &
					'c_codigo_var', 'c_codigo_cam', 'v_target_lot' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();
Return wf_CheckActionE( )

end function

public function boolean wf_checkactioni ();dw_1.Object.c_codigo_tem[ 1] = gs_codtem 
Return True
end function

on w_mant_lote_edit.create
call super::create
end on

on w_mant_lote_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_lote_edit
int X=0
int Y=0
int Width=2304
int Height=1220
string DataObject="d_mant_lote_edit"
end type

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_lote_edit
int X=1902
int Y=1244
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_lote_edit
int X=1527
int Y=1244
end type

