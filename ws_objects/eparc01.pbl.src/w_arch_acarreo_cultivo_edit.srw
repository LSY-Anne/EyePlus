$PBExportHeader$w_arch_acarreo_cultivo_edit.srw
forward
global type w_arch_acarreo_cultivo_edit from wa_mant_edit
end type
end forward

global type w_arch_acarreo_cultivo_edit from wa_mant_edit
int Width=1865
int Height=744
boolean TitleBar=true
string Title="Acarreo - "
long BackColor=79741120
end type
global w_arch_acarreo_cultivo_edit w_arch_acarreo_cultivo_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function boolean wf_checkactioni ()
public function long wf_retrievelist ()
end prototypes

public function boolean wf_validareg ();DateTime	ld_trabajo
String	ls_cul, ls_new


dw_1.AcceptText( )
ld_trabajo = dw_1.Object.d_trabajo_cua[ 1]
ls_cul = dw_1.Object.c_codigo_cul[ 1]

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que la fecha ingresada no exista */
			
	Select	c_codigo_cua
	Into 		:ls_new
	From		t_cultivo_acarreo
	Where		c_codigo_tem = :gs_codtem
	And		c_codigo_cul = :ls_cul
	And		d_trabajo_cua = :ld_trabajo ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_cultivo_acarreo.' ) = -1 Then
		Return False
	End If
	If f_Trim( ls_new ) <> '' Then
		MessageBox( Title, 'Registro de acarreo de fecha ' + String( ld_trabajo, 'dd/mm/yyyy' ) + &
								' del cultivo seleccionado ya existe.', Exclamation!)
		Return False
	End If

	Select	Max( c_codigo_cua )
	Into 		:ls_new
	From		t_cultivo_acarreo ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_cultivo_acarreo (Max).' ) = -1 Then
		Return False
	End If
	ls_new = f_Trim( ls_new )
	ls_new = Right( '000000' + f_Trim( String( Integer( ls_new ) + 1 )), 6 )
	dw_1.Object.c_codigo_cua[ 1] = ls_new 
End If

/* Validamos que campos mandatorios esten ingresados */
/* Los costos pueden ser ceros: n_coston_cua, n_costoe_cua */

Return True
end function

public function boolean wf_checkactionm ();Dec{4}	ldc_factor
datetime ld_trabajo
ld_trabajo = dw_1.Object.d_trabajo_cua[ 1]
ldc_factor = f_GetTipoCambio( ld_trabajo )

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

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'c_codigo_cul', 'd_trabajo_cua', 'n_coston_cua', 'n_costoe_cua' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();
Return wf_CheckActionE( )

end function

public function boolean wf_checkactioni ();Dec{4}	ldc_factor

f_GetSysDate( )

dw_1.Object.d_trabajo_cua[ 1] = gd_sys
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

public function long wf_retrievelist ();If UpperBound( istr_parm.dw_dat[ ] ) > 0 Then
	Return istr_parm.dw_dat[ 1].Retrieve( gs_codtem, gd_sys, gd_sys)
End If

Return 0

end function

on w_arch_acarreo_cultivo_edit.create
call super::create
end on

on w_arch_acarreo_cultivo_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_arch_acarreo_cultivo_edit
int X=0
int Y=0
int Width=1842
int Height=524
string DataObject="d_arch_acarreo_cultivo_edit"
end type

event dw_1::itemchanged;call super::itemchanged;DateTime	ld_trabajo
Dec{4}	ldc_factor, ldc_coston, ldc_costoe

ld_trabajo = dw_1.Object.d_trabajo_cua[ 1]
ldc_factor = f_GetTipoCambio( ld_trabajo )
dw_1.Object.n_factor_tic[ 1] = ldc_factor

If dwo.Name = 'd_trabajo_cua' Then
	If ldc_factor = -100 Then
		MessageBox( Parent.Title, 'No se ha ingresado el tipo de cambio para el día ' + String( ld_trabajo, 'dd/mm/yyyy' ))
		Return 2
	ElseIf ldc_factor = -1 Then
		Return 2
	End If
	dw_1.Object.n_factor_tic[ 1] = f_Zero( ldc_factor )
End If

ldc_factor = f_Zero( dw_1.Object.n_factor_tic[ 1] )
ldc_costoe = f_Zero( dw_1.Object.n_costoe_cua[ 1] )
ldc_coston = f_Zero( dw_1.Object.n_coston_cua[ 1] )

If ldc_factor = 0 Then
	ldc_factor = 1
End If

Choose Case dwo.Name
	Case 'n_costoe_cua'
		ldc_costoe = Dec( data ) 
	Case 'n_coston_cua'
		ldc_coston = Dec( data ) 
End Choose


dw_1.Object.n_coston_cua[ 1] = ldc_costoe * ldc_factor
dw_1.Object.n_costoe_cua[ 1] = ldc_coston / ldc_factor

end event

type cb_cancelar from wa_mant_edit`cb_cancelar within w_arch_acarreo_cultivo_edit
int X=1449
int Y=524
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_arch_acarreo_cultivo_edit
int X=1074
int Y=524
end type

