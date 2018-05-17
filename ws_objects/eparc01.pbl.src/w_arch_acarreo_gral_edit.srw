$PBExportHeader$w_arch_acarreo_gral_edit.srw
forward
global type w_arch_acarreo_gral_edit from wa_mant_edit
end type
end forward

global type w_arch_acarreo_gral_edit from wa_mant_edit
int Width=1865
int Height=1076
boolean TitleBar=true
string Title="Acarreo General - "
long BackColor=79741120
end type
global w_arch_acarreo_gral_edit w_arch_acarreo_gral_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function boolean wf_checkactioni ()
end prototypes

public function boolean wf_validareg ();DateTime	ld_trabajo
String	ls_new
dec{4} 	ldc_factor


dw_1.AcceptText( )
ld_trabajo = dw_1.Object.d_trabajo_acg[ 1]

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que la fecha ingresada no exista */
			
	Select	c_codigo_acg
	Into 		:ls_new
	From		t_acarreo_general
	Where		c_codigo_tem = :gs_codtem
	And		d_trabajo_acg = :ld_trabajo ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_acarreo_general.' ) = -1 Then
		Return False
	End If
	If f_Trim( ls_new ) <> '' Then
		MessageBox( Title, 'Registro de acarreo de fecha ' + String( ld_trabajo, 'dd/mm/yyyy' ) + &
								' ya existe.', Exclamation!)
		Return False
	End If

	Select	Max( c_codigo_acg )
	Into 		:ls_new
	From		t_acarreo_general ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_cultivo_acarreo (Max).' ) = -1 Then
		Return False
	End If
	ls_new = f_Trim( ls_new )
	ls_new = Right( '000000' + f_Trim( String( Integer( ls_new ) + 1 )), 6 )
	dw_1.Object.c_codigo_acg[ 1] = ls_new 
End If

/* Validamos que campos mandatorios esten ingresados */
/* Los costos pueden ser ceros: n_coston_acg, n_costoe_acg */

Return True
end function

public function boolean wf_checkactionm ();dec{4} ldc_factor
datetime ld_trabajo

ld_trabajo = dw_1.Object.d_trabajo_acg[ 1]
ldc_factor = f_GetTipoCambio( ld_trabajo )

dw_1.Object.n_factor_tic[ 1] = ldc_factor

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'd_trabajo_acg',  'n_coston_acg', 'n_costoe_acg', 'n_factor_tic', 'v_coment_acg' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();
Return wf_CheckActionE( )

end function

public function boolean wf_checkactioni ();Dec{4}	ldc_factor

f_GetSysDate( )

dw_1.Object.d_trabajo_acg[ 1] = gd_sys
dw_1.Object.c_codigo_tem[ 1] = gs_codtem

ldc_factor = f_GetTipoCambio( gd_sys )
If ldc_factor = -100 Then
	MessageBox( Title, 'No se ha ingresado el tipo de cambio para el día ' + String( gd_sys, 'dd/mm/yyyy' ))
	Close( This )
	Return False
ElseIf ldc_factor = -1 Then
	Close( This )
	Return False
End If

dw_1.Object.n_factor_tic[ 1] = ldc_factor

Return True
end function

on w_arch_acarreo_gral_edit.create
call super::create
end on

on w_arch_acarreo_gral_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_arch_acarreo_gral_edit
int X=0
int Y=0
int Width=1842
int Height=852
string DataObject="d_arch_acarreo_gral_edit"
end type

event dw_1::itemchanged;call super::itemchanged;DateTime		ld_trabajo
Dec{4}	ldc_factor, ldc_coston, ldc_costoe


If dwo.Name = 'd_trabajo_acg' Then
	ld_trabajo = DateTime( Date( data ) )
	ldc_factor = f_GetTipoCambio( ld_trabajo )
	If ldc_factor = -100 Then
		MessageBox( Parent.Title, 'No se ha ingresado el tipo de cambio para el día ' + String( ld_trabajo, 'dd/mm/yyyy' ))
		Return 2
	ElseIf ldc_factor = -1 Then
		Return 2
	End If
	dw_1.Object.n_factor_tic[ 1] = f_Zero( ldc_factor )
End If

ldc_factor = f_Zero( dw_1.Object.n_factor_tic[ 1] )
ldc_costoe = f_Zero( dw_1.Object.n_costoe_acg[ 1] )
ldc_coston = f_Zero( dw_1.Object.n_coston_acg[ 1] )

If ldc_factor = 0 Then
	ldc_factor = 1
End If

Choose Case dwo.Name
	Case 'n_costoe_acg'
		ldc_costoe = Dec( data ) 
	Case 'n_coston_acg'
		ldc_coston = Dec( data ) 
End Choose


dw_1.Object.n_coston_acg[ 1] = ldc_costoe * ldc_factor
dw_1.Object.n_costoe_acg[ 1] = ldc_coston / ldc_factor

end event

type cb_cancelar from wa_mant_edit`cb_cancelar within w_arch_acarreo_gral_edit
int X=1449
int Y=868
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_arch_acarreo_gral_edit
int X=1074
int Y=868
end type

