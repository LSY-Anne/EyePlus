$PBExportHeader$w_util_cierre_dia.srw
forward
global type w_util_cierre_dia from wa_response
end type
type p_1 from picture within w_util_cierre_dia
end type
type st_1 from statictext within w_util_cierre_dia
end type
type gb_1 from groupbox within w_util_cierre_dia
end type
end forward

global type w_util_cierre_dia from wa_response
int Width=1399
int Height=868
boolean TitleBar=true
string Title="Cierre de Dia"
long BackColor=81324524
p_1 p_1
st_1 st_1
gb_1 gb_1
end type
global w_util_cierre_dia w_util_cierre_dia

type variables
Dec{4}	idc_tc = 0
end variables

forward prototypes
public function long wf_paso2 ()
public function long wf_paso3 ()
public function long wf_paso1 ()
public function boolean wf_controlcierre ()
public function long wf_paso5 ()
public function long wf_paso4 ()
public function long wf_paso0 ()
end prototypes

public function long wf_paso2 ();DateTime	ld_con, ld_hoy
Dec{2}	ldc_emphoy, ldc_embhoy, ldc_merhoy, ldc_sobhoy, ldc_reehoy, &
			ldc_acchoy, ldc_sobant, ldc_emptot, ldc_embtot, ldc_sobtot, ldc_mertot
Integer	i, j
Long		ll_existe, ll_otromdo
String	ls_des, ls_ori, ls_pro, ls_eti


/* La mano de obra usa inf. de cultivos totalizados */
f_UtilAcumulaManoObraDiario( idc_tc )


dw_list.DataObject = 'd_rpt_acumulado_eye'
dw_list.SetTransObject( SqlCa )
dw_list.Retrieve( gs_codtem )

ld_hoy = DateTime( Today() )

For i = 1 To dw_list.RowCount( )
	/* Variables Key */
	ls_pro = dw_list.Object.c_codigo_pro[ i]
	ls_eti = dw_list.Object.c_codigo_eti[ i]
	ls_ori = dw_list.Object.c_merdes_pro[ i] //Mercado al Empacar
	ls_des = dw_list.Object.c_merdes_acu[ i] //Mercado al Embarcar
	
	ldc_emphoy = f_Zero( dw_list.Object.n_emphoy_acu[ i] )
	ldc_embhoy = f_Zero( dw_list.Object.n_embhoy_acu[ i] )
	ldc_merhoy = f_Zero( dw_list.Object.n_merhoy_acu[ i] )
	ldc_mertot = f_Zero( dw_list.Object.n_mertot_acu[ i] )
	ldc_sobhoy = f_Zero( dw_list.Object.n_sobhoy_acu[ i] )
	ldc_sobant = f_Zero( dw_list.Object.n_sobant_acu[ i] )
	ldc_reehoy = f_Zero( dw_list.Object.n_reehoy_acu[ i] )
	ldc_acchoy = f_Zero( dw_list.Object.n_acchoy_acu[ i] )
	ldc_emptot = f_Zero( dw_list.Object.n_emptot_acu[ i] )
	ldc_embtot = f_Zero( dw_list.Object.n_embtot_acu[ i] )
	ldc_sobtot = ldc_emptot + ldc_emphoy - ldc_sobant + ldc_sobhoy - ldc_embtot - ldc_embhoy - &
						ldc_merhoy - ldc_mertot
	
	/* Actualiza el acumulado por pro-eti y mercado */
	Update	t_acumulado
	Set		n_emptot_acu = IsNull( n_emptot_acu, 0 )  + :ldc_emphoy - :ldc_sobant + :ldc_sobhoy,
				n_emphoy_acu = 0,
				n_embtot_acu = IsNull( n_embtot_acu, 0 )  + :ldc_embhoy,
				n_embhoy_acu = 0,
				n_sobhoy_acu = 0,
				n_mertot_acu = IsNull( n_mertot_acu, 0 )  + :ldc_merhoy,
				n_merhoy_acu = 0,
				n_acctot_acu = IsNull( n_acctot_acu, 0 )  + :ldc_acchoy,
				n_acchoy_acu = 0,
				n_reetot_acu = IsNull( n_reetot_acu, 0 )  + :ldc_reehoy,
				n_reehoy_acu = 0,
				n_sobtot_acu = :ldc_sobtot,
				n_sobant_acu = :ldc_sobhoy,
				c_usumod_acu = :gs_usuario,
				c_activo_acu = '1',
				d_modifi_acu = :ld_hoy
	Where		c_codigo_tem = :gs_codtem
	And		c_codigo_pro = :ls_pro
	And		c_codigo_eti = :ls_eti
	And		c_merori_acu = :ls_ori
	And		c_merdes_acu = :ls_des ;
	If f_SqlError( SqlCa, 'No se pudo actualizar información de la tabla t_acumulado. (Update)' ) = -1 Then
		Return -1
	End If
