$PBExportHeader$w_arch_palet_2004.srw
forward
global type w_arch_palet_2004 from Window
end type
type st_del from statictext within w_arch_palet_2004
end type
type em_ini from uo_editmask within w_arch_palet_2004
end type
type cb_ini from uo_cbdate within w_arch_palet_2004
end type
type st_al from statictext within w_arch_palet_2004
end type
type em_fin from uo_editmask within w_arch_palet_2004
end type
type cb_fin from uo_cbdate within w_arch_palet_2004
end type
type cb_buscar from uo_cbother within w_arch_palet_2004
end type
type cb_pornumero from uo_cbother within w_arch_palet_2004
end type
type dw_lis from uo_dw_list within w_arch_palet_2004
end type
type cb_eliminar from uo_cbother within w_arch_palet_2004
end type
type cb_listado from uo_cbother within w_arch_palet_2004
end type
type cb_mixto from uo_cbother within w_arch_palet_2004
end type
type cb_normal from uo_cbother within w_arch_palet_2004
end type
type dw_mix2 from datawindow within w_arch_palet_2004
end type
type cb_newmix from uo_cbother within w_arch_palet_2004
end type
type cb_elimix from uo_cbother within w_arch_palet_2004
end type
type cb_agregar from uo_cbother within w_arch_palet_2004
end type
type dw_mix1 from datawindow within w_arch_palet_2004
end type
type cbx_1 from checkbox within w_arch_palet_2004
end type
type cb_nuevo from uo_cbother within w_arch_palet_2004
end type
type dw_col from datawindow within w_arch_palet_2004
end type
type dw_eti from datawindow within w_arch_palet_2004
end type
type st_tit from statictext within w_arch_palet_2004
end type
type dw_pro from datawindow within w_arch_palet_2004
end type
type dw_nor from datawindow within w_arch_palet_2004
end type
type p_nota from picture within w_arch_palet_2004
end type
type cb_imprimir from uo_cbother within w_arch_palet_2004
end type
type dw_prn from datawindow within w_arch_palet_2004
end type
type cb_aplicar from uo_cbother within w_arch_palet_2004
end type
type cb_cerrar from uo_cbcancelar within w_arch_palet_2004
end type
type cb_aceptar from uo_cbaceptar within w_arch_palet_2004
end type
type st_nota from statictext within w_arch_palet_2004
end type
type st_lis from statictext within w_arch_palet_2004
end type
end forward

global type w_arch_palet_2004 from Window
int X=0
int Y=0
int Width=3570
int Height=2224
boolean TitleBar=true
string Title="Pallet"
long BackColor=16777215
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean VScrollBar=true
boolean Resizable=true
WindowState WindowState=maximized!
event ue_print pbm_custom01
st_del st_del
em_ini em_ini
cb_ini cb_ini
st_al st_al
em_fin em_fin
cb_fin cb_fin
cb_buscar cb_buscar
cb_pornumero cb_pornumero
dw_lis dw_lis
cb_eliminar cb_eliminar
cb_listado cb_listado
cb_mixto cb_mixto
cb_normal cb_normal
dw_mix2 dw_mix2
cb_newmix cb_newmix
cb_elimix cb_elimix
cb_agregar cb_agregar
dw_mix1 dw_mix1
cbx_1 cbx_1
cb_nuevo cb_nuevo
dw_col dw_col
dw_eti dw_eti
st_tit st_tit
dw_pro dw_pro
dw_nor dw_nor
p_nota p_nota
cb_imprimir cb_imprimir
dw_prn dw_prn
cb_aplicar cb_aplicar
cb_cerrar cb_cerrar
cb_aceptar cb_aceptar
st_nota st_nota
st_lis st_lis
end type
global w_arch_palet_2004 w_arch_palet_2004

type variables
DataWindow idw_nor, idw_mix1, idw_mix2, idw_lis, idw_act
Boolean ib_generar = True, ib_mostrarmsg = True, ib_color = False
Integer ii_pag = 1, ii_ceros = 0
String is_acc = 'I', is_pal = '', is_lot
DateTime id_emp
end variables

forward prototypes
public function integer wf_aplicar ()
public function boolean wf_datosproducto (string as_pro, datawindow adw_pal)
public function integer wf_itemchanged (datawindow adw_pal, string as_dwo, string as_data, long al_row)
public function long wf_print ()
public function boolean wf_setcolumn ()
public subroutine wf_pallethoy ()
public function boolean wf_actualizaacumulado (string as_acc)
public function integer wf_setpag (integer ai_pag)
end prototypes

event ue_print;wf_print( )
end event

public function integer wf_aplicar ();Boolean	lb_generar = False
DataWindow	ldw_1
Integer	i, li_pal
Long		ll_row, ll_cnt
String	ls_acc = 'I', ls_msg, ls_pal, ls_ele, ls_col[], ls_pro, ls_nom, ls_cul, ls_eti, ls_lot, ls_clr

If ii_pag = 1 Then
	ldw_1 = idw_nor
Else
	ldw_1 = idw_mix2
	If is_acc = 'M' Then
		ls_acc = is_acc
	End If
End If

If KeyDown( KeyEnter! ) Then
	If wf_SetColumn( ) Then
		Return 0
	End If
End If

ll_row = ldw_1.GetRow( )
If ll_row = 0 Then ll_row = ldw_1.RowCount( )

If ll_row = 0 Then 
	MessageBox( Title, 'No existe ningun elemento para el pallet.', Exclamation! )
	ldw_1.SetFocus( )
	Return 0
End If	

ldw_1.AcceptText( )
/*
If Not wf_ValidaReg( ) Then
	Return 0
End If
If istr_parm.s_cad[1] = 'I' The
*/

ldw_1.SetFocus( )
If ii_pag = 1 Then
	cb_nuevo.SetFocus( )
	//tab_1.tabpage_1.cb_nuevo.Default = True
End If

