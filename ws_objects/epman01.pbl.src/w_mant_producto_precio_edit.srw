$PBExportHeader$w_mant_producto_precio_edit.srw
forward
global type w_mant_producto_precio_edit from wa_mant_edit
end type
end forward

global type w_mant_producto_precio_edit from wa_mant_edit
int Width=1586
int Height=760
boolean TitleBar=true
string Title="Precios - "
long BackColor=79741120
end type
global w_mant_producto_precio_edit w_mant_producto_precio_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
end prototypes

public function boolean wf_validareg ();Long		ll_cnt
String	ls_cod, ls_newcod, ls_eti, ls_pro


dw_1.AcceptText( )

ls_cod = f_Trim( dw_1.Object.c_codigo[ 1])
ls_eti = f_Trim( dw_1.Object.c_codigo_eti[ 1])
ls_pro = f_Trim( dw_1.Object.c_codigo_pro[ 1])

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el codigo ingresado no exista */
	If ls_cod <> '' Then
		Select	Count( * )
		Into 		:ll_cnt
		From		t_producto_precio
		Where		c_codigo_pro + c_codigo_eti = :ls_cod ;
		If f_Zero( ll_cnt ) > 0 Then
			MessageBox( Title, 'Código ingresado ya existe.', Exclamation!)
			Return False
		End If
		Select	Count( * )
		Into 		:ll_cnt
		From		t_producto
		Where		c_codigo_pro = :ls_pro
		And		c_activo_pro = '1' ;
		If f_Zero( ll_cnt ) = 0 Then
			MessageBox( Title, 'Producto ingresado no existe o está eliminado.', Exclamation!)
			Return False
		End If
		Select	Count( * )
		Into 		:ll_cnt
		From		t_etiqueta
		Where		c_codigo_eti = :ls_eti 
		And		c_activo_eti = '1' ;
		If f_Zero( ll_cnt ) = 0 Then
			MessageBox( Title, 'Etiqueta ingresada no existe o está eliminada.', Exclamation!)
			Return False
		End If
	Else
		MessageBox( Title, 'Debe ingresar el código o seleccionar el producto y la etiqueta.', Exclamation!)
		Return False
	End If
End If

/* Valida que campos mandatorios esten ingresados */
If ls_pro = '' Then
	MessageBox( Title, 'Debe ingresar/seleccionar el producto.', Exclamation!)
	Return False
End If

If ls_eti = '' Then
	MessageBox( Title, 'Debe ingresar/seleccionar la etiqueta.', Exclamation!)
	Return False
End If

If f_Zero( dw_1.Object.n_precmn_prp[ 1]) = 0 Then
	MessageBox( Title, 'Deberá ingresar el precio en moneda nacional.', Exclamation!)
End If

If f_Zero( dw_1.Object.n_precme_prp[ 1]) = 0 Then
	MessageBox( Title, 'Deberá ingresar el precio en moneda extranjera.', Exclamation!)
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo', 'c_codigo_pro', 'c_codigo_eti' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'c_codigo', 'c_codigo_pro', 'c_codigo_eti', &
					'n_precmn_prp', 'n_precme_prp' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();Return wf_CheckActionE( )
end function

on w_mant_producto_precio_edit.create
call super::create
end on

on w_mant_producto_precio_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_producto_precio_edit
int X=0
int Y=0
int Width=1563
int Height=540
string DataObject="d_mant_producto_precio_edit"
end type

event dw_1::itemchanged;call super::itemchanged;String	ls_dato

Choose Case dwo.name
	Case 'c_codigo'
		data = Left( f_Trim(data) + Space(6), 6 )
		ls_dato = Left( data, 4 ) 
		Object.c_codigo_pro[row] = ls_dato 
		ls_dato = Right( data, 2 )
		Object.c_codigo_eti[row] = ls_dato 
	Case 'c_codigo_pro'
		ls_dato = f_Trim( Object.c_codigo_eti[row] )
		Object.c_codigo[row] = data + ls_dato 
	Case 'c_codigo_eti'
		ls_dato = f_Trim( Object.c_codigo_pro[row] )
		Object.c_codigo[row] = ls_dato + data
End Choose
end event

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_producto_precio_edit
int X=1175
int Y=552
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_producto_precio_edit
int X=800
int Y=552
end type

