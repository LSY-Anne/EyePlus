$PBExportHeader$w_arch_otro_movimiento_edit.srw
forward
global type w_arch_otro_movimiento_edit from wa_mant_edit
end type
end forward

global type w_arch_otro_movimiento_edit from wa_mant_edit
int Width=1659
int Height=820
boolean TitleBar=true
string Title="Otros Movimientos - "
long BackColor=79741120
end type
global w_arch_otro_movimiento_edit w_arch_otro_movimiento_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function boolean wf_checkactioni ()
public function integer wf_postupdate ()
public function long wf_retrievelist ()
end prototypes

public function boolean wf_validareg ();DateTime	ld_mov
Dec{2}	ldc_bul
Long		ll_cnt
String	ls_ele, ls_pro, ls_bus, ls_cul, ls_eti, ls_new, ls_tip

dw_1.AcceptText( )

ls_ele = f_Trim( dw_1.Object.c_elemen_otm[ 1] )
ls_pro = f_Trim( dw_1.Object.c_codigo_pro[ 1] )
ls_cul = f_Trim( dw_1.Object.c_codigo_cul[ 1] )
ls_eti = f_Trim( dw_1.Object.c_codigo_eti[ 1] )
ls_tip = f_Trim( dw_1.Object.c_tipmov_otm[ 1] )
ldc_bul = f_Zero( dw_1.Object.n_afecto_otm[ 1] )
ld_mov = dw_1.Object.d_movimi_otm[ 1]
If ls_tip = '' Then
	MessageBox( Title, 'Debe seleccionar el tipo de movimiento para continuar.', Exclamation!)
	Return False
End If
If IsNull( ld_mov ) Then
	MessageBox( Title, 'Debe ingresar una fecha de trabajo válida para continuar.', Exclamation!)
	Return False
End If
If ls_ele = '' Then
	MessageBox( Title, 'Debe ingresar el elemento para continuar.', Exclamation!)
	Return False
End If
If ls_pro = '' Then
	MessageBox( Title, 'Debe seleccionar el producto para continuar.', Exclamation!)
	Return False
End If
If ls_cul = '' Then
	MessageBox( Title, 'Debe seleccionar el cultivo para continuar.', Exclamation!)
	Return False
End If
If ls_eti = '' Then
	MessageBox( Title, 'Debe seleccionar la etiqueta para continuar.', Exclamation!)
	Return False
End If
If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	If ldc_bul = 0 Then
		MessageBox( Title, 'Debe ingresar los bultos afectados para continuar.', Exclamation!)
		Return False
	End If
End If

/* Se busca el producto, se utiliza ls_bus */
Select	c_codigo_pro
Into		:ls_bus
From		t_producto
Where		c_codigo_pro = :ls_pro
And		c_activo_pro = '1' ;
If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_producto (c_codigo_pro)' ) =-1 Then
	Return False
End If

If f_Trim( ls_bus ) = '' Then
	MessageBox( Title, 'Debe ingresar/seleccionar un producto existente ' + &
								'y activo para poder continuar.', Exclamation!)
	Return False
End If

ls_bus = ''
/* Se busca la etiqueta , se utiliza ls_bus */
Select	c_codigo_eti
Into		:ls_bus
From		t_etiqueta
Where		c_codigo_eti = :ls_eti
And		c_activo_eti = '1' ;
If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_etiqueta (c_codigo_eti)' ) =-1 Then
	Return False
End If

If f_Trim( ls_bus ) = '' Then
	MessageBox( Title, 'Debe ingresar/seleccionar una etiqueta existente ' + &
								'y activa para poder continuar.', Exclamation!)
	Return False