For ll_row = 1 To ldw_1.RowCount( )
	/* Elemento = a Producto + Etiqueta */
	ldw_1.SetRow( ll_row )
	ldw_1.ScrollToRow( ll_row )
	ls_ele = f_Trim( ldw_1.Object.c_elemento[ll_row] )
	If ii_pag = 2 Then
		ldw_1.Object.c_codsec_pal[ll_row] = String( ll_row, '00' )
	End If
	If Len( ls_ele ) < 6 Then
		MessageBox( Title, 'Debe ingresar correctamente el elemento del palet.', Exclamation! )
		ldw_1.SetFocus( )
		Return 0
	End If

	/* Producto */
	ls_pro = f_Trim( ldw_1.Object.c_codigo_pro[ll_row] )
	ls_nom = ''
	Select	v_nombre_pro
	Into		:ls_nom
	From		t_producto
	Where		c_codigo_pro = :ls_pro 
	And		c_activo_pro = '1' ;
	If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_producto.' ) < 0 Then
		Return 0
	End If
	If f_Trim( ls_nom ) = '' Then
		MessageBox( Title, 'Debe ingresar/seleccionar un producto activo.', Exclamation! )
		ldw_1.SetFocus( )
		Return 0
	End If
	
	/* Etiqueta */
	ls_eti = f_Trim( ldw_1.Object.c_codigo_eti[ll_row] )
	ls_nom = ''
	Select	v_nombre_eti
	Into		:ls_nom
	From		t_etiqueta
	Where		c_codigo_eti = :ls_eti 
	And		c_activo_eti = '1' ;
	If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_etiqueta.' ) < 0  Then
		Return 0
	End If
	If f_Trim( ls_nom ) = '' Then
		MessageBox( Title, 'Debe ingresar/seleccionar una etiqueta activa.', Exclamation! )
		ldw_1.SetFocus( )
		Return 0
	End If
	
	/* Color */
	If ib_color Then
		ls_clr = f_Trim( ldw_1.Object.c_codigo_col[ll_row] )
		ls_nom = ''
		Select	c_codigo_col
		Into 		:ls_nom
		From		t_color
		Where		c_codigo_col = :ls_clr ;
		If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_color.' ) < 0  Then
			Return 0
		End If
		If f_Trim( ls_nom ) = '' Then
			MessageBox( Title, 'Debe ingresar un color válido.', Exclamation! )
			ldw_1.SetFocus( )
			Return 0
		End If
	End If
	
	/* Lote = Los 2 Primeros digitos del Producto o Elemento */
	ls_lot = f_Trim( ldw_1.Object.c_codigo_lot[ll_row] )
	ls_cul = Left( ls_pro, 2 )
	ls_nom = ''
	Select	v_nombre_lot
	Into		:ls_nom
	From		t_lote
	Where		c_codigo_tem = :gs_codtem
	And		c_codigo_lot = :ls_lot 
	And		c_codigo_cul = :ls_cul
	And		c_activo_lot = '1' ;
	If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_lote.' ) < 0 Then
		Return 0
	End If
	
	/* Si Tiene Lote Default no debe hacer la relacion */
	If f_Trim( is_lot ) = '' Then
		If f_Trim( ls_nom ) = '' Then
			MessageBox( Title, 'Debe ingresar/seleccionar un lote activo del mismo ' + &
										'cultivo que el producto.', Exclamation! )
			ldw_1.SetFocus( )
			Return 0
		End If
	End If
	
	If Not wf_DatosProducto( ls_pro, ldw_1 ) Then
		Return 0
	End If
	
	If f_Zero( ldw_1.Object.n_bulxpa_pal[ll_row] ) <= 0 Then
		MessageBox( Title, 'Debe ingresar la cantidad de bultos (cajas) por pallet.', Exclamation! )
		ldw_1.SetFocus( )
		Return 0
	End If
	
	If Not ib_generar Then
		ll_cnt = 0
		ls_pal = f_Trim( ldw_1.Object.c_codigo_pal[ll_row] )
		/* Completa de ceros segun configuracion */
		li_pal = ii_ceros
		If li_pal > 0 Then 
			ls_pal = Right( Fill( '0', li_pal ) + ls_pal, li_pal )
		End If
		Select	Count(*)
		Into 		:ll_cnt
		From		t_palet
		Where		c_codigo_tem = :gs_codtem
		And		c_codigo_pal = :ls_pal ;
		If SqlCa.SqlCode = 0 And ll_cnt > 0 Then
			ls_pal = ''
			Select	Max( c_codigo_pal )
			Into 		:ls_pal
			From		t_palet
			Where		c_codigo_tem = :gs_codtem ;
			ls_pal = String( Double( ls_pal ) + 1 )
			/* Completa de ceros segun configuracion */
			li_pal = ii_ceros
			If li_pal > 0 Then 
				ls_pal = Right( Fill( '0', li_pal ) + ls_pal, li_pal )
			End If
			MessageBox( Title, 'El número de pallet ingresado ya existe.~r~r' + &
									'El sistema sugiere utilizar el Nro ' + ls_pal, Exclamation! )
			ldw_1.SetFocus( )
			Return -1
		End If
	End If

	If f_Trim( ldw_1.Object.c_codigo_usu[ll_row] ) = '' Then
		ldw_1.Object.c_codigo_usu[ll_row] = gs_usuario
		ldw_1.Object.d_creacion_pal[ll_row] = DateTime( Today( ) )
		ldw_1.Object.c_activo_pal[ll_row] = '1'
	End If	
	If ls_acc <> 'I' Then
		ldw_1.Object.c_usumod_pal[ll_row] = gs_usuario
		ldw_1.Object.d_modifi_pal[ll_row] = DateTime( Today( ) )
		ldw_1.Object.c_activo_pal[ll_row] = '1'
		If ls_acc = 'E' Then
			ldw_1.Object.c_activo_pal[ll_row] = '0'
		ElseIf ls_acc = 'R' Then
			ldw_1.Object.c_activo_pal[ll_row] = '1'
		End If	
	End If	
Next

ls_pal = f_Trim( ldw_1.Object.c_codigo_pal[1] )
If ls_acc = 'I' Then
	/* Si el numero del palet "c_codigo_pal" esta vacio 
		el sistema generara el numero segun el ultimo valor
		de la tabla t_parametro */
	For ll_row = 1 To ldw_1.RowCount( )
		If ls_pal = '' Then 
			lb_generar = True
		End If
	Next
	If lb_generar Then
		If Not ib_generar Then
			MessageBox( Title, 'Debe ingresar un número válido de pallet.', Exclamation! )
			ldw_1.SetFocus( )
			Return -1
		End If
		ls_pal = String( Double( f_GetParmValue( '11' ) ) + 1 )
		ll_cnt = 0
		Select	Count(*)
		Into 		:ll_cnt
		From		t_palet
		Where		c_codigo_tem = :gs_codtem
		And		c_codigo_pal = :ls_pal ;
		If SqlCa.SqlCode = 0 And ll_cnt > 0 Then
			ls_pal = ''
			Select	Max( c_codigo_pal )
			Into 		:ls_pal
			From		t_palet
			Where		c_codigo_tem = :gs_codtem ;
			ls_pal = String( Double( ls_pal ) + 1 )
		End If

	Else
		//ls_pal = ldw_1.Object.c_codigo_pal[ll_row]
	End If
	/* Completa de ceros segun configuracion */
	li_pal = ii_ceros
	If li_pal > 0 Then 
		ls_pal = Right( Fill( '0', li_pal ) + ls_pal, li_pal )
	End If

	/* Guarda el ultimo palet generado en la tabla */
	If Not f_SetParmValue( '11', ls_pal ) Then
		RollBack Using SqlCa ;
		Return -1
	End If
	For ll_row = 1 To ldw_1.RowCount( )
		ldw_1.Object.c_codigo_pal[ll_row] = ls_pal
		ldw_1.Object.c_contab_pal[ll_row] = '0'
	Next
Else
	For ll_row = 1 To ldw_1.RowCount( )
		ldw_1.Object.c_codigo_pal[ll_row] = is_pal
		ldw_1.Object.d_empaque_pal[ll_row] = id_emp
	Next
End If

ldw_1.AcceptText( )

If Not wf_ActualizaAcumulado( ls_acc ) Then
	RollBack Using SqlCa ;
	MessageBox( Title, 'El registro no ha sido guardado.', StopSign! )
End If

If ldw_1.Update( ) = 1 Then
	Choose Case ls_acc
		Case 'I'
			ls_msg = 'insertado'
		Case 'M'
			ls_msg = 'modificado'
		Case 'E'
			ls_msg = 'eliminado'
		Case 'R'
			ls_msg = 'recuperado'
	End Choose
	Commit Using SqlCa ;
	//wf_Imprimir( )
	If ib_mostrarmsg Then
		MessageBox( Title, 'El registro ha sido ' + ls_msg + '.' )
	Else
		gw_frame.SetMicroHelp( 'Pallet ' + ls_pal + ' ha sido ' + ls_msg + '.' )
		Beep(2)
		Beep(1)
	End If
