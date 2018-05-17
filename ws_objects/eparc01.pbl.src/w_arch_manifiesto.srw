$PBExportHeader$w_arch_manifiesto.srw
forward
global type w_arch_manifiesto from wa_response
end type
type p_ind from picture within w_arch_manifiesto
end type
type dw_prn from datawindow within w_arch_manifiesto
end type
type cb_imprimir from uo_cbother within w_arch_manifiesto
end type
type cb_nuevo from uo_cbother within w_arch_manifiesto
end type
type cb_guardar from uo_cbother within w_arch_manifiesto
end type
type cb_eliminar from uo_cbother within w_arch_manifiesto
end type
type cb_disponibles from uo_cbother within w_arch_manifiesto
end type
type cb_agregar from uo_cbother within w_arch_manifiesto
end type
type p_trac from picture within w_arch_manifiesto
end type
type p_ext from picture within w_arch_manifiesto
end type
type p_nac from picture within w_arch_manifiesto
end type
type p_pallet from picture within w_arch_manifiesto
end type
type cb_rem from commandbutton within w_arch_manifiesto
end type
end forward

global type w_arch_manifiesto from wa_response
integer x = 5
integer y = 4
integer width = 3305
integer height = 4140
string title = "Manifiesto"
string menuname = "m_principal_arch_manifiesto"
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
windowtype windowtype = main!
windowstate windowstate = maximized!
long backcolor = 1090519039
event ue_save pbm_custom01
event ue_new pbm_custom02
event ue_open pbm_custom03
event vscroll pbm_vscroll
event ue_print pbm_custom04
p_ind p_ind
dw_prn dw_prn
cb_imprimir cb_imprimir
cb_nuevo cb_nuevo
cb_guardar cb_guardar
cb_eliminar cb_eliminar
cb_disponibles cb_disponibles
cb_agregar cb_agregar
p_trac p_trac
p_ext p_ext
p_nac p_nac
p_pallet p_pallet
cb_rem cb_rem
end type
global w_arch_manifiesto w_arch_manifiesto

type variables
Boolean ib_saved = True, ib_new = True

Integer ii_height = 72 /* Alto de cada registro */
end variables

forward prototypes
public function boolean wf_save ()
public function string wf_getrfc (string as_dwo, string as_data)
public function boolean wf_aceptar ()
public subroutine wf_disponibles ()
public function integer wf_agregar ()
public function integer wf_eliminar ()
public function integer wf_new ()
public function string wf_getnewnummanif ()
public function integer wf_open ()
public function long wf_print ()
public function integer wf_setimporte ()
public function integer wf_openmanif ()
public function long wf_printfact ()
public function boolean wf_savechanges ()
public function boolean wf_actualizaacumulados (string as_acc)
public function boolean wf_getprice (string as_pro, string as_eti, string as_cul, ref decimal adc_pmn, ref decimal adc_pme)
public subroutine wf_actualizadddw (string as_col)
public function boolean wf_reasignaprecios (boolean ab_update)
public subroutine wf_enabled (boolean ab_enabled)
public function integer wf_setimporte2 ()
public function integer wf_actualizapeso ()
public function integer wf_reenbarcado ()
end prototypes

event ue_save;wf_Save( )
end event

event ue_new;wf_New( )
end event

event ue_open;
wf_Open( )
end event

event vscroll;gw_frame.SetMIcrohelp( String(scrollpos ))



end event

event ue_print;wf_Print( )
end event

public function boolean wf_save ();Long	i,ll_rem,ll_renglon, ll_longitud, ll_por,ll_mismos,ll_list,u,m
String	ls_man, ls_pal, ls_eti, ls_cul, ls_pro, ls_sec, ls_fac, ls_aux, ls_mer, ls_pa1, ls_pa2, ls_chr, ls_num,ls_rem,ls_caux
string ls_col,ls_env,ls_null,ls_dis,ls_disp, ls_sello, ls_pesm, ls_pespal, ls_produc,ls_viaje,ls_poro,ls_por,ls_exis,ls_exc,ls_caa
DateTime	ld_hoy,ld_null 
Dec{2}	ldc_pmn, ldc_pme,ldc_precio,ldc_cantidad,ldc_total,ldc_pren,ldc_pree, ldc_pes, ldc_peso, ldc_peso1, ldc_pesopal, ldc_dif
Dec{2}   ldc_coprecio, ldc_precio1, ldc_difpre
datastore lds_listado,lds_1,lds_mismos

setnull(ls_null)
setnull(ld_null)

ls_disp = upper(f_trim(f_GetParmValue('072')))
ls_dis = f_trim(dw_1.object.c_codigo_dis[1])

ld_hoy = DateTime(Today())

If ib_saved Then 
	Beep(1)
	SetMicroHelp( 'Documento no modificado' )
	Return False
End If

ib_saved = False

dw_list.AcceptText( )
If dw_list.RowCount( ) <= 0 Then
	MessageBox( Title, 'No existe detalle de manifiesto.~r~n' + &
							'Debe ingresar la lista de pallets', Exclamation! )
	Return False
End If
dw_1.Object.c_codigo_man.Edit.DisplayOnly = 'yes'
dw_1.AcceptText( )
ls_man = f_Trim( dw_1.Object.c_codigo_man[1] )
ls_fac = f_Trim( dw_1.Object.c_numfac_man[1] )
ls_mer = f_Trim( dw_1.Object.c_merdes_man[1] )
ls_chr = Left( ls_man, 1 )


If ls_man = '' Then
	MessageBox( Title, 'Debe ingresar el número de manifiesto.', Exclamation! )
	Return False
End If

If f_Trim( dw_1.Object.c_numfac_man[1] ) = '' Then
	MessageBox( Title, 'Debe ingresar el número de factura.', Exclamation! )
	Return False
End If

If f_Trim( dw_1.Object.c_codigo_emb[1] ) = '' Then
	MessageBox( Title, 'Debe seleccionar el embarcador.', Exclamation! )
	Return False
End If

If ls_mer = '' Then
	MessageBox( Title, 'Debe seleccionar el mercado destino.', Exclamation! )
	Return False
End If

If f_Trim( dw_1.Object.c_numvia_man[1] ) = '' Then
	MessageBox( Title, 'Debe ingresar el número de viaje.', Exclamation! )
	Return False
End If

If f_Trim( dw_1.Object.c_codigo_aga[1] ) = '' Then
	MessageBox( Title, 'Debe seleccionar la agencia de aduanas nacional.', Exclamation! )
	Return False
End If

If ls_mer = 'E' Then
	If f_Trim( dw_1.Object.c_ageext_man[1] ) = '' Then
		MessageBox( Title, 'Debe seleccionar la agencia de aduanas extranjera.', Exclamation! )
		Return False
	End If
End If

If f_Trim( dw_1.Object.c_codigo_dis[1] ) = '' Then
	MessageBox( Title, 'Debe seleccionar el distribuidor.', Exclamation! )
	Return False
End If

If f_Trim( dw_1.Object.c_codigo_lit[1] ) = '' Then
	MessageBox( Title, 'Debe seleccionar la linea de transporte.', Exclamation! )
	Return False
End If

If f_Trim( dw_1.Object.v_lugdes_man[1] ) = '' Then
	MessageBox( Title, 'Debe ingresar el lugar destino.', Exclamation! )
	Return False
End If

If f_Trim( dw_1.Object.v_chofer_man[1] ) = '' Then
	MessageBox( Title, 'Debe ingresar el nombre del chofer.', Exclamation! )
	Return False
End If

If f_Trim( dw_1.Object.v_medtra_man[1] ) = '' Then
	MessageBox( Title, 'Debe ingresar/seleccionar el medio de transporte.', Exclamation! )
	Return False
End If

If f_Trim( dw_1.Object.v_numcaj_man[1] ) = '' Then
	MessageBox( Title, 'Debe ingresar el numero de caja del medio de transporte.', Exclamation! )
	Return False
End If

If f_Trim( dw_1.Object.c_horcre_man[1] ) = '' Then
	MessageBox( Title, 'Debe ingresar hora de salida del medio de transporte.', Exclamation! )
	Return False
End If

If f_getparmvalue ('091') = 'S' then
	If f_Trim( dw_1.Object.v_flejesagarpa_man[1] ) = '' Then
		MessageBox( Title, 'Debe ingresar SCAC / N° Fleje SAGARPA del medio de transporte.', Exclamation! )
		Return False
	End If
End If 

If f_getparmvalue ('090') = 'S' then
	If f_Trim( dw_1.Object.v_certiforigen_man[1] ) = '' Then
		MessageBox( Title, 'Debe ingresar N° Sello CTPAT / Cert. de Origen medio de transporte.', Exclamation! )
		Return False
	End If
End If



If f_getparmvalue ('092') = 'S' then
	If f_zero( dw_1.Object.n_gflete_man[1] ) = 0 Then
		MessageBox( Title, 'Debe ingresar Gastos de Flete .', Exclamation! )
		Return False
	End If
End If
If f_getparmvalue ('106') = 'S' then//hilda 20091204
	If gs_punto = '' Then
		MessageBox( Title, 'Debe estar activado un punto de embarque .', Exclamation! )
		Return False
	else
		dw_1.object.c_codigo_pte[1]=gs_punto
		dw_1.object.c_tipo_man[1]=gs_tipo
	End If
End If


If f_getparmvalue ('090') = 'S' then
    ls_sello = f_Trim( dw_1.Object.v_certiforigen_man[1] )
	 ll_longitud = len(ls_sello)
	
   If f_zero(ll_longitud) <> 12 Then
		MessageBox( Title, 'Ingresar el siguiente formato en N° Sello CTPAT / Cert. de Origen: A12345-B12345 (A5digitos-B5digitos)', Exclamation! )
		Return False
	End If
End If

//guardado de excedente hilda 20091210
if f_getparmvalue('106')='S' then
	For i = 1 To dw_list.RowCount( )
		ls_exc=f_trim(dw_list.object.c_excedente_pal [i])
		ls_pal=f_trim(dw_list.object.c_codigo_pal [i])
		if ls_exc='' then
			ls_exc='0'
		end if
		Update	t_palet 
		Set		c_excedente_pal =:ls_exc
		Where		c_codigo_tem = :gs_codtem 
		And		c_codigo_pal = :ls_pal
		Using		SqlCa ;			
		If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_palet.' ) < 0 Then 
			RollBack Using SqlCa ;
			Return False
		End If
	next
end if
//Inicio Faby 2009-10-27
ll_por  = f_zero(integer(f_getParmValue ('102')))
If f_getparmvalue ('101') = 'S' Then  //si esta obligado  no permite dejarlo en blanco
i =  0
	For i = 1 To dw_list.RowCount( )
	If dw_list.object.n_peso_pal [i] = 0.00 Then
		MessageBox( Title, 'Debe ingresar el Peso, está condicionado obligatorio en el parametro 101', Exclamation! )
		Return False
	End If
		
	ldc_peso1 = dw_list.object.peso[i]  
	ldc_pesopal = dw_list.object.n_peso_pal [i]
	
	ldc_dif = ldc_peso1 * (ll_por / 100)  //calcula que no se pase arriba o abajo del porcentaje del parametro
	If ldc_pesopal > (ldc_peso1 + ldc_dif) Then
		MessageBox( Title, 'El peso otorgado sobrepasa el pocentaje del peso del palet.~r~n' + &
								'Favor de checar y corregir', Exclamation! )
		Return False
	End If
Next
End If
	
If f_getparmvalue ('101') = 'S' Then
	i =  0
	For i = 1 To dw_list.RowCount( )
	If dw_list.object.precio [i] = 0.00 Then
		MessageBox( Title, 'Debe ingresar el Precio, está condicionado obligatorio en el parametro 80', Exclamation! )
		Return False
	End If
	
	ldc_coprecio = dw_list.object.co_precio[i]
	ldc_precio1 = dw_list.object.precio[i]
	
	ldc_difpre = ldc_coprecio  * (ll_por / 100)
	If ldc_precio1 > (ldc_coprecio + ldc_difpre) Then
		MessageBox( Title, 'El Precio otorgado sobrepasa el pocentaje del precio del palet.~r~n' + &
								'Favor de checar y corregir', Exclamation! )
		Return False
	End If
	Next
End If
////Fin Faby 2009-10-27
////hilda 20091208 si es rembarcado y con los mismos pallets 

if f_trim(dw_1.object.reembarque[1])='S' then
	lds_mismos = create datastore
	lds_mismos.dataobject = 'd_arch_palet_mismos'
	lds_mismos.settransobject(sqlca)
	lds_mismos.retrieve(gs_codtem +ls_mer+ls_man)
	ll_mismos =lds_mismos.rowcount()
	ll_list=dw_list.rowcount()
	if ll_mismos =ll_list then //si van los mismos pallets
		update t_manifiesto
		set c_tipo_man='F',c_codigo_pte=:gs_punto
		where c_codigo_man=:ls_mer+:ls_man
		using sqlca;
		If f_SqlError( SqlCa, 'No se pudo leer la tabla t_manifiesto. (UPDATE)' ) < 0 Then 
			RollBack Using SqlCa ;
			Return False
		End If
		
		Update	t_palet 
		Set		c_codigo_man =''
		Where		c_codigo_tem = :gs_codtem 
		And		c_codigo_man = :ls_mer+:ls_man
		and		c_excedente_pal='1'
		Using		SqlCa ;			
		If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_palet.' ) < 0 Then 
			RollBack Using SqlCa ;
			Return False
		End If
		ib_saved = True
		ib_new = False
		dw_1.object.c_codigo_man[1]=ls_mer+ls_man
		commit using sqlca;
		MessageBox( Title, 'Manifiesto Nro. ' + ls_man + ' guardado correctamente.' )
			wf_Print( )
		return true
		
		ELSE//algun palet cambio a excedente
			update t_manifiesto
			set c_tipo_man='F'
			where c_codigo_man=:ls_mer+:ls_man
			using sqlca;
			If f_SqlError( SqlCa, 'No se pudo leer la tabla t_manifiesto. (UPDATE)' ) < 0 Then 
				RollBack Using SqlCa ;
				Return False
			End If
			
	END IF
	destroy lds_mismos 
