$PBExportHeader$w_arch_palet_2.srw
forward
global type w_arch_palet_2 from Window
end type
type st_pp from statictext within w_arch_palet_2
end type
type tab_1 from tab within w_arch_palet_2
end type
type tabpage_1 from userobject within tab_1
end type
type dw_nor from datawindow within tabpage_1
end type
type cb_nuevo from uo_cbother within tabpage_1
end type
type cbx_1 from checkbox within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type cbx_ext from checkbox within tabpage_2
end type
type cbx_nac from checkbox within tabpage_2
end type
type st_mer from statictext within tabpage_2
end type
type dw_mix2 from datawindow within tabpage_2
end type
type cb_agregar from uo_cbother within tabpage_2
end type
type cb_elimix from uo_cbother within tabpage_2
end type
type cb_newmix from uo_cbother within tabpage_2
end type
type dw_mix1 from datawindow within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_lis from uo_dw_list within tabpage_3
end type
type st_1 from statictext within tabpage_3
end type
type em_ini from uo_editmask within tabpage_3
end type
type cb_5 from uo_cbdate within tabpage_3
end type
type st_2 from statictext within tabpage_3
end type
type em_fin from uo_editmask within tabpage_3
end type
type cb_fin from uo_cbdate within tabpage_3
end type
type cb_buscar from uo_cbother within tabpage_3
end type
type cb_modificar from uo_cbother within tabpage_3
end type
type cb_eliminar from uo_cbother within tabpage_3
end type
type cb_manifiesto from uo_cbother within tabpage_3
end type
type cb_pornumero from uo_cbother within tabpage_3
end type
type cb_expandir from uo_cbother within tabpage_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_scmix2 from datawindow within tabpage_4
end type
type cb_scagrega from commandbutton within tabpage_4
end type
type cb_scelimina from commandbutton within tabpage_4
end type
type cb_scmix from commandbutton within tabpage_4
end type
type dw_scmix from datawindow within tabpage_4
end type
type tabpage_5 from userobject within tab_1
end type
type st_4 from statictext within tabpage_5
end type
type sle_1 from singlelineedit within tabpage_5
end type
type st_3 from statictext within tabpage_5
end type
type sle_pal from singlelineedit within tabpage_5
end type
type cb_1 from commandbutton within tabpage_5
end type
type dw_confirma from datawindow within tabpage_5
end type
type cb_2 from commandbutton within tabpage_5
end type
type st_nota from statictext within w_arch_palet_2
end type
type p_nota from picture within w_arch_palet_2
end type
type cb_imprimir from uo_cbother within w_arch_palet_2
end type
type dw_prn from datawindow within w_arch_palet_2
end type
type cb_aplicar from uo_cbother within w_arch_palet_2
end type
type cb_cerrar from uo_cbcancelar within w_arch_palet_2
end type
type cb_aceptar from uo_cbaceptar within w_arch_palet_2
end type
type cb_confirma from commandbutton within w_arch_palet_2
end type
type tabpage_1 from userobject within tab_1
dw_nor dw_nor
cb_nuevo cb_nuevo
cbx_1 cbx_1
end type
type tabpage_2 from userobject within tab_1
cbx_ext cbx_ext
cbx_nac cbx_nac
st_mer st_mer
dw_mix2 dw_mix2
cb_agregar cb_agregar
cb_elimix cb_elimix
cb_newmix cb_newmix
dw_mix1 dw_mix1
end type
type tabpage_3 from userobject within tab_1
dw_lis dw_lis
st_1 st_1
em_ini em_ini
cb_5 cb_5
st_2 st_2
em_fin em_fin
cb_fin cb_fin
cb_buscar cb_buscar
cb_modificar cb_modificar
cb_eliminar cb_eliminar
cb_manifiesto cb_manifiesto
cb_pornumero cb_pornumero
cb_expandir cb_expandir
end type
type tabpage_4 from userobject within tab_1
dw_scmix2 dw_scmix2
cb_scagrega cb_scagrega
cb_scelimina cb_scelimina
cb_scmix cb_scmix
dw_scmix dw_scmix
end type
type tabpage_5 from userobject within tab_1
st_4 st_4
sle_1 sle_1
st_3 st_3
sle_pal sle_pal
cb_1 cb_1
dw_confirma dw_confirma
cb_2 cb_2
end type
type tab_1 from tab within w_arch_palet_2
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type
end forward

global type w_arch_palet_2 from Window
int X=1056
int Y=484
int Width=3054
int Height=1688
boolean TitleBar=true
string Title="Pallet"
string MenuName="m_principal_arch_pallet"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
event ue_print pbm_custom01
st_pp st_pp
tab_1 tab_1
st_nota st_nota
p_nota p_nota
cb_imprimir cb_imprimir
dw_prn dw_prn
cb_aplicar cb_aplicar
cb_cerrar cb_cerrar
cb_aceptar cb_aceptar
cb_confirma cb_confirma
end type
global w_arch_palet_2 w_arch_palet_2

type variables
DataWindow idw_nor, idw_mix1, idw_mix2, idw_lis,idw_scnor,idw_scmix1,idw_scmix2,idw_confirma
Boolean ib_generar = True, ib_mostrarmsg = True, ib_color = False
Integer ii_pag = 1, ii_ceros = 0
String is_acc = 'I', is_pal = '', is_lot, is_staemp = '1',is_merp
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
public function datetime wf_getsysdate ()
public function integer wf_buscapalletsc (string as_cod)
public function boolean wf_actualizaacumuladosc (string as_acc)
public function integer wf_generavarios (datawindow adw_list)
public function integer wf_agregar ()
public function integer wf_palletsato ()
public function integer wf_generadbfmix (string as_tem, string as_cod, string as_cod2)
public function integer wf_agregar2 ()
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
	//====
elseif ii_pag = 4 then
	ldw_1 = idw_scmix2
	If is_acc = 'M' Then
		ls_acc = is_acc
	End If
	//====
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
	tab_1.tabpage_1.cb_nuevo.SetFocus( )
	//tab_1.tabpage_1.cb_nuevo.Default = True
End If
	For ll_row = 1 To ldw_1.RowCount( )
		/* Elemento = a Producto + Etiqueta */
		ldw_1.SetRow( ll_row )
		ldw_1.ScrollToRow( ll_row )
		ls_ele = f_Trim( ldw_1.Object.c_elemento[ll_row] )
		If ii_pag = 2  or ii_pag = 4 Then //20081007
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
	//next
	//==================================================================
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
			ldw_1.Object.c_staemp_pal[ll_row] = is_staemp
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
NEXT
//Commit Using SqlCa ;
	For i = 1 To UpperBound( ls_col )
		f_ColEnabled( ldw_1, ls_col[i], False )
		If ii_pag = 2 Then
			f_ColEnabled( idw_mix1, ls_col[i], False )
		End If
		
		if ii_pag = 4 then
			f_ColEnabled( idw_scmix1, ls_col[i], False )
		End If
	Next

If ii_pag = 2 Then
	tab_1.tabpage_2.cb_agregar.Enabled = False
	tab_1.tabpage_2.cb_elimix.Enabled = False
	If is_acc = 'M' Then
		tab_1.tabpage_1.Enabled = True
		tab_1.tabpage_2.cb_newmix.TriggerEvent( Clicked! )
		Tab_1.SelectedTab = 3
		tab_1.tabpage_3.cb_buscar.TriggerEvent( Clicked! )
	End If
End If

If ii_pag = 4 Then
	tab_1.tabpage_4.cb_scagrega.Enabled = False
	tab_1.tabpage_4.cb_scelimina.Enabled = False
	If is_acc = 'M' Then
		tab_1.tabpage_1.Enabled = True
		tab_1.tabpage_1.Enabled = True
		tab_1.tabpage_4.cb_scmix.TriggerEvent( Clicked! )
		Tab_1.SelectedTab = 4
		tab_1.tabpage_3.cb_buscar.TriggerEvent( Clicked! )
	End If
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
String				ls_dato, ls_lot, ls_separaf, ls_merpro, ls_pro,ls_enc,ls_cul

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
	Case 'c_codigo_lot'		
		if f_getparmvalue('108') ='S' then//hilda 20091202
			select 	isnull(c_codigo_cul,'')
			into		:ls_cul
			from 		t_lote
			where  	c_codigo_lot=:as_data
			using  	sqlca;
			If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_lote.' ) < 0 Then 
				RollBack Using SqlCa ;
				Return 0
			End If
//			em_1.visible=true
			select 	isnull(c_codigo_cot,'')
			into		:ls_enc
			from 		t_corteyacarreo
			where  	c_status_cot='O'
			and 		c_codigo_cul=:ls_cul
			using  	sqlca;
			If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_corteyacarreo.' ) < 0 Then 
				RollBack Using SqlCa ;
				Return 0
			End If
			
//			em_1.text='Rastreo: ' +ls_enc
			adw_pal.Object.rastreo[al_row]='Rastreo: ' +ls_enc
		else
//			em_1.visible=false
		end if
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
// cambiar el folio que observa el usuario
ls_separaf = upper(f_trim(f_getparmvalue('085')))
ls_pro = adw_pal.Object.c_codigo_pro[al_row]
select c_merdes_pro
		into :ls_merpro
		from t_producto
		where c_codigo_pro = :ls_pro
		using sqlca;
		
		If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_producto.' ) < 0  Then
				Return 0
		End If

if ls_separaf = 'S' then
	if ls_merpro = 'N' then
	adw_pal.Object.c_ultimo[1] = f_GetParmValue( '30' )
	else
	adw_pal.Object.c_ultimo[1] = f_GetParmValue( '11' )
	end if
end if


//adw_pal.Object.c_ultimo[1] = f_GetParmValue( '11' )

Return 0
end function

public function long wf_print ();DataWindow ldw_1
Long		ll_row, ll_rows,ll_numpal,z,li_pal,ll_renglon,k,li_opc
String	ls_sec, ls_mess, ls_cod, ls_act, ls_tem, ls_dwp, ls_copias, ls_pallet, ls_print,ls_Defecto,ls_valta,ls_peso,ls_pr,ls_jul,ls_tpal,ls_separaf
Decimal{2} ldc_peso
Datetime ld_fecha1,ld_fecha2

ls_separaf = upper(f_trim(f_getparmvalue('085')))
//20090216
IF ls_separaf = 'S' then
	IF ii_pag = 3 then
		open(w_rpt_tipo_pallet)
			is_merp = f_trim(Message.StringParm)
			IF is_merp = '' then
				messagebox(title,'Debe elegir tipo de pallet a imprimir',Exclamation!)
				return 0
			END IF
			IF is_merp = 'N' then
				ii_ceros = long(f_trim(f_Getparmvalue('031')))
			END IF
		END IF
	END IF

ls_defecto = f_getprinter('N', "")
//is_printer = ls_defecto //20081007
Choose Case ii_pag
	Case 1
		ldw_1 = idw_nor
		ll_numpal = ldw_1.object.ll_pal[1]
		ls_cod = ldw_1.object.c_codigo_pal[1] 
	Case 2
		ldw_1 = idw_mix2
		ll_numpal = idw_mix1.object.ll_pal[1]
		ls_cod = st_pp.text
	Case 3
		ldw_1 = idw_lis
		ll_row = ldw_1.GetRow( )
		If ll_row = 0 Then
			Return 0
		End If
		ls_cod	= ldw_1.Object.c_codigo_pal[ll_row]
	Case 4
		ldw_1 = idw_scmix2
End Choose

If ldw_1.RowCount( ) <= 0 Then
	Beep(1)
	Return 0
End If

ll_row = ldw_1.GetRow( )
If ll_row = 0 Then ll_row = 1

ls_tem	= ldw_1.Object.c_codigo_tem[ll_row]
//ls_cod	= ldw_1.Object.c_codigo_pal[ll_row]
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
	ld_fecha1 = f_StringToDate( tab_1.tabpage_3.em_ini.Text )
	ld_fecha2 = f_StringToDate( tab_1.tabpage_3.em_fin.Text )
	ll_rows = dw_prn.Retrieve( ls_tem,ld_fecha1 ,ld_fecha2 ,'%')
Else
	If is_staemp <> '2' Then //20081118
		ls_dwp = ProfileString( gs_ini, 'System', 'dwPallet', 'd_rpt_pallet_std' )
		If ls_sec >= '01' Then 
			ls_dwp = ProfileString( gs_ini, 'System', 'dwPalletMix', 'd_rpt_pallet_mixto' )
		End If
		If ls_dwp = '' Then
			ls_dwp = 'd_rpt_pallet_std'
			If ls_sec >= '01' Then ls_dwp = 'd_rpt_pallet_mixto'
			MessageBox( Title, 'No tiene configurado el formato de etiqueta.~r~r' + &
										'se usará la etiqueta por default.(' + ls_dwp + ')', Exclamation! )
		End If
	Else
		ls_dwp = ProfileString( gs_ini, 'System', 'dwPalletsc', 'd_rpt_pallet_std_sc' )
		If ls_sec >= '01' Then 
			ls_dwp = ProfileString( gs_ini, 'System', 'dwPalletMixsc', 'd_rpt_pallet_mixto_sc' )
		End If
		If ls_dwp = '' Then
			ls_dwp = 'd_rpt_pallet_std_sc'
			If ls_sec >= '01' Then ls_dwp = 'd_rpt_pallet_mixto_sc'
			MessageBox( Title, 'No tiene configurado el formato de etiqueta.~r~r' + &
										'se usará la etiqueta por default.(' + ls_dwp + ')', Exclamation! )
		End If
	End If
	dw_prn.DataObject = ls_dwp
	dw_prn.SetTransObject( SqlCa )
	ls_copias = f_trim(f_GetParmValue( '38' ))
	If ls_copias = '' Then ls_copias = '1'
	If Integer( ls_copias ) < 1 Then ls_copias = '1'	
	dw_prn.Object.DataWindow.Print.Copies = Integer( ls_copias )
	If ls_mess = '2' Then
		ls_pallet = ProfileString ( gs_ini, 'Printers', 'P-'+f_getpcname(), "")
		If ls_pallet = '' Then
			MessageBox('ATENCION:', 'No se ha seleccionado la impresora de default para imprimir pallets.', Information!)
		Else
			ls_print = f_getprinter('N', "")
			f_getPrinter('S', ls_pallet) 
		End If
		
		//20081008 imprimir multiples
		//IMPRIMIR PALLET PARA ALTA y GPE=============================
		ls_valta = f_trim(f_getparmvalue('078'))
		If ls_valta = 'S' then // And ls_sec = '00' Then 
			If wf_palletsato() = 1 Then
				return 1
			Else
				return 0
			End If
		Else
			if ii_pag = 1 or ii_pag = 2 then
				if ll_numpal > 1 then
					for z = 1 to ll_numpal
						if z = 1 then
							ls_cod = f_trim(st_pp.text)
							IF ls_separaf = 'S' and ls_dwp = 'd_rpt_pallet_sanemilio_5secciones' THEN
								ll_rows = dw_prn.Retrieve( ls_tem, ls_cod,is_merp )
								dw_prn.Print( True )
							ELSE
								ll_rows = dw_prn.Retrieve( ls_tem, ls_cod )
								dw_prn.Print( True )
							END IF
						else
							ls_cod = string(long(ls_cod) + 1)
							li_pal = ii_ceros
							ls_cod = Right( Fill( '0', li_pal ) + ls_cod, li_pal )
							IF ls_separaf = 'S' and ls_dwp = 'd_rpt_pallet_sanemilio_5secciones' THEN
								ll_rows = dw_prn.Retrieve( ls_tem, ls_cod ,is_merp) 
								dw_prn.Print( True )
							ELSE
								ll_rows = dw_prn.Retrieve( ls_tem, ls_cod ) 
								dw_prn.Print( True )
							END IF
						end if
					next
				else
					IF ls_separaf = 'S' and ls_dwp = 'd_rpt_pallet_sanemilio_5secciones' THEN
						ll_rows = dw_prn.Retrieve( ls_tem, ls_cod,is_merp )
						dw_prn.Print( True ) //estaba solo este
					ELSE
						ll_rows = dw_prn.Retrieve( ls_tem, ls_cod )
						dw_prn.Print( True ) //estaba solo este
					END IF
				end if
			else
				IF ls_separaf = 'S' and ls_dwp = 'd_rpt_pallet_sanemilio_5secciones' THEN
					ll_rows = dw_prn.Retrieve( ls_tem, ls_cod,is_merp )
					dw_prn.Print( True ) //estaba solo este
				ELSE
					ll_rows = dw_prn.Retrieve( ls_tem, ls_cod )
					dw_prn.Print( True ) //estaba solo este
				END IF
			end if
			
			f_getPrinter('S', ls_print)
			f_getPrinter('S', ls_defecto) //20081005
			Return ll_rows
		End If
		//========================================================
	End If