Else
	RollBack Using SqlCa ;
	MessageBox( Title, 'El registro no ha sido guardado.', StopSign! )
End If
cb_aplicar.Enabled = False
ls_col = {'c_elemento', 'c_codigo_pro', 'c_codigo_eti', 'd_empaque_pal', 'c_codigo_col', &
								'c_codigo_env', 'n_bulxpa_pal', 'c_codigo_pal', 'c_codigo_lot' }

For i = 1 To UpperBound( ls_col )
	f_ColEnabled( ldw_1, ls_col[i], False )
	If ii_pag = 2 Then
		f_ColEnabled( idw_mix1, ls_col[i], False )
	End If
Next

If ii_pag = 2 Then
	cb_agregar.Enabled = False
	cb_elimix.Enabled = False
End If

is_acc = ''
is_pal = ''

Return 1
end function

public function boolean wf_datosproducto (string as_pro, datawindow adw_pal);DataWindowChild	ldwc_x
Dec{2}	ldc_bul, ldc_pmn, ldc_pme
Long		ll_row
String	ls_cul, ls_eti, ls_env, ls_img


/* Dependiendo de la ficha en se encuentre el usuario se toma el DW */
adw_pal.AcceptText( )

/* Se captura los precios si hay etiqueta */
ll_row = adw_pal.GetRow()
ls_eti = f_Trim( adw_pal.Object.c_codigo_eti[ ll_row ] )
ls_cul = Left( as_pro, 2 )
If ls_eti <> '' Then
	Select	n_precmn_prp,
				n_precme_prp
	Into 		:ldc_pmn,
				:ldc_pme
	From		t_producto_precio
	Where		c_codigo_pro = :as_pro
	And		c_codigo_eti = :ls_eti
	And		c_activo_prp = '1' ;
	
	If f_SqlError( SqlCa, 'No se pudo obtener informacion de la tabla t_producto_precio.' ) < 0 Then 
		Return False
	End If
	/* Si No hay precios especiales se toman del cultivo */
	If SqlCa.SqlCode = 100 Then
		Select	n_precmn_cul,
					n_precme_cul
		Into 		:ldc_pmn,
					:ldc_pme
		From		t_cultivo
		Where		c_codigo_cul = :ls_cul ;
		If f_SqlError( SqlCa, 'No se pudo obtener informacion de la tabla t_cultivo.' ) < 0 Then 
			Return False
		End If
	End If
End If

Select	c_codigo_env,
			n_bulxpa_pro,
			v_imagen_pro
Into 		:ls_env,
			:ldc_bul,
			:ls_img
From		t_producto
Where		c_codigo_pro = :as_pro
And		c_activo_pro = '1' ;
If f_SqlError( SqlCa, 'No se pudo obtener informacion de la tabla t_producto.' ) < 0 Then 
	Return False
End If
	

adw_pal.Object.c_codigo_env[ll_row] = ls_env
If ii_pag = 1 Then adw_pal.Object.n_bulxpa_pal[ll_row] = ldc_bul
adw_pal.Object.v_imagen_pro[ll_row] = ls_img
adw_pal.Object.n_precmn_pal[ll_row] = ldc_pmn
adw_pal.Object.n_precme_pal[ll_row] = ldc_pme

/* Solo debe mostrar lotes del cultivo del producto del palet */
ldwc_x.SetTransObject( SqlCa )
adw_pal.GetChild( 'c_codigo_lot', ldwc_x )
ldwc_x.SetFilter( "c_codigo_cul = '" + ls_cul + "'" )
ldwc_x.Filter( )
If SqlCa.SqlCode = 100 Then
	MessageBox( Title, 'Producto ingresado/seleccionado no existe o está eliminado.', Exclamation!)
	Return False
End If
	
Return True
end function

public function integer wf_itemchanged (datawindow adw_pal, string as_dwo, string as_data, long al_row);DataWindowChild	ldwc_x
DateTime				ld_emp
String				ls_dato, ls_lot


cb_aceptar.Enabled = True
cb_aplicar.Enabled = True


Choose Case as_dwo
	Case 'c_elemento' /* <--- Identificador del elemento */
		as_data = Left( f_Trim(as_data) + Space(6), 6 )
		ls_dato = Left( as_data, 4 ) 
		adw_pal.Object.c_codigo_pro[al_row] = ls_dato 
		ls_dato = Right( as_data, 2 )
		adw_pal.Object.c_codigo_eti[al_row] = ls_dato 
	Case 'c_codigo_pro'
		ls_dato = f_Trim( adw_pal.Object.c_codigo_eti[al_row] )
		adw_pal.Object.c_elemento[al_row] = as_data + ls_dato 
	Case 'c_codigo_eti'
		ls_dato = f_Trim( adw_pal.Object.c_codigo_pro[al_row] )
		adw_pal.Object.c_elemento[al_row] = ls_dato + as_data
	Case 'c_codigo_col'
		Select	c_codigo_col
		Into 		:ls_dato
		From		t_color
		Where		c_codigo_col = :as_data ;
		If Not f_Trim( ls_dato ) = as_data Then
			MessageBox( Title, 'Color ingresado no existe o eliminado.', Exclamation!)
			Return 2
		End If

	Case 'c_codigo_pal'
		ls_dato = f_Trim( adw_pal.Object.c_codigo_pro[al_row] )
		Select	d_empaque_pal
		Into 		:ld_emp
		From		t_palet
		Where		c_codigo_tem = :gs_codtem
		And		c_codigo_pal = :as_data ;
		If SqlCa.SqlCode = 0 Then
			MessageBox( Title, 'Número de pallet ingresado ya existe para esta temporada.~r~n' + &
										'Fecha de empaque del pallet ' + String( ld_emp, 'dd/mm/yyyy'), Exclamation!)
			Return 2
		End If
End Choose


If as_dwo = 'c_elemento' Or as_dwo = 'c_codigo_pro' Then
	ls_dato = Left( as_data, 4 )
	adw_pal.Object.c_codigo_lot[al_row] = is_lot
	/* Busca el producto y obtiene sus datos  */
	If Not wf_DatosProducto( ls_dato, adw_pal ) Then
		Return 2
	End If
End If

adw_pal.Object.c_codigo_tem[al_row] = gs_codtem

If IsNull( adw_pal.Object.d_empaque_pal[al_row] ) Then
	//adw_pal.Object.d_empaque_pal[al_row] = Today( ) 
End If

adw_pal.Object.c_ultimo[1] = f_GetParmValue( '11' )

Return 0
end function

public function long wf_print ();DataWindow	ldw_1
Long		ll_row, ll_rows
String	ls_sec, ls_mess, ls_cod, ls_act, ls_tem, ls_dwp, ls_copias, ls_pallet, ls_print


Choose Case ii_pag
	Case 1
		ldw_1 = idw_nor
	Case 2
		ldw_1 = idw_mix2
	Case 3
		ldw_1 = idw_lis
End Choose

If ldw_1.RowCount( ) <= 0 Then
	Beep(1)
	Return 0
End If

ll_row = ldw_1.GetRow( )
If ll_row = 0 Then ll_row = 1

ls_tem	= ldw_1.Object.c_codigo_tem[ll_row]
ls_cod	= ldw_1.Object.c_codigo_pal[ll_row]
ls_sec	= ldw_1.Object.c_codsec_pal[ll_row]
ls_act	= f_Trim( ldw_1.Object.c_activo_pal[ll_row] )
If ls_act = '0' Then
	MessageBox( Title, 'El registro se encuentra eliminado/cancelado.' )
	ldw_1.SetFocus( )
	Return -1