Next

Return 1
end function

public function long wf_paso3 ();Integer	i
DateTime	ld_sys
String	ls_tem, ls_mer

ld_sys = gd_sys
ls_tem = gs_codtem


Update	t_acumulado_mano_obra 
Set		d_trabajo_amo = :gd_sys,
			n_numtotjor_amo = IsNull( n_numtotjor_amo, 0 ) + IsNull( n_numjorhoy_amo, 0 ),
			n_montotjor_amo = IsNull( n_montotjor_amo, 0 ) + IsNull( n_monjorhoy_amo, 0 ),
			n_numtotjorgral_amo = IsNull( n_numtotjorgral_amo, 0 ) + IsNull( n_numjorhoygral_amo, 0 ),
			n_montotjorgral_amo = IsNull( n_montotjorgral_amo, 0 ) + IsNull( n_monjorhoygral_amo, 0 ),
			n_numjorhoy_amo = 0,
			n_monjorhoy_amo = 0,
			n_numjorhoygral_amo = 0,
			n_monjorhoygral_amo = 0 
Where		c_codigo_tem = :ls_tem ;
			
If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_acumulado_mano_obra. (Update)' ) = -1 Then
	Return -1
End If

Return 1

/*
For i = 1 To 2
	If i = 1 Then
		ls_mer = 'E' 
	Else
		ls_mer = 'N'
	End If
	//f_UtilAcumulaManoObraDiario( ls_mer, idc_tc )
	
	/* Liberar tablas de acumulados del dia */	
	Update	t_acumulado_mano_obra 
	Set		d_trabajo_amo = :gd_sys,
				n_numtotjor_amo = IsNull( n_numtotjor_amo ,0 )+ IsNull( n_numjorhoy_amo, 0 ),
				n_montotjor_amo = IsNull( n_montotjor_amo ,0 )+ IsNull( n_monjorhoy_amo, 0 ),
				n_numtotjorgral_amo = IsNull( n_numtotjorgral_amo ,0 )+ IsNull( n_numjorhoygral_amo, 0 ),
				n_montotjorgral_amo = IsNull( n_montotjorgral_amo ,0 )+ IsNull( n_monjorhoygral_amo, 0 ),
				n_numjorhoy_amo = 0,
				n_monjorhoy_amo = 0,
				n_numjorhoygral_amo = 0,
				n_monjorhoygral_amo = 0 
	Where		c_codigo_tem = :ls_tem
	And		c_merdes_amo = :ls_mer ;
				
	If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_acumulado_mano_obra. (Update)' ) = -1 Then
		Return -1
	End If
Next

Return 1
*/
end function

public function long wf_paso1 ();DateTime	ld_hoy
String	ls_tem

ls_tem = gs_codtem
ld_hoy = DateTime( Today() )

//CAMBIO: 20100125 AaronS - Cambio Funcion Para Procesar Costos (Puede Procesar el dia y todo Historico, Saca Costo Por Kilo y Corrige errorres varios
If f_util_procesa_costos('N', gd_sys) <> 1 Then
//If f_UtilAcumulaEmpaqueyCostoDiario( idc_tc ) <> 1 Then
	Return 0
End If


/* Proceso para el registro diario de costos */
Delete	t_acumulado_producto_costo
Where		c_codigo_tem = :ls_tem
And		d_costo_apc = :gd_sys
Using		SqlCa ;

If f_SqlError( SqlCa, 'No se pudo limpiar la tabla t_acumulado_producto_costo. (Delete)' ) = -1 Then
	Return -1
End If

Insert	t_acumulado_producto_costo
		( c_codigo_tem, d_costo_apc, c_codigo_pro, c_codigo_cos, n_importe_apc, c_codigo_usu, c_activo_apc )
Select
		:ls_tem, :gd_sys, c_codigo_pro, c_codigo_cos, n_importe_apd, :gs_usuario, '1'
From		t_acumulado_producto_diario
Where		c_codigo_tem = :ls_tem
Using		SqlCa ;

If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_acumulado_producto_costo. (Insert)' ) = -1 Then
	Return -1
End If