End If
ls_pallet = ProfileString ( gs_ini, 'Printers', 'P-'+f_getpcname(), "")

If ls_pallet = '' Then
	MessageBox('ATENCION:', 'No se ha seleccionado la impresora de default para imprimir pallets.', Information!)
Else
	ls_print = f_getprinter('N', "")
	f_getPrinter('S', ls_pallet)
End If

IF ls_separaf = 'S' and ls_dwp = 'd_rpt_pallet_sanemilio_5secciones' THEN
	If ls_mess <> '1' Then ll_rows = dw_prn.Retrieve( ls_tem, ls_cod,is_merp )
ELSE
	If ls_mess <> '1' Then ll_rows = dw_prn.Retrieve( ls_tem, ls_cod )
END IF

f_getPrinter('S', ls_pallet)
f_Preview( dw_prn )

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
		if ii_pag = 1 then
			//ls_col = 'c_codigo_pal'
			ls_col = 'n_peso_pal'
		else
			ls_col = 'n_peso_pal'
			//ls_col = 'll_pal'
		end if
	Case 'n_peso_pal'
		if ii_pag = 1 then
			ls_col = 'll_pal'
		else
			ls_col = 'll_pal'
		end if
	Case 'c_codigo_pal' 
		If ii_pag = 2 Then
			tab_1.tabpage_2.cb_agregar.SetFocus( )
			Return True
		End If
	case 'll_pal'
		if ii_pag = 2 then
			if wf_agregar() = 1 then
				ls_col = 'c_elemento'
			end if
			//tab_1.tabpage_2.cb_agregar.SetFocus( )
		end if
		
End Choose

If ls_col = '' Then
	Return False
End If
ldw_1.SetColumn( ls_col )
ldw_1.SetFocus( )
Return True
//DataWindow	ldw_1
//String		ls_col
//
//
//If ii_pag = 1 Then
//	ldw_1 = idw_nor
//Else
//	ldw_1 = idw_mix1
//End If
//
//ldw_1.AcceptText( )
//
//Choose Case ldw_1.GetColumnName( )
//	Case 'c_elemento' 
//		If ii_pag = 1 Then
//			ls_col = 'c_codigo_lot'
//		Else
//			ls_col = 'n_bulxpa_pal'
//		End If
//	Case 'n_bulxpa_pal' 
//		ls_col = 'c_codigo_lot'
//	Case 'c_codigo_lot' 
//		ls_col = 'll_pal'
//		//ls_col = 'c_codigo_pal'
//	case 'll_pal' 
//		ls_col = 'c_codigo_pal'
//	Case 'c_codigo_pal' 
//		If ii_pag = 2 Then
//			tab_1.tabpage_2.cb_agregar.SetFocus( )
//			Return True
//		End If
//End Choose
//
//If ls_col = '' Then
//	Return False
//End If
//ldw_1.SetColumn( ls_col )
//ldw_1.SetFocus( )
//Return True
//
//
///*DataWindow	ldw_1
//String		ls_col
//
//If ii_pag = 1 Then
//	ldw_1 = idw_nor
//Else
//	ldw_1 = idw_mix1
//End If
//
//ldw_1.AcceptText( )
//
//Choose case ldw_1.getcolumnname()
//	Case 'c_elemento' 
//		If ii_pag = 1 Then
//			ls_col = 'c_codigo_lot'
//		Elseif ii_pag = 2 then
//			ls_col = 'n_bulxpa_pal'
//		End If
//		
//	Case 'c_codigo_lot'
//		If ii_pag = 1 Then
//			ls_col = 'll_pal'
//		Elseif ii_pag = 2 then
//			ls_col = 'c_codigo_pal'
//		end if
//	case 'll_pal'
//		If ii_pag = 1 Then
//			ls_col = 'c_codigo_pal'
//		Elseif ii_pag = 2 then
//			tab_1.tabpage_2.cb_agregar.SetFocus( )
//		end if
//		
//	case 'c_codigo_pal'
//		If ii_pag = 1 Then
//			ls_col = 'c_codigo_pro'
//		Elseif ii_pag = 2 then 
//			ls_col = 'c_codigo_pro'
//		end if
//		
//	case 'c_codigo_pro'
//		If ii_pag = 1 Then
//			ls_col = 'c_codigo_eti'
//		Elseif ii_pag = 2 then
//			ls_col = 'c_codigo_eti'
//		end if
//	case 'c_codigo_eti'
//		If ii_pag = 1 Then
//			cb_aceptar.SetFocus( )
//		Elseif ii_pag = 2 then
//			ls_col = 'll_pal'
//		end if
//		
//end choose
//
////Choose Case ldw_1.GetColumnName( )
////	Case 'c_elemento' 
////		If ii_pag = 1 Then
////			ls_col = 'c_codigo_lot'
////		Else
////			ls_col = 'n_bulxpa_pal'
////		End If
////	Case 'n_bulxpa_pal' 
////		ls_col = 'c_codigo_lot'
////	Case 'c_codigo_lot' 
////		ls_col = 'c_codigo_pal'
////	Case 'c_codigo_pal' 
////		If ii_pag = 2 Then
////			ls_col = 'll_pal'
//////			tab_1.tabpage_2.cb_agregar.SetFocus( )
//////			Return True
////		elseif ii_pag = 1 then
////			ls_col = 'll_pal'
////		End If
////		
////	case 'll_pal'
////		If ii_pag = 2 Then
////			tab_1.tabpage_2.cb_agregar.SetFocus( )
////			Return True
////		End If 
////End Choose
////
//If ls_col = '' Then
//	Return False
//End If
//ldw_1.SetColumn( ls_col )
//ldw_1.SetFocus( )
//Return True*/
end function

public subroutine wf_pallethoy ();tab_1.SelectedTab = 3

f_getsysdate( )

tab_1.tabpage_3.em_ini.Text = String( gd_sys, 'dd/mm/yyyy' )
tab_1.tabpage_3.em_fin.Text = String( gd_sys, 'dd/mm/yyyy' )
tab_1.tabpage_3.cb_buscar.TriggerEvent( Clicked! )



end subroutine

public function boolean wf_actualizaacumulado (string as_acc);/* wf_ActualizaAcumulado( as_acc ) */

Boolean	lb_act
Dec{2}	ldc_bul
DataWindow	ldw_1
uo_DataStore lds_1
Integer	i
Long		ll_row
String	ls_pro, ls_eti, ls_mer

// Si es Empaque 0 entonces no debe acumular, esto sucederá cuando
//	se termine cierre del dia, si el empaque es '2'  no debe acumular lo debe hacer al confirmar el pallet
If is_staemp = '0' or is_staemp = '2' Then
	Return True
End If

If ii_pag = 1 Then
	ldw_1 = idw_nor
elseif ii_pag = 5 then
		ldw_1 = idw_confirma
Else
	ldw_1 = idw_mix2
End If

lb_act = f_ActualizaAcumulado( 'PAL', as_acc, ldw_1 )

Return lb_act
end function

public function datetime wf_getsysdate ();DateTime	ld_sys

ld_sys = f_GetSysDate( )

If is_staemp = '0' Then
	ld_sys = DateTime( RelativeDate( Date( ld_sys ), 1 ) )
End If

Return ld_sys
end function

public function integer wf_buscapalletsc (string as_cod);string ls_pal
long li_pal
String  ls_parm, ls_act

if as_cod = ''  Then
	OpenWithParm(w_mant_buscar_x_nombre, 'PAL' )
 	ls_parm = Message.StringParm	
	ls_parm = f_Trim( ls_parm )

	 If Not ls_parm = '' Then
  		as_cod = ls_parm
	 End If

Else	
	li_pal = ii_ceros
	If li_pal > 0 Then 
		as_cod = Right( Fill( '0', li_pal ) + as_cod, li_pal )
	End If

	Select	c_activo_pal
	Into     :ls_act 
	From		t_paletsinconfirmar (nolock)
	Where		c_codigo_pal= :as_cod
	Using SqlCa;

	If ls_act = '0' Then
		MessageBox( Title, 'Código de pallet está eliminado.', Exclamation! )
		tab_1.tabpage_5.sle_pal.text = ''
		tab_1.tabpage_5.sle_pal.setfocus()
		return 0
	Else
		If ls_act = '' Then
			MessageBox( Title, 'Código de pallet no fue encontrado.', Exclamation! )
			tab_1.tabpage_5.sle_pal.text = ''
			tab_1.tabpage_5.sle_pal.setfocus()
			return 0
		End If
	End If
end if

tab_1.tabpage_5.sle_pal.text = as_cod
	wf_agregar2()
//   tab_1.tabpage_5.cb_2.setfocus()
return 1
end function

public function boolean wf_actualizaacumuladosc (string as_acc);// wf_ActualizaAcumuladosc( as_acc ) 
Boolean	lb_act
Dec{2}	ldc_bul
DataWindow	ldw_1
uo_DataStore lds_1
Integer	i
Long		ll_row,ll_contpal
String	ls_pro, ls_eti, ls_mer,ls_pal,ls_edo,ls_hora
datetime ld_fecha
ldw_1 = idw_confirma
ll_contpal = 0
ls_hora  =string(today(),'hh:mm:ss')


ll_row = idw_confirma.rowcount()
FOR I = 1 TO LL_ROW
	ls_pal = idw_confirma.object.c_codigo_pal[i]
	SELECT top 1 c_staemp_pal
	INTO :LS_EDO
	FROM T_PALETsinconfirmar (nolock)
	WHERE C_CODIGO_PAL = :ls_pal
	AND C_CODIGO_TEM = :gs_codtem
	USING SQLCA;
	If f_SqlError( SqlCa, 'No se pudo leer la tabla t_paletsinconfirmar. (select)' ) < 0 Then 
		RollBack Using SqlCa ;
		Return false
	End If
	if ls_edo = '1' then
		ll_contpal = ll_contpal + 1
	end if
NEXT
IF LL_CONTPAL > 0 THEN
	MESSAGEBOX(TITLE,'Existen pallets confirmados en el listado, no puede continuar',exclamation!)
	return false
END IF

lb_act = f_ActualizaAcumulado( 'PAL', as_acc, ldw_1 )
//
IF lb_act THEN
	ll_row = idw_confirma.rowcount()
	if ll_row = 0 then
		messagebox(title,'No existen pallets para confirmar',exclamation!)
		return false
	end if
	
	ld_fecha = f_stringtodate(f_trim(tab_1.tabpage_5.sle_1.text))
	//20081118===
	FOR i = 1 TO ll_row
		ls_pal = idw_confirma.object.c_codigo_pal[i]
		UPDATE t_paletsinconfirmar
		SET d_empaque_pal = :ld_fecha,
			c_staemp_pal = '1'
		WHERE c_codigo_pal = :ls_pal
		AND c_codigo_tem = :gs_codtem
		USING sqlca;
		IF f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_paletsinconfirmar. (update)' ) < 0 Then 
			RollBack Using SqlCa ;
			Return false
		END IF
		
		INSERT INTO t_palet
		select * FROM t_paletsinconfirmar
		WHERE C_CODIGO_PAL = :ls_pal
		AND C_CODIGO_TEM = :gs_codtem
		Using sqlca;
		If f_SqlError( SqlCa, 'No se pudo insertar la información en la tabla t_palet.') = -1 Then
			rollback using sqlca;
			Return False
		End If
			
		update t_palet
		set	c_hora_pal=:ls_hora
		WHERE C_CODIGO_PAL = :ls_pal
		AND C_CODIGO_TEM = :gs_codtem
		Using sqlca;
		If f_SqlError( SqlCa, 'No se pudo insertar la información en la tabla t_palet.') = -1 Then
			rollback using sqlca;
			Return False
		End If
		
		DELETE  t_paletsinconfirmar
		WHERE C_CODIGO_PAL = :ls_pal
		AND C_CODIGO_TEM = :gs_codtem
		Using sqlca;
		If f_SqlError( SqlCa, 'No se pudo borrar la información en la tabla t_paletsinconfirmar.') = -1 Then
			rollback using sqlca;
			Return False
		End If
	NEXT
	cb_confirma.enabled = false
END IF
commit using sqlca;
RETURN lb_act
	
//====
//	Insert Into t_palet (c_codigo_tem,c_codigo_pal,c_codsec_pal,c_codigo_pro,c_codigo_eti,c_codigo_col,
//								c_codigo_lot,d_empaque_pal,c_staemp_pal,c_merdes_pal,c_staemb_pal,c_codigo_man,
//								c_codigo_env,n_bulxpa_pal,n_precmn_pal,n_precme_pal,c_contab_pal,d_contab_pal,
//								c_codigo_usu,d_creacion_pal,c_usumod_pal,d_modifi_pal,c_activo_pal,n_peso_pal)
//	Select 					c_codigo_tem,c_codigo_pal,c_codsec_pal,c_codigo_pro,c_codigo_eti,c_codigo_col,
//								c_codigo_lot,d_empaque_pal,c_staemp_pal,c_merdes_pal,c_staemb_pal,c_codigo_man,
//								c_codigo_env,n_bulxpa_pal,n_precmn_pal,n_precme_pal,c_contab_pal,d_contab_pal,
//								c_codigo_usu,d_creacion_pal,c_usumod_pal,d_modifi_pal,c_activo_pal,n_peso_pal	
//	From t_paletsinconfirmar
//	WHERE C_CODIGO_PAL = :ls_pal
//	AND C_CODIGO_TEM = :GS_CODTEM
//	Using sqlca;
//	If f_SqlError( SqlCa, 'No se pudo insertar la información en la tabla t_palet.') = -1 Then
//		Return False
//	End If
	
//	FOR i = 1 to ll_row// aki cambiaria
//		ls_pal = idw_confirma.object.c_codigo_pal[i]
//		update t_palet 
//		set c_staemp_pal = '1',
//			d_empaque_pal = :ld_fecha
//		where c_codigo_pal = :ls_pal
//				and c_codigo_tem = :gs_codtem
//		using sqlca;
//		If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_palet. (update)' ) < 0 Then 
//			RollBack Using SqlCa ;
//			Return false
//		End If
//	NEXT
	
end function

public function integer wf_generavarios (datawindow adw_list);string ls_tem,	ls_pal,	ls_sec,	ls_pro,ls_eti,ls_lot,ls_man,ls_env,	ls_usu,	ls_mod,	ls_activo,ls_conta,	ls_staemb,ls_nom,ls_pesob
string ls_col,ls_staemp,ls_null,ls_clr,ls_cul,ls_ele,ls_acc,ls_kil,ls_enc,ls_exc,ls_tipo
datetime ld_emp,ld_crea,ld_modifi,ld_null,ld_hoy
decimal{2} ldc_bulto,ldc_premn,ldc_preme,ldc_pesop,ldc_peso,ldc_tb,ldc_tpeso,ldc_por,ldc_pesob
long i,li_pal,ll_row,ll_numpal,j,ll_cnt
string ls_tipop,ls_separaf,ls_hora
adw_list.accepttext()
adw_list.AcceptText( )

ls_separaf = upper(f_trim(f_getparmvalue('085')))

ldc_tb = 0 
ls_acc = 'I'
if ii_pag = 1 then
	ll_numpal = idw_nor.object.ll_pal[1]
	ldc_pesop = f_Zero(idw_nor.object.n_peso_pal[1])
elseif ii_pag = 2 then
	ll_numpal = idw_mix1.object.ll_pal[1]
	ldc_pesop = f_zero(idw_mix1.object.n_peso_pal[1])
end if

setnull(ls_null)
setnull(ld_null)
setnull(ls_tipop)
ll_row = adw_list.rowcount()
ld_hoy = datetime(today())
ls_hora  =string(today(),'hh:mm:ss')

//validaciones===
If KeyDown( KeyEnter! ) Then
	If wf_SetColumn( ) Then
		Return 0
	End If
End If

ll_row = adw_list.GetRow( )
If ll_row = 0 Then 
	MessageBox( Title, 'No existe ningun elemento para el pallet.', Exclamation! )
	Return 0
End If	

ls_ele = f_Trim( adw_list.Object.c_elemento[ll_row] )

If Len( ls_ele ) < 6 Then
	MessageBox( Title, 'Debe ingresar correctamente el elemento del palet.', Exclamation! )
	adw_list.SetFocus( )
	Return 0
End If