End If

If ii_pag <> 3 Then
	OpenWithParm( w_arch_palet_imprimir, 'P' )
Else
	OpenWithParm( w_arch_palet_imprimir, 'L' )
End If
	
ls_mess = f_Trim( Message.StringParm )
If ls_mess = '' Then
	ldw_1.SetFocus( )
	Return 0
End If

If ls_mess = '1' Then
	dw_prn.DataObject = 'd_rpt_pallet_x_fechas'
	dw_prn.SetTransObject( SqlCa )
	ll_rows = dw_prn.Retrieve( ls_tem, f_StringToDate( em_ini.Text ), &
										f_StringToDate( em_fin.Text ) )
Else
	ls_dwp = ProfileString( gs_ini, 'System', 'dwPallet', 'd_rpt_pallet_std' )
	If ls_sec >= '01' Then 
		ls_dwp = ProfileString( gs_ini, 'System', 'dwPalletMix', 'd_rpt_pallet_mixto' )
	End If
	dw_prn.DataObject = ls_dwp
	dw_prn.SetTransObject( SqlCa )
	ll_rows = dw_prn.Retrieve( ls_tem, ls_cod ) 
	/* Mejora para la cantidad de copias 14/11/2003 */
	ls_copias = f_GetParmValue( '38' )
	If Integer( ls_copias ) < 1 Then ls_copias = '1'
	
	dw_prn.Object.DataWindow.Print.Copies = Integer( ls_copias )
	
	If ls_mess = '2' Then
		ls_pallet = ProfileString ( gs_ini, 'Printers', 'P-'+f_getpcname(), "")

		If ls_pallet = '' Then
			MessageBox('ATENCION:', 'No se ha seleccionado la impresora de default para imprimir pallets.', Information!)
		Else
			ls_print = f_getPrinter('S', ls_pallet)
		End If
		messagebox(title, ls_print, exclamation!)
		dw_prn.Print( True )
		f_getPrinter('S', ls_print)		
		Return ll_rows
	End If
End If

ls_pallet = ProfileString ( gs_ini, 'Printers', 'P-'+f_getpcname(), "")

If ls_pallet = '' Then
	MessageBox('ATENCION:', 'No se ha seleccionado la impresora de default para imprimir pallets.', Information!)
Else
	ls_print = f_getPrinter('S', ls_pallet)
End If
messagebox(title, ls_print, exclamation!)
f_Preview( dw_prn )

f_getPrinter('S', ls_print)

Return ll_rows

end function

public function boolean wf_setcolumn ();DataWindow	ldw_1
String		ls_col


If ii_pag = 1 Then
	ldw_1 = idw_nor
Else
	ldw_1 = idw_mix1
End If

ldw_1.AcceptText( )

Choose Case ldw_1.GetColumnName( )
	Case 'c_elemento' 
		If ii_pag = 1 Then
			ls_col = 'c_codigo_lot'
		Else
			ls_col = 'n_bulxpa_pal'
		End If
	Case 'n_bulxpa_pal' 
		ls_col = 'c_codigo_lot'
	Case 'c_codigo_lot' 
		ls_col = 'c_codigo_pal'
	Case 'c_codigo_pal' 
		If ii_pag = 2 Then
			cb_agregar.SetFocus( )
			Return True
		End If
End Choose

If ls_col = '' Then
	Return False
End If
ldw_1.SetColumn( ls_col )
ldw_1.SetFocus( )
Return True
end function

public subroutine wf_pallethoy ();wf_SetPag( 3 )

f_getsysdate( )

em_ini.Text = String( gd_sys, 'dd/mm/yyyy' )
em_fin.Text = String( gd_sys, 'dd/mm/yyyy' )
cb_buscar.TriggerEvent( Clicked! )



end subroutine

public function boolean wf_actualizaacumulado (string as_acc);Dec{2}	ldc_bul
DataWindow	ldw_1
uo_DataStore lds_1
Integer	i
Long		ll_row
String	ls_pro, ls_eti, ls_mer

If ii_pag = 1 Then
	ldw_1 = idw_nor
Else
	ldw_1 = idw_mix2
End If

lds_1 = Create uo_DataStore
lds_1.DataObject = 'd_arch_acumulado_edit'
lds_1.SetTransObject( SqlCa ) 

For i = 1 To ldw_1.RowCount( )
	ls_mer = ''
	ls_pro = f_Trim( ldw_1.Object.c_codigo_pro[ i] )
	
	Select	c_merdes_pro
	Into		:ls_mer
	From		t_producto
	Where		c_codigo_pro = :ls_pro ;
	
	ls_eti = f_Trim( ldw_1.Object.c_codigo_eti[ i] )
	ldc_bul = f_Zero( ldw_1.Object.n_bulxpa_pal[ i] )
	ll_row = lds_1.Retrieve( gs_codtem + ls_pro + ls_eti + ls_mer + ls_mer )
	If ll_row = 0 Then
		ll_row = lds_1.InsertRow(0)
		lds_1.Object.c_codigo_tem[ll_row] = gs_codtem
		lds_1.Object.c_codigo_pro[ll_row] = ls_pro
		lds_1.Object.c_codigo_eti[ll_row] = ls_eti
		lds_1.Object.c_merori_acu[ll_row] = ls_mer
		lds_1.Object.c_merdes_acu[ll_row] = ls_mer
		lds_1.Object.n_emphoy_acu[ll_row] = 0
		lds_1.Object.c_codigo_usu[ll_row] = gs_usuario
		lds_1.Object.d_creacion[ll_row] = DateTime( Today( ) )
		lds_1.Object.c_activo[ll_row] = '1'
	Else
		lds_1.Object.c_usumod[ll_row] = gs_usuario
		lds_1.Object.d_modifi[ll_row] = DateTime( Today( ) )
		lds_1.Object.c_activo[ll_row] = '1'
	End If
	If as_acc = 'E' Then
		lds_1.Object.n_emphoy_acu[ll_row] = f_Zero(lds_1.Object.n_emphoy_acu[ll_row]) - ldc_bul
	Else
		lds_1.Object.n_emphoy_acu[ll_row] = f_Zero(lds_1.Object.n_emphoy_acu[ll_row]) + ldc_bul
	End If

	lds_1.AcceptText( )
	If Not lds_1.Update( ) = 1 Then
		Return False
	End If

Next

Return True
end function

public function integer wf_setpag (integer ai_pag);/* wf_SetPag( ai_pag ) */

ii_pag = ai_pag


idw_nor.Visible = (ii_pag = 1)
cb_nuevo.Visible = (ii_pag = 1)
cbx_1.Visible = (ii_pag = 1)
	
cb_aceptar.Visible = (ii_pag = 1 Or ii_pag = 2)
cb_aplicar.Visible = (ii_pag = 1 Or ii_pag = 2)
dw_pro.Visible = (ii_pag = 1 Or ii_pag = 2)
dw_eti.Visible = (ii_pag = 1 Or ii_pag = 2)

If ib_color Then
	dw_col.Visible = (ii_pag = 1 Or ii_pag = 2)
End If

If ii_pag = 1 Then
	idw_act = idw_nor
	idw_nor.SetFocus( )
	idw_nor.Object.c_ultimo[1] = f_GetParmValue( '11' )
	If cbx_1.Checked Then
		cb_aplicar.Default = True
	End If
End If

