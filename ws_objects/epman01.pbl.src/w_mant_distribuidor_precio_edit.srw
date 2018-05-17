$PBExportHeader$w_mant_distribuidor_precio_edit.srw
forward
global type w_mant_distribuidor_precio_edit from wa_mant_edit
end type
end forward

global type w_mant_distribuidor_precio_edit from wa_mant_edit
int Width=1586
int Height=928
boolean TitleBar=true
string Title="Distribuidor - Precio - "
long BackColor=81324524
end type
global w_mant_distribuidor_precio_edit w_mant_distribuidor_precio_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
end prototypes

public function boolean wf_validareg ();Long		ll_cnt
String	ls_cod, ls_newcod, ls_eti, ls_pro,ls_dis
decimal {2} ldc_mn,ldc_me


dw_1.AcceptText( )

ls_cod = f_Trim( dw_1.Object.c_codigo[ 1])
ls_eti = f_Trim( dw_1.Object.c_codigo_eti[ 1])
ls_pro = f_Trim( dw_1.Object.c_codigo_pro[ 1])
ls_dis = f_trim( dw_1.Object.c_codigo_dis[ 1])

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el codigo ingresado no exista */
	If ls_cod <> '' Then
		Select	Count( * )
		Into 		:ll_cnt
		From		t_distribuidor_precio
		Where		c_codigo_dis + c_codigo_pro + c_codigo_eti = :ls_cod 
		and c_codigo_dis = :ls_dis
		using sqlca;
		If f_Zero( ll_cnt ) > 0 Then
			MessageBox( Title, 'Código ingresado ya existe.', Exclamation!)
			Return False
		End If
		
		Select	Count( * )
		Into 		:ll_cnt
		From		t_producto
		Where		c_codigo_pro = :ls_pro
		And		c_activo_pro = '1' 
		using sqlca;
		If f_Zero( ll_cnt ) = 0 Then
			MessageBox( Title, 'Producto ingresado no existe o está eliminado.', Exclamation!)
			Return False
		End If
		
		Select	Count( * )
		Into 		:ll_cnt
		From		t_etiqueta
		Where		c_codigo_eti = :ls_eti 
		And		c_activo_eti = '1' 
		using sqlca;
		If f_Zero( ll_cnt ) = 0 Then
			MessageBox( Title, 'Etiqueta ingresada no existe o está eliminada.', Exclamation!)
			Return False
		End If
	Else
		MessageBox( Title, 'Debe ingresar el código o seleccionar el producto,etiqueta y distribuidor.', Exclamation!)
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
	dw_1.setcolumn('c_codigo_eti')
	Return False
End If

ldc_mn = f_Zero( dw_1.Object.n_precmn_dip[ 1])
ldc_me =	f_Zero( dw_1.Object.n_precme_dip[ 1])

If ldc_mn = 0 Then
	if ldc_me = 0 then
		MessageBox( Title, 'Deberá ingresar el precio: nacional o extranjero', Exclamation!)
		dw_1.setcolumn('n_precmn_dip')
		return false
	end if
End If

If ldc_me = 0 Then
	if ldc_mn = 0 then
		MessageBox( Title, 'Deberá ingresar el precio en moneda extranjera.', Exclamation!)
		dw_1.setcolumn('n_precme_dip')
		return false
	end if
End If

If ls_dis = '' Then
	MessageBox( Title, 'Debe ingresar/seleccionar el distribuidor', Exclamation!)
	dw_1.setcolumn('c_codigo_dis')
		return false
	Return False
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo', 'c_codigo_proe','c_codigo_pro', 'c_codigo_eti','c_codigo_dis' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'c_codigo', 'c_codigo_proe','c_codigo_pro', 'c_codigo_eti', &
					'n_precmn_dip', 'n_precme_dip','c_codigo_dis' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();Return wf_CheckActionE( )
end function

on w_mant_distribuidor_precio_edit.create
call super::create
end on

on w_mant_distribuidor_precio_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_distribuidor_precio_edit
int X=0
int Y=32
int Width=1563
int Height=632
string DataObject="d_mant_distribuidor_precio_edit"
end type

event dw_1::itemchanged;call super::itemchanged;String	ls_dato,ls_pro,ls_eti,ls_dis

Choose Case dwo.name
	Case 'c_codigo_proe'
		data = Left( f_Trim(data) + Space(6), 6 )
		ls_dato = Left( data, 4 ) 
		ls_pro = ls_dato
		dw_1.Object.c_codigo_pro[row] = ls_dato 
		ls_dato = Right( data, 2 )
		dw_1.Object.c_codigo_eti[row] = ls_dato 
		ls_dis = f_trim(dw_1.object.c_codigo_dis[1])//20080609
		dw_1.object.c_codigo[row] = ls_dis + ls_pro + ls_dato //20080609
	Case 'c_codigo_pro'
		ls_dato = f_Trim( Object.c_codigo_eti[row] )
		dw_1.Object.c_codigo_proe[row] = data + ls_dato 
		//Object.c_codigo_proe[row] = ls_pro + ls_dato
		ls_dis = f_trim(dw_1.object.c_codigo_dis[1])//20080609
		dw_1.Object.c_codigo[row] = ls_dis + data + ls_dato  //20080609
	Case 'c_codigo_eti'
		ls_dato = f_Trim( Object.c_codigo_pro[row] )
		dw_1.Object.c_codigo_proe[row] = ls_dato + data
		ls_dis = f_trim(dw_1.object.c_codigo_dis[1])//20080609
		dw_1.Object.c_codigo[row] = ls_dis + ls_dato + data
	case 'c_codigo_dis'
		ls_pro = f_trim(dw_1.object.c_codigo_pro[1])
		ls_eti = f_trim(dw_1.object.c_codigo_eti[1])
		dw_1.Object.c_codigo[row] = data + ls_pro + ls_eti //20080609
		
End Choose
end event

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_distribuidor_precio_edit
int X=1175
int Y=708
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_distribuidor_precio_edit
int X=805
int Y=708
end type