FOR j = 1 to ll_numpal
	IF ls_separaf <> 'S' THEN
		ls_pal = String( Double( f_GetParmValue( '11' ) ) + 1 )
		li_pal = ii_ceros
		If li_pal > 0 Then 
			ls_pal = Right( Fill( '0', li_pal ) + ls_pal, li_pal )
		End If
		ls_pal = Right( Fill( '0', li_pal ) + ls_pal, li_pal )
	END IF
	ls_tem = gs_codtem
		
	if j = 1 then
		st_pp.text = ls_pal
		if ii_pag = 1 then
			 idw_nor.object.c_codigo_pal[1] = ls_pal
		else
			idw_mix1.object.c_codigo_pal[1] = ls_pal
		end if
	end if

	for i = 1 to ll_row
		ls_pro = f_trim(adw_list.object.c_codigo_pro[i])
		ls_eti = f_trim(adw_list.object.c_codigo_eti[i])
		ls_lot = f_trim(adw_list.object.c_codigo_lot[i])
		if f_getparmvalue('108') ='S' then//hilda 20091202
			select 	isnull(c_codigo_cul,'')
			into		:ls_cul
			from 		t_lote (nolock)
			where  	c_codigo_lot=:ls_lot
			using  	sqlca;
			If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_lote.' ) < 0 Then 
				RollBack Using SqlCa ;
				Return 0
			End If
			select 	isnull(c_codigo_cot,'')
			into		:ls_enc
			from 		t_corteyacarreo (nolock)
			where  	c_status_cot='O'
			and 		c_codigo_cul=:ls_cul
			using  	sqlca;
			If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_corteyacarreo.' ) < 0 Then 
				RollBack Using SqlCa ;
				Return 0
			End If
			if ls_enc ='' then
				Messagebox(title,'El cultivo no tiene rastreo activo',exclamation!)
				return 0
			end if 
		end if
		
		adw_list.object.c_excedente_pal[i]='0'
		ld_emp = adw_list.object.d_empaque_pal[i]
		ls_man = f_trim(adw_list.object.c_codigo_man[i])
		ls_env = f_trim(adw_list.object.c_codigo_env[i])
		ldc_bulto = f_zero(adw_list.object.n_bulxpa_pal[i])
		ldc_premn = f_zero(adw_list.object.n_precmn_pal[i])
		ldc_preme = f_zero(adw_list.object.n_precme_pal[i])
		ls_conta = '0'
		ls_staemb = f_trim(adw_list.object.c_staemb_pal[i])
		ls_col = f_trim(adw_list.object.c_codigo_col[i])
		ls_staemp = is_staemp
		ls_exc=f_trim(adw_list.object.c_excedente_pal[i])//20091203 hilda
		ls_tipo=f_trim(adw_list.object.c_tipo_pal[i])
		
		If ii_pag =1  Then //20081007
			ls_Sec = '00'
			adw_list.Object.c_codsec_pal[1] = ls_sec
			//mercado es el del producto
			select c_merdes_pro
			into :ls_tipop
			from t_producto (nolock)
			where c_codigo_pro = :ls_pro
			using sqlca;
			If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_producto.' ) < 0  Then
				Return 0
			End If
		else
			ls_sec = right('00'+string(i),2)
			adw_list.Object.c_codsec_pal[i] = ls_sec
			//si es mixto a que mercado se ira //20090216
			IF ls_separaf = 'S' THEN
				IF tab_1.tabpage_2.cbx_nac.checked then
					ls_tipop = 'N'
				ELSEIF tab_1.tabpage_2.cbx_ext.checked then
					ls_tipop = 'E'
				ELSE
					Messagebox(title,'Elija de que mercado es el palet',exclamation!)
					return 0
				END IF
			END IF
		end if
		
		//cambiar el codigo del pallet si maneja separado los folios o no 20090216//
		IF ls_separaf = 'S' THEN
			IF ls_tipop = 'N' THEN
				ls_pal = String( Double( f_GetParmValue( '30' ) ) + 1 )
				li_pal = long(f_getparmvalue('31'))
				ii_ceros = li_pal
				If li_pal > 0 Then 
					ls_pal = Right( Fill( '0', li_pal ) + ls_pal, li_pal )
				End If
				ls_pal = Right( Fill( '0', li_pal ) + ls_pal, li_pal )
			ELSE
				ls_pal = String( Double( f_GetParmValue( '11' ) ) + 1 )
				li_pal = ii_ceros
				If li_pal > 0 Then 
					ls_pal = Right( Fill( '0', li_pal ) + ls_pal, li_pal )
				End If
				ls_pal = Right( Fill( '0', li_pal ) + ls_pal, li_pal )
			END IF
			IF ii_pag = 1 THEN
				 	idw_nor.object.c_codigo_pal[1] = ls_pal
				ELSE
					idw_mix1.object.c_codigo_pal[1] = ls_pal
				END IF
				
				if j = 1 then
					st_pp.text = ls_pal
				end if
		END IF
		//=====================================================

		//validaciones===
		If KeyDown( KeyEnter! ) Then
			If wf_SetColumn( ) Then
				Return 0
			End If
		End If
		
		/* Etiqueta */
		ls_eti = f_Trim( adw_list.Object.c_codigo_eti[i] )
		ls_nom = ''
		Select	v_nombre_eti
		Into		:ls_nom
		From		t_etiqueta (nolock)
		Where		c_codigo_eti = :ls_eti 
		And		c_activo_eti = '1' ;
		If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_etiqueta.' ) < 0  Then
			Return 0
		End If
		If f_Trim( ls_nom ) = '' Then
			MessageBox( Title, 'Debe ingresar/seleccionar una etiqueta activa.', Exclamation! )
			adw_list.SetFocus( )
			Return 0
		End If
				
		/* Color */
		If ib_color Then
			ls_clr = f_Trim( adw_list.Object.c_codigo_col[i] )
			ls_nom = ''
			Select	c_codigo_col
			Into 		:ls_nom
			From		t_color (nolock)
			Where		c_codigo_col = :ls_clr ;
			If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_color.' ) < 0  Then
				Return 0
			End If
			If f_Trim( ls_nom ) = '' Then
				MessageBox( Title, 'Debe ingresar un color válido.', Exclamation! )
				adw_list.SetFocus( )
				Return 0
			End If
		End If	
		/* Lote = Los 2 Primeros digitos del Producto o Elemento */
		ls_lot = f_Trim( adw_list.Object.c_codigo_lot[i] )
		ls_cul = Left( ls_pro, 2 )
		ls_nom = ''
		Select	v_nombre_lot
		Into		:ls_nom
		From		t_lote (nolock)
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
				adw_list.SetFocus( )
				Return 0
			End If
		End If		
		//============checkar si es peso obligatorio y si, es si y tiene 0 no guarde
		ls_pesob = upper(f_trim(f_getparmvalue('079')))
		If ls_pesob = 'S' THEN
			If ldc_pesop = 0 then
				messagebox(title,'Debe ingresar el peso del pallet ya que es obligatorio',exclamation!)
				Return 0
			End If
		End If
		
		If Not wf_DatosProducto( ls_pro, adw_list ) Then
			Return 0
		End If
				
		If f_Zero( adw_list.Object.n_bulxpa_pal[i] ) <= 0 Then
			MessageBox( Title, 'Debe ingresar la cantidad de bultos (cajas) por pallet.', Exclamation! )
			adw_list.SetFocus( )
			Return 0
		End If	
		
		Select	Count(*)
		Into 		:ll_cnt
		From		t_palet
		Where		c_codigo_tem = :gs_codtem
		and 		c_codsec_pal = :ls_sec
		And		c_codigo_pal = :ls_pal ;
		If f_SqlError( SqlCa, 'No se pudo leer la tabla t_palet . (select)' ) < 0 Then 
			 RollBack Using SqlCa ;
			 Return 0
		End If	
		
		if ll_cnt > 0 then
			messagebox(title,'Código de pallet ingresado ya existe',exclamation!)
			return 0
		end if
		
		//=======20081119===chekar si el pallet existe en la sinconfirmados===========
		Select	Count(*)
		Into 		:ll_cnt
		From		t_paletsinconfirmar
		Where		c_codigo_tem = :gs_codtem
		and 		c_codsec_pal = :ls_sec
		And		c_codigo_pal = :ls_pal ;
		If f_SqlError( SqlCa, 'No se pudo leer la tabla t_paletsinconfirmar . (select)' ) < 0 Then 
			 RollBack Using SqlCa ;
			 Return 0
		End If	
		
		if ll_cnt > 0 then
			messagebox(title,'Código de pallet ingresado ya existe',exclamation!)
			return 0
		end if
			
		IF ii_pag = 2 THEN
			ldc_tb = ldc_tb + ldc_bulto
		END IF
		
		if ls_staemp ='2' then //20081114 Hilda cambio de tabla================================================================================================
			IF ii_pag = 1 THEN //20081023 para guardar el peso-20091202guardar rastreo
					insert into t_paletsinconfirmar
						(c_codigo_tem,	c_codigo_pal, 		c_codsec_pal,	c_codigo_pro,	c_codigo_eti,	c_codigo_lot,	d_empaque_pal,	c_codigo_man,	c_codigo_env,	n_bulxpa_pal,
						c_codigo_usu,	d_creacion_pal,	c_usumod_pal,	d_modifi_pal,	c_activo_pal,	n_precmn_pal,	n_precme_pal,	c_contab_pal,	c_staemb_pal,	c_codigo_col,	
						c_staemp_pal,	n_peso_pal	,c_codigo_cot,	c_excedente_pal,c_tipo_pal)
					values
						(:ls_tem,		:ls_pal,				:ls_sec,			:ls_pro,			:ls_eti,			:ls_lot,			:ld_emp,	:ls_man,			:ls_env,			:ldc_bulto,	
						:gs_usuario,	:ld_hoy,			   :ls_null,			:ld_null,		'1',		:ldc_premn,		:ldc_preme,		:ls_conta,		:ls_staemb,		:ls_col,
						:is_staemp,		:ldc_pesop	,:ls_enc	,:ls_exc		,:ls_tipo)
					using sqlca;
					If f_SqlError( SqlCa, 'No se pudo insertar la tabla t_paletsinconfirmar . (insert)' ) < 0 Then 
						 RollBack Using SqlCa ;
						 Return 0
					End If	
			ELSE
				insert into t_paletsinconfirmar
					(c_codigo_tem,	c_codigo_pal, 		c_codsec_pal,	c_codigo_pro,	c_codigo_eti,	c_codigo_lot,	d_empaque_pal,	c_codigo_man,	c_codigo_env,	n_bulxpa_pal,
					c_codigo_usu,	d_creacion_pal,	c_usumod_pal,	d_modifi_pal,	c_activo_pal,	n_precmn_pal,	n_precme_pal,	c_contab_pal,	c_staemb_pal,	c_codigo_col,	
					c_staemp_pal,c_codigo_cot,c_excedente_pal,c_tipo_pal	)
				values
					(:ls_tem,		:ls_pal,				:ls_sec,			:ls_pro,			:ls_eti,			:ls_lot,			:ld_emp,			:ls_man,			:ls_env,			:ldc_bulto,	
					:gs_usuario,	:ld_hoy,			   :ls_null,			:ld_null,		'1',				:ldc_premn,		:ldc_preme,		:ls_conta,		:ls_staemb,		:ls_col,
					:is_staemp,:ls_enc,:ls_exc	,:ls_tipo)
				using sqlca;
				If f_SqlError( SqlCa, 'No se pudo insertar la tabla t_paletsinconfirmar. (insert)' ) < 0 Then 
					 RollBack Using SqlCa ;
					 Return 0
				End If	
			END IF
		else //20081114 Hilda cambio de tabla
			IF ii_pag = 1 THEN //20081023 para guardar el peso-20091202guardar rastreo
				insert into t_palet
					(c_codigo_tem,	c_codigo_pal, 		c_codsec_pal,	c_codigo_pro,	c_codigo_eti,	c_codigo_lot,	d_empaque_pal,	c_codigo_man,	c_codigo_env,	n_bulxpa_pal,
					c_codigo_usu,	d_creacion_pal,	c_usumod_pal,	d_modifi_pal,	c_activo_pal,	n_precmn_pal,	n_precme_pal,	c_contab_pal,	c_staemb_pal,	c_codigo_col,	
					c_staemp_pal,	n_peso_pal, c_hora_pal,c_codigo_cot	,c_excedente_pal,c_tipo_pal			   	)
				values
					(:ls_tem,		:ls_pal,				:ls_sec,			:ls_pro,			:ls_eti,			:ls_lot,			:ld_emp,	:ls_man,			:ls_env,			:ldc_bulto,	
					:gs_usuario,	:ld_hoy,		   	:ls_null,		:ld_null,		'1',		:ldc_premn,		:ldc_preme,		:ls_conta,		:ls_staemb,		:ls_col,
					:is_staemp,		:ldc_pesop	,:ls_hora	,:ls_enc,:ls_exc,:ls_tipo	)
				using sqlca;
				If f_SqlError( SqlCa, 'No se pudo insertar la tabla t_palet . (insert)' ) < 0 Then 
					 RollBack Using SqlCa ;
					 Return 0
				End If	
			ELSE
				insert into t_palet
					(c_codigo_tem,	c_codigo_pal, 		c_codsec_pal,	c_codigo_pro,	c_codigo_eti,	c_codigo_lot,	d_empaque_pal,	c_codigo_man,	c_codigo_env,	n_bulxpa_pal,
					c_codigo_usu,	d_creacion_pal,	c_usumod_pal,	d_modifi_pal,	c_activo_pal,	n_precmn_pal,	n_precme_pal,	c_contab_pal,	c_staemb_pal,	c_codigo_col,	
					c_staemp_pal,  n_peso_pal	,c_hora_pal	,c_codigo_cot,c_excedente_pal,c_tipo_pal)
				values
					(:ls_tem,		:ls_pal,				:ls_sec,			:ls_pro,			:ls_eti,			:ls_lot,			:ld_emp,			:ls_man,			:ls_env,			:ldc_bulto,	
					:gs_usuario,	:ld_hoy,			 :ls_null,			:ld_null,		'1',				:ldc_premn,		:ldc_preme,		:ls_conta,		:ls_staemb,		:ls_col,
					:is_staemp,    :ldc_pesop,:ls_hora	,:ls_enc,:ls_exc,:ls_tipo	)
				using sqlca;
				If f_SqlError( SqlCa, 'No se pudo insertar la tabla t_palet. (insert)' ) < 0 Then 
					 RollBack Using SqlCa ;
					 Return 0
				End If	
			END IF
		end if
	next
	
	IF ii_pag = 2 THEN
		ldc_tpeso = 0
	//repartir los bultos
		ldc_por = ldc_pesop/ldc_tb
		FOR i = 1 TO ll_row
			ls_sec = adw_list.Object.c_codsec_pal[i]
			ldc_bulto = adw_list.object.n_bulxpa_pal[i]
			ldc_peso = adw_list.object.n_peso_pal[i]
			//ldc_peso = round(ldc_por * ldc_bulto,2)
			//ldc_tpeso = ldc_tpeso + ldc_peso	
			IF i = ll_row THEN
				IF ldc_tpeso <> ldc_pesop THEN
					IF ldc_pesop >= ldc_tpeso THEN
						ldc_peso = ldc_peso + (ldc_pesop - ldc_tpeso)
					ELSE
						ldc_peso = ldc_peso - (ldc_tpeso - ldc_pesop)
					END IF
				END IF
			END IF
			if ls_staemp <>'2' then //20081114 Hilda cambio de tabla		========================================						
				UPDATE t_palet
				SET n_peso_pal = :ldc_peso
				WHERE c_codigo_pal = :ls_pal
				AND c_codigo_tem = :ls_tem
				AND c_codsec_pal = :ls_sec
				USING sqlca;
				IF f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_palet . (update)' ) < 0 Then 
					 RollBack Using SqlCa ;
					 Return 0
				END IF	
			elseif ls_staemp ='2' then //20081114 Hilda cambio de tabla==========================================
				UPDATE t_paletsinconfirmar
				SET n_peso_pal = :ldc_peso
				WHERE c_codigo_pal = :ls_pal
				AND c_codigo_tem = :ls_tem
				AND c_codsec_pal = :ls_sec
				USING sqlca;
				IF f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_paletsinconfirmar . (update)' ) < 0 Then 
					 RollBack Using SqlCa ;
					 Return 0
				END IF	
			end if
		NEXT
		tab_1.tabpage_2.cbx_nac.enabled = false
		tab_1.tabpage_2.cbx_ext.enabled = false
	END IF
	if not ls_exc='1' THEN//20091203 hilda acumula cuando no sea excedente
		If Not wf_ActualizaAcumulado( ls_acc ) Then
			RollBack Using SqlCa ;
		End If
	end if
	/* Guarda el ultimo palet generado en la tabla */
	//preguntar si es folio separado
	IF ls_separaf = 'S' THEN
		IF ls_tipop = 'N' THEN
			If Not f_SetParmValue( '30', ls_pal ) Then
				RollBack Using SqlCa ;
				Return -1
			End IF
		ELSE
			If Not f_SetParmValue( '11', ls_pal ) Then
				RollBack Using SqlCa ;
				Return -1
			End IF
		END IF
	ELSE
		If Not f_SetParmValue( '11', ls_pal ) Then
			RollBack Using SqlCa ;
			Return -1
		End IF
	END IF