end if
If Not IsNumber( ls_chr ) Then // Si no es un digito verificar si tiene la letra de mer_des
	If Not ls_chr = 'E' And Not ls_chr = 'N' Then
		ls_man = ls_mer + ls_man
	End If
Else		
	ls_man = ls_mer + ls_man
End If

/* Numero con que se guardar'a el folio en la tabla de parametros */
ls_num = Mid( ls_man, 2 )

SetMicroHelp( 'Guardando ...' )

wf_SetImporte( )
wf_setimporte2( )

dw_1.Object.c_codigo_tem[1] = gs_codtem
dw_1.Object.c_codigo_usu[1] = gs_usuario 
dw_1.Object.c_activo_man[1] = '1'
//dw_1.Object.c_horcre_man[1] = String( Now( ), 'hhmm' )
dw_1.Object.d_creacion_man[1] = Datetime(Today( ))
dw_1.Object.c_codigo_man[1] = ls_man
//guarda pto y reempaque 20091206
if gs_tipo='F' then
	dw_1.Object.c_tipo_man[1] = 'F'
	dw_1.Object.c_codigo_pte[1] = gs_punto
end if
dw_1.AcceptText( )

//20080524
ls_rem = upper(f_trim(f_getparmvalue('071')))
if ls_rem = 'S' then
	//dw_1.object.c_numfac_man[1]= ls_fac
	dw_1.object.c_numfac_man[1]= ls_fac
//else
//	dw_1.object.c_numfac_man[1]= ls_fac
end if

if( f_trim(dw_1.object.reembarque[1])='S'  and  ll_mismos <> ll_list ) or f_getparmvalue ('106') = 'N' OR f_trim(dw_1.object.reembarque[1])='' then	//hilda 20091209	
/* Guarda el ultimo manifiesto generado en la tabla */
If ib_new Then
	If f_getparmvalue ('106') = 'S' and gs_tipo='N' then//hilda 20100112
		ls_caa=f_Trim( dw_1.Object.c_caades_man[1] )
		If ls_caa = '' Then
			MessageBox( Title, 'Debe ingresar el numero de CAADES.', Exclamation! )
			Return False
		End If
		
		select c_caades_man
		into   :ls_caux
		from   t_manifiesto(nolock)
		where	 c_caades_man=:ls_caa
		Using		SqlCa ;			
		If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_palet.' ) < 0 Then 
			RollBack Using SqlCa ;
			Return False
		End If
		if ls_caux <> '' then
			MessageBox( Title, 'El numero de CAADES, ya existe debe de ingresar otro.', Exclamation! )
			Return False
		end if
	end if
	//20080522 no repetir remision si es san simon
	if ls_rem = 'S' then
		select count(c_numfac_man)
		into :ll_rem
		from t_manifiesto
		where c_numfac_man = :ls_fac
		and c_merdes_man = 'N'
		using sqlca;
		If f_SqlError( SqlCa, 'No se pudo leer la tabla t_manifiesto. (select)' ) < 0 Then 
			RollBack Using SqlCa ;
			Return False
		End If
		
		if ll_rem > 0 then
			messagebox(title,'El número de remisión ingresado ya existe... favor de corregir',exclamation!)
			return false
		end if
	end if	
	
	//
	ls_aux = ''
	Select	c_codigo_man
	Into		:ls_aux
	From		t_manifiesto (nolock)
	Where		c_codigo_tem = :gs_codtem 
	And		c_codigo_man = :ls_man ;
	
	If f_SqlError( SqlCa, 'No se pudo actualizar la tabla . (c_codigo_man)' ) < 0 Then 
		RollBack Using SqlCa ;
		Return False
	End If
	
	If f_Trim( ls_aux ) <> '' Then
		MessageBox( Title, 'El Número de Manifiesto ingresado ya existe, debe de reemplazarlo.', Exclamation! )
		Return False
	End If
	
	dw_1.Object.c_contab_man[1] = '0'
	If ls_mer = 'N' Then
		ls_pa1 = '32' ; ls_pa2 = '34' // <---- Actualizar los parametros segun mercado /Nacional
	Else
		ls_pa1 = '12' ; ls_pa2 = '14' // <---- Extranjero
	End If
	If f_getparmvalue ('106') <> 'S' then//hilda 20091204
		If Not f_SetParmValue( ls_pa1, ls_num ) Then
			RollBack Using SqlCa ;
			Return False
		End If
		
		If Not f_SetParmValue( ls_pa2, ls_fac ) Then
			RollBack Using SqlCa ;
			Return False
		End If
		
		If Not f_SetParmValue( '16', f_Trim( dw_1.Object.c_numvia_man[1] ) ) Then
			RollBack Using SqlCa ;
			Return False
		End If
	else		
		ls_viaje=f_Trim( dw_1.Object.c_numvia_man[1] )
		If ls_mer = 'N' Then
			update	t_puntoembarque
			set		n_foliomanifiestomn_pte=:ls_num,n_foliofacturamn_pte=:ls_fac,n_numeroviaje_pte=:ls_viaje,c_caades_man=:ls_caa
			where		c_codigo_pte=:gs_punto
			using		sqlca;
			If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_puntoembarque.' ) < 0 Then 
				RollBack Using SqlCa ;
				Return False
			End If
		else
			update	t_puntoembarque
			set		n_foliomanifiestome_pte=:ls_num,n_foliofacturame_pte=:ls_fac,n_numeroviaje_pte=:ls_viaje,c_caades_man=:ls_caa
			where		c_codigo_pte=:gs_punto
			using		sqlca;
			If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_puntoembarque.' ) < 0 Then 
				RollBack Using SqlCa ;
				Return False
			End If
		end if
		
	end if
End If
end if//hilda
/* Actualizacion de Acumulados */
If Not ib_new Then
	If Not wf_ActualizaAcumulados( 'E' ) Then
		RollBack Using SqlCa ;
		MessageBox( Title, 'Se produjo un error al guardar el Manifiesto Nro. ' + ls_man + '.', StopSign! )
		Return False
	End If
End If

wf_ReasignaPrecios( False )

If dw_1.Update( ) <> 1 Then
	RollBack Using SqlCa ;
	Return False
End If
//marca palet como normales 20091206
if gs_tipo='F' and  f_trim(dw_1.object.reembarque[1]) <> 'S'   then
	Update	t_palet 
	Set		c_excedente_pal = '0'
	Where		c_codigo_tem = :gs_codtem 
	And		c_codigo_man = :ls_man 
	Using		SqlCa ;
	
	If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_palet.' ) < 0 Then 
		RollBack Using SqlCa ;
		Return False
	End If
//falta marcar aki los excedentes si no fuern reemvbaracdos
elseif f_trim(dw_1.object.reembarque[1]) = 'S' and  ll_mismos <> ll_list  then
	lds_mismos = create datastore
	lds_mismos.dataobject = 'd_arch_palet_mismos'
	lds_mismos.settransobject(sqlca)
	lds_mismos.retrieve(gs_codtem +ls_mer+ls_man)
	ll_mismos =lds_mismos.rowcount()
	ll_list=dw_list.rowcount()
	for u=1 to ll_mismos //originales
		ls_poro=lds_mismos.object.c_codigo_pal[u]
		for m=1 to ll_list
			ls_por=dw_list.object.c_codigo_pal[m]
			if ls_poro = ls_por then
				ls_exis='S'
			else	
				CONTINUE
			END IF	
			IF LS_EXIS='S' THEN			
				Update	t_palet 
				Set		c_excedente_pal = 'E',c_codigo_man =''
				Where		c_codigo_tem = :gs_codtem 
				And		c_codigo_pal = :ls_por 
				Using		SqlCa ;			
				If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_palet.' ) < 0 Then 
					RollBack Using SqlCa ;
					Return False
				End If
			END IF
		next
		
	next
	
end if	


Update	t_palet 
Set		c_codigo_man = '',
			c_usumod_pal = :gs_usuario,
			c_staemb_pal = '0',
			d_modifi_pal = :ld_hoy
Where		c_codigo_tem = :gs_codtem 
And		c_codigo_man = :ls_man 
Using		SqlCa ;

If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_palet. (c_codigo_man = "")' ) < 0 Then 
	RollBack Using SqlCa ;
	Return False
End If
	

If Not wf_ReasignaPrecios( True ) Then
	RollBack Using SqlCa ;
	MessageBox( Title, 'Se produjo un error al guardar el Manifiesto Nro. ' + ls_man + '.', StopSign! )
	Return False
End If
//********************************************
ls_pesm = upper(f_trim(f_getparmvalue('101')))
if ls_pesm = 'S' then
	for i = 1 to dw_list.rowcount()
		ls_pespal = f_trim(dw_list.object.c_codigo_pal[i])
		ldc_pes = dw_list.object.n_peso_pal[i]
		ldc_peso =dw_list.object.peso[i]
		ls_produc = dw_list.object.c_codigo_pro [i]
		if (ldc_peso <> 0) and (ldc_peso <> ldc_pes) then
			
			Update	t_palet 
			Set		n_peso_pal = :ldc_pes,   //:ldc_peso,
						d_modifi_pal = :ld_hoy
			Where		c_codigo_tem = :gs_codtem 
			And		c_codigo_man = :ls_man 
			and      c_codigo_pal = :ls_pespal
			and		c_codigo_pro = :ls_produc
			Using		SqlCa ;
		
			If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_palet. (n_peso_pal = "")' ) < 0 Then 
				RollBack Using SqlCa ;
				Return False
			End If
			
		end if
	next
end if

//********************************************
If Not wf_ActualizaAcumulados( 'I' ) Then
	RollBack Using SqlCa ;
	MessageBox( Title, 'Se produjo un error al guardar el Manifiesto Nro. ' + ls_man + '.', StopSign! )
	Return False
End If

Commit Using SqlCa ;
ib_saved = True
ib_new = False

If f_GetParmValue( '26' ) = 'S' Then
SetMicroHelp( 'Imprimiendo ...' )
	wf_Print( )
Else
	MessageBox( Title, 'Manifiesto Nro. ' + ls_man + ' guardado correctamente.' )
End If

SetMicroHelp( 'Listo' )
if gs_tipo='F' and  f_trim(dw_1.object.reembarque[1]) <> 'S'  then
////20080605============================================================================
////crear remisiones
if ls_rem = 'S' then	
	ldc_total = f_zero(dw_1.object.n_importe_man[1])
	if ib_new then
//		if ls_mer = 'N' then
			lds_listado = create datastore
			lds_listado.dataobject = 'd_arch_generaremision'
			lds_listado.settransobject(sqlca)
			lds_listado.retrieve(gs_codtem,ls_mer,ls_fac)
			ll_renglon =lds_listado.rowcount()
			
			for i = 1 to ll_renglon
				ls_pro = f_trim(lds_listado.object.c_codigo_pro[i]) 
				ls_eti = f_trim(lds_listado.object.c_codigo_eti[i])  
				ls_col = f_trim(lds_listado.object.c_codigo_col[i]) 
				ls_env = f_trim(lds_listado.object.c_codigo_env[i])  
				ldc_cantidad = f_zero(lds_listado.object.n_bulxpa_pal[i]) 
				ldc_precio = f_zero(lds_listado.object.n_precmn_pal[i])
				ls_sec = right('000'+string(i),3)
				

				ldc_total = ldc_precio * ldc_cantidad
				if ls_mer = 'N' then	
						insert into cxcremision
							(c_remision_rem,	c_secuencia_rem,	c_codigo_pro,		c_codigo_eti,
							c_codigo_col,		n_cajas_rem,		n_preciouni_rem,	n_saldo_rem,	c_codigo_usu,	d_creacion_rem,
							 c_usumod_rem,		d_modifi_rem,		c_activo_rem,		n_importe_rem,	 n_saldocaja_rem,	c_codigo_dis)
						values(:ls_fac,			:ls_sec,				:ls_pro,			:ls_eti,
								:ls_col,			:ldc_cantidad,		:ldc_precio,		:ldc_total,		:gs_usuario,	:ld_hoy,
								:ls_null,		:ld_null,				'1',				:ldc_total,		:ldc_cantidad,		:ls_dis)
						using sqlca;
						If f_SqlError( SqlCa, 'No se pudo insertar en la tabla cxcremision . (insert)' ) < 0 Then 
							 RollBack Using SqlCa ;
							 Return false
						end if
				end if	
			next
			
