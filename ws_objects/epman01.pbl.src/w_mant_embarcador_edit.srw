$PBExportHeader$w_mant_embarcador_edit.srw
forward
global type w_mant_embarcador_edit from wa_mant_edit
end type
end forward

global type w_mant_embarcador_edit from wa_mant_edit
int Width=2053
int Height=1244
boolean TitleBar=true
string Title="Embarcador - "
long BackColor=79741120
end type
global w_mant_embarcador_edit w_mant_embarcador_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
end prototypes

public function boolean wf_validareg ();String	ls_codigo, ls_newcod


ls_codigo = f_trim( dw_1.Object.c_codigo_emb[ 1])
dw_1.AcceptText( )

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el codigo ingresado no exista */
	If ls_codigo <> '' Then
		Select	v_nombre_emb
		Into 		:ls_newcod
		From		t_embarcador
		Where		c_codigo_emb = :ls_codigo ;
		If f_Trim( ls_newcod ) <> '' Then
			ls_codigo = ''
			MessageBox( Title, 'Código ingresado ya existe.~n~rPertenece a ' + ls_newcod + &
									'~r~n~r~nEl sistema generará el código.', Exclamation!)
		End If
	Else
		MessageBox( Title, 'Debe ingresar el código.' + '~r~n~r~nEl sistema generará el código.', Exclamation!)
	End If
	If ls_codigo = '' Then
		Select	Max( c_codigo_emb )
		Into 		:ls_newcod
		From		t_embarcador ;
		ls_newcod = f_Trim( ls_newcod )
		ls_newcod = Right( '00' + f_Trim( String( Integer( ls_newcod ) + 1 )), 2 )
		dw_1.Object.c_codigo_emb[ 1] = ls_newcod 
		Return False
	End If
End If

/* Validamos que campos mandatorios esten ingresados */
/* Descripcion */
if f_trim( dw_1.Object.v_nombre_emb[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar nombre/descripción.', Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo_emb' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'c_codigo_emb', 'v_nombre_emb', 'v_nomcom_emb', 'c_rfc_emb', &
				'c_origen_emb', 'v_direcc_emb', 'v_ciudad_emb', 'v_apapos_emb', &
				'v_codpos_emb', 'v_telef1_emb', 'v_telef2_emb', 'v_ptoemb_emb' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();Return wf_CheckActionE( )

end function

on w_mant_embarcador_edit.create
call super::create
end on

on w_mant_embarcador_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_embarcador_edit
int X=0
int Y=0
int Width=2048
int Height=1004
string DataObject="d_mant_embarcador_edit"
end type

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_embarcador_edit
int X=1641
int Y=1016
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_embarcador_edit
int X=1266
int Y=1016
end type