Next

is_merp = ls_tipop
Return 1
end function

public function integer wf_agregar ();DateTime	ld_emp
Integer	i
long ll_pal
String	ls_ele, ls_pal, ls_pro, ls_nom, ls_kil
decimal{2} ldc_peso, ldc_pesbul

idw_mix1.AcceptText( )
ls_ele = f_Trim( idw_mix1.Object.c_elemento[1] )
ld_emp = idw_mix1.Object.d_empaque_pal[1]
ls_pal = idw_mix1.Object.c_codigo_pal[1]
ll_pal = idw_mix1.object.ll_pal[1]
ldc_peso =  idw_mix1.object.n_peso_pal[1]

If Len( ls_ele ) <> 6 Then
	MessageBox( title, 'Debe ingresar el elemento o seleccionar ' + &
					'el producto y la etiqueta.', Exclamation! )
	Return 0
End If

If IsNull( ld_emp ) Then
	MessageBox( title, 'Debe ingresar la fecha del empaque.', Exclamation! )
	//idw_mix1.Object.d_empaque_pal[1] = DateTime( Today( ) )
	Return 0
End If

If f_Zero( idw_mix1.Object.n_bulxpa_pal[1] ) <= 0 Then
	MessageBox( title, 'Debe ingresar la cantidad de bultos(cajas).', Exclamation! )
	Return 0
End If

ls_pro = f_Trim(idw_mix1.Object.c_codigo_pro[1])
Select v_nombre_pro, c_porkilo_pro, n_pesbul_pro
Into	:ls_nom,     :ls_kil,		  :ldc_pesbul
From	 t_producto
Where	 c_codigo_pro = :ls_pro
And	 c_activo_pro = '1' ;
If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_producto.' ) < 0 Then
	Return 0
End If
If f_Trim(ls_kil) = 'S' and ldc_peso = 0 Then
	MessageBox( Title, 'Debe ingresar el peso del producto.', Exclamation! )
	Return 0
ElseIf f_Trim(ls_kil) = 'N' Then
	ldc_peso = ldc_pesbul * Dec(idw_mix1.Object.n_bulxpa_pal[1])
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
idw_mix2.Object.n_peso_pal[i]	   = ldc_peso
idw_mix2.ScrollToRow( i )

For i = 1 To idw_mix2.RowCount( )
	idw_mix2.Object.c_codigo_pal[i] = idw_mix1.Object.c_codigo_pal[1]
Next

idw_mix1.DeleteRow( 0 )
idw_mix1.InsertRow( 0 )

idw_mix1.Object.d_empaque_pal[1] = ld_emp 
idw_mix1.Object.c_codigo_pal[1] = ls_pal 
idw_mix1.Object.c_staemp_pal[1] = is_staemp
idw_mix1.object.ll_pal[1] = ll_pal
//idw_mix1.object.n_peso_pal[1] = ldc_peso

idw_mix1.SetFocus( )
idw_mix1.SetColumn( 'c_elemento' )

return 1
/*DateTime	ld_emp
Integer	i
String	ls_ele, ls_pal
long ll_pal

idw_mix1.AcceptText( )
ll_pal = idw_mix1.object.ll_pal[1]
ls_ele = f_Trim( idw_mix1.Object.c_elemento[1] )
ld_emp = idw_mix1.Object.d_empaque_pal[1]
ls_pal = idw_mix1.Object.c_codigo_pal[1]

If Len( ls_ele ) <> 6 Then
	MessageBox( title, 'Debe ingresar el elemento o seleccionar ' + &
					'el producto y la etiqueta.', Exclamation! )
	Return 0
End If

If IsNull( ld_emp ) Then
	MessageBox( title, 'Debe ingresar la fecha del empaque.', Exclamation! )
	//idw_mix1.Object.d_empaque_pal[1] = DateTime( Today( ) )
	Return 0
End If

If f_Zero( idw_mix1.Object.n_bulxpa_pal[1] ) <= 0 Then
	MessageBox( title, 'Debe ingresar la cantidad de bultos(cajas).', Exclamation! )
	Return 0
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
idw_mix1.Object.c_staemp_pal[1] = is_staemp
idw_mix1.object.ll_pal[1] = ll_pal

idw_mix1.SetFocus( )
idw_mix1.SetColumn( 'c_elemento' )*/
end function

public function integer wf_palletsato ();datawindow ldw_1
LONG ll_numpal,ll_row,k,li_pal,ll_renglon
STRING ls_tem,ls_sec,ls_act,ls_cod,ls_cod2,ls_pr,ls_fecha,ls_peso,ls_valta,ls_jul,ls_tpal, ls_fn, ls_fm
datastore lds_1
decimal{2} ldc_peso

Choose Case ii_pag
	Case 1
		ldw_1 = idw_nor
		ll_numpal = ldw_1.object.ll_pal[1]
		ls_cod = ldw_1.object.c_codigo_pal[1] 
	Case 2
		ldw_1 = idw_mix2
		ll_numpal = idw_mix1.object.ll_pal[1]
		ls_cod = st_pp.text
	Case 3
		ldw_1 = idw_lis
		ll_row = ldw_1.GetRow( )
		ls_cod	= ldw_1.Object.c_codigo_pal[ll_row]
	Case 4
		ldw_1 = idw_scmix2
End Choose

If ldw_1.RowCount( ) <= 0 Then
	Beep(1)
	Return 0
End If

ll_row = ldw_1.GetRow( )
If ll_row = 0 Then ll_row = 1

ls_tem	= ldw_1.Object.c_codigo_tem[ll_row]
//ls_cod	= ldw_1.Object.c_codigo_pal[ll_row]
ls_sec	= ldw_1.Object.c_codsec_pal[ll_row]
ls_act	= f_Trim( ldw_1.Object.c_activo_pal[ll_row] )
If ls_act = '0' Then
	MessageBox( Title, 'El registro se encuentra eliminado/cancelado.' )
	ldw_1.SetFocus( )
	Return -1
End If
//==========================================20081008 imprimir multiples
//IMPRIMIR PALLET PARA ALTA=============================
ls_valta = f_trim(f_getparmvalue('078'))
//que datastore crear
IF is_staemp <> '2' THEN
	ls_tpal = ProfileString( gs_ini, 'System', 'dwddspal', 'd_arch_dds_pallet_alta' )
ELSE
	ls_tpal = ProfileString( gs_ini, 'System', 'dwddspalSC', 'd_arch_dds_pallet_alta_sc' )
END IF
IF ls_valta = 'S' THEN
	IF ii_pag = 1 or ii_pag = 2 THEN
		IF ls_sec = '00' THEN //20081020 NORMAL
			IF ll_numpal = 1 THEN
				lds_1 = create datastore
				lds_1.dataobject = ls_tpal
				lds_1.settransobject(sqlca)
				lds_1.retrieve(ls_tem,ls_cod,ls_cod)
				ll_renglon =lds_1.rowcount()
			ELSE //mas de una etiqueta
				li_pal = ii_ceros
				ls_cod2 =  string(long(ls_cod) + (ll_numpal - 1))
				ls_cod2 = RIGHT(FILL('0',li_pal) + ls_cod2 ,li_pal)
				lds_1 = create datastore
				lds_1.dataobject = ls_tpal
				lds_1.settransobject(sqlca)
				lds_1.retrieve(ls_tem,ls_cod,ls_cod2)
			END IF 
		ELSE //MIXTO 20081020
				IF ll_numpal = 1 THEN
					ls_cod2 = ls_cod
				ELSE //mas de una etiqueta
					li_pal = ii_ceros
					ls_cod2 =  string(long(ls_cod) + (ll_numpal - 1))
					ls_cod2 = RIGHT(FILL('0',li_pal) + ls_cod2 ,li_pal)
				END IF 
				IF wf_generadbfmix(ls_tem,ls_cod,ls_cod2) <> 1 THEN
					Return 0
				END IF
		END IF//20081020
	ELSE //CUANDO IMPRIMO DEL LISTADO QUE SOLO SE MANDA UNA ETIQUETA
		IF ls_sec = '00' THEN //20081020  NORMAL
			lds_1 = create datastore
			lds_1.dataobject = ls_tpal
			lds_1.settransobject(sqlca)
			lds_1.Retrieve( ls_tem, ls_cod,ls_cod)
			ll_renglon =lds_1.rowcount()
		ELSE //MIXTO20081020
		   IF wf_generadbfmix(ls_tem,ls_cod,ls_cod) <> 1 THEN
				Return 0
			END IF
		END IF //20081020
	END IF
	ls_fn = f_trim(f_getparmvalue('099'))
	if ls_fn = '' then
		ls_fn = 'S1'
	end if
	
	ls_fm = f_trim(f_getparmvalue('100'))
	if ls_fm = '' then
		ls_fm = 'SM1'
	end if
	//messagebox(ls_fm, ls_sec) //cambio jose 20091010
	If ls_sec = '00' Then
		choose case ls_fn
			case 'S1'
				ll_row = lds_1.rowcount()
				lds_1.SaveAs( "c:\eyeprint.dbf", dBASE3!, True )
				If Run('eyeprint.exe EYE_SATO_01', minimized!) <> 1 Then
					messagebox(Title,'Impresión fallo intente de nuevo (S1)',exclamation!)
					Return 0
				Else
					Messagebox(Title,'Documento ha sido enviado a la impresora (S1)',exclamation!)
					Return 1
				End If
			case 'Z1'
				ll_row = lds_1.rowcount()
				lds_1.SaveAs( "c:\eyeprint.dbf", dBASE3!, True )
				If Run('eyeprint.exe EYE_ZEB_01', minimized!) <> 1 Then
					messagebox(Title,'Impresión fallo intente de nuevo (Z1)',exclamation!)
					Return 0
				Else
					Messagebox(Title,'Documento ha sido enviado a la impresora (Z1)',exclamation!)
					Return 1
				End If
			case 'Z2'
				ll_row = lds_1.rowcount()
				lds_1.SaveAs( "c:\eyeprint.dbf", dBASE3!, True )
				If Run('eyeprint.exe EYE_ZEB_03', minimized!) <> 1 Then
					messagebox(Title,'Impresión fallo intente de nuevo (Z2)',exclamation!)
					Return 0
				Else
					Messagebox(Title,'Documento ha sido enviado a la impresora (Z2)',exclamation!)
					Return 1
				End If
			Case 'Z3'
				ll_row = lds_1.rowcount()
				lds_1.SaveAs( "c:\eyeprint.dbf", dBASE3!, True )
				If Run('eyeprint.exe EYE_ZEB_05', minimized!) <> 1 Then
					messagebox(Title,'Impresión fallo intente de nuevo (Z3)',exclamation!)
					Return 0
				Else
					Messagebox(Title,'Documento ha sido enviado a la impresora (Z3)',exclamation!)
					Return 1
				End If				
		    case else
				messagebox(title,'Valor incorrecto en el parametro 099',exclamation!)
			return 0
		end choose
	Else
		choose case ls_fm
			case 'SM1'
				If Run('eyeprint.exe EYE_SATO_02', minimized!) <> 1 Then
					messagebox(Title,'Impresión fallo intente de nuevo (SM1)',exclamation!)
					Return 0
				Else
					Messagebox(Title,'Documento ha sido enviado a la impresora (SM1)',exclamation!)
					Return 1
				End If
			case 'ZM1'
				If Run('eyeprint.exe EYE_ZEB_02', minimized!) <> 1 Then
					messagebox(Title,'Impresión fallo intente de nuevo (ZM1)',exclamation!)
					Return 0
				Else
					Messagebox(Title,'Documento ha sido enviado a la impresora (ZM1)',exclamation!)
					Return 1
				End If
			case 'ZM2'
				If Run('eyeprint.exe EYE_ZEB_04', minimized!) <> 1 Then
					messagebox(Title,'Impresión fallo intente de nuevo (ZM2)',exclamation!)
					Return 0
				Else
					Messagebox(Title,'Documento ha sido enviado a la impresora (ZM2)',exclamation!)
					Return 1
				End If
			Case 'ZM3'
				If Run('eyeprint.exe EYE_ZEB_06', minimized!) <> 1 Then
					messagebox(Title,'Impresión fallo intente de nuevo (ZM2)',exclamation!)
					Return 0
				Else
					Messagebox(Title,'Documento ha sido enviado a la impresora (ZM2)',exclamation!)
					Return 1
				End If				
			case else
				messagebox(title,'Valor incorrecto en el parametro 100',exclamation!)
			return 0
		end choose
		/*if ls_valta = 'Z' then
			If Run('eyeprint.exe EYE_ZEB_02', minimized!) <> 1 Then
				messagebox(Title,'Impresión fallo intente de nuevo (Z)',exclamation!)
				Return 0
			Else
				Messagebox(Title,'Documento ha sido enviado a la impresora (Z)',exclamation!)
				Return 1
			End If
		else
			If Run('eyeprint.exe EYE_SATO_02', minimized!) <> 1 Then
				messagebox(Title,'Impresión fallo intente de nuevo (S)',exclamation!)
				Return 0
			Else
				Messagebox(Title,'Documento ha sido enviado a la impresora(S)',exclamation!)
				Return 1
			End If			
		end if*/
	End If
	
	Destroy lds_1
	Return 1
End If
Return 1
end function

public function integer wf_generadbfmix (string as_tem, string as_cod, string as_cod2);STRING ls_tpal,ls_pal,ls_pro,ls_env,ls_lote,ls_eti,ls_veti,ls_bulto,ls_pals,ls_venv,ls_tpeso,ls_tbulto,ls_vlote, ls_totpeso,ls_cia,ls_fecha,ls_jul,ls_peso, ls_tam
LONG ll_renglon,ll_count,i,k,ll_numpal,ll_cont2
DATASTORE lds_1, lds_2
datawindow ldw_1

ll_count = 0
ls_cia = f_getparmvalue('004')
//validar este cambio
IF is_staemp <> '2' THEN
	ls_tpal = ProfileString( gs_ini, 'System', 'dwddspal', 'd_arch_dds_pallet_alta' )
ELSE
	ls_tpal = ProfileString( gs_ini, 'System', 'dwddspalSC', 'd_arch_dds_pallet_alta_sc' )
END IF

//ls_tpal = ProfileString( gs_ini, 'System', 'dwddspal', 'd_arch_dds_pallet_alta' )
Choose Case ii_pag
 Case 1
  ldw_1 = idw_nor
  ll_numpal = ldw_1.object.ll_pal[1]
 Case 2
  ldw_1 = idw_mix2
  ll_numpal = idw_mix1.object.ll_pal[1]
END CHOOSE