If ii_pag = 2 Then
	idw_act = idw_mix1
	idw_mix1.X = idw_nor.X
	idw_mix1.Y = idw_nor.Y
	idw_mix1.Width = idw_nor.Width 
	idw_mix2.Width = idw_nor.Width 
	idw_mix2.X = idw_nor.X
	idw_mix2.Y = idw_mix1.Y + idw_mix1.Height
	
	
	idw_mix1.SetFocus( )
	idw_mix1.Object.c_ultimo[1] = f_GetParmValue( '11' )
	cb_aceptar.Default = True
	cb_aplicar.Default = False
End If

idw_mix1.Visible = (ii_pag = 2)
idw_mix2.Visible = (ii_pag = 2)
cb_agregar.Visible = (ii_pag = 2)
cb_elimix.Visible = (ii_pag = 2)
cb_newmix.Visible = (ii_pag = 2)



If ii_pag = 3 Then
	idw_lis.Width = st_tit.Width
	idw_lis.X = idw_nor.X
	idw_act = idw_lis
//	em_fin.Y = idw_nor.Y
//	em_ini.Y = idw_nor.Y
//	st_al.Y = idw_nor.Y
//	st_del.Y = idw_nor.Y
//	cb_ini.Y = idw_nor.Y
//	cb_fin.Y = idw_nor.Y
//	cb_buscar.Y = idw_nor.Y
//	cb_pornumero.Y = idw_nor.Y
	idw_lis.Y = idw_nor.Y + ( st_lis.Height * 4 )
End If

idw_lis.Visible = (ii_pag = 3)
st_lis.Visible = (ii_pag = 3)
cb_eliminar.Visible = (ii_pag = 3)
em_fin.Visible = (ii_pag = 3)
em_ini.Visible = (ii_pag = 3)
st_al.Visible = (ii_pag = 3)
st_del.Visible = (ii_pag = 3)
cb_ini.Visible = (ii_pag = 3)
cb_fin.Visible = (ii_pag = 3)
cb_buscar.Visible = (ii_pag = 3)
cb_pornumero.Visible = (ii_pag = 3)

Return ii_pag
end function

on w_arch_palet_2004.create
this.st_del=create st_del
this.em_ini=create em_ini
this.cb_ini=create cb_ini
this.st_al=create st_al
this.em_fin=create em_fin
this.cb_fin=create cb_fin
this.cb_buscar=create cb_buscar
this.cb_pornumero=create cb_pornumero
this.dw_lis=create dw_lis
this.cb_eliminar=create cb_eliminar
this.cb_listado=create cb_listado
this.cb_mixto=create cb_mixto
this.cb_normal=create cb_normal
this.dw_mix2=create dw_mix2
this.cb_newmix=create cb_newmix
this.cb_elimix=create cb_elimix
this.cb_agregar=create cb_agregar
this.dw_mix1=create dw_mix1
this.cbx_1=create cbx_1
this.cb_nuevo=create cb_nuevo
this.dw_col=create dw_col
this.dw_eti=create dw_eti
this.st_tit=create st_tit
this.dw_pro=create dw_pro
this.dw_nor=create dw_nor
this.p_nota=create p_nota
this.cb_imprimir=create cb_imprimir
this.dw_prn=create dw_prn
this.cb_aplicar=create cb_aplicar
this.cb_cerrar=create cb_cerrar
this.cb_aceptar=create cb_aceptar
this.st_nota=create st_nota
this.st_lis=create st_lis
this.Control[]={this.st_del,&
this.em_ini,&
this.cb_ini,&
this.st_al,&
this.em_fin,&
this.cb_fin,&
this.cb_buscar,&
this.cb_pornumero,&
this.dw_lis,&
this.cb_eliminar,&
this.cb_listado,&
this.cb_mixto,&
this.cb_normal,&
this.dw_mix2,&
this.cb_newmix,&
this.cb_elimix,&
this.cb_agregar,&
this.dw_mix1,&
this.cbx_1,&
this.cb_nuevo,&
this.dw_col,&
this.dw_eti,&
this.st_tit,&
this.dw_pro,&
this.dw_nor,&
this.p_nota,&
this.cb_imprimir,&
this.dw_prn,&
this.cb_aplicar,&
this.cb_cerrar,&
this.cb_aceptar,&
this.st_nota,&
this.st_lis}
end on

on w_arch_palet_2004.destroy
destroy(this.st_del)
destroy(this.em_ini)
destroy(this.cb_ini)
destroy(this.st_al)
destroy(this.em_fin)
destroy(this.cb_fin)
destroy(this.cb_buscar)
destroy(this.cb_pornumero)
destroy(this.dw_lis)
destroy(this.cb_eliminar)
destroy(this.cb_listado)
destroy(this.cb_mixto)
destroy(this.cb_normal)
destroy(this.dw_mix2)
destroy(this.cb_newmix)
destroy(this.cb_elimix)
destroy(this.cb_agregar)
destroy(this.dw_mix1)
destroy(this.cbx_1)
destroy(this.cb_nuevo)
destroy(this.dw_col)
destroy(this.dw_eti)
destroy(this.st_tit)
destroy(this.dw_pro)
destroy(this.dw_nor)
destroy(this.p_nota)
destroy(this.cb_imprimir)
destroy(this.dw_prn)
destroy(this.cb_aplicar)
destroy(this.cb_cerrar)
destroy(this.cb_aceptar)
destroy(this.st_nota)
destroy(this.st_lis)
end on

event open;/* Posición fija de coordenadas */
X = 0
Y = 0

idw_nor = dw_nor
idw_mix1 = dw_mix1
idw_mix2 = dw_mix2
idw_lis = dw_lis

dw_pro.SetTransObject( SqlCa )
dw_pro.Retrieve( )

dw_eti.SetTransObject( SqlCa )
dw_eti.Retrieve( )

dw_col.SetTransObject( SqlCa )
dw_col.Retrieve( )

idw_nor.SetTransObject( SqlCa )
idw_nor.InsertRow(0)
idw_nor.Object.d_empaque_pal[1] = f_GetSysDate( )


idw_mix2.SetTransObject( SqlCa )
idw_mix1.SetTransObject( SqlCa )
idw_mix1.InsertRow(0)
idw_mix1.Object.d_empaque_pal[1] = f_GetSysDate( )


em_ini.Text = f_GetParmValue( '20' )
em_fin.Text = String( Today(), 'dd/mm/yyyy' )
dw_prn.Visible = False


If f_GetParmValue( '19' ) = 'S' Then 
	cbx_1.Checked = True
End If

is_lot = f_GetParmValue( '23' )
ib_generar = (Upper(f_GetParmValue( '27' )) = 'S' )
If ib_generar Then
	idw_nor.Object.c_codigo_pal.Edit.DisplayOnly = 'Yes'
	idw_mix1.Object.c_codigo_pal.Edit.DisplayOnly = 'Yes'
End If

st_nota.Visible = ib_generar
p_nota.Visible = ib_generar


ii_ceros = f_Zero( Integer( f_GetParmValue( '28' ) ) )
ib_mostrarmsg = (f_GetParmValue( '29' ) = 'S' )
ib_color = (f_GetParmValue( '39' ) = 'S' )
If Not ib_color Then
	idw_nor.Object.c_codigo_col.Visible = 0
	idw_nor.Object.c_codigo_col_t.Visible = 0
	idw_mix1.Object.c_codigo_col.Visible = 0
	idw_mix1.Object.c_codigo_col_t.Visible = 0
	idw_mix2.Object.c_codigo_col.Visible = 0
	idw_mix2.Object.c_codigo_col_t.Visible = 0
	idw_lis.Object.c_codigo_col.Visible = 0
	idw_lis.Object.c_codigo_col_t.Visible = 0
