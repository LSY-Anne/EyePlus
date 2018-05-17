$PBExportHeader$w_mant_cruze_edit.srw
forward
global type w_mant_cruze_edit from wa_mant_edit
end type
end forward

global type w_mant_cruze_edit from wa_mant_edit
int Width=2894
int Height=604
boolean TitleBar=true
string Title="Lugares Cruce - "
long BackColor=82899184
end type
global w_mant_cruze_edit w_mant_cruze_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
end prototypes

public function boolean wf_validareg ();String	ls_codigo, ls_newcod


dw_1.AcceptText( )
ls_codigo = f_trim( dw_1.Object.c_codigo[ 1])

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el codigo ingresado no exista */
	If ls_codigo <> '' Then
		Select	c_codigo_cze
		Into 		:ls_newcod
		From		t_lugarescruce
		Where		c_codigo_cze = :ls_codigo ;
		If f_Trim( ls_newcod ) <> '' Then
			ls_codigo = ''
			MessageBox( Title, 'Código ingresado ya existe.~n~rPertenece a ' + ls_newcod + &
									'~r~n~r~nEl sistema generará el código.', Exclamation!)
		End If
	Else
		MessageBox( Title, 'Debe ingresar el código.' + '~r~n~r~nEl sistema generará el código.', Exclamation!)
	End If
	If ls_codigo = '' Then
		Select	Max( c_codigo_cze )
		Into 		:ls_newcod
		From		t_lugarescruce ;
		ls_newcod = f_Trim( ls_newcod )
		ls_newcod = Right( '00' + f_Trim( String( Integer( ls_newcod ) + 1 )), 2 )
		dw_1.Object.c_codigo[ 1] = ls_newcod 
		Return False
	End If
End If

/* Validamos que campos mandatorios esten ingresados */
/* Descripcion */
if f_trim( dw_1.Object.v_desccorta_cze[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar nombre/descripción corta.', Exclamation!)
	Return False
End If

if f_trim( dw_1.Object.v_desclarga_cze[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar nombre/descripción larga.', Exclamation!)
	Return False
End If
Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'c_codigo', 'v_desccorta_cze','v_desclarga_cruze' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();
Return wf_CheckActionE( )

end function

on w_mant_cruze_edit.create
call super::create
end on

on w_mant_cruze_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_cruze_edit
int X=0
int Y=28
int Width=2834
int Height=328
string DataObject="d_mant_cruze_edit"
end type

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_cruze_edit
int X=2487
int Y=376
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_cruze_edit
int X=2112
int Y=376
end type