lds_2 = create datastore
lds_2.dataobject = 'd_arch_dds_pallet_mixto_alta'
lds_2.settransobject(sqlca)
IF ii_pag = 1 or ii_pag = 2 THEN
 IF ll_numpal = 1 THEN
  lds_1 = create datastore
  lds_1.dataobject = ls_tpal
  lds_1.settransobject(sqlca)
  lds_1.retrieve(as_tem, as_cod, as_cod)
  ll_renglon =lds_1.rowcount()
  FOR i = 1 TO ll_renglon
   IF i = 1 THEN
    ls_pal = lds_1.object.cpal[i]
    ls_pro = lds_1.object.vpro[i]
    ls_env = lds_1.object.venv[i]
    ls_lote = lds_1.object.clote[i]
    ls_eti = lds_1.object.ceti[i]
    ls_veti = lds_1.object.veti[i]
    ls_bulto = lds_1.object.cbultos[i]
    ls_tpeso = lds_1.object.totpeso[i]
    ls_tbulto = lds_1.object.totbulto[i]
    ls_vlote = lds_1.object.vlote[i]
    ls_totpeso = lds_1.object.totpeso[i]
    ls_fecha = lds_1.object.vfecha[i]
    ls_jul = lds_1.object.jul[i]
    ls_peso = lds_1.object.peso[i]
	 ls_tam = lds_1.object.tamanio[i]
    
    lds_2.object.cia[1] = ls_cia
    lds_2.object.vfecha[1] = ls_fecha
    lds_2.object.jul[1] = ls_jul
    lds_2.object.cpal[1] = ls_pal
    lds_2.object.vpro1[1] = ls_pro
    lds_2.object.venv1[1] = ls_env
    lds_2.object.clote1[1] = ls_lote
    lds_2.object.veti1[1] = ls_veti
    lds_2.object.cbul1[1] = ls_bulto
    lds_2.object.tpeso[1] = ls_tpeso
    lds_2.object.tbulto[1] = ls_tbulto
    lds_2.object.vlote1[1] = ls_vlote
    lds_2.object.cpeso1[1] = ls_peso
	 lds_2.object.vtam1[1] = ls_tam
   ELSE
    ls_pro = lds_1.object.vpro[i]
    ls_venv = lds_1.object.venv[i]
    ls_lote = lds_1.object.clote[i]
    ls_veti = lds_1.object.veti[i]
    ls_bulto = lds_1.object.cbultos[i]  
    ls_vlote = lds_1.object.vlote[i]
    ls_peso = lds_1.object.peso[i]
    ls_tam = lds_1.object.tamanio[i]
	 IF i = 2 THEN
     lds_2.object.cpal[1] = ls_pal
     lds_2.object.vpro2[1] = ls_pro
     lds_2.object.venv2[1] = ls_venv
     lds_2.object.clote2[1] = ls_lote
     lds_2.object.veti2[1] = ls_veti
     lds_2.object.cbul2[1] = ls_bulto
     lds_2.object.vlote2[1] = ls_vlote
     lds_2.object.cpeso2[1] = ls_peso
	  lds_2.object.vtam2[1] = ls_tam
    ELSEIF i = 3 THEN
     lds_2.object.cpal[1] = ls_pal
     lds_2.object.vpro3[1] = ls_pro
     lds_2.object.venv3[1] = ls_venv
     lds_2.object.clote3[1] = ls_lote
     lds_2.object.veti3[1] = ls_veti
     lds_2.object.cbul3[1] = ls_bulto
     lds_2.object.vlote3[1] = ls_vlote
     lds_2.object.cpeso3[1] = ls_peso
	  lds_2.object.vtam3[1] = ls_tam
    ELSEIF i = 4 THEN
     lds_2.object.cpal[1] = ls_pal
     lds_2.object.vpro4[1] = ls_pro
     lds_2.object.venv4[1] = ls_venv
     lds_2.object.clote4[1] = ls_lote
     lds_2.object.veti4[1] = ls_veti
     lds_2.object.cbul4[1] = ls_bulto
     lds_2.object.vlote4[1] = ls_vlote
     lds_2.object.cpeso4[1] = ls_peso
	  lds_2.object.vtam4[1] = ls_tam
    ELSEIF i = 5 THEN
     lds_2.object.cpal[1] = ls_pal
     lds_2.object.vpro5[1] = ls_pro
     lds_2.object.venv5[1] = ls_venv
     lds_2.object.clote5[1] = ls_lote
     lds_2.object.veti5[1] = ls_veti
     lds_2.object.cbul5[1] = ls_bulto
     lds_2.object.vlote5[1] = ls_vlote
     lds_2.object.cpeso5[1] = ls_peso
	  lds_2.object.vtam5[1] = ls_tam
    ELSEIF i = 6 THEN
     lds_2.object.cpal[1] = ls_pal
     lds_2.object.vpro6[1] = ls_pro
     lds_2.object.venv6[1] = ls_venv
     lds_2.object.clote6[1] = ls_lote
     lds_2.object.veti6[1] = ls_veti
     lds_2.object.cbul6[1] = ls_bulto
     lds_2.object.vlote6[1] = ls_vlote
     lds_2.object.cpeso6[1] = ls_peso
	  lds_2.object.vtam6[1] = ls_tam
    END IF
   END IF
  NEXT
 ELSE //mas de un pallet
  lds_1 = create datastore
  lds_1.dataobject = ls_tpal
  lds_1.settransobject(sqlca)
  lds_1.retrieve(as_tem,as_cod,as_cod2)
  ll_renglon =lds_1.rowcount()
  FOR i = 1 TO ll_renglon
   ll_count = ll_count + 1
   ls_pal =  lds_1.object.cpal[i]
    ll_cont2 = 0
    FOR k = i TO ll_renglon
     ls_pals = lds_1.object.cpal[k]
     ll_cont2 = ll_cont2 + 1
     IF ls_pals = ls_pal THEN
      ls_pro = lds_1.object.vpro[k]
      ls_venv = lds_1.object.venv[k]
      ls_lote = lds_1.object.clote[k]
      ls_eti = lds_1.object.ceti[k]
      ls_veti = lds_1.object.veti[i]
      ls_bulto = lds_1.object.cbultos[k]
      ls_tpeso = lds_1.object.totpeso[k]
      ls_tbulto = lds_1.object.totbulto[k]
      ls_vlote = lds_1.object.vlote[k]
		ls_tam = lds_1.object.tamanio[k]
      IF ll_cont2 = 1 THEN
       lds_2.object.cpal[ll_count] = ls_pal
       lds_2.object.vpro1[ll_count] = ls_pro
       lds_2.object.venv1[ll_count] = ls_venv
       lds_2.object.clote1[ll_count] = ls_lote
       lds_2.object.veti1[ll_count] = ls_veti
       lds_2.object.cbul1[ll_count] = ls_bulto
       lds_2.object.vlote1[ll_count] = ls_vlote
		 lds_2.object.vtam1[ll_count]= ls_tam
      ELSEIF ll_cont2 = 2 THEN
       lds_2.object.cpal[ll_count] = ls_pal
       lds_2.object.vpro2[ll_count] = ls_pro
       lds_2.object.venv2[ll_count] = ls_venv
       lds_2.object.clote2[ll_count] = ls_lote
       lds_2.object.veti2[ll_count] = ls_veti
       lds_2.object.cbul2[ll_count] = ls_bulto
       lds_2.object.vlote2[ll_count] = ls_vlote
		 lds_2.object.vtam2[ll_count]= ls_tam
      ELSEIF ll_cont2 = 3 THEN
       lds_2.object.cpal[ll_count] = ls_pal
       lds_2.object.vpro3[ll_count] = ls_pro
       lds_2.object.venv3[ll_count] = ls_venv
       lds_2.object.clote3[ll_count] = ls_lote
       lds_2.object.veti3[ll_count] = ls_veti
       lds_2.object.cbul3[ll_count] = ls_bulto
       lds_2.object.vlote3[ll_count] = ls_vlote
		 lds_2.object.vtam3[ll_count]= ls_tam
      ELSEIF ll_cont2 = 4 THEN
       lds_2.object.cpal[ll_count] = ls_pal
       lds_2.object.vpro4[ll_count] = ls_pro
       lds_2.object.venv4[ll_count] = ls_venv
       lds_2.object.clote4[ll_count] = ls_lote
       lds_2.object.veti4[ll_count] = ls_veti
       lds_2.object.cbul4[ll_count] = ls_bulto
       lds_2.object.vlote4[ll_count] = ls_vlote
		 lds_2.object.vtam4[ll_count]= ls_tam
      ELSEIF ll_cont2 = 5 THEN
       lds_2.object.cpal[ll_count] = ls_pal
       lds_2.object.vpro5[ll_count] = ls_pro
       lds_2.object.venv5[ll_count] = ls_venv
       lds_2.object.clote5[ll_count] = ls_lote
       lds_2.object.veti5[ll_count] = ls_veti
       lds_2.object.cbul5[ll_count] = ls_bulto
       lds_2.object.vlote5[ll_count] = ls_vlote
		 lds_2.object.vtam5[ll_count]= ls_tam
      ELSEIF ll_cont2 = 6 THEN
       lds_2.object.cpal[ll_count] = ls_pal
       lds_2.object.vpro6[ll_count] = ls_pro
       lds_2.object.venv6[ll_count] = ls_venv
       lds_2.object.clote6[ll_count] = ls_lote
       lds_2.object.veti6[ll_count] = ls_veti
       lds_2.object.cbul6[ll_count] = ls_bulto
       lds_2.object.vlote6[ll_count] = ls_vlote
		 lds_2.object.vtam6[ll_count]= ls_tam
      END IF
     ELSE //no es el mismo pallet
      k = k -1
      ll_count = ll_count + 1
      ll_cont2 = 0
      ls_pal = ls_pals
     END IF
    NEXT
   Exit
  NEXT
 END IF
ELSE //CUANDO IMPRIMO DEL LISTADO QUE SOLO SE MANDA UNA ETIQUETA
 lds_1 = create datastore
 lds_1.dataobject = ls_tpal
 lds_1.settransobject(sqlca)
 lds_1.Retrieve( as_tem, as_cod,as_cod)
 ll_renglon =lds_1.rowcount()
 
 FOR i = 1 TO ll_renglon
  ls_pal = lds_1.object.cpal[i]
  IF i = 1 THEN
   ls_pal = lds_1.object.cpal[i]
   ls_pro = lds_1.object.vpro[i]
   ls_env = lds_1.object.venv[i]
   ls_lote = lds_1.object.clote[i]
   ls_eti = lds_1.object.ceti[i]
   ls_veti = lds_1.object.veti[i]
   ls_bulto = lds_1.object.cbultos[i]
   ls_tpeso = lds_1.object.totpeso[i]
   ls_tbulto = lds_1.object.totbulto[i]
   ls_vlote = lds_1.object.vlote[i]
	ls_tam = lds_1.object.tamanio[i]
   
   lds_2.object.cpal[1] = ls_pal
   lds_2.object.vpro1[1] = ls_pro
   lds_2.object.venv1[1] = ls_env
   lds_2.object.clote1[1] = ls_lote
   lds_2.object.veti1[1] = ls_veti
   lds_2.object.cbul1[1] = ls_bulto
   lds_2.object.tpeso[1] = ls_tpeso
   lds_2.object.tbulto[1] = ls_tbulto
   lds_2.object.vlote1[1] = ls_vlote
	lds_2.object.vtam1[1] = ls_tam
  ELSE
   ls_pro = lds_1.object.vpro[i]
   ls_venv = lds_1.object.venv[i]
   ls_lote = lds_1.object.clote[i]
   ls_veti = lds_1.object.veti[i]
   ls_bulto = lds_1.object.cbultos[i]  
   ls_vlote = lds_1.object.vlote[i]
	ls_tam = lds_1.object.tamanio[i]
   IF i = 2 THEN
    lds_2.object.cpal[1] = ls_pal
    lds_2.object.vpro2[1] = ls_pro
    lds_2.object.venv2[1] = ls_venv
    lds_2.object.clote2[1] = ls_lote
    lds_2.object.veti2[1] = ls_veti
    lds_2.object.cbul2[1] = ls_bulto
    lds_2.object.vlote2[1] = ls_vlote
	 lds_2.object.vtam2[1] = ls_tam
   ELSEIF i = 3 THEN
    lds_2.object.cpal[1] = ls_pal
    lds_2.object.vpro3[1] = ls_pro
    lds_2.object.venv3[1] = ls_venv
    lds_2.object.clote3[1] = ls_lote
    lds_2.object.veti3[1] = ls_veti
    lds_2.object.cbul3[1] = ls_bulto
    lds_2.object.vlote3[1] = ls_vlote
	 lds_2.object.vtam3[1] = ls_tam
   ELSEIF i = 4 THEN
    lds_2.object.cpal[1] = ls_pal
    lds_2.object.vpro4[1] = ls_pro
    lds_2.object.venv4[1] = ls_venv
    lds_2.object.clote4[1] = ls_lote
    lds_2.object.veti4[1] = ls_veti
    lds_2.object.cbul4[1] = ls_bulto
    lds_2.object.vlote4[1] = ls_vlote
	 lds_2.object.vtam4[1] = ls_tam
   ELSEIF i = 5 THEN
    lds_2.object.cpal[1] = ls_pal
    lds_2.object.vpro5[1] = ls_pro
    lds_2.object.venv5[1] = ls_venv
    lds_2.object.clote5[1] = ls_lote
    lds_2.object.veti5[1] = ls_veti
    lds_2.object.cbul5[1] = ls_bulto
    lds_2.object.vlote5[1] = ls_vlote
	 lds_2.object.vtam5[1] = ls_tam
   ELSEIF i = 6 THEN
    lds_2.object.cpal[1] = ls_pal
    lds_2.object.vpro6[1] = ls_pro
    lds_2.object.venv6[1] = ls_venv
    lds_2.object.clote6[1] = ls_lote
    lds_2.object.veti6[1] = ls_veti
    lds_2.object.cbul6[1] = ls_bulto
    lds_2.object.vlote6[1] = ls_vlote
	 lds_2.object.vtam6[1] = ls_tam
   END IF
  END IF
 NEXT
END IF
lds_2.SaveAs( "c:\eyeprint.dbf", dBASE3!, True )
destroy lds_1
destroy lds_2

return 1
end function

public function integer wf_agregar2 ();datastore lds_listado
long ll_renglon,i,j,ll_row,ll_existe,li_pal
string ls_elemento,ls_pal,ls_sec,ls_eti,ls_lot,ls_color,ls_pro,ls_env,ls_pall
decimal{2} ldc_bultos
datetime ld_fecha
//
ls_pal = f_trim(tab_1.tabpage_5.sle_pal.text)


li_pal = f_Zero( Integer( f_GetParmValue( '28' ) ) )
ls_pal = Right( Fill( '0', li_pal ) + ls_pal, li_pal )

ll_row = idw_confirma.rowcount()

select count(c_codigo_pal)
into :ll_existe
from t_paletsinconfirmar 
where c_codigo_pal = :ls_pal
and c_codigo_tem = :gs_codtem
and c_staemp_pal = '2'
using sqlca;
If f_SqlError( SqlCa, 'No se pudo leer la tabla  t_palet (select)' ) < 0 Then 
		RollBack Using SqlCa ;
		Return 0
End If	
if ll_existe = 0 then
	messagebox(title,' este pallet ya ha sido confirmado',exclamation!)
	tab_1.tabpage_5.sle_pal.text = ''
	tab_1.tabpage_5.sle_pal.setfocus()
	return 0
end if

for i = 1 to ll_row
	ls_pall = idw_confirma.object.c_codigo_pal[i]
	if ls_pall = ls_pal then
		messagebox(title,'El pallet ya existe en el detalle no puede agregarlo de nuevo',exclamation!)
		tab_1.tabpage_5.sle_pal.text = ''
		return 0
	end if
next

lds_listado = create datastore
lds_listado.dataobject = 'd_arch_dds_palet_mixto_confirma'
lds_listado.settransobject(sqlca)
lds_listado.retrieve(ls_pal)
ll_renglon =lds_listado.rowcount()

for i = 1 to ll_renglon
	ls_elemento = lds_listado.object.c_elemento[i]
	ls_pal = lds_listado.object.c_codigo_pal[i]   
	ls_Sec = lds_listado.object.c_codsec_pal[i]   
	ls_pro = lds_listado.object.c_codigo_pro[i]   
	ls_eti = lds_listado.object.c_codigo_eti[i]   
	ls_lot = lds_listado.object.c_codigo_lot[i]   
	ld_fecha = lds_listado.object.d_empaque_pal[i]     
	ls_env = lds_listado.object.c_codigo_env[i]   
	ldc_bultos = lds_listado.object.n_bulxpa_pal[i]   
	ls_color = lds_listado.object.c_codigo_col[i]
	
	j = idw_confirma.InsertRow(0)
	idw_confirma.ScrollToRow(j)
	idw_confirma.SetRow(j)
	
	idw_confirma.object.c_elemento[j] = ls_elemento
	idw_confirma.object.c_codigo_pal[j] = ls_elemento  
	idw_confirma.object.c_codsec_pal[j] = ls_Sec 
	idw_confirma.object.c_codigo_pro[j] = ls_pro
	idw_confirma.object.c_codigo_eti[j] = ls_eti 
	idw_confirma.object.c_codigo_lot[j] =  ls_lot 
	idw_confirma.object.d_empaque_pal[j] = ld_fecha     
	idw_confirma.object.c_codigo_env[j]  = ls_env  
	idw_confirma.object.n_bulxpa_pal[j]  =  ldc_bultos 
	idw_confirma.object.c_codigo_col[j] = ls_color
	idw_confirma.object.c_codigo_pal[j] = ls_pal
next

tab_1.tabpage_5.sle_pal.text = ''

return 1
end function

on w_arch_palet_2.create
if this.MenuName = "m_principal_arch_pallet" then this.MenuID = create m_principal_arch_pallet
this.st_pp=create st_pp
this.tab_1=create tab_1
this.st_nota=create st_nota
this.p_nota=create p_nota
this.cb_imprimir=create cb_imprimir
this.dw_prn=create dw_prn
this.cb_aplicar=create cb_aplicar
this.cb_cerrar=create cb_cerrar
this.cb_aceptar=create cb_aceptar
this.cb_confirma=create cb_confirma
this.Control[]={this.st_pp,&
this.tab_1,&
this.st_nota,&
this.p_nota,&
this.cb_imprimir,&
this.dw_prn,&
this.cb_aplicar,&
this.cb_cerrar,&
this.cb_aceptar,&
this.cb_confirma}
end on

on w_arch_palet_2.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_pp)
destroy(this.tab_1)
destroy(this.st_nota)
destroy(this.p_nota)
destroy(this.cb_imprimir)
destroy(this.dw_prn)
destroy(this.cb_aplicar)
destroy(this.cb_cerrar)
destroy(this.cb_aceptar)
destroy(this.cb_confirma)
end on