//		end if
	else
		if ls_mer = 'N' then
			delete cxcremision
			where c_remision_rem = :ls_fac
			using sqlca;
			If f_SqlError( SqlCa, 'No se pudo eliminar en la tabla cxcfacturaremision . (delete)' ) < 0 Then 
				 RollBack Using SqlCa ;
				 Return false
			end if
		end if
			
			lds_listado = create datastore
			lds_listado.dataobject = 'd_arch_generaremision'
			lds_listado.settransobject(sqlca)
			lds_listado.retrieve(gs_codtem,ls_mer,ls_fac)
			ll_renglon =lds_listado.rowcount()
			
			for i = 1 to ll_renglon
				ls_pro = f_trim(lds_listado.object.c_codigo_pro[i]) 
				ls_eti = f_trim(lds_listado.object.c_codigo_eti[i])  
				ls_col = f_trim(lds_listado.object.c_codigo_col[i]) 
				ls_env = f_trim(lds_listado.object.c_codigo_env[i])  
				ldc_cantidad = f_zero(lds_listado.object.n_bulxpa_pal[i]) 
				ldc_precio = f_zero(lds_listado.object.n_precmn_pal[i])
				ls_sec = right('000'+string(i),3)
				
				ldc_total = ldc_precio * ldc_cantidad
				
				if ls_mer = 'N' then
					insert into cxcremision
							(c_remision_rem,	c_secuencia_rem,	c_codigo_pro,		c_codigo_eti,
							c_codigo_col,		n_cajas_rem,		n_preciouni_rem,	n_saldo_rem,	c_codigo_usu,	d_creacion_rem,
							 c_usumod_rem,		d_modifi_rem,		c_activo_rem,		n_importe_rem,	 n_saldocaja_rem,		c_codigo_dis)
					values(:ls_fac,			:ls_sec,				:ls_pro,				:ls_eti,
								:ls_col,			:ldc_cantidad,		:ldc_precio,		:ldc_total,		:gs_usuario,	:ld_hoy,
								:ls_null,		:ld_null,				'1',				:ldc_total,		:ldc_cantidad,			:ls_dis)
					using sqlca;
					If f_SqlError( SqlCa, 'No se pudo insertar en la tabla cxcremision . (insert)' ) < 0 Then 
						 RollBack Using SqlCa ;
						 Return false
					end if
				end if
			next
//		end if
	end if
		
end if
end if
destroy lds_1
commit using sqlca;

Return True
end function

public function string wf_getrfc (string as_dwo, string as_data);String	ls_rfc, ls_tabla

Choose Case as_dwo
	/* Todas las transacciones se hacen con SqlCa x Default */
	Case 'c_codigo_aga', 'c_codigo_age'
		ls_tabla = 't_agencia_aduana'
		Select	c_rfc_aga
		Into		:ls_rfc
		From		t_agencia_aduanal
		Where		c_codigo_aga = :as_data ;
		
	Case 'c_codigo_dis'
		ls_tabla = 't_distribuidor'
		Select	c_rfc_dis
		Into		:ls_rfc
		From		t_distribuidor
		Where		c_codigo_dis = :as_data ;

	Case 'c_codigo_emb'
		ls_tabla = 't_embarcador'
		Select	c_rfc_emb
		Into		:ls_rfc
		From		t_embarcador
		Where		c_codigo_emb = :as_data ;

	Case 'c_codigo_lit'
		ls_tabla = 't_linea_transporte'
		Select	c_rfc_lit
		Into		:ls_rfc
		From		t_linea_transporte
		Where		c_codigo_lit = :as_data ;

End Choose

If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla ' + ls_tabla + '.') < 0 Then
	Return ''
End If

Return ls_rfc
end function

public function boolean wf_aceptar ();String	ls_col,ls_lug,ls_desc

dw_1.AcceptText( )
Choose Case dw_1.GetColumnName( )
	Case 'c_codigo_man' 
		ls_col = 'd_embarque_man'
	Case 'd_embarque_man' 
		ls_col = 'c_numfac_man'
	Case 'c_numfac_man' 
		ls_col = 'c_codigo_emb'
	Case 'c_codigo_emb'
		ls_col = 'c_rfc_emb'
	Case 'c_rfc_emb' 
		ls_col = 'c_merdes_man'
	Case 'c_merdes_man' 
		ls_col = 'c_numvia_man'
	Case 'c_numvia_man' 
		ls_col = 'c_codigo_aga'
	Case 'c_codigo_aga' 
		//If f_Trim( dw_1.Object.c_merdes_man[1] ) = 'E' Then
			ls_col = 'c_rfc_aga'
		//Else
		//	ls_col = 'c_codigo_dis'
		//End If
	Case 'c_rfc_aga'
		ls_col = 'c_ageext_man'
	Case 'c_ageext_man'
		ls_col = 'c_rfc_age'		
	Case 'c_rfc_age' 
		ls_col = 'c_codigo_dis'
	Case 'c_codigo_dis' 
		//20071222
		ls_col = 'c_rfc_dis'
	Case 'c_rfc_dis'
		ls_col = 'v_observacion_man'
	case 'v_observacion_man'
		ls_col = 'c_codigo_lit'
//		ls_col = 'c_codigo_lit'
	Case 'c_codigo_lit'
		ls_col = 'c_rfc_lit'
	Case 'c_rfc_lit' 
		ls_col = 'v_lugdes_man'
	Case 'v_lugdes_man' 
		ls_col = 'c_codigo_cze'
	Case 'c_codigo_cze' 
		
		ls_lug = f_trim(dw_1.Object.c_codigo_cze[1])
		If ls_lug <>'' Then
			Select v_desclarga_cze
			Into :ls_desc
			From t_lugarescruce
			Where c_codigo_cze=:ls_lug
			Using SqlCa;
			
			If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_lugarescruce.' ) < 0 Then
				Return False
			End If
			dw_1.Object.v_cruzax_man[1]=ls_desc
		End If
		ls_col = 'v_chofer_man'
	Case 'v_chofer_man' 
		ls_col = 'v_licencia_man'
	Case 'v_licencia_man'
		ls_col ='v_medtra_man'
	Case 'v_medtra_man'
		ls_col = 'c_horcre_man'
	Case 'c_horcre_man' 
		ls_col = 'v_anofab_man'
	Case 'v_anofab_man' 
		ls_col = 'v_nummed_man'
	Case 'v_nummed_man' 
		ls_col = 'v_marca_man'
	Case 'v_marca_man' 
		ls_col = 'v_numcaj_man'
	Case 'v_numcaj_man' 
		ls_col = 'v_placaj_man'
	Case 'v_placaj_man' 
		ls_col = 'v_numpla_man'
	Case 'v_numpla_man' 
		ls_col = 'v_flejesagarpa_man'
	Case 'v_flejesagarpa_man' 
		ls_col = 'v_certiforigen_man'
	Case 'v_certiforigen_man' 
		ls_col = 'n_temper_man'
	Case 'n_temper_man' 
		ls_col = 'c_temmed_man'
	Case 'c_temmed_man'
		ls_col = 'v_cartaporte_man'
	Case 'v_cartaporte_man'	
		ls_col='c_caades_man'
	Case 'c_caades_man'
		ls_col = 'n_gflete_man'
	Case 'n_gflete_man' 
		ls_col = 'n_antfle_man'
	Case 'n_antfle_man' 
		ls_col = 'n_totbul_man'
	Case 'n_totbul_man' 
		ls_col = 'n_impiva_man'
	Case 'n_impiva_man'
		ls_col = 'n_importe_man'
	Case 'n_importe_man'
		ls_col = 'c_codigo_pal'
	Case 'c_codigo_pal' 
		If f_Trim( dw_1.Object.c_codigo_pal[1] ) <> '' Then
			wf_Agregar( )
		End If
		ls_col = 'c_codigo_pal'
	Case 'peso'
		wf_actualizapeso()
		ls_col = 'c_codigo_pal'
End Choose

dw_1.SetColumn( ls_col )
dw_1.SetFocus( )
Return True
end function

public subroutine wf_disponibles ();Integer	i
string ls_man,ls_mer
s_parm	lstr_parm

SetNull( Message.PowerObjectParm	)
ls_man=f_trim(dw_1.object.c_codigo_man[1])
ls_mer=f_trim(dw_1.object.c_merdes_man[1])
if dw_1.Object.reembarque[1] ='S' then
	OpenWithParm( w_arch_palet_disp_reembarque, ls_mer+ ls_man )
else
	OpenWithParm( w_arch_palet_disponibles, 'MAN' )
end if
lstr_parm = Message.PowerObjectParm	

If IsNull( lstr_parm ) Then Return
If Not IsValid( lstr_parm ) Then Return
If UpperBound( lstr_parm.s_cad[] ) = 0 Then Return

For i = 1 To UpperBound( lstr_parm.s_cad[] )
	dw_1.Object.c_codigo_pal[1] = lstr_parm.s_cad[i]
	wf_Agregar( )
Next

end subroutine

public function integer wf_agregar ();Dec{4}	ldc_pmn, ldc_pme, ldc_peso
uo_DataStore	lds_1
Long		ll_find, i, j,li_pal
String	ls_pal, ls_man, ls_pro, ls_eti, ls_cul,ls_ceros,ls_mer,ls_xkilo,ls_env,ls_pman, ls_pesm,ls_rem,ls_ori,ls_tipo,ls_exc,ls_punto

ls_pman =f_trim(f_getparmvalue('080'))
ls_pesm = f_trim(f_getparmvalue('101'))
ls_rem= dw_1.object.reembarque[1]
ls_ori= dw_1.object.c_codigo_man[1]
ls_mer=dw_1.object.c_merdes_man[1]

if gs_tipo='F' then
	dw_list.object.c_excedente_pal.visible = false 
else
	dw_list.object.c_excedente_pal.visible = true 
end if
IF ls_pman = 'S' then //SI Modifica precio
	//SI Modifica peso
	IF ls_pesm = 'S' then
		dw_list.object.precio.visible = TRUE // campo
		dw_list.object.prec.visible = TRUE // etiqueta
		dw_list.object.total1.visible = false
		dw_list.object.n_importe_man2.visible = false
		dw_list.object.co_totalxreg.visible = false
		dw_list.object.n_importe_man.visible = false
		
		dw_list.object.peso.visible = TRUE
		dw_list.object.pes.visible = TRUE
		dw_list.object.total2.visible = true
		dw_list.object.n_importe_man4.visible = true
		dw_list.object.co_totalxregi.visible = false
		dw_list.object.n_importe_man3.visible = false
	else //NO Modifica peso
		dw_list.object.precio.visible = TRUE // campo
		dw_list.object.prec.visible = TRUE // etiqueta
		dw_list.object.total1.visible = true
		dw_list.object.n_importe_man2.visible = true
		dw_list.object.co_totalxreg.visible = false
		dw_list.object.n_importe_man.visible = false
			
		dw_list.object.peso.visible = false
		dw_list.object.pes.visible = false
		dw_list.object.total2.visible = false
		dw_list.object.n_importe_man4.visible = false
		dw_list.object.co_totalxregi.visible = false
		dw_list.object.n_importe_man3.visible = false
	End if	
ELSE //NO Modifica Precio
	//SI Modifica peso
	IF ls_pesm = 'S' then
		dw_list.object.precio.visible = false // campo
		dw_list.object.prec.visible = false // etiqueta
		dw_list.object.total1.visible = false
		dw_list.object.n_importe_man2.visible = false
		dw_list.object.co_totalxreg.visible = false
		dw_list.object.n_importe_man.visible = false
		
		dw_list.object.peso.visible = TRUE
		dw_list.object.pes.visible = TRUE
		dw_list.object.n_peso_pal.visible = TRUE
		
		dw_list.object.total2.visible = false
		dw_list.object.n_importe_man4.visible = false
		dw_list.object.co_totalxregi.visible = true
		dw_list.object.n_importe_man3.visible = true
	else //NO Modifica peso****************************************
		dw_list.object.precio.visible = false // campo
		dw_list.object.prec.visible = false // etiqueta
		dw_list.object.total1.visible = false
		dw_list.object.n_importe_man2.visible = false
		dw_list.object.co_totalxreg.visible = true
		dw_list.object.n_importe_man.visible = true
			
	 	dw_list.object.peso.visible = TRUE
	   dw_list.object.n_peso_pal.visible = false
	   dw_list.object.pes.visible = false
	   dw_list.object.total2.visible = false
	   dw_list.object.n_importe_man4.visible = false
	   dw_list.object.co_totalxregi.visible = false
	   dw_list.object.n_importe_man3.visible = false
	End if
	
END IF
li_pal = f_Zero( Integer( f_GetParmValue( '28' ) ) )

ib_saved = False
dw_1.AcceptText( )
ib_saved = False
ls_pal	= f_Trim( dw_1.Object.c_codigo_pal[1] )
ls_pal = Right( Fill( '0', li_pal ) + ls_pal, li_pal )

/* Debe revisar ke el pallet est'e digitado */
If ls_pal = '' Then
	dw_1.SetFocus( )
	MessageBox( Title, 'Debe ingresar el nro. de pallet.', Exclamation! )
	Return -1
End If

if gs_tipo='N'  THEN 
	ls_punto=''
else
	ls_punto=gs_punto