End If

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el registro ingresado no exista */
	dw_1.Object.c_codigo_tem[ 1] = gs_codtem
	Select	Count( * )
	Into 		:ll_cnt
	From		t_otro_movimiento
	Where		c_codigo_tem = :gs_codtem
	And		c_elemen_otm = :ls_ele
	And		c_tipmov_otm = :ls_tip
	And		d_movimi_otm = :ld_mov ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_otro_movimiento (Count)' ) =-1 Then
		Return False
	End If
	If f_Zero( ll_cnt ) > 0 Then
		MessageBox( Title,  'Este registro con este tipo de movimiento ya existe con la misma fecha que lo quiere agregar.~n~r' + &
							'~r~nSi desea actualizarlo, seleccionelo y haga clic en Modificar.', Exclamation!)
		Return False
	End If
	
//	If f_Zero( ll_cnt ) > 0 Then
//		MessageBox( Title, 'Este registro de mano de obra ya existe.~n~r' + &
//							'~r~nSi desea actualizarlo, seleccionelo y haga clic en Modificar.', Exclamation!)
//		Return False
//	End If

	/* Genera código */
	Select	Max( c_codigo_otm )
	Into 		:ls_new
	From		t_otro_movimiento ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_otro_movimiento (Max)' ) =-1 Then
		Return False
	End If
	ls_new = f_Trim( ls_new )
	ls_new = Right( '000000' + f_Trim( String( Integer( ls_new ) + 1 )), 6 )
	dw_1.Object.c_codigo_otm[ 1] = ls_new 
End If

/* Validamos que campos mandatorios esten ingresados */
/* */

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { '' }

ls_acol[] = { 'c_tipmov_otm', 'd_movimi_otm', 'c_elemen_otm', &
					'c_codigo_pro', 'c_codigo_eti', 'c_codigo_cul' }


wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();
String	ls_acol[]