Update	t_acumulado_empaque_diario 
Set		n_acubulemp_aed = IsNull( n_acubulemp_aed, 0 ) + IsNull( n_bulemp_aed, 0 ),
			n_acupestot_aed = IsNull( n_acupestot_aed, 0 ) + IsNull( n_pestot_aed, 0 ),
			n_acucosmat_aed = IsNull( n_acucosmat_aed, 0 ) + IsNull( n_cosmat_aed, 0 ),
			n_acucosgas_aed = IsNull( n_acucosgas_aed, 0 ) + IsNull( n_cosgas_aed, 0 ),
			n_acucoscor_aed = IsNull( n_acucoscor_aed, 0 ) + IsNull( n_coscor_aed, 0 ),
			n_acucosaca_aed = IsNull( n_acucosaca_aed, 0 ) + IsNull( n_cosaca_aed, 0 ),
			n_acucosmao_aed = IsNull( n_acucosmao_aed, 0 ) + IsNull( n_cosmao_aed, 0 ),
			n_acucostot_aed = IsNull( n_acucostot_aed, 0 ) + IsNull( n_costot_aed, 0 ),
			n_acucostotme_aed = IsNull( n_acucostotme_aed, 0 ) + IsNull( n_costotme_aed, 0 ),
			c_usumod_aed = :gs_usuario,
			d_modifi_aed = :ld_hoy
Where		c_codigo_tem = :ls_tem
And		c_activo_aed = '1'
Using		SqlCa ;

If f_SqlError( SqlCa, 'No se pudo limpiar la tabla t_acumulado_empaque_diario. (Update)' ) = -1 Then
	Return -1
End If

Update	t_acumulado_empaque_diario 
Set		n_acucosumn_aed = isnull(n_acucostot_aed,0) / isnull(n_acubulemp_aed,0),
			n_acucosume_aed = isnull(n_acucostotme_aed,0) / isnull(n_acubulemp_aed,0),
			c_usumod_aed = :gs_usuario,
			d_modifi_aed = :ld_hoy
Where		c_codigo_tem = :ls_tem
And		c_activo_aed = '1'
And		IsNull( n_acubulemp_aed, 0 ) <> 0
Using		SqlCa ;
commit ;

If f_SqlError( SqlCa, 'No se pudo limpiar la tabla t_acumulado_empaque_diario. (Update)' ) = -1 Then
	Return -1
End If


Update	t_acumulado_empaque_diario 
Set		n_acuporcen_aed = (isnull(n_acupestot_aed,0) * 100 ) / ( Select	Sum( IsNull( A.n_acupestot_aed, 0 ) )
																			From		t_acumulado_empaque_diario A
																			Where		A.c_codigo_cul = t_acumulado_empaque_diario.c_codigo_cul 
																			And		A.c_codigo_tem = :ls_tem
																			And		t_acumulado_empaque_diario.c_activo_aed = '1' ),
			n_acuporpro_aed =  (isnull(n_acupestot_aed,0) * 100 ) / ( Select	Sum( A.n_acupestot_aed )
																			From		t_acumulado_empaque_diario A
																			Where		A.c_codigo_tem = :ls_tem
																			And		t_acumulado_empaque_diario.c_activo_aed = '1' ),
			n_acucosumn_aed = isnull(n_acucostot_aed,0) / isnull(n_acubulemp_aed,0),
			n_acucosume_aed = isnull(n_acucostotme_aed,0) / isnull(n_acubulemp_aed,0),
         n_bulemp_aed = 0,
			n_pestot_aed = 0,
			n_porcen_aed = 0,
			n_porpro_aed = 0,
			n_cosmat_aed = 0,
			n_cosgas_aed = 0,
			n_coscor_aed = 0,
			n_cosaca_aed = 0,
			n_cosmao_aed = 0,
			n_costot_aed = 0,
			n_costotme_aed = 0,
			n_cosumn_aed = 0,
			n_cosume_aed = 0,
			c_usumod_aed = :gs_usuario,
			d_modifi_aed = :ld_hoy
Where		c_codigo_tem = :ls_tem
And		c_activo_aed = '1'
And		IsNull( n_acubulemp_aed, 0 ) <> 0
Using		SqlCa ;

If f_SqlError( SqlCa, 'No se pudo limpiar la tabla t_acumulado_empaque_diario. (Update)' ) = -1 Then
	Return -1
End If


Update	t_acumulado_producto_diario 
Set		n_acuimporte_apd = IsNull( n_acuimporte_apd, 0) + IsNull( n_importe_apd, 0),
			n_importe_apd = 0
Where		c_codigo_tem = :ls_tem
And		c_activo_apd = '1'
Using		SqlCa ;

If f_SqlError( SqlCa, 'No se pudo limpiar la tabla t_acumulado_producto_diario. (Update)' ) = -1 Then
	Return -1