end if
/* Debe revisar ke exista el pallet */
Destroy lds_1
lds_1 = Create uo_DataStore
lds_1.DataObject = 'd_arch_palet_mixto' /* Obtiene todos los pallets */
lds_1.SetTransObject( SqlCa )
lds_1.Retrieve( gs_codtem + ls_pal,ls_punto )
If lds_1.RowCount( ) <= 0 Then
	dw_1.SetFocus( )
	MessageBox( Title, 'El pallet ingresado no existe.', Exclamation! )
	Return -1
End If

/* Debe revisar ke si existe el pallet no pertenesca a un manifiesto */


ls_man	= f_Trim( lds_1.Object.c_codigo_man[1] )
if f_trim(ls_rem) <> 'S' THEN //CHECAR AKI CUANDO SEA MANIFIESTO DE EXCEDENTES
	if  (f_Trim( lds_1.Object.c_tipo_pal[1] ) = 'N' and  f_Trim( lds_1.Object.c_puntodes_pal[1] ) = '')  or (ls_man <>  f_Trim( lds_1.Object.c_origen_man[1] ) )   then
		If ls_man <> '' Then
			dw_1.SetFocus( )
			MessageBox( Title, 'El pallet ingresado ya se encuentra en el manifiesto nro. ' + ls_man + '.', Exclamation! )
			Return -1
		End If
	end if
end if
/* Debe revisar si el pallet es disponible como "empaque" */
If f_Trim( lds_1.Object.c_staemp_pal[1] ) = '0' or f_Trim( lds_1.Object.c_staemp_pal[1] ) = '2' Then //20081009
	dw_1.SetFocus( )
	MessageBox( Title, 'El pallet ingresado aun no está disponible para ser embarcado.', Exclamation! )
	Return -1
End If

/* Debe revisar ke el pallet no exista en el listado */
ll_find = dw_list.Find( "c_codigo_pal = '" + ls_pal + "'", 1, dw_list.RowCount( ) )
If ll_find > 0 Then
	dw_list.ScrollToRow( ll_find )
	MessageBox( Title, 'El pallet ya se encuentra en la lista del manifiesto.' )
	Return -1
End If

For i = 1 To lds_1.RowCount( )
	
	ls_tipo	= f_Trim( lds_1.Object.c_tipo_pal[i] )
	ls_exc= f_Trim( lds_1.Object.c_excedente_pal[i] )
	//Hilda 20091208 valida si es del mismo manifiesto
	if ls_rem='S' then
		ls_man	= f_Trim( lds_1.Object.c_codigo_man[i] )
		If ls_man <> ls_mer+ls_ori Then
			dw_1.SetFocus( )
			MessageBox( Title, 'El pallet ingresado no pertenece al manifiesto nro. ' + ls_man + '.', Exclamation! )
			Return -1
		End If
		If ls_tipo <>'N' Then
			dw_1.SetFocus( )
			MessageBox( Title, 'El pallet ingresado debe ser normal.', Exclamation! )
			Return -1
		End If
		If ls_exc ='1' Then
			dw_1.SetFocus( )
			MessageBox( Title, 'El pallet ingresado no puede ser excedente.', Exclamation! )
			Return -1
		End If
	END IF
	j = dw_list.InsertRow(0)
	/*If j = 1 Then
		dw_list.Height = dw_list.Height * 3
	Else
		dw_list.Height = dw_list.Height + ii_height
	End If */
	
	dw_list.Object.c_codigo_pal[j] = lds_1.Object.c_codigo_pal[i] 
	dw_list.Object.c_codsec_pal[j] = lds_1.Object.c_codsec_pal[i] 
	dw_list.Object.c_elemento[j] = lds_1.Object.c_elemento[i] 
	ls_pro = lds_1.Object.c_codigo_pro[i] 
	ls_cul = Left( ls_pro, 2 )
	dw_list.Object.c_codigo_pro[j] = ls_pro
	dw_list.Object.c_codigo_cul[j] = ls_cul
	ls_eti = lds_1.Object.c_codigo_eti[i] 
	dw_list.Object.c_codigo_eti[j] = ls_eti
	dw_list.Object.c_codigo_env[j] = lds_1.Object.c_codigo_env[i] 
	dw_list.Object.c_codigo_col[j] = lds_1.Object.c_codigo_col[i] 
	dw_list.Object.n_bulxpa_pal[j] = lds_1.Object.n_bulxpa_pal[i] 
	dw_list.Object.n_peso_pal[j] = 0.00 //lds_1.Object.n_peso_pal[i]
	
	// nuevo coliman   ///////yo lo comente
	dw_list.object.peso[j] = lds_1.Object.n_peso_pal[i]
	// fin nuevo coliman
	
	//dw_list.Object.n_precmn_pal[j] = lds_1.Object.n_precmn_pal[i] 
	//dw_list.Object.n_precme_pal[j] = lds_1.Object.n_precme_pal[i] 
	ldc_pmn = 0; ldc_pme = 0
	
	wf_GetPrice( ls_pro, ls_eti, ls_cul, ldc_pmn, ldc_pme )
	//20081024
	ls_mer = f_Trim( dw_1.Object.c_merdes_man[1] )

//////////yo lo comente
//	IF ls_mer = 'N' THEN 
//		dw_list.Object.precio[j] = ldc_pmn
//	ELSEIF ls_mer = 'E' THEN
//		dw_list.Object.precio[j] = ldc_pme
//	END IF
	
//	If ls_pman = 'S' and ls_mer = 'N' Then  // 20091027 Si el parametro dice modificar precio, y es mercado nacional, lo permite modificar
//		f_colEnabled (dw_list, 'precio', True)
//	else
//		dw_list.object.precio.visible = false // campo
//		dw_list.object.prec.visible = false // etiqueta
//	End If
	
	//20081029 
	ls_env = lds_1.Object.c_codigo_env[i] 
	select c_porkilo_pro
	into :ls_xkilo
	from t_producto (nolock)
	where c_codigo_pro = :ls_pro
	and c_codigo_cul = :ls_cul
	and c_codigo_env = :ls_env
	using sqlca;
	If f_SqlError( SqlCa, 'No se pudo leer la tabla t_producto . (select)' ) < 0 Then 
		 RollBack Using SqlCa ;
		 Return 0
	End If
	dw_list.Object.c_porkilo_pro[j] = ls_xkilo
	//
	
	dw_list.Object.n_precmn_pal[j] = ldc_pmn
	dw_list.Object.n_precme_pal[j] = ldc_pme
	dw_list.Object.c_merdes_man[j] = dw_1.Object.c_merdes_man[1] 
	
	If dw_1.Object.c_merdes_man[1] = 'N' then
		 dw_list.Object.precio[j] = ldc_pmn
	else
		dw_list.Object.precio[j] = ldc_pme
	end if
	
Next
dw_list.ScrollToRow( dw_list.RowCount( ))
dw_list.AcceptText( )
Destroy lds_1

i = 0  //inicio
For i = 1 To dw_list.RowCount( )
	ldc_peso = 	ldc_peso + dw_list.object.peso [i]
Next 
dw_1.object.peso [1] = ldc_peso
dw_1.object.peso1 [1] = ldc_peso
//fin

wf_SetImporte( )

Return 1
end function

public function integer wf_eliminar ();Long		ll_find, i, j
String	ls_pal, ls_man,ls_pesm
dec{4} ldc_peso

ib_saved = False

If dw_list.RowCount( ) <= 0 Then
	Return 0
End If

ls_pal	= f_Trim( dw_list.Object.c_codigo_pal[dw_list.GetRow()] )

/* Debe revisar ke el pallet est'e digitado */
If ls_pal = '' Then
	dw_1.SetFocus( )
	MessageBox( Title, 'Debe ingresar el nro. de pallet.', Exclamation! )
	Return -1
End If


/* Debe revisar ke el pallet no exista en el listado */
ll_find = dw_list.Find( "c_codigo_pal = '" + ls_pal + "'", 1, dw_list.RowCount( ) )
Do While ll_find > 0 
	dw_list.ScrollToRow( ll_find )
	dw_list.DeleteRow(ll_find )
	ll_find = dw_list.Find( "c_codigo_pal = '" + ls_pal + "'", 1, dw_list.RowCount( ) )
	//dw_list.Height = dw_list.Height - 72 //Alto de cada registro
Loop

wf_SetImporte( )
ls_pesm = f_trim(f_getparmvalue('101'))
If ls_pesm = 'S' Then
 i = 0 
 For i = 1 To dw_list.RowCount( )
  ldc_peso =  ldc_peso + dw_list.object.peso [i]
 Next 
 dw_1.object.peso [1] = ldc_peso
 dw_1.object.peso1 [1] = ldc_peso
End If
Return 1
end function

public function integer wf_new ();DateTime	ld_dia
Integer	li_man, li_fac, li_viaje
String	ls_man, ls_fac, ls_ant, ls_dia, ls_mess, ls_mer, ls_CERT,ls_caa
dec 	ldc_via,ldc_nvia,ldc_mane,ldc_nmane,ldc_face,ldc_nface,ldc_mann,ldc_nmann,ldc_facn,ldc_nfacn
uo_DataStore	lds_1 


If Not wf_SaveChanges( ) Then
	Return 0
End If

ib_new = True
IF gs_tipo='F' then
	cb_rem.visible=true
else
	cb_rem.visible=false
end if
dw_1.Reset( )
dw_1.SetTransObject( SqlCa )
dw_1.Object.c_codigo_man.Edit.DisplayOnly = 'no'
dw_list.Reset( )
dw_list.SetTransObject( SqlCa )

dw_1.object.nomcaa.visible=false
dw_1.object.c_caades_man.visible=false
if f_getparmvalue('106')<>'S' THEN
	li_viaje = f_Zero( Integer( f_GetParmValue( '16' ) ) )
else	
	select 	n_numeroviaje_pte,n_longitudnumeroviaje_pte,c_caades_man				
	into		:ldc_via,:ldc_nvia,:ls_caa					
	from		t_puntoembarque(nolock)
	where		c_codigo_pte=:gs_punto
	using 	sqlca;
	If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_puntoembarque.' ) < 0 Then 
			RollBack Using SqlCa ;
			Return 0
	End If
	li_viaje= f_Zero( Integer(ldc_via) )
	if gs_tipo= 'N' then 
		dw_1.object.nomcaa.visible=true
		dw_1.object.c_caades_man.visible=true

	end if

////	dw_1.Object.tipo[1]=gs_tipo
end if

dw_1.InsertRow(0)

/* Segun el valor 18, si esta en S, tomar los datos del manifiesto anterior */
Open( w_arch_manifiesto_nuevo )
ls_mess = f_Trim( Message.StringParm )
ls_ant = Left( ls_mess, 1 ) /* Si genera bajo el manifiesto anterior */
ls_mer = Right( ls_mess, 1 ) /* indica el mercado */
//////cambio para tomar valor de manifiesto segun punto 20091206
if f_getparmvalue('106')<>'S' THEN
	If ls_mer = 'E' Then
		ls_man = f_GetParmValue( '12' )
		li_man = f_Zero( Integer( f_GetParmValue( '13' ) ) )
		ls_fac = f_GetParmValue( '14' )
		li_fac = f_Zero( Integer( f_GetParmValue( '15' ) ) )
		p_ext.Visible = True
		p_nac.Visible = False
	Else
		ls_man = f_GetParmValue( '32' )
		li_man = f_Zero( Integer( f_GetParmValue( '33' ) ) )
		ls_fac = f_GetParmValue( '34' )
		li_fac = f_Zero( Integer( f_GetParmValue( '35' ) ) )
		p_ext.Visible = False
		p_nac.Visible = True
	End If
else
	//select para tomar datos 20091206 hilda
	select 	n_foliomanifiestome_pte,n_longitudmanifiestome_pte,n_foliofacturame_pte,n_longitudfacturame_pte,
				n_foliomanifiestomn_pte,n_longitudmanifiestomn_pte,n_foliofacturamn_pte,n_longitudfacturamn_pte				
	into		:ldc_mane,:ldc_nmane,:ldc_face,:ldc_nface,
				:ldc_mann,:ldc_nmann,:ldc_facn,:ldc_nfacn				
	from		t_puntoembarque(nolock)
	where		c_codigo_pte=:gs_punto
	using sqlca;
	If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_puntoembarque.' ) < 0 Then 
			RollBack Using SqlCa ;
			Return 0
	End If				
	If ls_mer = 'E' Then
		ls_man = Right( Fill( '0', ldc_nmane ) + &
					f_Trim( String( Double(string(ldc_mane) )  ) ), ldc_nmane )
		li_man = f_Zero( Integer( ldc_nmane ) )
		ls_fac = Right( Fill( '0', ldc_nface ) + &
					f_Trim( String( Double(string(ldc_face) ) ) ), ldc_nface )
		ls_fac =  string(ldc_face)		
		li_fac = f_Zero( Integer( ldc_nface) )
		p_ext.Visible = True
		p_nac.Visible = False
	Else
		ls_man=Right( Fill( '0', ldc_nmann ) + &
					f_Trim( String( Double(string(ldc_mann) )  ) ), ldc_nmann )
		li_man = f_Zero( Integer( ldc_nmann ) )
		ls_fac=Right( Fill( '0', ldc_nfacn ) + &
					f_Trim( String( Double(string(ldc_facn) ) ) ), ldc_nfacn )
		li_fac = f_Zero( Integer( ldc_nfacn) )
		p_ext.Visible = False
		p_nac.Visible = True
	End If
end if	
//aki termina 20091206	

