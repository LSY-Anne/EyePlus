$PBExportHeader$w_mant_tipo_cambio_edit.srw
forward
global type w_mant_tipo_cambio_edit from wa_mant_edit
end type
end forward

global type w_mant_tipo_cambio_edit from wa_mant_edit
int Width=1499
int Height=668
boolean TitleBar=true
string Title="Tipo de Cambio - "
long BackColor=79741120
end type
global w_mant_tipo_cambio_edit w_mant_tipo_cambio_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function boolean wf_setlast ()
public function boolean wf_checkactioni ()
end prototypes

public function boolean wf_validareg ();Dec{2}	ldc_factor
DateTime	ld_trabajo
String	ls_new


dw_1.AcceptText( )
ld_trabajo = dw_1.Object.d_trabajo_tic[ 1]
ldc_factor = dw_1.Object.n_factor_tic[ 1]

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que la fecha ingresada no exista */
			
	Select	c_codigo_tic
	Into 		:ls_new
	From		t_tipo_cambio
	Where		d_trabajo_tic = :ld_trabajo ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_tipo_cambio.' ) = -1 Then
		Return False
	End If
	If f_Trim( ls_new ) <> '' Then
		MessageBox( Title, 'Registro del tipo de cambio de fecha ' + &
									String( ld_trabajo, 'dd/mm/yyyy' ) + ' ya existe.', Exclamation!)
		Return False
	End If
	ls_new = String( ld_trabajo, 'yymmdd' )
	dw_1.Object.c_codigo_tic[ 1] = ls_new 
End If

/* Validamos que campos mandatorios esten ingresados */
/* Factor de tipo de Cambio */
If f_Zero( dw_1.Object.n_factor_tic[ 1]) = 0 Then
	MessageBox( Title, 'Debe ingresar el tipo de cambio.', Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'd_trabajo_tic' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'd_trabajo_tic', 'n_factor_tic' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();
Return wf_CheckActionE( )

end function

public function boolean wf_setlast ();/* wf_SetLast( ) 
	Muestra Ultimo tipo de cambio */
DateTime	ld_trabajo
Dec{4}	ldc_factor

f_GetSysDate( )

Select	Max( d_trabajo_tic )
Into 		:ld_trabajo
From		t_tipo_cambio
Where		d_trabajo_tic  < :gd_sys ;
If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_tipo_cambio (Max).' ) = -1 Then
	Return False
End If

Select	n_factor_tic
Into 		:ldc_factor
From		t_tipo_cambio
Where		d_trabajo_tic  = :ld_trabajo ;
If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_tipo_cambio (n_factor_tic).' ) = -1 Then
	Return False
End If

dw_1.Object.d_ultimo[ 1] = ld_trabajo
dw_1.Object.n_ultimo[ 1] = ldc_factor
dw_1.AcceptText( )

Return True
end function

public function boolean wf_checkactioni ();wf_SetLast( ) 
dw_1.Object.d_trabajo_tic[1] = f_GetsysDate( )
Return True
end function

on w_mant_tipo_cambio_edit.create
call super::create
end on

on w_mant_tipo_cambio_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_tipo_cambio_edit
int X=0
int Y=0
int Width=1472
int Height=440
string DataObject="d_mant_tipo_cambio_edit"
end type

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_tipo_cambio_edit
int X=1079
int Y=440
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_tipo_cambio_edit
int X=704
int Y=440
end type