End If

Return 1
end function

public function boolean wf_controlcierre ();/* wf_ControlCierre( ) */
Dec{4}	ldc_tc
Dec{2}	ldc_emphoy
String	ls_cod, ls_hor, ls_usu, ls_msg, ls_tem, ls_pro, ls_eti, ls_mo, ls_md
DateTime	ld_cre




gd_sys = f_GetSysDate( )

Select	c_codigo_coc,
			c_hora_coc,
			c_codigo_usu,
			d_creacion_coc
Into		:ls_cod, 
			:ls_hor, 
			:ls_usu,
			:ld_cre
From		t_control_cierre 
Where		d_trabajo_coc = :gd_sys
And		c_activo_coc  = '1' ;

If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla ' + &
								't_control_cierre. No se puede continuar.' ) = -1 Then
	Return False
End If

If f_Trim( ls_cod ) <> '' Then
	ls_msg = 'La fecha de trabajo ' + String( gd_sys, 'dd/mm/yyyy' ) + &
				' ha sido cerrada~r~npor ' + f_Trim( ls_usu ) + &
				' el día ' + String( ld_cre, 'dd/mm/yyyy' ) + &
				' a la(s) ' + Left( ls_hor, 2 ) + ':' + Right( ls_hor, 2 ) + &
				'.~r~n~r~nNo podrá realizar el proceso nuevamente.'
	Beep(2)
	Beep(2)
	MessageBox( Title, ls_msg, Exclamation! )
	Return False
End If

/* Se revisa el tipo de cambio */
ldc_tc = f_GetTipoCambio( gd_sys )
If ldc_tc = -100 Then
	MessageBox( Title, 'No se tiene ingresado el tipo de cambio para la fecha de trabajo: ' + &
	String( gd_sys, 'dd/mm/yyyy') + ' o está eliminado.', Exclamation! )
	Return False
End If

If ldc_tc = -1 Then
	MessageBox( Title, 'Se produjo un error al obtener el tipo de cambio, no se puede continuar.', StopSign! )
	Return False
End If


If ldc_tc = 0 Then
	MessageBox( Title, 'El tipo de cambio tiene el valor Cero. Debe actualizarlo para poder continuar.', Exclamation! )
	Return False
End If

idc_tc = ldc_tc

// para determinar si hay cantidad de empaque negativo
ls_tem = gs_codtem


select	c_codigo_pro,
			c_codigo_eti,
			c_merori_acu,
			c_merdes_acu,
			(IsNull( n_emphoy_acu, 0) +  IsNull( n_sobhoy_acu, 0) -  IsNull( n_sobant_acu, 0))
into		:ls_pro, 
			:ls_eti, 
			:ls_mo, 
			:ls_md,
			:ldc_emphoy
from	t_acumulado
where c_codigo_tem = : ls_tem
Using SQLCA;
//	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla ' + &
//								't_acumulado. No se puede continuar.' ) = -1 Then
//		Return False
//	End If

	If f_Zero( ldc_emphoy ) < 0 Then
		ls_msg = 'Existe algún producto con cantidad negativa en empaque del día' + &
				'.~r~n~r~nDebe verificar sus datos para poder continuar.'
		Beep(2)
		Beep(2)
		MessageBox( Title, ls_msg, Exclamation! )
		Return False
	End If




Return True
end function

public function long wf_paso5 ();Boolean	lb_ret

dw_list.DataObject = 'd_util_palets_no_acumulados'
dw_list.SetTransObject( SqlCa )
dw_list.Retrieve( gs_codtem )

lb_ret = f_ActualizaAcumulado( 'CIE', 'I', dw_list )

If Not lb_ret Then 
	RollBack Using SqlCa ;
	Return -1
End If

Update	t_palet 
Set		c_staemp_pal = '1' 
Where		IsNull( c_staemp_pal, '0' ) = '0'
Using		SqlCa ;
If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_palet (c_staemp_pal = "1")' ) = -1 Then
	Return -1
End If

Return 1
end function

public function long wf_paso4 ();DateTime	ld_dia, ld_hoy
String	ls_dia, ls_control, ls_hora

ls_dia = f_GetParmValue( '20' )
If ls_dia = '' Then
	MessageBox( Title, 'No se tiene un valor de fecha inicial para poder continuar.', Exclamation! )
	Return -1
End If

ld_dia = f_StringToDate( ls_dia )
ls_control = String( ld_dia, 'yyyymmdd' )
ld_hoy = DateTime( Today() )
ls_hora = String( Now(), 'hhmm')