If ls_ant = 'S' And f_Zero( Double( ls_man ) ) > 0 Then
	lds_1 = Create uo_DataStore
	lds_1.DataObject = dw_1.DataObject
	lds_1.SetTransObject( SqlCa )
	If lds_1.Retrieve( gs_codtem, ls_mer + ls_man ) = 1 Then
		/* Copia el registro anterior al nuevo registro creado por default */
		dw_1.Object.n_gflete_man[1] = 0 
		dw_1.Object.n_antfle_man[1] = 0
		dw_1.Object.n_totbul_man[1] = 0
		dw_1.Object.n_importe_man[1] = 0
		dw_1.Object.c_codigo_emb[1]	= lds_1.Object.c_codigo_emb[1] 
		dw_1.Object.c_rfc_emb[1]		= lds_1.Object.c_rfc_emb[1] 
		dw_1.Object.c_merdes_man[1]	= lds_1.Object.c_merdes_man[1] 
		dw_1.Object.c_codigo_aga[1]	= lds_1.Object.c_codigo_aga[1] 
		dw_1.Object.c_rfc_aga[1]		= lds_1.Object.c_rfc_aga[1] 
		dw_1.Object.c_ageext_man[1]	= lds_1.Object.c_ageext_man[1] 
		dw_1.Object.c_rfc_age[1]		= lds_1.Object.c_rfc_age[1] 
		dw_1.Object.c_codigo_dis[1]	= lds_1.Object.c_codigo_dis[1] 
		dw_1.Object.c_rfc_dis[1]		= lds_1.Object.c_rfc_dis[1] 
		dw_1.Object.c_codigo_lit[1]	= lds_1.Object.c_codigo_lit[1] 
		dw_1.Object.c_rfc_lit[1]		= lds_1.Object.c_rfc_lit[1] 
		dw_1.Object.v_lugdes_man[1]	= lds_1.Object.v_lugdes_man[1] 
		dw_1.Object.v_chofer_man[1]	= lds_1.Object.v_chofer_man[1] 
		dw_1.Object.v_medtra_man[1]	= lds_1.Object.v_medtra_man[1] 
		dw_1.Object.v_numpla_man[1]	= lds_1.Object.v_numpla_man[1] 
		dw_1.Object.v_marca_man[1]		= lds_1.Object.v_marca_man[1] 
		dw_1.Object.v_anofab_man[1]	= lds_1.Object.v_anofab_man[1] 
		dw_1.Object.v_nummed_man[1]	= lds_1.Object.v_nummed_man[1] 
		dw_1.Object.v_placaj_man[1]	= lds_1.Object.v_placaj_man[1] 
		dw_1.Object.v_numcaj_man[1]	= lds_1.Object.v_numcaj_man[1] 
		dw_1.Object.n_temper_man[1]	= lds_1.Object.n_temper_man[1] 
		dw_1.Object.c_temmed_man[1]	= lds_1.Object.c_temmed_man[1]
		dw_1.Object.v_cruzax_man[1]	= lds_1.Object.v_cruzax_man[1]
	End If
	Destroy lds_1
ElseIf ls_mess = 'OPEN' Then
	wf_Open( )
	Return 2
ElseIf ls_ant = '' Then
	Close( This )
	Return 0
End If

dw_1.Object.c_codigo_man.Edit.DisplayOnly = 'no'
If dw_1.RowCount() <=0 Then 
	dw_1.InsertRow(0)
End If

/* Asigna el mercado default */
dw_1.Object.c_merdes_man[1] = ls_mer

/* Fecha de Embarque del dia */
ls_dia = f_GetParmValue( '20' )
If ls_dia = '' Then
	ld_dia = DateTime( Today( ) )
	MessageBox( Title, 'No se tiene un valor de fecha del sistema.', Exclamation! )
Else
	ld_dia = f_StringToDate( ls_dia )
End If


dw_1.Object.d_embarque_man[1] = ld_dia

/* Asigna el nuevo numero de manifiesto con la cantidad de digitos ke este en parametros */
If li_man > 0 Then 
	dw_1.Object.c_codigo_man[1] = Right( Fill( '0', li_man ) + &
					f_Trim( String( Double( ls_man ) + 1 ) ), li_man )
Else
	dw_1.Object.c_codigo_man[1] = f_Trim( String( Double( ls_man ) + 1 ) )
End If

/* Asigna el nuevo numero de factura con la cantidad de digitos ke este en parametros */
If li_fac > 0 Then 
	dw_1.Object.c_numfac_man[1] = Right( Fill( '0', li_fac ) + &
					f_Trim( String( Double( ls_fac ) + 1 ) ), li_fac )
Else
	dw_1.Object.c_numfac_man[1] = f_Trim( String( Double( ls_fac ) + 1 ) )
End If

/* Asigna el nuevo numero de viaje con lo de parametros */
dw_1.Object.c_numvia_man[1] = f_Trim( String( Double( li_viaje + 1 ) ) )

ls_CERT = f_GetParmValue( '090' )

If ls_CERT='S' Then
	dw_1.Modify( "v_certiforigen_man.Format='@#####-@#####'")
	dw_1.Modify( "v_certiforigen_man.EditMask.Mask='X#####-X#####'")
   //	dw_1.Object.v_certiforigen_man.Format='@#####-@#####'
//	dw_1.Object.v_certiforigen_man.EditMask.Mask='X#####-X#####'
//	dw_1.Describe("v_certiforigen_man.Edit.Format='@#####-@#####'")
//	dw_1.Describe("v_certiforigen_man.EditMask.Mask='X#####-X#####'")

End If

if f_getparmvalue('106')='S' THEN
	dw_1.Object.tipo[1]=gs_tipo
  	if gs_tipo='N' then	
		ls_caa=f_Trim( String( Double( ls_caa ) + 1 ) )
		dw_1.object.c_caades_man[1]=ls_caa
	end if
end if
dw_list.SetRowFocusIndicator( p_ind )
p_ind.Visible = False

Return 1
end function

public function string wf_getnewnummanif ();Integer	li_man
String	ls_man

ls_man = f_GetParmValue( '12' )
li_man = f_Zero( Integer( f_GetParmValue( '13' ) ) )

/* Retorna el nuevo numero de manifiesto con la cantidad de digitos ke este en parametros */
If li_man > 0 Then 
	dw_1.Object.c_codigo_man[1] = Right( Fill( '0', li_man ) + f_Trim( String( Double( ls_man ) + 1 ) ), li_man )
Else
	dw_1.Object.c_codigo_man[1] = f_Trim( String( Double( ls_man ) + 1 ) )
End If

/* Asigna el nuevo numero de factura con la cantidad de digitos ke este en parametros */

Return ls_man
end function

public function integer wf_open ();Boolean	lb_cont = True
Integer	li_opc
String	ls_man,ls_tem,ls_rem,ls_mrem, ls_prem1, ls_pesm1
long ll_rem,i,ll_count
decimal{2}ldc_precio, ldc_peso
s_parm	lstr_parm


SetNull( Message.PowerObjectParm )

Open( w_arch_manifiesto_abrir )
lstr_parm = Message.PowerObjectParm
ls_prem1 =f_trim(f_getparmvalue('080'))
ls_pesm1 = f_trim(f_getparmvalue('101'))

If Not IsValid( lstr_parm ) Then Return 0
If IsNull( lstr_parm ) Then Return 0
If UpperBound( lstr_parm.s_cad[] ) = 0 Then Return 0

If Not ib_saved Then 
	ls_man = f_Trim( dw_1.Object.c_codigo_man[1] )
	If ls_man <> '' Then
		ls_man = 'Nro ' + ls_man
	End If
	li_opc = MessageBox( Title, '¿Desea guardar los cambios efectuados en el ' + &
								'Manifiesto ' + ls_man + '?', Question!, YesNoCancel! )
	Choose Case	li_opc
		Case 1
			If wf_Save( ) Then
				/* debe continuar con la operacion */
				lb_cont = True
			Else
				lb_cont = False
			End If
		Case 2
			lb_cont = True
		Case Else
			Return 0
	End Choose

End If

If lb_cont Then 
	If lstr_parm.s_cad[1] = 'NEW' Then
		wf_New( )
	ElseIf lstr_parm.s_cad[1] <> '' Then
		dw_list.SetRedraw(false)
		ib_saved = True
		ib_new = False
		dw_1.Retrieve( lstr_parm.s_cad[1], lstr_parm.s_cad[2] )
		dw_list.Retrieve( lstr_parm.s_cad[1], lstr_parm.s_cad[2] )// como controlo los campos...
		//************inicio cambio 20091015

		IF ls_prem1 = 'S' then //SI Modifica precio
			IF ls_pesm1 = 'S' then//SI Modifica peso
				dw_list.object.precio.visible = TRUE // campo
				dw_list.object.prec.visible = TRUE // etiqueta
				dw_list.object.total1.visible = false
				dw_list.object.n_importe_man2.visible = false
				dw_list.object.co_totalxreg.visible = false
				dw_list.object.n_importe_man.visible = false
				
				dw_list.object.peso.visible = TRUE
				dw_list.object.pes.visible = TRUE
				dw_list.object.total2.visible = true
				dw_list.object.n_importe_man4.visible = true
				dw_list.object.co_totalxregi.visible = false
				dw_list.object.n_importe_man3.visible = false
			else //NO Modifica peso
				dw_list.object.precio.visible = TRUE // campo
				dw_list.object.prec.visible = TRUE // etiqueta
				dw_list.object.total1.visible = true
				dw_list.object.n_importe_man2.visible = true
				dw_list.object.co_totalxreg.visible = false
				dw_list.object.n_importe_man.visible = false
					
				dw_list.object.peso.visible = false
				dw_list.object.pes.visible = false
				dw_list.object.total2.visible = false
				dw_list.object.n_importe_man4.visible = false
				dw_list.object.co_totalxregi.visible = false
				dw_list.object.n_importe_man3.visible = false
			End if	
		ELSE //NO Modifica Precio
			IF ls_pesm1 = 'S' then//SI Modifica peso
				dw_list.object.precio.visible = false // campo
				dw_list.object.prec.visible = false // etiqueta
				dw_list.object.total1.visible = false
				dw_list.object.n_importe_man2.visible = false
				dw_list.object.co_totalxreg.visible = false
				dw_list.object.n_importe_man.visible = false
				
				dw_list.object.peso.visible = TRUE
				dw_list.object.pes.visible = TRUE
				dw_list.object.total2.visible = false
				dw_list.object.n_importe_man4.visible = false
				dw_list.object.co_totalxregi.visible = true
				dw_list.object.n_importe_man3.visible = true
			else //NO Modifica peso****************************************
				dw_list.object.precio.visible = false // campo
				dw_list.object.prec.visible = false // etiqueta
				dw_list.object.total1.visible = false
				dw_list.object.n_importe_man2.visible = false
				dw_list.object.co_totalxreg.visible = true
				dw_list.object.n_importe_man.visible = true
					
				dw_list.object.peso.visible = false
				dw_list.object.pes.visible = false
				dw_list.object.total2.visible = false
				dw_list.object.n_importe_man4.visible = false
				dw_list.object.co_totalxregi.visible = false
				dw_list.object.n_importe_man3.visible = false
			End if
		END IF
		
		//************fin cambio
		dw_1.SetFocus( )
		dw_1.Object.c_codigo_man.Edit.DisplayOnly = 'yes'
		
		//=====================================
		//
		////20080607
		ls_man = f_trim(dw_1.object.c_codigo_man[1])
		ls_tem =  f_trim(dw_1.object.c_codigo_tem[1])
		//20081101
		gs_mercado=f_trim(dw_1.object.c_merdes_man[1])
		select c_numfac_man
		into :ls_rem
		from t_manifiesto
		where c_codigo_man = :ls_man
		and c_codigo_Tem = :ls_tem
		using sqlca;
		If f_SqlError( SqlCa, 'No se pudo leer la tabla t_manifiesto. [select]') < 0 Then 
			RollBack Using SqlCa ;
			Return 0
		End If
		
		//==========20081024
		IF ls_prem1= 'S' THEN
			ll_count = dw_list.rowcount()
			FOR i = 1 TO ll_count
				ldc_precio = f_zero(dw_list.object.co_precio[i])
				dw_list.object.precio[i] = ldc_precio
			NEXT
		END IF		
		//=============
		//============= 20091012 Cambio de Peso para Coliman

		IF ls_pesm1 = 'S' THEN
			ll_count = dw_list.rowcount()
			FOR i = 1 TO ll_count
				ldc_peso = f_zero(dw_list.object.n_peso_pal[i])
				dw_list.object.peso[i] = ldc_peso
			NEXT
		END IF
		//=============*/
//		
		ls_mrem = upper(f_trim(f_getparmvalue('071')))
		if ls_mrem = 'S' then
			select count(c_codigo_fac)
			into :ll_rem
			from cxcfacturaremision
			where c_remision_far = :ls_rem
			using sqlca;
			If f_SqlError( SqlCa, 'No se pudo leer la tabla cxcfacturaremision. [select]') < 0 Then 
				RollBack Using SqlCa ;
				Return 0
			End If
			
			if ll_rem > 0 then
				wf_enabled(false)
			end if
		end if
		//=====================================
		dw_list.SetRedraw(true)
	Else
		
		Return 0
	End If
	
End If

Return 1
end function