ls_acol[] = { 'c_tipmov_otm', 'd_movimi_otm', 'c_elemen_otm', &
				'n_afecto_otm', 'c_codigo_pro', 'c_codigo_eti', 'c_codigo_cul' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();Return wf_CheckActionE( )

end function

public function boolean wf_checkactioni ();f_GetSysDate( )
dw_1.Object.c_codigo_tem[1] = gs_codtem
dw_1.Object.c_contab_otm[1] = '0'
dw_1.Object.d_movimi_otm[1] = gd_sys

Return True

end function

public function integer wf_postupdate ();Dec{2}	ldc_bul, ldc_ant
uo_DataStore lds_1
Integer	i
Long		ll_row
String	ls_pro, ls_eti, ls_mer


lds_1 = Create uo_DataStore
lds_1.DataObject = 'd_arch_acumulado_edit'
lds_1.SetTransObject( SqlCa ) 

For i = 1 To dw_1.RowCount( )
	ls_mer = ''
	ls_pro = f_Trim( dw_1.Object.c_codigo_pro[ i] )
	
	Select	c_merdes_pro
	Into		:ls_mer
	From		t_producto
	Where		c_codigo_pro = :ls_pro ;
	
	ls_eti = f_Trim( dw_1.Object.c_codigo_eti[ i] )
	ldc_bul = f_Zero( dw_1.Object.n_afecto_otm[ i] )
	ll_row = lds_1.Retrieve( gs_codtem + ls_pro + ls_eti + ls_mer + ls_mer )
	If ll_row = 0 Then
		ll_row = lds_1.InsertRow(0)
		lds_1.Object.c_codigo_tem[ll_row] = gs_codtem
		lds_1.Object.c_codigo_pro[ll_row] = ls_pro
		lds_1.Object.c_codigo_eti[ll_row] = ls_eti
		lds_1.Object.c_merori_acu[ll_row] = ls_mer
		lds_1.Object.c_merdes_acu[ll_row] = ls_mer
		lds_1.Object.n_emphoy_acu[ll_row] = 0
		lds_1.Object.n_merhoy_acu[ll_row] = 0
		lds_1.Object.n_sobhoy_acu[ll_row] = 0
		lds_1.Object.n_acchoy_acu[ll_row] = 0
		lds_1.Object.n_reehoy_acu[ll_row] = 0
		lds_1.Object.c_codigo_usu[ll_row] = gs_usuario
		lds_1.Object.d_creacion[ll_row] = DateTime( Today( ) )
		lds_1.Object.c_activo[ll_row] = '1'
	Else
		lds_1.Object.c_usumod[ll_row] = gs_usuario
		lds_1.Object.d_modifi[ll_row] = DateTime( Today( ) )
		lds_1.Object.c_activo[ll_row] = '1'
	End If
	If istr_parm.s_cad[ 1] = 'E' Then	/* Elimina */
		ldc_bul = 0 //- ldc_bul
	End If
	If istr_parm.s_cad[ 1] = 'M' Then	/* Modifico sumo nuevo y resto anterior */
		//ldc_ant = (f_Zero( dw_1.GetItemDecimal( i, 'n_afecto_otm', Primary!, True ) ) )
		//ldc_bul = ldc_bul - ldc_ant
	End If
	If dw_1.Object.c_tipmov_otm[ i] = 'M' Then
		lds_1.Object.n_merhoy_acu[ll_row] = ldc_bul
	ElseIf dw_1.Object.c_tipmov_otm[ i] = 'S' Then
		lds_1.Object.n_sobhoy_acu[ll_row] = ldc_bul
	ElseIf dw_1.Object.c_tipmov_otm[ i] = 'A' Then
		lds_1.Object.n_acchoy_acu[ll_row] = ldc_bul
	ElseIf dw_1.Object.c_tipmov_otm[ i] = 'R' Then
		lds_1.Object.n_reehoy_acu[ll_row] = ldc_bul
	End If
Next

lds_1.AcceptText( )
If Not lds_1.Update( ) = 1 Then
	Return -1
End If

Return 1
end function

public function long wf_retrievelist ();If UpperBound( istr_parm.dw_dat[ ] ) > 0 Then
	Return istr_parm.dw_dat[ 1].Retrieve( gs_codtem, gd_sys, gd_sys)
End If

Return 0

end function

on w_arch_otro_movimiento_edit.create
call super::create
end on

on w_arch_otro_movimiento_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_arch_otro_movimiento_edit
int X=0
int Y=0
int Width=1623
int Height=592
string DataObject="d_arch_otro_movimiento_edit"
end type

event dw_1::itemchanged;call super::itemchanged;DataWindowChild	ldwc_x
String	ls_dato


/* Asignacion de datos segun el campo modificado */
Choose Case dwo.Name
	Case 'c_elemen_otm' /* <--- Identificador del elemento */
		data = Left( f_Trim(data) + Space(6), 6 )
		ls_dato = Left( data, 4 ) 
		This.Object.c_codigo_pro[row] = ls_dato 
		ls_dato = Left( data, 2 ) 
		This.Object.c_codigo_cul[row] = ls_dato 
		ls_dato = Right( data, 2 )
		This.Object.c_codigo_eti[row] = ls_dato 
	Case 'c_codigo_pro'
		ls_dato = f_Trim( This.Object.c_codigo_eti[row] )
		This.Object.c_elemen_otm[row] = data + ls_dato 
		ls_dato = Left( data, 2 ) 
		This.Object.c_codigo_cul[row] = ls_dato 
	Case 'c_codigo_cul'
		GetChild( 'c_codigo_pro', ldwc_x )
		ldwc_x.SetFilter( 'Left( c_codigo_pro, 2 ) = ' + '"' + data + '"'  )
		ldwc_x.Filter( )
		This.Object.c_codigo_pro[row] = ''
		This.Object.c_elemen_otm[row] = data 
	Case 'c_codigo_eti'
		ls_dato = f_Trim( This.Object.c_codigo_pro[row] )
		If ls_dato = '' Then 
			ls_dato = Right( '  ' + f_Trim( This.Object.c_codigo_cul[row] ), 2 )
			ls_dato = ls_dato + '  '
		End If
		This.Object.c_elemen_otm[row] = ls_dato + data
	Case 'c_tipmov_otm'
End Choose


end event

type cb_cancelar from wa_mant_edit`cb_cancelar within w_arch_otro_movimiento_edit
int X=1248
int Y=596
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_arch_otro_movimiento_edit
int X=873
int Y=596
end type

