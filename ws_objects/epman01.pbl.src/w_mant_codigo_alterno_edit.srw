$PBExportHeader$w_mant_codigo_alterno_edit.srw
forward
global type w_mant_codigo_alterno_edit from wa_mant_edit
end type
end forward

global type w_mant_codigo_alterno_edit from wa_mant_edit
int Width=1623
int Height=804
boolean TitleBar=true
string Title="Código Alterno - "
long BackColor=81324524
end type
global w_mant_codigo_alterno_edit w_mant_codigo_alterno_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
end prototypes

public function boolean wf_validareg ();Long		ll_cnt
String	ls_cod, ls_dis, ls_alt, ls_pro


dw_1.AcceptText( )

ls_dis = f_Trim( dw_1.Object.c_codigo_dis[ 1])
ls_pro = f_Trim( dw_1.Object.c_codigo_pro[ 1])
ls_alt = f_Trim( dw_1.Object.c_codigo_alt[ 1])

/* Validamos que campos mandatorios esten ingresados */
If ls_dis = '' Then
	MessageBox( Title, 'Debe seleccionar un distribuidor.', Exclamation!)
	Return False
End If

If Not ls_pro = '' Then
	ll_cnt = 0
	Select	Count(*)
	Into		:ll_cnt
	From		t_producto
	Where		c_codigo_pro = :ls_pro
	And		c_activo_pro = '1'
	Using		SqlCa ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_producto.') = -1 Then
		Return False
	End If
End If

If ls_pro = '' Or f_Zero( ll_cnt ) = 0 Then
	MessageBox( Title, 'Debe ingresar/seleccionar un producto válido.', Exclamation!)
	Return False
End If

If ls_alt = '' Then
	MessageBox( Title, 'Debe ingresar el código alterno.', Exclamation!)
	Return False
End If

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el codigo ingresado no exista */
	ls_cod = ls_dis + ls_pro
	If ls_cod <> '' Then
		ll_cnt = 0
		Select	Count(*)
		Into 		:ll_cnt
		From		t_codigo_alterno
		Where		c_codigo_dis + c_codigo_pro = :ls_cod 
		Using		SqlCa ;
		If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_codigo_alterno.') = -1 Then
			Return False
		End If
		If f_Zero( ll_cnt ) > 0 Then
			MessageBox( Title, 'La combinación del Distribuidor+Producto ya existe.', Exclamation!)
			Return False
		End If
	End If
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo_dis', 'c_codigo_pro' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'c_codigo_pro', 'c_codigo_alp', 'c_codigo_dis', 'v_nombre_alt' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();
Return wf_CheckActionE( )

end function

on w_mant_codigo_alterno_edit.create
call super::create
end on

on w_mant_codigo_alterno_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_codigo_alterno_edit
int X=0
int Y=0
int Width=1573
int Height=588
string DataObject="d_mant_codigo_alterno_edit"
end type

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_codigo_alterno_edit
int X=1202
int Y=588
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_codigo_alterno_edit
int X=837
int Y=588
end type