End If

cb_normal.TriggerEvent( Clicked! )
end event

event activate;This.WindowState = Maximized!
end event

event resize;cb_cerrar.y = newheight - cb_cerrar.height - 100

st_nota.y = cb_cerrar.y + 120
p_nota.y = cb_cerrar.y + 120

cb_imprimir.y = cb_cerrar.y 
cb_aplicar.y = cb_imprimir.y 
cb_aceptar.y = cb_aplicar.y 

cb_normal.y = cb_cerrar.y //- 200
cb_mixto.y = cb_normal.y 
cb_listado.y = cb_normal.y 
cb_eliminar.y = cb_normal.y 


dw_lis.Height = newheight - 650
dw_mix2.Height = newheight - 1000

dw_pro.Height = newheight - 240
dw_col.Height = dw_pro.Height
dw_eti.Height = dw_pro.Height


end event

type st_del from statictext within w_arch_palet_2004
int X=78
int Y=296
int Width=119
int Height=76
boolean Enabled=false
string Text="Del:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_ini from uo_editmask within w_arch_palet_2004
int X=210
int Y=292
int TabOrder=110
end type

event getfocus;cb_buscar.Default = True
end event

type cb_ini from uo_cbdate within w_arch_palet_2004
int X=558
int Y=296
int TabOrder=120
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_al from statictext within w_arch_palet_2004
int X=722
int Y=296
int Width=73
int Height=76
boolean Enabled=false
string Text="Al:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_fin from uo_editmask within w_arch_palet_2004
int X=855
int Y=292
int TabOrder=110
end type

event getfocus;cb_buscar.Default = True
end event

type cb_fin from uo_cbdate within w_arch_palet_2004
int X=1198
int Y=296
int TabOrder=130
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type cb_buscar from uo_cbother within w_arch_palet_2004
int X=1353
int Y=288
int TabOrder=100
string Text="&Buscar"
end type

event clicked;String	ls_null

SetNull( ls_null )

dw_lis.Retrieve( gs_codtem, f_StringToDate( em_ini.Text ), f_StringToDate( em_fin.Text ), ls_null )
dw_lis.SetFocus( )
end event

type cb_pornumero from uo_cbother within w_arch_palet_2004
int X=1733
int Y=288
int TabOrder=140
string Text="&Por Número..."
end type

event clicked;DateTime	ld_null
String	ls_numdoc

Open( w_arch_ingresar_numero_doc )

ls_numdoc = f_Trim( Message.StringParm )

If ls_numdoc = '' Then Return

If Len( ls_numdoc ) <= 2 Then
	MessageBox( Title, 'Para buscar por número de documento por lo menos ' + & 
							'debe ingresar 3 caracteres consecutivos', Exclamation! )
	Return
End If

ls_numdoc = '%' + ls_numdoc + '%'

SetNull( ld_null )
dw_lis.Retrieve( gs_codtem, ld_null, ld_null, ls_numdoc)
dw_lis.SetFocus( )


end event

type dw_lis from uo_dw_list within w_arch_palet_2004
int X=1298
int Y=1528
int Width=512
int Height=568
int TabOrder=180
string DataObject="d_arch_palet_listado_2004"
end type

type cb_eliminar from uo_cbother within w_arch_palet_2004
int X=1486
int Y=1284
int TabOrder=20
string Text="&Eliminar"
end type

event clicked;uo_DataStore	lds_1, lds_acu
Long		ll_row, ll_find, i
Dec{2}	ldc_bul
String	ls_tipo, ls_mess, ls_cod, ls_man, ls_act, ls_tem, ls_pro, ls_eti, ls_mer

If idw_lis.RowCount( ) <= 0 Then
	Beep(1)
	Return
End If

ll_row = idw_lis.GetRow( )


ls_tipo = idw_lis.Object.c_codsec_pal[ll_row]
ls_cod	= idw_lis.Object.c_codigo_pal[ll_row]
ls_man	= f_Trim( idw_lis.Object.c_codigo_man[ll_row] )
ls_act	= f_Trim( idw_lis.Object.c_activo_pal[ll_row] )
If ls_man <> '' Then
	MessageBox( Title, 'El palet ya se encuentra en un manifiesto, no puede ser actualizado.' )
	idw_lis.SetFocus( )
	Return
End If
If ls_act = '0' Then
	MessageBox( Title, 'El registro ya se encuentra eliminado/cancelado.' )
	idw_lis.SetFocus( )
	Return
End If

If MessageBox( Title, '¿Confirma la eliminación del palet?', Question!, YesNo! ) <> 1 Then
	idw_lis.SetFocus( )
	Return
End If

//OpenWithParm( w_arch_palet_eliminar, ls_tipo )
//ls_mess = f_Trim( Message.StringParm )
//If ls_mess = '' Then
//	idw_lis.SetFocus( )
//	Return
//End If
ls_mess = '2'

lds_1 = Create uo_DataStore
lds_1.DataObject = 'd_arch_palet_mixto'
lds_1.SetTransObject( SqlCa )
lds_1.Retrieve( gs_codtem + ls_cod )

ll_find = lds_1.Find( "c_codsec_pal = '" + ls_tipo + "'", 1, lds_1.RowCount( ) )
If ll_find <= 0 Then
	MessageBox( Title, 'El registro ha sido eliminado.' )
End If

If ls_mess = '1' Then
	lds_1.DeleteRow( ll_find )
End If


lds_acu = Create uo_DataStore
lds_acu.DataObject = 'd_arch_acumulado_edit'
lds_acu.SetTransObject( SqlCa ) 

For i = 1 To lds_1.RowCount( )
	If ls_tipo <> '00' Then	lds_1.Object.c_codsec_pal[i] = String( i, '00' )
	//ls_tem = lds_1.Object.c_usumod_pal[i]
	lds_1.Object.c_usumod_pal[i] = gs_usuario
	lds_1.Object.d_modifi_pal[i] = Today( )
	If ls_mess = '2' Then
		lds_1.Object.c_activo_pal[i] = '0'
	End If
	ls_mer = ''
	ls_pro = f_Trim( lds_1.Object.c_codigo_pro[ i] )
	
	Select	c_merdes_pro
	Into		:ls_mer
	From		t_producto
	Where		c_codigo_pro = :ls_pro ;
	
	ls_eti = f_Trim( lds_1.Object.c_codigo_eti[ i] )
	ldc_bul = f_Zero( lds_1.Object.n_bulxpa_pal[ i] )
	ll_row = lds_acu.Retrieve( gs_codtem + ls_pro + ls_eti + ls_mer + ls_mer )
	If ll_row > 0 Then
		lds_acu.Object.c_usumod[ll_row] = gs_usuario
		lds_acu.Object.d_modifi[ll_row] = DateTime( Today( ) )
		lds_acu.Object.c_activo[ll_row] = '1'
		lds_acu.Object.n_emphoy_acu[ll_row] = f_Zero(lds_acu.Object.n_emphoy_acu[ll_row]) - ldc_bul
	End If
	lds_acu.AcceptText( )
	If lds_acu.Update( ) <> 1 Then
		RollBack Using SqlCa ;
		MessageBox( Title, 'El registro no ha sido actualizado.', StopSign! )
		Destroy lds_acu
		Destroy lds_1
		Return
	End If
Next

/* Ahora hace un borrado fisico del registro de pallet */
Delete From t_palet 
Where c_codigo_pal = :ls_cod ;