public function long wf_print ();Long	ll_rows,li_opc
string ls_mer,ls_rem

ls_rem = upper(f_trim(f_getparmvalue('071')))

If Not ib_saved Then
	MessageBox( Title, 'El manifiesto Nro.' + f_Trim( dw_1.Object.c_codigo_man[1] ) + &
								' no ha sido guardado.~r~nPara poder imprimir, revise/complete' + &
								' el documento y haga clic en guardar y reintente.', Exclamation! )
	Return -1
End If

//ll_rows = dw_prn.Retrieve( gs_codtem, f_Trim( dw_1.Object.c_codigo_man[1] )) 
//f_Preview( dw_prn )

istr_parm.s_cad[ 1] = 'M' // ---> Manifiesto por default
istr_parm.s_cad[ 2] = ''
istr_parm.s_cad[ 3] = ''

//20080522 preguntar si es con importe
if ls_rem = 'S' then
	ls_mer = f_trim(dw_1.object.c_merdes_man[1])
	if ls_mer = 'N' then
		li_opc = MessageBox( Title, '¿Remisión con precios ?',Question!, YesNoCancel! )
			Choose Case	li_opc
				Case 1
					istr_parm.s_cad[ 4] = 'S'
				Case 2
					istr_parm.s_cad[ 4] = 'N'
				Case Else
					Return 0
			End Choose
	end if
else
	istr_parm.s_cad[ 4] = ''
end if


//ls_dis = f_trim(dw_1.object.c_codigo_dis[1])
//ls_mer = f_trim(dw_1.object.c_merdes_man[1])
//if ls_mer = 'N' then
//	select isnull(c_tipo_dis,'')
//	into :ls_tipo
//	from t_distribuidor
//	where c_codigo_dis = :ls_dis
//	using sqlca;
//	If f_SqlError( SqlCa, 'No se pudo leer la tabla t_distribuidor . (select)' ) < 0 Then 
//		 RollBack Using SqlCa ;
//		 Return 0
//	End If
// 	istr_parm.s_cad[ 4] = ls_tipo
//end if
//

istr_parm.dw_dat[ 1] = dw_1
OpenWithParm( w_arch_manifiesto_imprimir, istr_parm )

Return ll_rows
end function

public function integer wf_setimporte ();/* wf_SetImporte( ) */
string ls_modp
Dec{2}	ldc_imp, ldc_iva, ldc_bul

ls_modp = upper(f_trim(f_getparmvalue('080')))  //20081024

If dw_list.RowCount( ) <= 0 Then
	dw_1.Object.n_totbul_man[1] = 0
	dw_1.Object.n_importe_man[1] = 0
	dw_1.Object.n_impiva_man[1] = 0
Else
	ldc_bul = dw_list.Object.n_totbul_man[dw_list.RowCount( )]
	dw_1.Object.n_totbul_man[1] = ldc_bul
	IF ls_modp <> 'S' THEN
		ldc_imp = dw_list.Object.n_importe_man[dw_list.RowCount( )]
	ELSE
		ldc_imp = dw_list.Object.n_importe_man2[dw_list.RowCount( )]
	END IF
	dw_1.Object.n_importe_man[1] = ldc_imp
	ldc_iva = f_Zero( Dec( f_GetParmValue( '17' ) ) )
	dw_1.Object.n_impiva_man[1] = ldc_imp * ( ldc_iva/100)
End If

dw_1.AcceptText( )


Return 1
end function

public function integer wf_openmanif ();Boolean	lb_cont = True
Integer	li_opc
String	ls_man
s_parm	lstr_parm



lstr_parm = Message.PowerObjectParm

If Not IsValid( lstr_parm ) Then Return 0
If IsNull( lstr_parm ) Then Return 0
If UpperBound( lstr_parm.s_cad[] ) = 0 Then Return 0

If Not ib_saved Then 
	ls_man = f_Trim( dw_1.Object.c_codigo_man[1] )
	If ls_man <> '' Then
		ls_man = 'Nro ' + ls_man
	End If
	li_opc = MessageBox( Title, '¿Desea guardar los cambios efectuados en el ' + &
								'Manifiesto ' + ls_man + '?', Question!, YesNoCancel! )
	Choose Case	li_opc
		Case 1
			If wf_Save( ) Then
				/* debe continuar con la operacion */
				lb_cont = True
			Else
				lb_cont = False
			End If
		Case 2
			lb_cont = True
		Case Else
			Return 0
	End Choose

End If

If lb_cont Then 
	If lstr_parm.s_cad[1] = 'NEW' Then
		wf_New( )
	ElseIf lstr_parm.s_cad[1] <> '' Then
		ib_saved = False
		ib_new = False
		dw_1.Retrieve( lstr_parm.s_cad[1], lstr_parm.s_cad[2] )
		dw_list.Retrieve( lstr_parm.s_cad[1], lstr_parm.s_cad[2] )
		dw_1.SetFocus( )
	Else
		Return 0
	End If
End If

Return 1
end function

public function long wf_printfact ();Long		ll_rows
String	ls_cia

If Not ib_saved Then
	MessageBox( Title, 'El manifiesto Nro.' + f_Trim( dw_1.Object.c_codigo_man[1] ) + &
								' no ha sido guardado.~r~nPara poder imprimir, revise/complete' + &
								' el documento y haga clic en guardar y reintente.', Exclamation! )
	Return -1
End If

ls_cia = f_GetParmValue('3')

Choose Case ls_cia
	Case '1'
		dw_prn.DataObject = 'd_rpt_factura_cia_1'
	Case Else
		dw_prn.DataObject = 'd_rpt_factura_gral'
End Choose

dw_prn.SetTransObject( SqlCa )
ll_rows = dw_prn.Retrieve( gs_codtem, f_Trim( dw_1.Object.c_codigo_man[1] )) 
f_Preview( dw_prn )


Return ll_rows
end function

public function boolean wf_savechanges ();Integer	li_opc
String	ls_man


If Not ib_saved Then 
	ls_man = f_Trim( dw_1.Object.c_codigo_man[1] )
	If ls_man <> '' Then
		ls_man = 'Nro ' + ls_man
	End If
	li_opc = MessageBox( Title, '¿Desea guardar los cambios efectuados en el ' + &
								'Manifiesto ' + ls_man + '?', Question!, YesNoCancel! )
	Choose Case	li_opc
		Case 1
			If wf_Save( ) Then
				Return True
			Else
				Return False
			End If
		Case 2
			Return True
		Case Else
			Return False
	End Choose
End If

Return True
end function

public function boolean wf_actualizaacumulados (string as_acc);uo_DataStore	lds_1, lds_acu
DateTime	ld_emp, ld_emb
Dec{2}	ldc_bul
String	ls_cod, ls_mer, ls_pro, ls_eti, ls_des, ls_codori
Long		ll_row, i, ll_ret


Destroy lds_acu
Destroy lds_1

ls_cod = dw_1.Object.c_codigo_man[ 1]
ls_des = dw_1.Object.c_merdes_man[ 1]
ld_emb = dw_1.Object.d_embarque_man[ 1]

lds_1 = Create uo_DataStore
lds_1.DataObject = 'd_arch_manifiesto_det'
lds_1.SetTransObject( SqlCa )
ll_ret = lds_1.Retrieve( gs_codtem, ls_cod )


lds_acu = Create uo_DataStore
lds_acu.DataObject = 'd_arch_acumulado_edit'
lds_acu.SetTransObject( SqlCa ) 

For i = 1 To lds_1.RowCount( )
	ls_mer = ''
	ls_pro = f_Trim( lds_1.Object.c_codigo_pro[ i] )
	
	Select	c_merdes_pro
	Into		:ls_mer
	From		t_producto (nolock)
	Where		c_codigo_pro = :ls_pro 
	Using sqlca;
	If f_SqlError( SqlCa, 'No se puede leer la t_producto (wf_actualizaacumulados)' ) = -1 Then
		Return False
	End If
	ls_eti = f_Trim( lds_1.Object.c_codigo_eti[ i] )
	ldc_bul = f_Zero( lds_1.Object.n_bulxpa_pal[ i] )
	ld_emp = lds_1.Object.d_empaque_pal[ i]
	ls_codori = gs_codtem + ls_pro + ls_eti + ls_mer
	ll_row = lds_acu.Retrieve( gs_codtem + ls_pro + ls_eti + ls_mer + ls_des )
	If ll_row = 0 And as_acc = 'I' Then
		ll_row = lds_acu.InsertRow(0)
		lds_acu.Object.c_codigo_tem[ll_row] = gs_codtem
		lds_acu.Object.c_codigo_pro[ll_row] = ls_pro
		lds_acu.Object.c_codigo_eti[ll_row] = ls_eti
		lds_acu.Object.c_merori_acu[ll_row] = ls_mer
		lds_acu.Object.c_merdes_acu[ll_row] = ls_des
		lds_acu.Object.n_emphoy_acu[ll_row] = 0
		lds_acu.Object.c_codigo_usu[ll_row] = gs_usuario
		lds_acu.Object.d_creacion[ll_row] = DateTime( Today( ) )
		lds_acu.Object.c_activo[ll_row] = '1'
	Else
		ll_row = lds_acu.GetRow()
		If ll_row < 0 Then 
			Return false
		End If
		If ll_row = 0 Then 
			Return true
		End If
		lds_acu.Object.c_usumod[ll_row] = gs_usuario
		lds_acu.Object.d_modifi[ll_row] = DateTime( Today( ) )
		lds_acu.Object.c_activo[ll_row] = '1'
	End If
	If ll_row > 0 Then
		If as_acc = 'I' Then
			lds_acu.Object.n_embhoy_acu[ll_row] = f_Zero(lds_acu.Object.n_embhoy_acu[ll_row]) + ldc_bul
			If Not ls_mer = ls_des Then
				If ld_emp = ld_emb Then
					lds_acu.Object.n_emphoy_acu[ll_row] = f_Zero(lds_acu.Object.n_emphoy_acu[ll_row]) + ldc_bul
				Else
					lds_acu.Object.n_emptot_acu[ll_row] = f_Zero(lds_acu.Object.n_emptot_acu[ll_row]) + ldc_bul
				End If
			End If
		Else
			lds_acu.Object.n_embhoy_acu[ll_row] = f_Zero(lds_acu.Object.n_embhoy_acu[ll_row]) - ldc_bul
			If Not ls_mer = ls_des Then
				If ld_emp = ld_emb Then
					lds_acu.Object.n_emphoy_acu[ll_row] = f_Zero(lds_acu.Object.n_emphoy_acu[ll_row]) - ldc_bul
				Else
					lds_acu.Object.n_emptot_acu[ll_row] = f_Zero(lds_acu.Object.n_emptot_acu[ll_row]) - ldc_bul
				End If
			End If
		End If
		lds_acu.AcceptText( )
		If lds_acu.Update( ) <> 1 Then
			RollBack Using SqlCa ;
			MessageBox( Title, 'El registro no ha sido actualizado.', StopSign! )
			Destroy lds_acu
			Destroy lds_1
			Return False
		Else
			If ( as_acc = 'I' ) And ( Not ls_mer = ls_des ) Then
				/* Se debe efectuar el descuento por cambio de mercado */
				If ld_emp = ld_emb Then
					/* Si la fecha de empaque es = a la de embarque se descuenta el empaque de hoy */
					Update	t_acumulado
					Set		n_emphoy_acu = IsNull( n_emphoy_acu, 0 ) - :ldc_bul
					Where		c_codigo_tem + c_codigo_pro + c_codigo_eti + c_merori_acu = :ls_codori
         		And		c_merdes_acu <> :ls_des
					Using		SqlCa ;
				Else
					/* Si la fecha de empaque NO es = a la de embarque se descuenta el empaque acumulado total anterior */
					Update	t_acumulado
					Set		n_emptot_acu = IsNull( n_emptot_acu, 0 ) - :ldc_bul
					Where		c_codigo_tem + c_codigo_pro + c_codigo_eti + c_merori_acu = :ls_codori
         		And		c_merdes_acu <> :ls_des
					Using		SqlCa ;
				End If
				If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_acumulado (empaque)' ) = -1 Then
					Return False
				End If
			End If
			/* Restauracion */
			If ( as_acc = 'E' ) And ( Not ls_mer = ls_des ) Then
				/* Se debe efectuar el descuento por cambio de mercado */
				If ld_emp = ld_emb Then
					/* Si la fecha de empaque es = a la de embarque se vuelve acumular el empaque de hoy */
					Update	t_acumulado
					Set		n_emphoy_acu = IsNull( n_emphoy_acu, 0 ) + :ldc_bul
					Where		c_codigo_tem + c_codigo_pro + c_codigo_eti + c_merori_acu = :ls_codori
         		And		c_merdes_acu <> :ls_des
					Using		SqlCa ;
				Else
					/* Si la fecha de empaque NO es = a la de embarque se vuelve acumular el empaque acumulado total anterior */
					Update	t_acumulado
					Set		n_emptot_acu = IsNull( n_emptot_acu, 0 ) + :ldc_bul
					Where		c_codigo_tem + c_codigo_pro + c_codigo_eti + c_merori_acu = :ls_codori
         		And		c_merdes_acu <> :ls_des
					Using		SqlCa ;
				End If
				If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_acumulado (empaque)' ) = -1 Then
					Return False
				End If
			End If
		End If
	End If
Next


Destroy lds_acu
Destroy lds_1