event open;string ls_defecto,ls_folios,ls_enc

/* Posición fija de coordenadas */
X = 0
Y = 0

ls_defecto = f_getprinter('N', "")
gs_dprinter = ls_defecto //20081007

is_staemp = Message.StringParm

tab_1.tabpage_4.visible = false
tab_1.tabpage_5.visible = false

If is_staemp = '0' Then
	Title = 'Pallet del Dia Siguiente'
Elseif is_staemp = '2' then
	Title = 'Pallet sin confirmar'
	tab_1.tabpage_4.visible = false
	tab_1.tabpage_5.visible = true
End If

idw_nor = tab_1.tabpage_1.dw_nor
idw_mix1 = tab_1.tabpage_2.dw_mix1
idw_mix2 = tab_1.tabpage_2.dw_mix2
idw_lis = tab_1.tabpage_3.dw_lis

//============================
//idw_scnor = tab_1.tabpage_4.dw_scnor
idw_scmix1 = tab_1.tabpage_4.dw_scmix
idw_scmix2 = tab_1.tabpage_4.dw_scmix2
idw_confirma = tab_1.tabpage_5.dw_confirma

//tab_1.tabpage_4.dw_scmix.visible = false
//tab_1.tabpage_4.dw_scmix2.visible = false
//
//idw_scnor.SetTransObject( SqlCa )
//idw_scnor.InsertRow(0)
//idw_scnor.Object.d_empaque_pal[1] = wf_GetSysDate( )
//idw_scnor.Object.c_staemp_pal[1] = is_staemp
//
idw_scmix2.SetTransObject( SqlCa )
idw_scmix1.SetTransObject( SqlCa )
idw_scmix1.InsertRow(0)
idw_scmix1.Object.d_empaque_pal[1] = wf_GetSysDate( )
//tab_1.tabpage_4.cbx_3.visible = true
//tab_1.tabpage_4.cb_scnew.visible = false

idw_confirma.SetTransObject( SqlCa )

//=============================
idw_nor.SetTransObject( SqlCa )
idw_nor.InsertRow(0)
idw_nor.Object.d_empaque_pal[1] = wf_GetSysDate( )
idw_nor.Object.c_staemp_pal[1] = is_staemp

idw_mix2.SetTransObject( SqlCa )
idw_mix1.SetTransObject( SqlCa )
idw_mix1.InsertRow(0)
idw_mix1.Object.d_empaque_pal[1] = wf_GetSysDate( )

tab_1.tabpage_3.em_ini.Text = f_GetParmValue( '20' )
tab_1.tabpage_3.em_fin.Text = String( Today(), 'dd/mm/yyyy' )
dw_prn.Visible = False


If f_GetParmValue( '19' ) = 'S' Then 
	tab_1.tabpage_1.cbx_1.Checked = True
//	tab_1.tabpage_4.cbx_3.Checked = True
End If

is_lot = f_GetParmValue( '23' )
ib_generar = (Upper(f_GetParmValue( '27' )) = 'S' )
If ib_generar Then
	idw_nor.Object.c_codigo_pal.Edit.DisplayOnly = 'Yes'
	idw_mix1.Object.c_codigo_pal.Edit.DisplayOnly = 'Yes'	
	//==============
//	idw_scnor.Object.c_codigo_pal.Edit.DisplayOnly = 'Yes'
	idw_scmix1.Object.c_codigo_pal.Edit.DisplayOnly = 'Yes'
	//==============
End If

st_nota.Visible = ib_generar
p_nota.Visible = ib_generar

ii_ceros = f_Zero( Integer( f_GetParmValue( '28' ) ) )
ib_mostrarmsg = (f_GetParmValue( '29' ) = 'S' )
ib_color = (f_GetParmValue( '39' ) = 'S' )

idw_nor.object.c_tipo_pal[1]='N'
idw_nor.object.c_excedente_pal[1]='0'
If Not ib_color Then
	idw_nor.Object.c_codigo_col.Visible = 0
	idw_nor.Object.c_codigo_col_t.Visible = 0
	idw_mix1.Object.c_codigo_col.Visible = 0
	idw_mix1.Object.c_codigo_col_t.Visible = 0
	idw_mix2.Object.c_codigo_col.Visible = 0
	idw_mix2.Object.c_codigo_col_t.Visible = 0
	idw_lis.Object.c_codigo_col.Visible = 0
	idw_lis.Object.c_codigo_col_t.Visible = 0
	//===
//	idw_scnor.Object.c_codigo_col.Visible = 0
//	idw_scnor.Object.c_codigo_col_t.Visible = 0
	idw_scmix1.Object.c_codigo_col.Visible = 0
	idw_scmix1.Object.c_codigo_col_t.Visible = 0
	idw_scmix2.Object.c_codigo_col.Visible = 0
	idw_scmix2.Object.c_codigo_col_t.Visible = 0
	//==
End If

cb_confirma.visible = false
tab_1.tabpage_5.sle_1.text = string(date(wf_GetSysDate( )),'dd/mm/yyyy')

idw_nor.object.ll_pal[1] = 1
idw_mix1.object.ll_pal[1] = 1

st_pp.visible = false

ls_folios = upper(f_trim(f_getparmvalue('085')))
IF ls_folios = 'S' THEN
	tab_1.tabpage_2.st_mer.visible = true
	tab_1.tabpage_2.cbx_nac.visible = true
	tab_1.tabpage_2.cbx_ext.visible = true
ELSE
	tab_1.tabpage_2.st_mer.visible = false
	tab_1.tabpage_2.cbx_nac.visible = false
	tab_1.tabpage_2.cbx_ext.visible = false
END IF


end event

type st_pp from statictext within w_arch_palet_2
int X=965
int Y=1236
int Width=590
int Height=84
boolean Enabled=false
string Text="pallet 1"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tab_1 from tab within w_arch_palet_2
int X=46
int Y=64
int Width=2821
int Height=1168
int TabOrder=10
boolean RaggedRight=true
int SelectedTab=1
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

event selectionchanged;ii_pag = newindex

If ii_pag = 1 Then
	idw_nor.SetFocus( )
	idw_nor.Object.c_ultimo[1] = f_GetParmValue( '11' )
	cb_aceptar.Visible = True
	cb_aplicar.Visible = True
	If tab_1.tabpage_1.cbx_1.Checked Then
		cb_aplicar.Default = True
	End If
End If

If ii_pag = 2 Then
	idw_mix1.SetFocus( )
	idw_mix1.Object.c_ultimo[1] = f_GetParmValue( '11' )
	cb_aceptar.Visible = True
	cb_aplicar.Visible = True
	cb_aceptar.Default = True
	cb_aplicar.Default = False
End If

If ii_pag = 3 Then
	cb_aceptar.Visible = False
	cb_aplicar.Visible = False
	//CAMBIAR EL DW_LIST DEL LISTADO DEPENDIENDO SI ES pallet normal O SIN CONFIRMAR
	IF is_staemp ='2' THEN
		tab_1.tabpage_3.dw_lis.dataobject = 'd_arch_paletsc_listado'
		tab_1.tabpage_3.dw_lis.settransobject(sqlca)
		IF not ib_color  THEN
			tab_1.tabpage_3.dw_lis.object.c_codigo_col.visible = false
		END IF
//		idw_lissc
	END IF
End If
//
//ii_pag = newindex
//
//If ii_pag = 1 Then
//	idw_nor.SetFocus( )
//	idw_nor.Object.c_ultimo[1] = f_GetParmValue( '11' )
//	cb_aceptar.Visible = True
//	cb_aplicar.Visible = True
//	If tab_1.tabpage_1.cbx_1.Checked Then
//		//cb_aplicar.Default = True
//	End If
//	st_pp.text = ''
//End If
//
//If ii_pag = 2 Then
//	idw_mix1.SetFocus( )
//	idw_mix1.Object.c_ultimo[1] = f_GetParmValue( '11' )
//	cb_aceptar.Visible = True
//	cb_aplicar.Visible = True
////	cb_aceptar.Default = True
//	cb_aplicar.Default = False
//	st_pp.text = ''
//
//End If
//
//If ii_pag = 3 Then
//	cb_aceptar.Visible = False
//	cb_aplicar.Visible = False
//	st_pp.text = ''
//End If
//
if ii_pag = 4 then
	idw_scmix1.SetFocus( )
	idw_scmix1.Object.c_ultimo[1] = f_GetParmValue( '11' )
	cb_aceptar.Visible = True
	cb_aplicar.Visible = True
//	cb_aceptar.Default = True
	cb_aplicar.Default = False
	st_pp.text = ''
End If

if ii_pag = 5 then
	tab_1.tabpage_5.sle_pal.setfocus()
	cb_confirma.visible = true
	cb_aceptar.visible = false
	cb_aplicar.visible = false
	st_pp.text = ''
end if
	
end event

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

type tabpage_1 from userobject within tab_1
int X=18
int Y=100
int Width=2784
int Height=1052
long BackColor=79741120
string Text="Pallet Normal"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_nor dw_nor
cb_nuevo cb_nuevo
cbx_1 cbx_1
end type

on tabpage_1.create
this.dw_nor=create dw_nor
this.cb_nuevo=create cb_nuevo
this.cbx_1=create cbx_1
this.Control[]={this.dw_nor,&
this.cb_nuevo,&
this.cbx_1}
end on

on tabpage_1.destroy
destroy(this.dw_nor)
destroy(this.cb_nuevo)
destroy(this.cbx_1)
end on

type dw_nor from datawindow within tabpage_1
int X=64
int Y=36
int Width=2217
int Height=992
int TabOrder=10
string DataObject="d_arch_palet_normal"
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

type cb_nuevo from uo_cbother within tabpage_1
int X=2318
int Y=68
int TabOrder=20
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
idw_nor.Object.c_staemp_pal[1] = is_staemp
idw_nor.object.c_tipo_pal[1]='N'
idw_nor.object.c_excedente_pal[1]='0'

idw_nor.object.ll_pal[1] = 1
idw_mix1.object.ll_pal[1] = 1

end event

type cbx_1 from checkbox within tabpage_1
int X=2318
int Y=188
int Width=439
int Height=76
string Text="Igual al anterior"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tabpage_2 from userobject within tab_1
int X=18
int Y=100
int Width=2784
int Height=1052
long BackColor=79741120
string Text="Pallet Mixto"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cbx_ext cbx_ext
cbx_nac cbx_nac
st_mer st_mer
dw_mix2 dw_mix2
cb_agregar cb_agregar
cb_elimix cb_elimix
cb_newmix cb_newmix
dw_mix1 dw_mix1
end type

on tabpage_2.create
this.cbx_ext=create cbx_ext
this.cbx_nac=create cbx_nac
this.st_mer=create st_mer
this.dw_mix2=create dw_mix2
this.cb_agregar=create cb_agregar
this.cb_elimix=create cb_elimix
this.cb_newmix=create cb_newmix
this.dw_mix1=create dw_mix1
this.Control[]={this.cbx_ext,&
this.cbx_nac,&
this.st_mer,&
this.dw_mix2,&
this.cb_agregar,&
this.cb_elimix,&
this.cb_newmix,&
this.dw_mix1}
end on

on tabpage_2.destroy
destroy(this.cbx_ext)
destroy(this.cbx_nac)
destroy(this.st_mer)
destroy(this.dw_mix2)
destroy(this.cb_agregar)
destroy(this.cb_elimix)
destroy(this.cb_newmix)
destroy(this.dw_mix1)
end on

type cbx_ext from checkbox within tabpage_2
int X=407
int Y=576
int Width=306
int Height=80
string Text="Extranjero"
BorderStyle BorderStyle=StyleLowered!
boolean RightToLeft=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF cbx_ext.checked then
	cbx_nac.checked = false
END IF
end event

type cbx_nac from checkbox within tabpage_2
int X=82
int Y=572
int Width=311
int Height=80
string Text="Nacional"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF cbx_nac.checked then
	cbx_ext.checked = false
END IF
end event

type st_mer from statictext within tabpage_2
int X=50
int Y=500
int Width=233
int Height=80
boolean Enabled=false
string Text="Mercado:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_mix2 from datawindow within tabpage_2
int X=41
int Y=692
int Width=2679
int Height=352
int TabOrder=30
string DataObject="d_arch_palet_mixto"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event itemchanged;return wf_ItemChanged( This, dwo.Name, data, row )
end event

type cb_agregar from uo_cbother within tabpage_2
int X=1541
int Y=576
int TabOrder=20
string Text="Agregar"
end type

event clicked;DateTime	ld_emp
Integer	i
long ll_pal
String	ls_ele, ls_pal, ls_pro, ls_kil, ls_nom
decimal{2} ldc_peso, ldc_pesbul

idw_mix1.AcceptText( )
ls_ele = f_Trim( idw_mix1.Object.c_elemento[1] )
ld_emp = idw_mix1.Object.d_empaque_pal[1]
ls_pal = idw_mix1.Object.c_codigo_pal[1]
ll_pal = idw_mix1.object.ll_pal[1]
ldc_peso = f_zero(idw_mix1.object.n_peso_pal[1])

If Len( ls_ele ) <> 6 Then
	MessageBox( Parent.Text, 'Debe ingresar el elemento o seleccionar ' + &
					'el producto y la etiqueta.', Exclamation! )
	Return
End If

If IsNull( ld_emp ) Then
	MessageBox( Parent.Text, 'Debe ingresar la fecha del empaque.', Exclamation! )
	Return
End If

If f_Zero( idw_mix1.Object.n_bulxpa_pal[1] ) <= 0 Then
	MessageBox( Parent.Text, 'Debe ingresar la cantidad de bultos(cajas).', Exclamation! )
	Return
End If

ls_pro = f_Trim(idw_mix1.Object.c_codigo_pro[1])
Select v_nombre_pro, c_porkilo_pro, n_pesbul_pro
Into	:ls_nom,     :ls_kil,		  :ldc_pesbul
From	 t_producto
Where	 c_codigo_pro = :ls_pro
And	 c_activo_pro = '1' ;
If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_producto.' ) < 0 Then
	Return 0
End If
If f_Trim(ls_kil) = 'S' and ldc_peso = 0 Then
	MessageBox( Title, 'Debe ingresar el peso del producto.', Exclamation! )
	Return 0
ElseIf f_Trim(ls_kil) = 'N' Then
	ldc_peso = ldc_pesbul * Dec(idw_mix1.Object.n_bulxpa_pal[1])
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
idw_mix2.Object.n_peso_pal[i]	   = ldc_peso
idw_mix2.ScrollToRow( i )

For i = 1 To idw_mix2.RowCount( )
	idw_mix2.Object.c_codigo_pal[i] = idw_mix1.Object.c_codigo_pal[1]
Next

idw_mix1.DeleteRow( 0 )
idw_mix1.InsertRow( 0 )

idw_mix1.Object.d_empaque_pal[1] = ld_emp 
idw_mix1.Object.c_codigo_pal[1] = ls_pal 
idw_mix1.Object.c_staemp_pal[1] = is_staemp
idw_mix1.object.ll_pal[1] = ll_pal
//idw_mix1.object.n_peso_pal[1] = ldc_peso

idw_mix1.SetFocus( )
idw_mix1.SetColumn( 'c_elemento' )

end event

type cb_elimix from uo_cbother within tabpage_2
int X=1952
int Y=576
int TabOrder=20
string Text="Eliminar"
end type

event clicked;Long	ll_row

If idw_mix2.RowCount( ) <= 0 Then
	Beep(1)
	Return
End If

ll_row = idw_mix2.GetRow( )

idw_mix2.SelectRow( ll_row, True )
If MessageBox( Parent.Text, 'Confirma que desea eliminar este elemento?', Question!, YesNo! ) = 1 Then
	idw_mix2.DeleteRow(0)
End If
idw_mix2.SelectRow( 0, False )
end event

type cb_newmix from uo_cbother within tabpage_2
int X=2368
int Y=576
int TabOrder=20
string Text="Nuevo"
end type

event clicked;DataWindow	ldw_1
DataWindowChild	ldwc_x
DateTime				ld_emp
Integer	i, j
long ll_pal
String	ls_col[]
string ls_separaf

ls_separaf = upper(f_trim(f_getparmvalue('085')))

ll_pal = idw_mix1.object.ll_pal[1]

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

idw_mix1.object.ll_pal[1] = ll_pal
cb_agregar.Enabled = True
cb_elimix.Enabled = True

if ls_separaf = 'S' THEN //20090216
	tab_1.tabpage_2.cbx_nac.checked = false
		tab_1.tabpage_2.cbx_ext.checked = false
		tab_1.tabpage_2.cbx_nac.enabled = true
		tab_1.tabpage_2.cbx_ext.enabled = true
END IF
end event

type dw_mix1 from datawindow within tabpage_2
int Width=2702
int Height=560
int TabOrder=10
string DataObject="d_arch_palet_mixto_cab"
boolean Border=false
boolean LiveScroll=true
end type