If f_SqlError( SqlCa, '' ) = -1 Then
	RollBack Using SqlCa ;
	MessageBox( Title, 'El registro no ha sido actualizado.', StopSign! )
Else
	Commit Using SqlCa ;
	cb_buscar.TriggerEvent( Clicked! )
	MessageBox( Title, 'El registro ha sido eliminado.' )
End If

Destroy lds_acu
Destroy lds_1
end event

type cb_listado from uo_cbother within w_arch_palet_2004
int X=773
int Y=1284
int TabOrder=220
string Text="Listado"
end type

event clicked;wf_SetPag( 3 )
end event

type cb_mixto from uo_cbother within w_arch_palet_2004
int X=416
int Y=1284
int TabOrder=210
string Text="Pallet Mixto"
end type

event clicked;wf_SetPag( 2 )
end event

type cb_normal from uo_cbother within w_arch_palet_2004
int X=59
int Y=1284
int TabOrder=200
string Text="Pallet Normal"
end type

event clicked;

wf_SetPag( 1 ) 
end event

type dw_mix2 from datawindow within w_arch_palet_2004
int X=631
int Y=1528
int Width=521
int Height=568
int TabOrder=90
string DataObject="d_arch_palet_mixto_2004"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event itemchanged;Return wf_ItemChanged( This, dwo.Name, data, row )
end event

type cb_newmix from uo_cbother within w_arch_palet_2004
int X=1979
int Y=624
int TabOrder=80
string Text="Nuevo"
end type

event clicked;DataWindow	ldw_1
DataWindowChild	ldwc_x
DateTime				ld_emp
Integer	i, j
String	ls_col[]

ls_col = {'c_elemento', 'c_codigo_pro', 'c_codigo_eti', 'd_empaque_pal', &
				'c_codigo_env', 'n_bulxpa_pal', 'c_codigo_pal', 'c_codigo_lot', 'c_codigo_col' }

/* Reseteo de Valores */
ldw_1 = idw_mix1
ld_emp = ldw_1.Object.d_empaque_pal[1]
ldw_1.Reset( )
ldw_1.SetTransObject( SqlCa )
ldw_1.InsertRow(0)
ldw_1.SetFocus( )
ldw_1.Object.c_ultimo[1] = f_GetParmValue( '11' )
ldw_1.Object.d_empaque_pal[1]	= ld_emp

For i = 1 To UpperBound( ls_col )
	f_ColEnabled( ldw_1, ls_col[i], True )
Next

/* Solo debe mostrar lotes del cultivo del producto del palet */
idw_mix1.GetChild( 'c_codigo_lot', ldwc_x )
ldwc_x.SetTransObject( SqlCa )
ldwc_x.SetFilter( '' )
ldwc_x.Filter( )
ldwc_x.Retrieve( )

ldw_1 = idw_mix2
ldw_1.SetRedraw( False )
ldw_1.Reset( )
ldw_1.SetTransObject( SqlCa )
ldw_1.SetRedraw( True )
ls_col = {'c_elemento', 'c_codigo_pro', 'c_codigo_eti', 'd_empaque_pal', &
			'c_codigo_env', 'n_bulxpa_pal', 'c_codigo_pal', 'c_codigo_lot', 'c_codigo_col' }
	
For i = 1 To UpperBound( ls_col )
	f_ColEnabled( ldw_1, ls_col[i], True )
Next

cb_agregar.Enabled = True
cb_elimix.Enabled = True

end event

type cb_elimix from uo_cbother within w_arch_palet_2004
int X=1609
int Y=624
int TabOrder=70
string Text="Eliminar"
end type

event clicked;Long	ll_row

If idw_mix2.RowCount( ) <= 0 Then
	Beep(1)
	Return
End If

ll_row = idw_mix2.GetRow( )

idw_mix2.SelectRow( ll_row, True )
If MessageBox( Parent.Title, '¿Confirma que desea eliminar este elemento?', Question!, YesNo! ) = 1 Then
	idw_mix2.DeleteRow(0)
End If
idw_mix2.SelectRow( 0, False )
end event

type cb_agregar from uo_cbother within w_arch_palet_2004
int X=1234
int Y=624
int TabOrder=60
string Text="Agregar"
end type

event clicked;DateTime	ld_emp
Integer	i
String	ls_ele, ls_pal

idw_mix1.AcceptText( )
ls_ele = f_Trim( idw_mix1.Object.c_elemento[1] )
ld_emp = idw_mix1.Object.d_empaque_pal[1]
ls_pal = idw_mix1.Object.c_codigo_pal[1]

If Len( ls_ele ) <> 6 Then
	MessageBox( Parent.Title, 'Debe ingresar el elemento o seleccionar ' + &
					'el producto y la etiqueta.', Exclamation! )
	Return
End If

If IsNull( ld_emp ) Then
	MessageBox( Parent.Title, 'Debe ingresar la fecha del empaque.', Exclamation! )
	//idw_mix1.Object.d_empaque_pal[1] = DateTime( Today( ) )
	Return
End If

If f_Zero( idw_mix1.Object.n_bulxpa_pal[1] ) <= 0 Then
	MessageBox( Parent.Title, 'Debe ingresar la cantidad de bultos(cajas).', Exclamation! )
	Return
End If

i = idw_mix2.InsertRow( 0 )

idw_mix2.Object.c_codigo_tem[i]	= idw_mix1.Object.c_codigo_tem[1]
idw_mix2.Object.c_elemento[i]		= idw_mix1.Object.c_elemento[1]
idw_mix2.Object.d_empaque_pal[i]	= idw_mix1.Object.d_empaque_pal[1]
idw_mix2.Object.c_codigo_pal[i]	= idw_mix1.Object.c_codigo_pal[1]
idw_mix2.Object.c_codigo_pro[i]	= idw_mix1.Object.c_codigo_pro[1]
idw_mix2.Object.c_codigo_eti[i]	= idw_mix1.Object.c_codigo_eti[1]
idw_mix2.Object.c_codigo_col[i]	= idw_mix1.Object.c_codigo_col[1]
idw_mix2.Object.c_codigo_lot[i]	= idw_mix1.Object.c_codigo_lot[1]
idw_mix2.Object.c_codigo_env[i]	= idw_mix1.Object.c_codigo_env[1]
idw_mix2.Object.n_bulxpa_pal[i]	= idw_mix1.Object.n_bulxpa_pal[1]
idw_mix2.ScrollToRow( i )

For i = 1 To idw_mix2.RowCount( )
	idw_mix2.Object.c_codigo_pal[i] = idw_mix1.Object.c_codigo_pal[1]
Next

idw_mix1.DeleteRow( 0 )
idw_mix1.InsertRow( 0 )

idw_mix1.Object.d_empaque_pal[1] = ld_emp 
idw_mix1.Object.c_codigo_pal[1] = ls_pal 
idw_mix1.SetFocus( )
idw_mix1.SetColumn( 'c_elemento' )
end event

type dw_mix1 from datawindow within w_arch_palet_2004
event ue_lbuttondown pbm_lbuttondown
int X=78
int Y=1484
int Width=521
int Height=620
int TabOrder=10
string DataObject="d_arch_palet_mixto_cab_2004"
boolean Border=false
boolean LiveScroll=true
end type

event itemchanged;Return wf_ItemChanged( This, dwo.Name, data, row )
end event

event buttonclicked;If dwo.Name = 'cb_mas' Then
	Object.n_bulxpa_pal[ 1] = f_Zero( Object.n_bulxpa_pal[ 1] ) + 1