Return True
end function

public function boolean wf_getprice (string as_pro, string as_eti, string as_cul, ref decimal adc_pmn, ref decimal adc_pme);/* wf_GetPrice( as_pro, as_eti, as_cul, adc_pmn, adc_pme ) */
string ls_disp,ls_dis
ls_disp = upper(f_trim(f_GetParmValue('072')))
ls_dis = f_trim(dw_1.object.c_codigo_dis[1])

if ls_disp = 'S' then
	Select	n_precmn_dip,
				n_precme_dip
	Into 		:adc_pmn,
				:adc_pme
	From		t_distribuidor_precio
	Where		c_codigo_pro = :as_pro
	And		c_codigo_eti = :as_eti
	and 		c_codigo_dis = :ls_dis
	And		c_activo_dip = '1' ;
	If f_SqlError( SqlCa, 'No se pudo obtener informacion de la tabla t_distribuidor_precio.' ) < 0 Then 
		Return False
	End If
	
	if adc_pmn = 0 or adc_pme = 0 then
		Select	n_precmn_prp,
				n_precme_prp
		Into 		:adc_pmn,
					:adc_pme
		From		t_producto_precio
		Where		c_codigo_pro = :as_pro
		And		c_codigo_eti = :as_eti
		And		c_activo_prp = '1' ;
		If f_SqlError( SqlCa, 'No se pudo obtener informacion de la tabla t_producto_precio.' ) < 0 Then 
			Return False
		End If
		
		/* Si No hay precios especiales se toman del cultivo */
		If SqlCa.SqlCode = 100 Then
			adc_pmn = 0
			adc_pme = 0
			Select	n_precmn_cul,
						n_precme_cul
			Into 		:adc_pmn,
						:adc_pme
			From		t_cultivo
			Where		c_codigo_cul = :as_cul ;
			If f_SqlError( SqlCa, 'No se pudo obtener informacion de la tabla t_cultivo.' ) < 0 Then 
				Return False
			End If
		End If
	end if
		
else
	Select	n_precmn_prp,
				n_precme_prp
	Into 		:adc_pmn,
				:adc_pme
	From		t_producto_precio
	Where		c_codigo_pro = :as_pro
	And		c_codigo_eti = :as_eti
	And		c_activo_prp = '1' ;
	If f_SqlError( SqlCa, 'No se pudo obtener informacion de la tabla t_producto_precio.' ) < 0 Then 
		Return False
	End If
	
	/* Si No hay precios especiales se toman del cultivo */
	If SqlCa.SqlCode = 100 Then
		adc_pmn = 0
		adc_pme = 0
		Select	n_precmn_cul,
					n_precme_cul
		Into 		:adc_pmn,
					:adc_pme
		From		t_cultivo
		Where		c_codigo_cul = :as_cul ;
		If f_SqlError( SqlCa, 'No se pudo obtener informacion de la tabla t_cultivo.' ) < 0 Then 
			Return False
		End If
	End If
end if

Return True

end function

public subroutine wf_actualizadddw (string as_col);DataWindowChild	ldwc_x
s_parm	lstr_parm

lstr_parm.s_cad[1] = 'I'
lstr_parm.s_cad[2] = ''
lstr_parm.n_num[1] = 1

Choose Case as_col
		
	Case 'c_codigo_aga', 'c_ageext_man'
			OpenWithParm( w_mant_agencia_edit, lstr_parm )
	
	Case 'c_codigo_dis'
			OpenWithParm( w_mant_distribuidor_edit, lstr_parm )

	Case 'c_codigo_lit'
			OpenWithParm( w_mant_linea_transporte_edit, lstr_parm )

End Choose
		

dw_1.GetChild( as_col, ldwc_x )
ldwc_x.SetTransObject( SqlCa )
ldwc_x.Retrieve( )

end subroutine

public function boolean wf_reasignaprecios (boolean ab_update);/* wf_ReasignaPrecios( ab_update ) */
DateTime	ld_hoy
Dec{2}	ldc_pmn, ldc_pme,ldc_pre
Integer	i
String	ls_pal, ls_sec, ls_eti, ls_pro, ls_cul, ls_man,ls_dis,ls_mer,ls_modp
long ll_count


ls_man = f_Trim( dw_1.Object.c_codigo_man[1] )
ls_mer = f_Trim( dw_1.Object.c_merdes_man[1] ) //20081024
ls_modp = upper(f_trim(f_getparmvalue('080')))  //20081024

ll_count = dw_list.RowCount( )

For i = 1 To ll_count
	/* Reasigna precios */
	ldc_pmn = 0 ; ldc_pme = 0
	ls_pal = f_Trim( dw_list.Object.c_codigo_pal[ i ] )
	ls_sec = f_Trim( dw_list.Object.c_codsec_pal[ i ] )
	ls_eti = f_Trim( dw_list.Object.c_codigo_eti[ i ] )
	ls_pro = f_Trim( dw_list.Object.c_codigo_pro[ i ] )
	ls_cul = f_Trim( dw_list.Object.c_codigo_cul[ i ] )
	
	IF ls_modp <> 'S' THEN //20081023 que pueda capturar los precios 
		wf_GetPrice( ls_pro, ls_eti, ls_cul, ldc_pmn, ldc_pme )
	ELSE
		ldc_pre = f_Zero( dw_list.Object.precio[ i ] )  //20081024
		IF ldc_pre=0 then
			ldc_pre=f_Zero( dw_list.Object.co_precio[ i ] )  //20100306 hilda
		end if
		IF ls_mer = 'N' THEN
			ldc_pmn = ldc_pre
		ELSE
			ldc_pme = ldc_pre
		END IF
	END IF
	/* Si es el momento de guardar actualiza en palet */
	If ab_update Then
		ld_hoy = DateTime(Today( ))
		Update	t_palet
		Set		c_codigo_man = :ls_man,
					n_precmn_pal = :ldc_pmn,
					n_precme_pal = :ldc_pme,
					c_usumod_pal = :gs_usuario,
					c_staemb_pal = '1',
					d_modifi_pal = :ld_hoy
		Where		c_codigo_tem = :gs_codtem 
		And		c_codigo_pal = :ls_pal
		And		c_codsec_pal = :ls_sec 
		Using		SqlCa ;
		If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_palet.' ) < 0 Then 
			RollBack Using SqlCa ;
			Return False
		End If
	End If
	
	dw_list.Object.n_precmn_pal[ i ] = ldc_pmn
	dw_list.Object.n_precme_pal[ i ] = ldc_pme
	
Next

dw_list.AcceptText( )
wf_SetImporte( )

Return True
end function

public subroutine wf_enabled (boolean ab_enabled);If Not ab_enabled Then
	dw_1.Object.DataWindow.ReadOnly = 'yes'
	dw_list.Object.DataWindow.ReadOnly = 'yes'
Else
	dw_1.Object.DataWindow.ReadOnly = 'no'
	dw_list.Object.DataWindow.ReadOnly = 'no'
End If

cb_agregar.Enabled = ab_enabled
cb_guardar.Enabled = ab_enabled
cb_eliminar.Enabled = ab_enabled
cb_disponibles.Enabled = ab_enabled
cb_eliminar.Enabled = ab_enabled

If Not ab_enabled Then
	ib_new = False
	ib_saved = True
End If
end subroutine

public function integer wf_setimporte2 ();string ls_pesm, ls_prem
Dec{2}	ldc_imp, ldc_iva 


ls_prem = upper(f_trim(f_getparmvalue('080')))
ls_pesm = upper(f_trim(f_getparmvalue('101')))  //20081024

If dw_list.RowCount( ) <= 0 Then
	dw_1.Object.n_totbul_man[1] = 0
	dw_1.Object.n_importe_man[1] = 0
	dw_1.Object.n_impiva_man[1] = 0
Else
	IF ls_pesm = 'S' THEN
		if ls_prem = 'S' then
			ldc_imp = dw_list.Object.n_importe_man4[dw_list.RowCount( )]
		else 
			ldc_imp = dw_list.Object.n_importe_man3[dw_list.RowCount( )]
		end if
	ELSE
		if ls_prem = 'S' then
			ldc_imp = dw_list.Object.n_importe_man2[dw_list.RowCount( )]
		else
			ldc_imp = dw_list.Object.n_importe_man[dw_list.RowCount( )]
		end if	
	END IF
	
	dw_1.Object.n_importe_man[1] = ldc_imp
	ldc_iva = f_Zero( Dec( f_GetParmValue( '17' ) ) )
	dw_1.Object.n_impiva_man[1] = ldc_imp * ( ldc_iva/100)
//	dw_1.object.v_observacion_man[1] = 'Peso Modif.'
	 
	 
	
End If



dw_1.AcceptText( )

Return 1
end function

public function integer wf_actualizapeso ();	dec {2} peso, n_peso_pal, peso1
	long i, j

dw_1.AcceptText( )
		peso = dw_1.object.peso[1]
		peso1 = dw_1.object.peso1[1]
	
	j = dw_list.rowcount()
	
	For i = 1 To j
		dw_list.object.n_peso_pal[i] = ((dw_list.object.peso [i] / peso1) * peso)
	Next

return 1
end function

public function integer wf_reenbarcado ();// 20091206 hilda
string ls_mer,ls_man,ls_fac,ls_man1
dec{2} ldc_mane,ldc_nmane,ldc_face,ldc_nface,ldc_mann,ldc_nmann,ldc_facn,ldc_nfacn
integer li_man,li_fac
uo_DataStore	lds_1 

Open( w_arch_manifiesto_abrir_3)
ls_man1 = f_Trim( Message.StringParm )

select	c_merdes_man
into		:ls_mer
from		t_manifiesto
where		c_codigo_man=:ls_man1
using 	sqlca;
If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_manifiesto.' ) < 0 Then 
		RollBack Using SqlCa ;
		Return 0
End If		

select 	n_foliomanifiestome_pte,n_longitudmanifiestome_pte,n_foliofacturame_pte,n_longitudfacturame_pte,
			n_foliomanifiestomn_pte,n_longitudmanifiestomn_pte,n_foliofacturamn_pte,n_longitudfacturamn_pte				
into		:ldc_mane,:ldc_nmane,:ldc_face,:ldc_nface,
			:ldc_mann,:ldc_nmann,:ldc_facn,:ldc_nfacn				
from		t_puntoembarque(nolock)
where		c_codigo_pte=:gs_punto
using sqlca;
If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_puntoembarque.' ) < 0 Then 
		RollBack Using SqlCa ;
		Return 0
End If				

	
lds_1 = Create uo_DataStore
lds_1.DataObject = dw_1.DataObject
lds_1.SetTransObject( SqlCa )
If lds_1.Retrieve( gs_codtem, ls_man1 ) = 1 Then
	dw_1.Retrieve( gs_codtem, ls_man1 )
//	/* Copia el registro anterior al nuevo registro creado por default */
//	ll_tam=leng(dw_1.object.c_codigo_man[1])
	dw_1.object.c_codigo_man[1] = mid(dw_1.object.c_codigo_man[1],2)
	dw_1.Object.n_gflete_man[1] = 0 
	dw_1.Object.n_antfle_man[1] = 0
	dw_1.Object.n_totbul_man[1] = 0
	dw_1.Object.n_importe_man[1] = 0
	dw_1.object.reembarque[1]='S'
End If
Destroy lds_1
//
//If ls_mer = 'E' Then
//	
//	ls_man = string(ldc_mane)
//	li_man = f_Zero( Integer( ldc_nmane ) )
//	ls_fac =  string(ldc_face)
//	li_fac = f_Zero( Integer( ldc_nface) )
//	p_ext.Visible = True
//	p_nac.Visible = False
//Else
//	ls_man = string(ldc_mann)
//	li_man = f_Zero( Integer( ldc_nmann ) )
//	ls_fac =  string(ldc_facn)
//	li_fac = f_Zero( Integer( ldc_nfacn) )
//	p_ext.Visible = False
//	p_nac.Visible = True
//End If	
///* Asigna el nuevo numero de manifiesto con la cantidad de digitos ke este en parametros */
//If li_man > 0 Then 
//	dw_1.Object.c_codigo_man[1] = Right( Fill( '0', li_man ) + &
//					f_Trim( String( Double( ls_man ) + 1 ) ), li_man )
//Else
//	dw_1.Object.c_codigo_man[1] = f_Trim( String( Double( ls_man ) + 1 ) )
//End If
return 1
end function

on w_arch_manifiesto.create
int iCurrent
call super::create
if this.MenuName = "m_principal_arch_manifiesto" then this.MenuID = create m_principal_arch_manifiesto
this.p_ind=create p_ind
this.dw_prn=create dw_prn
this.cb_imprimir=create cb_imprimir
this.cb_nuevo=create cb_nuevo
this.cb_guardar=create cb_guardar
this.cb_eliminar=create cb_eliminar
this.cb_disponibles=create cb_disponibles
this.cb_agregar=create cb_agregar
this.p_trac=create p_trac
this.p_ext=create p_ext
this.p_nac=create p_nac
this.p_pallet=create p_pallet
this.cb_rem=create cb_rem
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_ind
this.Control[iCurrent+2]=this.dw_prn
this.Control[iCurrent+3]=this.cb_imprimir
this.Control[iCurrent+4]=this.cb_nuevo
this.Control[iCurrent+5]=this.cb_guardar
this.Control[iCurrent+6]=this.cb_eliminar
this.Control[iCurrent+7]=this.cb_disponibles
this.Control[iCurrent+8]=this.cb_agregar
this.Control[iCurrent+9]=this.p_trac
this.Control[iCurrent+10]=this.p_ext
this.Control[iCurrent+11]=this.p_nac
this.Control[iCurrent+12]=this.p_pallet
this.Control[iCurrent+13]=this.cb_rem
end on