event itemchanged;Return wf_ItemChanged( This, dwo.Name, data, row )
end event

type tabpage_3 from userobject within tab_1
int X=18
int Y=100
int Width=2784
int Height=1052
long BackColor=79741120
string Text="Listado"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_lis dw_lis
st_1 st_1
em_ini em_ini
cb_5 cb_5
st_2 st_2
em_fin em_fin
cb_fin cb_fin
cb_buscar cb_buscar
cb_modificar cb_modificar
cb_eliminar cb_eliminar
cb_manifiesto cb_manifiesto
cb_pornumero cb_pornumero
cb_expandir cb_expandir
end type

on tabpage_3.create
this.dw_lis=create dw_lis
this.st_1=create st_1
this.em_ini=create em_ini
this.cb_5=create cb_5
this.st_2=create st_2
this.em_fin=create em_fin
this.cb_fin=create cb_fin
this.cb_buscar=create cb_buscar
this.cb_modificar=create cb_modificar
this.cb_eliminar=create cb_eliminar
this.cb_manifiesto=create cb_manifiesto
this.cb_pornumero=create cb_pornumero
this.cb_expandir=create cb_expandir
this.Control[]={this.dw_lis,&
this.st_1,&
this.em_ini,&
this.cb_5,&
this.st_2,&
this.em_fin,&
this.cb_fin,&
this.cb_buscar,&
this.cb_modificar,&
this.cb_eliminar,&
this.cb_manifiesto,&
this.cb_pornumero,&
this.cb_expandir}
end on

on tabpage_3.destroy
destroy(this.dw_lis)
destroy(this.st_1)
destroy(this.em_ini)
destroy(this.cb_5)
destroy(this.st_2)
destroy(this.em_fin)
destroy(this.cb_fin)
destroy(this.cb_buscar)
destroy(this.cb_modificar)
destroy(this.cb_eliminar)
destroy(this.cb_manifiesto)
destroy(this.cb_pornumero)
destroy(this.cb_expandir)
end on

type dw_lis from uo_dw_list within tabpage_3
int X=46
int Y=148
int Width=2670
int Height=760
int TabOrder=11
string DataObject="d_arch_palet_listado"
end type

event getfocus;cb_modificar.Default = True
end event

type st_1 from statictext within tabpage_3
int X=46
int Y=44
int Width=119
int Height=76
boolean Enabled=false
string Text="Del:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_ini from uo_editmask within tabpage_3
int X=178
int Y=40
int TabOrder=20
end type

event getfocus;cb_buscar.Default = True
end event

type cb_5 from uo_cbdate within tabpage_3
int X=526
int Y=44
int TabOrder=20
end type

event clicked;uof_Calendar( w_arch_palet_2, em_ini )

end event

type st_2 from statictext within tabpage_3
int X=690
int Y=44
int Width=73
int Height=76
boolean Enabled=false
string Text="Al:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_fin from uo_editmask within tabpage_3
int X=823
int Y=40
int TabOrder=20
end type

event getfocus;cb_buscar.Default = True
end event

type cb_fin from uo_cbdate within tabpage_3
int X=1166
int Y=44
int TabOrder=20
end type

event clicked;uof_Calendar( w_arch_palet_2, em_fin )
end event

type cb_buscar from uo_cbother within tabpage_3
int X=1312
int Y=36
int TabOrder=20
string Text="&Buscar"
end type

event clicked;String	ls_null,ls_tipo
datetime ld_ini,ld_fin

SetNull( ls_null )

ld_ini = f_StringToDate( em_ini.Text )
ld_fin = f_StringToDate( em_fin.Text )
if gs_tipo='' then
	ls_tipo='%'
else
	if gs_tipo='F' then
		ls_tipo='1'
	else
		ls_tipo='0'
	end if
end if

dw_lis.Retrieve( gs_codtem,ld_ini,ld_fin, ls_null,ls_tipo )
dw_lis.SetFocus( )
end event

type cb_modificar from uo_cbother within tabpage_3
int X=1627
int Y=776
int TabOrder=20
boolean Visible=false
string Text="Modificar"
end type

event clicked;Long		ll_row
String	ls_tem, ls_man, ls_act, ls_cod, ls_sec

If idw_lis.RowCount( ) <= 0 Then
	Beep(1)
	Return
End If

ll_row = idw_lis.GetRow( )


ls_tem	= f_Trim( idw_lis.Object.c_codigo_tem[ll_row] )
ls_cod	= f_Trim( idw_lis.Object.c_codigo_pal[ll_row] )
ls_sec	= f_Trim( idw_lis.Object.c_codsec_pal[ll_row] )
ls_man	= f_Trim( idw_lis.Object.c_codigo_man[ll_row] )
ls_act	= f_Trim( idw_lis.Object.c_activo_pal[ll_row] )
id_emp	= idw_lis.Object.d_empaque_pal[ll_row]
If ls_sec = '00' Then
	MessageBox( Title, 'El palet normal no puede ser actualizado, debe eliminarlo y volver a ingresar.' )
	idw_lis.SetFocus( )
	Return
End If
If ls_man <> '' Then
	MessageBox( Title, 'El palet ya se encuentra en un manifiesto, no puede ser actualizado.' )
	idw_lis.SetFocus( )
	Return
End If
If ls_act = '0' Then
	MessageBox( Title, 'El registro se encuentra eliminado/cancelado.' )
	idw_lis.SetFocus( )
	Return
End If

tab_1.tabpage_1.Enabled = False
is_acc = 'M'
is_pal = ls_cod
idw_mix2.Retrieve( ls_tem + ls_cod )
f_ColEnabled( idw_mix1, 'c_codigo_pal', False )
f_ColEnabled( idw_mix1, 'd_empaque_pal', False )
idw_mix1.Object.c_codigo_pal[1] = is_pal
idw_mix1.Object.d_empaque_pal[1] = id_emp
tab_1.SelectedTab = 2
end event

type cb_eliminar from uo_cbother within tabpage_3
int X=2368
int Y=936
int TabOrder=20
string Text="&Eliminar"
end type

event clicked;uo_DataStore	lds_1, lds_acu
Long		ll_row, ll_find, i
datetime ld_empaque, ld_trabajo
Dec{2}	ldc_bul
String	ls_tipo, ls_mess, ls_cod, ls_man, ls_act, ls_tem, ls_pro, ls_eti, ls_mer,ls_tipop,ls_parm
s_parm  lstr_parm ///Faby
If idw_lis.RowCount( ) <= 0 Then
	Beep(1)
	Return
End If

ll_row = idw_lis.GetRow( )

ld_empaque = idw_lis.Object.d_empaque_pal[ll_row]
ld_trabajo = f_getsysdate()
ls_tipo = idw_lis.Object.c_codsec_pal[ll_row]
ls_cod	= idw_lis.Object.c_codigo_pal[ll_row]
ls_man	= f_Trim( idw_lis.Object.c_codigo_man[ll_row] )
ls_act	= f_Trim( idw_lis.Object.c_activo_pal[ll_row] )

select top 1 c_staemp_pal
into :ls_tipop
from t_palet
where c_codigo_pal = :ls_Cod
and c_codigo_Tem = :gs_Codtem
using sqlca;
If f_SqlError( SqlCa, 'No se pudo leer la tabla t_palet . (select)' ) < 0 Then 
	 RollBack Using SqlCa ;
	 Return 0
End If	

If ls_man <> '' Then
	MessageBox( Title, 'El palet ya se encuentra en un manifiesto, no puede ser actualizado.' )
	idw_lis.SetFocus( )
	Return
End If

If ld_empaque > ld_trabajo Then
	MessageBox( Title, 'El palet no se puede eliminar, por que la fecha de empaque es mayor a la de trabajo.' )
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

lstr_parm.s_cad[1]=ls_cod  /////faby
lstr_parm.s_cad[2]=ls_tipo  /////hilda
OpenWithParm( w_arch_palet_eliminar, lstr_parm )
ls_parm = Message.StringParm

ls_parm = f_Trim( ls_parm )

If Not ls_parm = '' Then

	//OpenWithParm( w_arch_palet_eliminar, ls_tipo )
	//ls_mess = f_Trim( Message.StringParm )
	//If ls_mess = '' Then
	//	idw_lis.SetFocus( )
	//	Return
	//End If
	ls_mess = '2'
	
	IF is_staemp <> '2' THEN
		lds_1 = Create uo_DataStore
		lds_1.DataObject = 'd_arch_palet_mixto'
		lds_1.SetTransObject( SqlCa )
		lds_1.Retrieve( gs_codtem + ls_cod ,'%')
	ELSE
		lds_1 = Create uo_DataStore
		lds_1.DataObject = 'd_arch_palet_mixto_sc'
		lds_1.SetTransObject( SqlCa )
		lds_1.Retrieve( gs_codtem + ls_cod )
	END IF
		
	ll_find = lds_1.Find( "c_codsec_pal = '" + ls_tipo + "'", 1, lds_1.RowCount( ) )
	If ll_find <= 0 Then
		MessageBox( Title, 'El registro ha sido eliminado.' )
	End If
	
	If ls_mess = '1' Then
		lds_1.DeleteRow( ll_find )
	End If
	
	IF is_staemp <> '2' THEN
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
			//20081009//////////////////////
			if ls_tipop <> '2' then//
			//
				If ll_row > 0 Then
					lds_acu.Object.c_usumod[ll_row] = gs_usuario
					lds_acu.Object.d_modifi[ll_row] = DateTime( Today( ) )
					lds_acu.Object.c_activo[ll_row] = '1'
					If ld_empaque < ld_trabajo Then
						lds_acu.Object.n_emptot_acu[ll_row] = f_Zero(lds_acu.Object.n_emptot_acu[ll_row]) - ldc_bul
						lds_acu.Object.n_sobtot_acu[ll_row] = f_Zero(lds_acu.Object.n_sobtot_acu[ll_row]) - ldc_bul 
					Else	
						lds_acu.Object.n_emphoy_acu[ll_row] = f_Zero(lds_acu.Object.n_emphoy_acu[ll_row]) - ldc_bul
					End If
				End If
				lds_acu.AcceptText( )
				If lds_acu.Update( ) <> 1 Then
					RollBack Using SqlCa ;
					MessageBox( Title, 'El registro no ha sido actualizado.', StopSign! )
					Destroy lds_acu
					Destroy lds_1
					Return
				End If
			end if//
		Next
	END IF//==20081118
		
	/* Ahora hace un borrado fisico del registro de pallet */
	IF is_staemp <> '2' THEN
		Delete From t_palet 
		Where c_codigo_pal = :ls_cod 
		and c_codigo_tem = :gs_codtem;
		If f_SqlError( SqlCa, '' ) = -1 Then
			RollBack Using SqlCa ;
			MessageBox( Title, 'El registro no ha sido actualizado.', StopSign! )
		End if
	ELSE
		Delete From t_paletsinconfirmar 
		Where c_codigo_pal = :ls_cod 
		and c_codigo_tem = :gs_codtem;
		If f_SqlError( SqlCa, '' ) = -1 Then
			RollBack Using SqlCa ;
			MessageBox( Title, 'El registro no ha sido actualizado.', StopSign! )
		End if
	END IF
Commit Using SqlCa ;
cb_buscar.TriggerEvent( Clicked! )
MessageBox( Title, 'El registro ha sido eliminado.' )
end if


Destroy lds_acu
Destroy lds_1
end event

type cb_manifiesto from uo_cbother within tabpage_3
int X=2368
int Y=776
int TabOrder=20
boolean Visible=false
string Text="Manifiesto"
end type

event clicked;Long		ll_row
String	ls_tem, ls_man, ls_act, ls_cod, ls_sec

If idw_lis.RowCount( ) <= 0 Then
	Beep(1)
	Return
End If

ll_row = idw_lis.GetRow( )


ls_tem	= f_Trim( idw_lis.Object.c_codigo_tem[ll_row] )
ls_cod	= f_Trim( idw_lis.Object.c_codigo_pal[ll_row] )
ls_sec	= f_Trim( idw_lis.Object.c_codsec_pal[ll_row] )
ls_man	= f_Trim( idw_lis.Object.c_codigo_man[ll_row] )
ls_act	= f_Trim( idw_lis.Object.c_activo_pal[ll_row] )
id_emp	= idw_lis.Object.d_empaque_pal[ll_row]
If ls_sec = '00' Then
	MessageBox( Title, 'El palet normal no puede ser actualizado, debe eliminarlo y volver a ingresar.' )
	idw_lis.SetFocus( )
	Return
End If
If ls_man = '' Then
	MessageBox( Title, 'El palet no se encuentra en un manifiesto, no se puede continuar.' )
	idw_lis.SetFocus( )
	Return
End If
If ls_act = '0' Then
	MessageBox( Title, 'El registro se encuentra eliminado/cancelado.' )
	idw_lis.SetFocus( )
	Return
End If

/*If dw_list.Object.c_activo_man[dw_list.GetRow( )] = '0' Then
	MessageBox( Title, 'El registro se encuentra eliminado/cancelado.' )
	dw_list.SetFocus( )
	Return
End If
*/
//lstr_parm.s_cad[1] = ls_tem
//lstr_parm.s_cad[2] = ls_man
//CloseWithReturn( Parent, lstr_parm )
end event

type cb_pornumero from uo_cbother within tabpage_3
int X=1701
int Y=36
int TabOrder=20
string Text="&Por Número..."
end type

event clicked;DateTime	ld_null
String	ls_numdoc,ls_tipo

Open( w_arch_ingresar_numero_doc )

ls_numdoc = f_Trim( Message.StringParm )

If ls_numdoc = '' Then Return

If Len( ls_numdoc ) <= 2 Then
	MessageBox( Title, 'Para buscar por número de documento por lo menos ' + & 
							'debe ingresar 3 caracteres consecutivos', Exclamation! )
	Return
End If

ls_numdoc = '%' + ls_numdoc + '%'
if gs_tipo='' then
	ls_tipo='%'
else
	if gs_tipo='F' then
		ls_tipo='1'
	else
		ls_tipo='0'
	end if
end if


SetNull( ld_null )
dw_lis.Retrieve( gs_codtem, ld_null, ld_null, ls_numdoc,ls_tipo)
dw_lis.SetFocus( )


end event

type cb_expandir from uo_cbother within tabpage_3
int X=46
int Y=936
int TabOrder=20
string Tag="Expandir"
string Text="E&xpandir"
end type

event clicked;//w_arch_palet_2.Resizable = True

If This.Text = 'C&ontraer' Then
	This.Text = 'E&xpandir'
	w_arch_palet_2.WindowState = Normal!
	tab_1.width = 2789
	tab_1.height = 1008
	idw_lis.width = 2670
	idw_lis.height = 616
	w_arch_palet_2.Width = 2870
	w_arch_palet_2.Height = 1360
Else
	This.Text = 'C&ontraer'
	//w_arch_palet_2.WindowState = Maximized!
	w_arch_palet_2.ArrangeSheets(Layer!)
	tab_1.width = w_arch_palet_2.width - (tab_1.x * 2 ) - 50
	tab_1.height = w_arch_palet_2.height - (tab_1.x * 2 ) - (cb_cerrar.height * 2 )
	idw_lis.width = tab_1.width - 100
	idw_lis.height = tab_1.height - 400
End If

cb_cerrar.y = tab_1.height + tab_1.x + (tab_1.x/2) 
st_nota.y = cb_cerrar.y 
p_nota.y = cb_cerrar.y 
cb_imprimir.y = cb_cerrar.y 
cb_aplicar.y = cb_imprimir.y 
cb_aceptar.y = cb_aplicar.y 
This.y = idw_lis.height + (This.height * 1.8)
cb_eliminar.y = This.y

idw_lis.SetFocus( )

Return


end event

type tabpage_4 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=100
int Width=2784
int Height=1052
long BackColor=82899184
string Text="Pallet sin Confirmar"
long TabBackColor=82899184
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_scmix2 dw_scmix2
cb_scagrega cb_scagrega
cb_scelimina cb_scelimina
cb_scmix cb_scmix
dw_scmix dw_scmix
end type

on tabpage_4.create
this.dw_scmix2=create dw_scmix2
this.cb_scagrega=create cb_scagrega
this.cb_scelimina=create cb_scelimina
this.cb_scmix=create cb_scmix
this.dw_scmix=create dw_scmix
this.Control[]={this.dw_scmix2,&
this.cb_scagrega,&
this.cb_scelimina,&
this.cb_scmix,&
this.dw_scmix}
end on

on tabpage_4.destroy
destroy(this.dw_scmix2)
destroy(this.cb_scagrega)
destroy(this.cb_scelimina)
destroy(this.cb_scmix)
destroy(this.dw_scmix)
end on