End If
If dwo.Name = 'cb_menos' Then
	Object.n_bulxpa_pal[ 1] = f_Zero( Object.n_bulxpa_pal[ 1] ) - 1
End If
end event

type cbx_1 from checkbox within w_arch_palet_2004
int X=1568
int Y=1004
int Width=439
int Height=76
string Text="Igual al anterior"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_nuevo from uo_cbother within w_arch_palet_2004
int X=1193
int Y=992
int TabOrder=160
string Text="Nuevo"
end type

event clicked;DataWindowChild	ldwc_x
DateTime	ld_emp
Dec{2}	ldc_bul
Integer	i
String	ls_col[], ls_ele, ls_lot, ls_env, ls_clr


idw_nor.AcceptText( )
ld_emp = idw_nor.Object.d_empaque_pal[1]

If cbx_1.Checked Then
	ls_ele = idw_nor.Object.c_elemento[1]
	ls_lot = idw_nor.Object.c_codigo_lot[1]
	ls_env = idw_nor.Object.c_codigo_env[1]
	ls_clr = idw_nor.Object.c_codigo_col[1]
	ldc_bul = idw_nor.Object.n_bulxpa_pal[1]
End If
idw_nor.Reset( )
idw_nor.SetTransObject( SqlCa )
idw_nor.InsertRow(0)
idw_nor.SetFocus( )
idw_nor.Object.c_ultimo[1] = f_GetParmValue( '11' )

ls_col = {'c_elemento', 'c_codigo_pro', 'c_codigo_eti', 'd_empaque_pal', &
			'c_codigo_pal', 'c_codigo_lot', 'c_codigo_col' }

For i = 1 To UpperBound( ls_col )
	f_ColEnabled( idw_nor, ls_col[i], True )
Next

idw_nor.GetChild( 'c_codigo_lot', ldwc_x )
ldwc_x.SetTransObject( SqlCa )
ldwc_x.SetFilter( '' )
ldwc_x.Filter( )
ldwc_x.Retrieve( )

If cbx_1.Checked Then
	idw_nor.Object.c_elemento[1]	= ls_ele
	wf_ItemChanged( idw_nor, 'c_elemento', ls_ele, 1 )
	idw_nor.Object.c_codigo_pro[1] = Left( ls_ele, 4 )
	idw_nor.Object.c_codigo_eti[1] = Right( ls_ele, 2 )
	idw_nor.Object.c_codigo_lot[1] = ls_lot
	idw_nor.Object.c_codigo_col[1] = ls_clr
	idw_nor.Object.c_codigo_env[1] = ls_env
	idw_nor.Object.n_bulxpa_pal[1] = ldc_bul
	idw_nor.SetColumn( 'c_codigo_pal' )
	cb_aplicar.Default = True //( )
End If

idw_nor.Object.d_empaque_pal[1]	= ld_emp

end event

type dw_col from datawindow within w_arch_palet_2004
int X=3195
int Y=140
int Width=302
int Height=1236
int TabOrder=190
string DataObject="d_arch_palet_color_2004"
boolean Border=false
boolean LiveScroll=true
end type

event clicked;String	ls_data

If row <= 0 Then Return

ls_data = Object.c_codigo_col[row]
idw_act.Object.c_codigo_col[1] = ls_data

wf_ItemChanged( idw_act, 'c_codigo_col', ls_data, 1 )

end event

type dw_eti from datawindow within w_arch_palet_2004
int X=2875
int Y=140
int Width=302
int Height=1236
int TabOrder=50
string DataObject="d_arch_palet_etiqueta_2004"
boolean Border=false
boolean LiveScroll=true
end type

event clicked;String	ls_ele, ls_data


If row <= 0 Then Return

ls_data = Object.c_codigo_eti[row]
idw_act.Object.c_codigo_eti[1] = ls_data
ls_ele = idw_act.Object.c_codigo_pro[1] 
ls_ele = ls_ele + ls_data
idw_act.Object.c_elemento[1] = ls_ele

wf_ItemChanged( idw_act, 'c_codigo_eti', ls_data, 1 )

end event

type st_tit from statictext within w_arch_palet_2004
int X=59
int Y=52
int Width=3383
int Height=72
boolean Enabled=false
string Text="    Registro de Pallet"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=15780518
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_pro from datawindow within w_arch_palet_2004
int X=2555
int Y=140
int Width=302
int Height=1236
int TabOrder=40
string DataObject="d_arch_palet_producto_2004"
boolean Border=false
boolean LiveScroll=true
end type

event clicked;String	ls_data

If row <= 0 Then Return

ls_data = Object.c_codigo_pro[row]
idw_act.Object.c_codigo_pro[1] = ls_data
idw_act.Object.c_elemento[1] = ls_data

wf_ItemChanged( idw_act, 'c_codigo_pro', ls_data, 1 )
end event

type dw_nor from datawindow within w_arch_palet_2004
int X=59
int Y=136
int Width=2418
int Height=976
int TabOrder=30
string DataObject="d_arch_palet_normal_2004"
boolean Border=false
boolean LiveScroll=true
end type

event editchanged;

If Not cb_aceptar.Enabled Then cb_aceptar.Enabled = True
If Not cb_aplicar.Enabled Then cb_aplicar.Enabled = True
end event

event itemchanged;
Return wf_ItemChanged( This, dwo.Name, data, row )
end event

type p_nota from picture within w_arch_palet_2004
int X=73
int Y=1408
int Width=73
int Height=56
string PictureName="nota.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type cb_imprimir from uo_cbother within w_arch_palet_2004
int X=1842
int Y=1284
int TabOrder=230
string Text="Imprimir"
end type

event clicked;wf_Print( )
end event

type dw_prn from datawindow within w_arch_palet_2004
int X=37
int Y=1160
int Width=137
int Height=92
boolean LiveScroll=true
end type

type cb_aplicar from uo_cbother within w_arch_palet_2004
event ue_postaply pbm_custom01
int X=1486
int Y=1284
int TabOrder=170
boolean Enabled=false
string Text="&Aplicar"
end type

event ue_postaply;If Not cb_aceptar.Enabled Then
	If ii_pag = 1 Then
		cb_nuevo.SetFocus( )
		cb_nuevo.Default = True
	End If
	If ii_pag = 2 Then
		cb_newmix.SetFocus( )
	End If
End If

end event

event clicked;
If wf_Aplicar( ) = 1 Then
	cb_aceptar.Enabled = False
	If Upper( f_GetParmValue( '21' ) ) <> 'N' Then
		wf_Print( )
	End If
	PostEvent( 'ue_PostAply' )
End If
end event

type cb_cerrar from uo_cbcancelar within w_arch_palet_2004
int X=2199
int Y=1284
int TabOrder=240
string Text="Cerrar"
end type

type cb_aceptar from uo_cbaceptar within w_arch_palet_2004
int X=1129
int Y=1284
int TabOrder=150
boolean Enabled=false
end type

event clicked;If wf_Aplicar( ) = 1 Then
	wf_Print( )
	Close ( Parent )
End If
end event

type st_nota from statictext within w_arch_palet_2004
int X=59
int Y=1400
int Width=3383
int Height=80
boolean Enabled=false
string Text="        El Número de Pallet no podrá ser modificado"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=15780518
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_lis from statictext within w_arch_palet_2004
int X=59
int Y=176
int Width=3383
int Height=72
boolean Enabled=false
string Text="    Listado"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=15780518
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