Insert Into t_control_cierre  
		( c_codigo_coc, d_trabajo_coc, c_hora_coc, c_codigo_usu, d_creacion_coc, c_activo_coc )  
Values
		( :ls_control, :ld_dia, :ls_hora, :gs_usuario, :ld_hoy, '1' )  ;


ld_dia = DateTime( RelativeDate( Date( ld_dia ), 1 ) )
ls_dia = String( ld_dia, 'dd/mm/yyyy' )
If Not f_SetParmValue( '20', ls_dia ) Then
	RollBack Using SqlCa ;
	Return -1
End If

Return 1
end function

public function long wf_paso0 ();Integer li_num
string ls_tem

ls_tem=f_getparmvalue('001')
Select Count(*) 
Into :li_num
From t_acumulado 
Where (n_emphoy_acu+n_sobhoy_acu-n_sobant_acu) < 0 
and c_codigo_tem=:ls_tem
Using sqlca;

If Not li_num = 0 then
	MessageBox( Title, 'No Se Puede Cerrar El Dia, Falta Registrar Los Sobrantes.', StopSign! )
	Return -1
End If
	
Return 1
end function

on w_util_cierre_dia.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.gb_1
end on

on w_util_cierre_dia.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;call super::open;
If f_ContarVentanas( ) > 0 Then
	MessageBox( Title, 'Debe cerrar todas las ventanas para poder continuar.', Exclamation! )
	Close( This )
	Return
End If

dw_list.Visible = False
end event

event closequery;f_GetSysDate( )
gw_frame.wf_GetDefault( )
gw_frame.wf_ShowDefault( )

end event

type dw_list from wa_response`dw_list within w_util_cierre_dia
int X=23
int Y=488
int Width=128
int Height=88
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean VScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_util_cierre_dia
int X=0
int Y=0
int Width=1326
int Height=456
string DataObject="d_util_cierre_dia"
end type

type cb_cancelar from wa_response`cb_cancelar within w_util_cierre_dia
int X=946
int Y=496
end type

event cb_cancelar::clicked;If This.Text = 'Cerrar' Then
	MessageBox( Title, 'Se recomienda reiniciar la sesión si desea continuar.', Exclamation! )
End If

Close( Parent )
end event

type cb_aceptar from wa_response`cb_aceptar within w_util_cierre_dia
int X=567
int Y=496
boolean Enabled=true
end type

event cb_aceptar::clicked;Boolean	lb_error = False
Integer	i

If MessageBox( Parent.Title, '¿Confirma el cierre del día?', Question!, YesNo!, 2 ) <> 1 Then
	cb_cancelar.SetFocus( )
	Return
End If

SetPointer( HourGlass! )

If Not wf_ControlCierre( ) Then
	Return
End If

For i = 1 To dw_1.RowCount( )
	dw_1.SetRedraw( False )
	dw_1.ScrollToRow( i )
	dw_1.SetRow( i )
	dw_1.SetRedraw( True )
	Choose Case i
		Case 1
			If wf_Paso0( ) <> 1 Then
				lb_error = True
				Exit
			End If
		Case 2
			If wf_Paso1( ) <> 1 Then
				lb_error = True
				Exit
			End If
		Case 3
			If wf_Paso2( ) <> 1 Then
				lb_error = True
				Exit
			End If
		Case 4
			If wf_Paso3( ) <> 1 Then
				lb_error = True
				Exit
			End If
		Case 5
			If wf_Paso4( ) <> 1 Then
				lb_error = True
				Exit
			End If
		Case 6
			If wf_Paso5( ) <> 1 Then
				lb_error = True
				Exit
			End If
	End Choose
	dw_1.Object.c_procesado[i] = '1'
Next
SetPointer( Arrow! )

If lb_error Then
	RollBack Using SqlCa ;
	MessageBox( Parent.Title, 'No se pudo realizar el cierre de dia.', StopSign! )
	Return
End If

dw_1.AcceptText( )

Commit Using SqlCa ;
cb_aceptar.Enabled = False
cb_cancelar.Text = 'Cerrar'
cb_cancelar.SetFocus( )
end event

type p_1 from picture within w_util_cierre_dia
int X=82
int Y=628
int Width=73
int Height=56
boolean BringToTop=true
string PictureName="nota.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_1 from statictext within w_util_cierre_dia
int X=169
int Y=628
int Width=1111
int Height=108
boolean Enabled=false
boolean BringToTop=true
string Text="Este proceso puede tardar, las demás sesiones de EyePlus deberán cerrarse"
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

type gb_1 from groupbox within w_util_cierre_dia
int X=41
int Y=580
int Width=1253
int Height=172
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