type dw_scmix2 from datawindow within tabpage_4
int X=37
int Y=520
int Width=2679
int Height=352
int TabOrder=40
string DataObject="d_arch_palet_mixto"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event itemchanged;Return wf_ItemChanged( This, dwo.Name, data, row )
end event

type cb_scagrega from commandbutton within tabpage_4
int X=1527
int Y=372
int Width=347
int Height=92
int TabOrder=50
string Text="Agregar"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;DateTime	ld_emp
Integer	i
String	ls_ele, ls_pal

idw_scmix1.AcceptText( )
ls_ele = f_Trim( idw_scmix1.Object.c_elemento[1] )
ld_emp = idw_scmix1.Object.d_empaque_pal[1]
ls_pal = idw_scmix1.Object.c_ultimo[1]

If Len( ls_ele ) <> 6 Then
	MessageBox( Parent.Text, 'Debe ingresar el elemento o seleccionar ' + &
					'el producto y la etiqueta.', Exclamation! )
	Return
End If

If IsNull( ld_emp ) Then
	MessageBox( Parent.Text, 'Debe ingresar la fecha del empaque.', Exclamation! )
	//idw_scmix1.Object.d_empaque_pal[1] = DateTime( Today( ) )
	Return
End If

If f_Zero( idw_scmix1.Object.n_bulxpa_pal[1] ) <= 0 Then
	MessageBox( Parent.Text, 'Debe ingresar la cantidad de bultos(cajas).', Exclamation! )
	Return
End If

i = idw_scmix2.InsertRow( 0 )

idw_scmix2.Object.c_codigo_tem[i]	= idw_scmix1.Object.c_codigo_tem[1]
idw_scmix2.Object.c_elemento[i]		= idw_scmix1.Object.c_elemento[1]
idw_scmix2.Object.d_empaque_pal[i]	= idw_scmix1.Object.d_empaque_pal[1]
idw_scmix2.Object.c_codigo_pal[i]	= idw_scmix1.Object.c_codigo_pal[1]
idw_scmix2.Object.c_codigo_pro[i]	= idw_scmix1.Object.c_codigo_pro[1]
idw_scmix2.Object.c_codigo_eti[i]	= idw_scmix1.Object.c_codigo_eti[1]
idw_scmix2.Object.c_codigo_col[i]	= idw_scmix1.Object.c_codigo_col[1]
idw_scmix2.Object.c_codigo_lot[i]	= idw_scmix1.Object.c_codigo_lot[1]
idw_scmix2.Object.c_codigo_env[i]	= idw_scmix1.Object.c_codigo_env[1]
idw_scmix2.Object.n_bulxpa_pal[i]	= idw_scmix1.Object.n_bulxpa_pal[1]
idw_scmix2.ScrollToRow( i )

For i = 1 To idw_scmix2.RowCount( )
	idw_scmix2.Object.c_codigo_pal[i] = idw_scmix1.Object.c_codigo_pal[1]
Next

idw_scmix1.DeleteRow( 0 )
idw_scmix1.InsertRow( 0 )

idw_scmix1.Object.d_empaque_pal[1] = ld_emp 
idw_scmix1.Object.c_ultimo[1] = ls_pal 
idw_scmix1.Object.c_staemp_pal[1] = is_staemp

idw_scmix1.SetFocus( )
idw_scmix1.SetColumn( 'c_elemento' )
end event

type cb_scelimina from commandbutton within tabpage_4
int X=1998
int Y=372
int Width=347
int Height=92
int TabOrder=40
string Text="Eliminar"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long	ll_row

If idw_scmix2.RowCount( ) <= 0 Then
	Beep(1)
	Return
End If

ll_row = idw_scmix2.GetRow( )

idw_scmix2.SelectRow( ll_row, True )
If MessageBox( Parent.Text, 'Confirma que desea eliminar este elemento?', Question!, YesNo! ) = 1 Then
	idw_scmix2.DeleteRow(0)
End If
idw_scmix2.SelectRow( 0, False )
end event

type cb_scmix from commandbutton within tabpage_4
int X=2432
int Y=372
int Width=347
int Height=92
int TabOrder=30
string Text="Nuevo"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;DataWindow	ldw_1
DataWindowChild	ldwc_x
DateTime				ld_emp
Integer	i, j
String	ls_col[]

ls_col = {'c_elemento', 'c_codigo_pro', 'c_codigo_eti', 'd_empaque_pal', &
				'c_codigo_env', 'n_bulxpa_pal', 'c_codigo_pal', 'c_codigo_lot', 'c_codigo_col' }

/* Reseteo de Valores */
ldw_1 = idw_scmix1
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
idw_scmix1.GetChild( 'c_codigo_lot', ldwc_x )
ldwc_x.SetTransObject( SqlCa )
ldwc_x.SetFilter( '' )
ldwc_x.Filter( )
ldwc_x.Retrieve( )

ldw_1 = idw_scmix2
ldw_1.SetRedraw( False )
ldw_1.Reset( )
ldw_1.SetTransObject( SqlCa )
ldw_1.SetRedraw( True )
ls_col = {'c_elemento', 'c_codigo_pro', 'c_codigo_eti', 'd_empaque_pal', &
			'c_codigo_env', 'n_bulxpa_pal', 'c_codigo_pal', 'c_codigo_lot', 'c_codigo_col' }
	
For i = 1 To UpperBound( ls_col )
	f_ColEnabled( ldw_1, ls_col[i], True )
Next

cb_scagrega.Enabled = True
cb_scelimina.Enabled = True

end event

type dw_scmix from datawindow within tabpage_4
int Y=16
int Width=2725
int Height=496
int TabOrder=20
string DataObject="d_arch_palet_mixto_cab"
boolean Border=false
boolean LiveScroll=true
end type

event itemchanged;Return wf_ItemChanged( This, dwo.Name, data, row )
end event

type tabpage_5 from userobject within tab_1
int X=18
int Y=100
int Width=2784
int Height=1052
long BackColor=82899184
string Text="Confirmar Pallet"
long TabBackColor=82899184
long TabTextColor=33554432
long PictureMaskColor=536870912
st_4 st_4
sle_1 sle_1
st_3 st_3
sle_pal sle_pal
cb_1 cb_1
dw_confirma dw_confirma
cb_2 cb_2
end type

on tabpage_5.create
this.st_4=create st_4
this.sle_1=create sle_1
this.st_3=create st_3
this.sle_pal=create sle_pal
this.cb_1=create cb_1
this.dw_confirma=create dw_confirma
this.cb_2=create cb_2
this.Control[]={this.st_4,&
this.sle_1,&
this.st_3,&
this.sle_pal,&
this.cb_1,&
this.dw_confirma,&
this.cb_2}
end on

on tabpage_5.destroy
destroy(this.st_4)
destroy(this.sle_1)
destroy(this.st_3)
destroy(this.sle_pal)
destroy(this.cb_1)
destroy(this.dw_confirma)
destroy(this.cb_2)
end on

type st_4 from statictext within tabpage_5
int X=87
int Y=152
int Width=187
int Height=80
boolean Enabled=false
string Text="Fecha:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within tabpage_5
int X=279
int Y=152
int Width=439
int Height=68
int TabOrder=30
boolean Border=false
boolean AutoHScroll=false
long TextColor=255
long BackColor=82899184
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within tabpage_5
int X=87
int Y=28
int Width=169
int Height=80
boolean Enabled=false
string Text="Pallet:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_pal from singlelineedit within tabpage_5
int X=283
int Y=28
int Width=718
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;string ls_pal

ls_pal =  f_trim(sle_pal.text)
if ls_pal <> '' then
	wf_buscapalletsc(ls_pal)


end if
end event

type cb_1 from commandbutton within tabpage_5
int X=1006
int Y=28
int Width=105
int Height=92
string Text="..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_buscapalletsc('')
end event

type dw_confirma from datawindow within tabpage_5
int X=59
int Y=228
int Width=2679
int Height=744
int TabOrder=40
string DataObject="d_arch_palet_mixtosc"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event itemchanged;Return wf_ItemChanged( This, dwo.Name, data, row )
end event

type cb_2 from commandbutton within tabpage_5
int X=1147
int Y=28
int Width=347
int Height=92
int TabOrder=20
string Text="&Agregar"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//datastore lds_listado
//long ll_renglon,i,j,ll_row,ll_existe,li_pal
//string ls_elemento,ls_pal,ls_sec,ls_eti,ls_lot,ls_color,ls_pro,ls_env,ls_pall
//decimal{2} ldc_bultos
//datetime ld_fecha
//
//ls_pal = f_trim(sle_pal.text)
//li_pal = f_Zero( Integer( f_GetParmValue( '28' ) ) )
//ls_pal = Right( Fill( '0', li_pal ) + ls_pal, li_pal )
//
//ll_row = idw_confirma.rowcount()
//
//select count(c_codigo_pal)
//into :ll_existe
//from t_paletsinconfirmar 
//where c_codigo_pal = :ls_pal
//and c_codigo_tem = :gs_codtem
//and c_staemp_pal = '2'
//using sqlca;
//If f_SqlError( SqlCa, 'No se pudo leer la tabla  t_palet (select)' ) < 0 Then 
//		RollBack Using SqlCa ;
//		Return 0
//End If	
//if ll_existe = 0 then
//	messagebox(title,' este pallet ya ha sido confirmado',exclamation!)
//	sle_pal.text = ''
//	sle_pal.setfocus()
//	return 0
//end if
//
//for i = 1 to ll_row
//	ls_pall = idw_confirma.object.c_codigo_pal[i]
//	if ls_pall = ls_pal then
//		messagebox(title,'El pallet ya existe en el detalle no puede agregarlo de nuevo',exclamation!)
//		sle_pal.text = ''
//		return 0
//	end if
//next
//
//lds_listado = create datastore
//lds_listado.dataobject = 'd_arch_dds_palet_mixto_confirma'
//lds_listado.settransobject(sqlca)
//lds_listado.retrieve(ls_pal)
//ll_renglon =lds_listado.rowcount()
//
//for i = 1 to ll_renglon
//	ls_elemento = lds_listado.object.c_elemento[i]
//	ls_pal = lds_listado.object.c_codigo_pal[i]   
//	ls_Sec = lds_listado.object.c_codsec_pal[i]   
//	ls_pro = lds_listado.object.c_codigo_pro[i]   
//	ls_eti = lds_listado.object.c_codigo_eti[i]   
//	ls_lot = lds_listado.object.c_codigo_lot[i]   
//	ld_fecha = lds_listado.object.d_empaque_pal[i]     
//	ls_env = lds_listado.object.c_codigo_env[i]   
//	ldc_bultos = lds_listado.object.n_bulxpa_pal[i]   
//	ls_color = lds_listado.object.c_codigo_col[i]
//	
//	j = idw_confirma.InsertRow(0)
//	idw_confirma.ScrollToRow(j)
//	idw_confirma.SetRow(j)
//	
//	idw_confirma.object.c_elemento[j] = ls_elemento
//	idw_confirma.object.c_codigo_pal[j] = ls_elemento  
//	idw_confirma.object.c_codsec_pal[j] = ls_Sec 
//	idw_confirma.object.c_codigo_pro[j] = ls_pro
//	idw_confirma.object.c_codigo_eti[j] = ls_eti 
//	idw_confirma.object.c_codigo_lot[j] =  ls_lot 
//	idw_confirma.object.d_empaque_pal[j] = ld_fecha     
//	idw_confirma.object.c_codigo_env[j]  = ls_env  
//	idw_confirma.object.n_bulxpa_pal[j]  =  ldc_bultos 
//	idw_confirma.object.c_codigo_col[j] = ls_color
//	idw_confirma.object.c_codigo_pal[j] = ls_pal
//next
//
//sle_pal.text = ''
wf_agregar2()
end event

type st_nota from statictext within w_arch_palet_2
int X=114
int Y=1304
int Width=965
int Height=80
boolean Enabled=false
string Text="El Número de Pallet no podrá ser modificado"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_nota from picture within w_arch_palet_2
int X=32
int Y=1304
int Width=73
int Height=56
string PictureName="nota.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type cb_imprimir from uo_cbother within w_arch_palet_2
int X=2107
int Y=1328
int TabOrder=50
string Text="Imprimir"
end type

event clicked;wf_Print( )
end event

type dw_prn from datawindow within w_arch_palet_2
int X=1211
int Y=1608
int Width=137
int Height=92
boolean Border=false
boolean LiveScroll=true
end type

type cb_aplicar from uo_cbother within w_arch_palet_2
event ue_postaply pbm_custom01
int X=1723
int Y=1328
int TabOrder=40
boolean Enabled=false
string Text="&Aplicar"
boolean Default=true
end type

event ue_postaply;If Not cb_aceptar.Enabled Then
	If ii_pag = 1 Then
		tab_1.tabpage_1.cb_nuevo.SetFocus( )
		tab_1.tabpage_1.cb_nuevo.Default = True
	End If
	If ii_pag = 2 Then
		tab_1.tabpage_2.cb_newmix.SetFocus( )
	End If
End If

end event

event clicked;long ll_numpal,i
datawindow ldw_1
string ls_acc,ls_valta
idw_nor.accepttext()
idw_mix1.accepttext()

//ll_numpal = long(f_trim(em_1.text))
if ii_pag = 1 then
	ll_numpal = idw_nor.object.ll_pal[1]
elseif ii_pag = 2 then
	ll_numpal = idw_mix1.object.ll_pal[1]
end if
	
//ll_numpal = long(f_trim(em_1.text))

//if ll_numpal > 1 then
	If ii_pag = 1 Then
		ldw_1 = idw_nor
	//====
	elseif ii_pag = 4 then
		ldw_1 = idw_scmix2
		If is_acc = 'M' Then
			ls_acc = is_acc
		End If
	//====
	Else
		ldw_1 = idw_mix2
		If is_acc = 'M' Then
			ls_acc = is_acc
		End If
	End if
	
//	if wf_generavarios(ldw_1) = 1 then
//		commit using sqlca;
//		wf_print()
//	else
//	end if
//	
	
ls_valta = f_trim(f_getparmvalue('078')) //20081018 630pm
IF ls_valta <> 'S' and ii_pag = 2 THEN
	if wf_generavarios(ldw_1) = 1 then
			commit using sqlca;
			wf_print()
			//messagebox(title,'El registro ha sido guardado',exclamation!)
	else
		ROLLBACK USING SQLCA;
	end if
ELSE//20081018630PM valta
	IF wf_generavarios(ldw_1) = 1 THEN	
		commit using sqlca;
			WF_PRINT()
	ELSE
		ROLLBACK USING SQLCA;
	END IF

END IF
commit using sqlca;
	
end event

type cb_cerrar from uo_cbcancelar within w_arch_palet_2
int X=2469
int Y=1328
int TabOrder=60
string Text="Cerrar"
end type

event clicked;call super::clicked;f_getPrinter('S', gs_dprinter) 
close(w_arch_palet)
end event

type cb_aceptar from uo_cbaceptar within w_arch_palet_2
int X=1362
int Y=1328
int TabOrder=20
boolean Enabled=false
boolean Default=false
end type

event clicked;Long ll_numpal,i
Datawindow ldw_1
String ls_acc,ls_valta

If ii_pag = 1 Then
	ldw_1 = idw_nor
elseif ii_pag = 4 then
	ldw_1 = idw_scmix2
	If is_acc = 'M' Then
		ls_acc = is_acc
	End If
Else
	ldw_1 = idw_mix2
	If is_acc = 'M' Then
		ls_acc = is_acc
	End If
End if

idw_nor.accepttext()
idw_mix1.accepttext()

if ii_pag = 1 then
	ll_numpal = idw_nor.object.ll_pal[1]
elseif ii_pag = 2 then
	ll_numpal = idw_mix1.object.ll_pal[1]
end if

ls_valta = f_trim(f_getparmvalue('078')) //20081018 630pm
IF ls_valta <> 'S' and ii_pag = 2 THEN
	if wf_generavarios(ldw_1) = 1 then
			commit using sqlca;
			wf_print()
	else
		ROLLBACK USING SQLCA;
	end if
ELSE//20081018630PM valta
	IF wf_generavarios(ldw_1) = 1 THEN	
		commit using sqlca;
		WF_PRINT()
	ELSE
		ROLLBACK USING SQLCA;
	END IF
END IF
commit using sqlca;
end event

type cb_confirma from commandbutton within w_arch_palet_2
int X=1746
int Y=1328
int Width=347
int Height=92
int TabOrder=30
string Text="Con&firmar"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_acc 

ls_acc = 'I'
If Not wf_ActualizaAcumuladosc( ls_acc ) Then
	RollBack Using SqlCa ;
	MessageBox( Title, 'El registro no ha sido guardado.', StopSign! )
else
	commit using sqlca;
	MessageBox( Title, 'El registro ha sido guardado.', information! )
End If
end event

