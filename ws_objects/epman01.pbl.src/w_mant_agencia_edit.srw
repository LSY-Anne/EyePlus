$PBExportHeader$w_mant_agencia_edit.srw
forward
global type w_mant_agencia_edit from wa_mant_edit
end type
end forward

global type w_mant_agencia_edit from wa_mant_edit
int Width=2053
int Height=1244
WindowType WindowType=response!
boolean TitleBar=true
string Title="Agencia de Aduana - "
long BackColor=81324524
boolean ControlMenu=true
end type
global w_mant_agencia_edit w_mant_agencia_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function boolean wf_checkactioni ()
end prototypes

public function boolean wf_validareg ();String	ls_codigo, ls_newcod


ls_codigo = f_trim( dw_1.Object.c_codigo_aga[ 1])
dw_1.AcceptText( )

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el codigo ingresado no exista */
	If ls_codigo <> '' Then
		Select	v_nombre_aga
		Into 		:ls_newcod
		From		t_agencia_aduanal
		Where		c_codigo_aga = :ls_codigo ;
		If f_Trim( ls_newcod ) <> '' Then
			ls_codigo = ''
			MessageBox( Title, 'Código ingresado ya existe.~n~rPertenece a ' + ls_newcod + &
									'~r~n~r~nEl sistema generará el código.', Exclamation!)
		End If
	Else
		MessageBox( Title, 'Debe ingresar el código.' + '~r~n~r~nEl sistema generará el código.', Exclamation!)
	End If
	If ls_codigo = '' Then
		Select	Max( c_codigo_aga )
		Into 		:ls_newcod
		From		t_agencia_aduanal ;
		ls_newcod = f_Trim( ls_newcod )
		ls_newcod = Right( '00' + f_Trim( String( Integer( ls_newcod ) + 1 )), 2 )
		dw_1.Object.c_codigo_aga[ 1] = ls_newcod 
		Return False
	End If
End If

/* Validamos que campos mandatorios esten ingresados */
/* Descripcion */
if f_trim( dw_1.Object.v_nombre_aga[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar nombre/descripción.', Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo_aga' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'c_codigo_aga', 'v_nombre_aga', 'v_nomcom_aga', 'c_rfc_aga', &
				'c_origen_aga', 'v_direcc_aga', 'v_ciudad_aga', 'v_apapos_aga', &
				'v_codpos_aga', 'v_telef1_aga', 'v_telef2_aga', 'v_ptoemb_aga' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();Return wf_CheckActionE( )

end function

public function boolean wf_checkactioni ();
/* Asigna por default el mercado como origen, el usuario puede cambiarlo */
dw_1.Object.c_origen_aga[1] = gs_mercado

Return True

end function

on w_mant_agencia_edit.create
call super::create
end on

on w_mant_agencia_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_agencia_edit
int X=0
int Y=0
int Width=2048
int Height=1004
string DataObject="d_mant_agencia_edit"
end type

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_agencia_edit
int X=1641
int Y=1016
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_agencia_edit
int X=1266
int Y=1016
end type