on w_arch_manifiesto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_ind)
destroy(this.dw_prn)
destroy(this.cb_imprimir)
destroy(this.cb_nuevo)
destroy(this.cb_guardar)
destroy(this.cb_eliminar)
destroy(this.cb_disponibles)
destroy(this.cb_agregar)
destroy(this.p_trac)
destroy(this.p_ext)
destroy(this.p_nac)
destroy(this.p_pallet)
destroy(this.cb_rem)
end on

event open;call super::open;
If Not (f_GetParmValue( '39' ) = 'S' ) Then
	dw_list.Object.c_codigo_col.Visible = 0
	dw_list.Object.c_codigo_col_t.Visible = 0
End If

Show( )
p_ind.Visible = False
dw_prn.Visible = False

cb_aceptar.Width = 0
cb_aceptar.Height = 0

dw_list.SetRowFocusIndicator( p_ind )
wf_New( )
end event

event resize;
dw_1.X = (newwidth - dw_1.Width ) / 2
dw_list.X = (newwidth - dw_list.Width ) / 2
p_ext.X = ( dw_1.X - p_ext.Width ) / 2
p_nac.X = ( dw_1.X - p_nac.Width ) / 2
p_trac.X = ( dw_1.X - p_trac.Width ) / 2
p_pallet.X = ( dw_1.X - p_pallet.Width ) / 2


//
cb_agregar.x = ((newwidth - cb_agregar.Width ) / 2) -200
//cb_agregar.y = dw_1.height 

cb_disponibles.x = cb_agregar.x + cb_agregar.Width + 40
cb_disponibles.y = cb_agregar.y

cb_eliminar.x = cb_disponibles.x + cb_disponibles.Width + 40
cb_eliminar.y = cb_agregar.y

//
cb_guardar.x = ((newwidth - cb_guardar.Width ) / 2) -200
//cb_guardar.y = cb_agregar.y + cb_guardar.height + 30

cb_nuevo.x = cb_guardar.x + cb_nuevo.Width + 40
cb_nuevo.y = cb_guardar.y

cb_imprimir.x = cb_nuevo.x + cb_nuevo.Width + 40
cb_imprimir.y = cb_guardar.y

end event

event closequery;Integer	li_opc
String	ls_man


If wf_SaveChanges( ) Then
	Return 0
Else
	Return 1
End If


end event

event activate;This.WindowState = Maximized!
end event

type dw_list from wa_response`dw_list within w_arch_manifiesto
integer x = 256
integer y = 2664
integer width = 2825
integer height = 1120
integer taborder = 110
string dataobject = "d_arch_manifiesto_det"
boolean border = false
boolean hsplitscroll = false
borderstyle borderstyle = stylebox!
end type

event dw_list::rowfocuschanged;call super::rowfocuschanged;//This.SelectRow( 0, False )


end event

event dw_list::retrieveend;call super::retrieveend;This.SelectRow( 0, False )
end event

event dw_list::itemchanged;call super::itemchanged;string ls_pal, ls_mer, ls_xkilo
int li_fil
dec{2} ldc_pes, ldc_pre, ldc_tot, ldc_cpre, ldc_ctot, ldc_peso
Long	i

dw_list.accepttext()

If dwo.Name = 'precio' Then
	wf_Setimporte()
For i = 1 To dw_list.RowCount( )
	ldc_peso = 	dw_list.object.peso [i]
	
	
Next 
//	peso = 
end if
If dwo.Name = 'peso' Then
	
	wf_setimporte2()
end if

ib_saved = False



end event

type dw_1 from wa_response`dw_1 within w_arch_manifiesto
integer x = 265
integer y = 12
integer width = 2821
integer height = 2520
string dataobject = "d_arch_manifiesto"
end type

event dw_1::buttonclicked;long i
dec {2} peso

Choose Case dwo.Name
	Case 'cb_disponibles' /* Coloca el # de pallet en el campo de un listado */
		ib_saved = False
		wf_Disponibles( )		
	Case 'cb_agregar' /* Adiciona los elementos del pallet al listado de la parte inferior */
		ib_saved = False
		wf_Agregar( )
	Case 'cb_eliminar'
		ib_saved = False
		wf_Eliminar( )
	Case 'cb_peso'
		wf_actualizapeso()
	Case 'cb_rem'
		wf_reenbarcado()
End Choose

end event

event dw_1::itemchanged;call super::itemchanged;Dec{2}	ldc_imp, ldc_iva
Long		i
String   ls_desc,ls_lug
ib_saved = False
dw_1.AcceptText( )
If dwo.Name = 'c_merdes_man' Then
	If data = 'N' Then
		Object.c_ageext_man[row] = ''
		Object.c_rfc_age[row] = ''
		p_ext.Visible = False
		p_nac.Visible = True
	Else
		p_ext.Visible = True
		p_nac.Visible = False
	End If
	For i = 1 To dw_list.RowCount( )
		dw_list.Object.c_merdes_man[i] = data 
	Next
	dw_list.AcceptText( )
	wf_SetImporte( )
End If


Choose Case dwo.name
	Case 'c_codigo_aga'
		This.SetItem( row, 'c_rfc_aga', wf_GetRFC( dwo.name, data ) )

	Case 'c_ageext_man'
		This.SetItem( row, 'c_rfc_age', wf_GetRFC( dwo.name, data ) )
		
	Case 'c_codigo_dis'
		This.SetItem( row, 'c_rfc_dis', wf_GetRFC( dwo.name, data ) )

	Case 'c_codigo_emb'
		This.SetItem( row, 'c_rfc_emb', wf_GetRFC( dwo.name, data ) )

	Case 'c_codigo_lit'
		This.SetItem( row, 'c_rfc_lit', wf_GetRFC( dwo.name, data ) )
	Case 'c_codigo_cze'
		ls_lug = f_trim(dw_1.Object.c_codigo_cze[1])
		Select v_desclarga_cze
		Into :ls_desc
		From t_lugarescruce
		Where c_codigo_cze=:ls_lug
		Using SqlCa;
		
		If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_lugarescruce.' ) < 0 Then
			Return 
		End If
		dw_1.Object.v_cruzax_man[1]=ls_desc
End Choose


end event

event dw_1::editchanged;call super::editchanged;ib_saved = False
end event

event dw_1::dberror;//Row changed between retrieve and update

s_parm	lstr_parm


lstr_parm.s_cad[1] = SqlCa.DataBase
lstr_parm.s_cad[2] = DataObject
lstr_parm.s_cad[3] = String( SqlDBCode )
lstr_parm.s_cad[4] = SqlErrText + '~r~n~r~nSQL Syntax: ' + sqlsyntax

RollBack ;
OpenWithParm( w_sqlerror, lstr_parm )

Return 1

end event

event dw_1::clicked;Integer	i, li_pages
dec {2} peso

li_pages = Integer( ProfileString( gs_ini, 'System', 'SaltaPaginasManifiesto', '6' ))



Choose Case dwo.name
		

	Case 'c_codigo_aga_t'
		wf_ActualizaDDDW( 'c_codigo_aga' )
	Case 'c_ageext_man_t'
		wf_ActualizaDDDW( 'c_ageext_man' )
	Case 'c_codigo_dis_t'
		wf_ActualizaDDDW( 'c_codigo_dis' )
	Case 'c_codigo_lit_t'
		wf_ActualizaDDDW( 'c_codigo_lit' )
	Case 'detalle_t', 'down_t' 
		For i = 1 To li_pages
			Send(Handle(Parent), 277, 2, 0)
		Next
		For i = 1 To li_pages
			Send(Handle(Parent), 277, 3, 0)
		Next
		This.SetColumn( 'c_codigo_pal' )
	Case 'up_t' 
		For i = 1 To li_pages
			Send(Handle(Parent), 277, 2, 0)
		Next
		This.SetColumn( 'c_codigo_man' )
		
	Case 'cb_peso'
	wf_actualizapeso()

End Choose
end event

event dw_1::retrieveend;If Object.c_merdes_man[rowcount] = 'N' Then
	p_ext.Visible = False
	p_nac.Visible = True
Else
	p_ext.Visible = True
	p_nac.Visible = False
End If
end event

event dw_1::itemfocuschanged;String ls_lug,ls_desc
dw_1.AcceptText( )
Choose Case dwo.name
	
	Case 'c_codigo_cze'
		ls_lug = f_trim(dw_1.Object.c_codigo_cze[1])
		Select v_desclarga_cze
		Into :ls_desc
		From t_lugarescruce
		Where c_codigo_cze=:ls_lug
		Using SqlCa;
		
		If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_lugarescruce.' ) < 0 Then
			Return 
		End If
		dw_1.Object.v_cruzax_man[1]=ls_desc
End Choose
dw_1.AcceptText( )

end event

type cb_cancelar from wa_response`cb_cancelar within w_arch_manifiesto
boolean visible = false
integer x = 9
integer y = 116
integer taborder = 100
boolean enabled = false
boolean cancel = false
end type

type cb_aceptar from wa_response`cb_aceptar within w_arch_manifiesto
integer x = 0
integer y = 312
integer width = 46
integer height = 36
integer taborder = 90
boolean enabled = true
string text = ""
end type

event cb_aceptar::clicked;wf_Aceptar( )
end event

type p_ind from picture within w_arch_manifiesto
integer x = 55
integer y = 236
integer width = 27
integer height = 44
boolean bringtotop = true
boolean originalsize = true
string picturename = "ind.bmp"
boolean focusrectangle = false
end type

type dw_prn from datawindow within w_arch_manifiesto
integer width = 224
integer height = 132
string dataobject = "d_rpt_manifiesto_gral"
boolean border = false
boolean livescroll = true
end type

event constructor;SetTransObject( SqlCa )
end event

type cb_imprimir from uo_cbother within w_arch_manifiesto
integer x = 2249
integer y = 3804
integer width = 462
integer height = 80
integer taborder = 80
boolean bringtotop = true
string text = "&Imprimir"
end type

event clicked;wf_Print( )
end event

type cb_nuevo from uo_cbother within w_arch_manifiesto
integer x = 1742
integer y = 3804
integer width = 462
integer height = 80
integer taborder = 70
boolean bringtotop = true
string text = "&Nuevo"
end type

event clicked;wf_New( )
end event

type cb_guardar from uo_cbother within w_arch_manifiesto
integer x = 1239
integer y = 3804
integer width = 462
integer height = 80
integer taborder = 60
boolean bringtotop = true
string text = "&Guardar"
end type

event clicked;string ls_man,ls_mer
ls_man=f_trim(dw_1.object.c_codigo_man[1])
ls_mer=f_trim(dw_1.object.c_merdes_man[1])
//if dw_1.object.reembarque[1]='S' then
	wf_Save( )
//else
//	update t_manifiesto
// set c_tipo_man='F'
// where c_codigo_man=:ls_man
//	using sqlca;


end event

type cb_eliminar from uo_cbother within w_arch_manifiesto
integer x = 2249
integer y = 2568
integer width = 549
integer height = 80
integer taborder = 50
boolean bringtotop = true
string text = "&Eliminar Seleccionado"
end type

event clicked;ib_saved = False
wf_Eliminar( )
end event

type cb_disponibles from uo_cbother within w_arch_manifiesto
integer x = 1742
integer y = 2568
integer width = 462
integer height = 80
integer taborder = 40
boolean bringtotop = true
string text = "&Disponibles"
end type

event clicked;ib_saved = False
wf_Disponibles( )	
end event

type cb_agregar from uo_cbother within w_arch_manifiesto
integer x = 1239
integer y = 2568
integer width = 462
integer height = 80
integer taborder = 20
boolean bringtotop = true
string text = "Agregar a la &Lista"
end type

event clicked;ib_saved = False
wf_Agregar( )
end event

type p_trac from picture within w_arch_manifiesto
integer x = 82
integer y = 1192
integer width = 146
integer height = 128
boolean bringtotop = true
boolean originalsize = true
string picturename = "btractor.bmp"
boolean focusrectangle = false
end type

type p_ext from picture within w_arch_manifiesto
integer x = 59
integer y = 424
integer width = 146
integer height = 92
boolean bringtotop = true
boolean originalsize = true
string picturename = "bext.bmp"
boolean focusrectangle = false
end type

type p_nac from picture within w_arch_manifiesto
integer x = 59
integer y = 424
integer width = 146
integer height = 92
boolean bringtotop = true
boolean originalsize = true
string picturename = "bnac.bmp"
boolean focusrectangle = false
end type

type p_pallet from picture within w_arch_manifiesto
integer x = 82
integer y = 2172
integer width = 146
integer height = 132
boolean bringtotop = true
boolean originalsize = true
string picturename = "bpallet.bmp"
boolean focusrectangle = false
end type

type cb_rem from commandbutton within w_arch_manifiesto
integer x = 2043
integer y = 48
integer width = 814
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Reenvio de Embarque de Origen"
end type

event clicked;wf_reenbarcado()
end event

