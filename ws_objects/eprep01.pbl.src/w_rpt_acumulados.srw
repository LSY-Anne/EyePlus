$PBExportHeader$w_rpt_acumulados.srw
forward
global type w_rpt_acumulados from wa_response
end type
type rb_1 from radiobutton within w_rpt_acumulados
end type
type rb_2 from radiobutton within w_rpt_acumulados
end type
type rb_3 from radiobutton within w_rpt_acumulados
end type
type p_1 from picture within w_rpt_acumulados
end type
type rb_4 from radiobutton within w_rpt_acumulados
end type
type rb_5 from radiobutton within w_rpt_acumulados
end type
type rb_6 from radiobutton within w_rpt_acumulados
end type
type rb_7 from radiobutton within w_rpt_acumulados
end type
type st_2 from statictext within w_rpt_acumulados
end type
type em_fin from uo_editmask within w_rpt_acumulados
end type
type cb_fin from uo_cbdate within w_rpt_acumulados
end type
end forward

global type w_rpt_acumulados from wa_response
int Width=1289
int Height=1064
boolean TitleBar=true
string Title="Reporte de Acumulados"
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
p_1 p_1
rb_4 rb_4
rb_5 rb_5
rb_6 rb_6
rb_7 rb_7
st_2 st_2
em_fin em_fin
cb_fin cb_fin
end type
global w_rpt_acumulados w_rpt_acumulados

forward prototypes
public function long wf_acumanodeobra ()
public function long wf_acueye ()
public function long wf_acuproducciondecampo ()
public function long wf_acugral ()
public function long wf_acueye_bk ()
public function long wf_acucostos ()
public function long wf_acuprod ()
public function long wf_acuetiqueta ()
end prototypes

public function long wf_acumanodeobra ();Dec{4}	ldc_tc
String	ls_mer


ls_mer = 'E'

f_GetSysDate( )
ldc_tc = f_GetTipoCambio( gd_sys )
//CAMBIO: 20100125 AaronS - Cambio Funcion Para Procesar Costos (Puede Procesar el dia y todo Historico, Saca Costo Por Kilo y Corrige errorres varios
If f_util_procesa_costos('N', gd_sys) = 1 Then
//If f_UtilAcumulaEmpaqueyCostoDiario( ldc_tc ) = 1 Then
	If f_UtilAcumulaManoObraDiario( ldc_tc ) = 1 Then
		Commit Using SqlCa ;
	Else
		RollBack Using SqlCa ;
	End If
Else
	RollBack Using SqlCa ;
End If

dw_list.DataObject = 'd_rpt_mano_obra_acumulado'
dw_list.SetTransObject( SqlCa )
dw_list.Retrieve( gs_codtem )

dw_list.AcceptText( )
This.SetFocus( )
f_Preview( dw_list )

Return dw_list.RowCount( )
end function

public function long wf_acueye ();string ls_parm,as_tem
Datetime ad_fecha

ls_parm = f_trim(f_getparmvalue('089'))

ad_fecha = f_stringtodate(f_trim(em_fin.text))
as_tem = f_trim(gs_codtem)

If ls_parm = 'S' Then
	
	DELETE t_acumulado_aux
	Using SqlCa;
	If f_SqlError( SqlCa, 'No se pudo eliminar la tabla t_acumulado_aux).') < 0 Then 
		Return 0
	End If
	
	Insert into t_acumulado_aux
	SELECT c_codigo_tem = :as_tem, 
			c_codigo_pro = a.c_codigo_pro, 
			Producto = pro.v_nombre_pro, 
			CveCul = pro.c_codigo_cul, 
			Cultivo = cul.v_nombre_cul, 
			c_codigo_eti = a.c_codigo_eti, 
			Etiqueta = eti.v_nombre_eti, 
			c_merori_acu=a.c_merori_pro,
			n_emphoy_acu=SUM(a.emphoy), n_emptot_acu=SUM(a.empacu), 
			n_embhoyE_acu=SUM(a.embhoyE), n_embtotE_acu=SUM(a.embacuE),
			n_embhoyN_acu=SUM(a.embhoyN), n_embtotN_acu=SUM(a.embacuN),
			n_sobant_acu=SUM(a.sobayer), n_sobhoy_acu=SUM(a.sobhoy), n_sobtot_acu=SUM(a.sobacu), 
			n_reeant_acu=SUM(a.reeayer), n_reehoy_acu=SUM(a.reehoy), n_reetot_acu=SUM(a.reeacu), 
			n_merant_acu=SUM(a.merayer), n_merhoy_acu=SUM(a.merhoy), n_mertot_acu=SUM(a.meracu), 
			n_accant_acu=SUM(a.accayer), n_acchoy_acu=SUM(a.acchoy), n_acctot_acu=SUM(a.accacu)
	FROM (
	 select p.c_codigo_pro, p.c_codigo_eti, c_merori_pro=t.c_merdes_pro,
	 emphoy = SUM(CASE WHEN p.d_empaque_pal = :ad_fecha THEN IsNull(p.n_bulxpa_pal,0) ELSE 0 END),
	 empacu = SUM(CASE WHEN p.d_empaque_pal < :ad_fecha THEN IsNull(p.n_bulxpa_pal,0) ELSE 0 END),
	 embhoyE=0, embhoyN=0, embacuE=0, embacuN=0,
	 sobhoy = 0, sobayer = 0, sobacu = 0, reehoy = 0, reeayer = 0, reeacu = 0, 
	 merhoy = 0, merayer = 0, meracu = 0, acchoy = 0, accayer = 0, accacu = 0
	 from t_palet p, t_producto t
	 where c_codigo_tem=:as_tem
	 and p.c_codigo_pro = t.c_codigo_pro
	 and IsNull(p.c_codigo_man,'')=''
	 GROUP BY p.c_codigo_pro, p.c_codigo_eti, t.c_merdes_pro 

	 UNION ALL
	 
	 select p.c_codigo_pro, p.c_codigo_eti, c_merori_pro=t.c_merdes_pro,
	 emphoy = SUM(CASE WHEN p.d_empaque_pal=:ad_fecha THEN IsNull(p.n_bulxpa_pal,0) ELSE 0 END),
	 empacu = SUM(CASE WHEN p.d_empaque_pal<:ad_fecha THEN IsNull(p.n_bulxpa_pal,0) ELSE 0 END),
	 embhoyE = SUM(CASE WHEN m.d_embarque_man=:ad_fecha AND m.c_merdes_man='E' THEN IsNull(p.n_bulxpa_pal,0) ELSE 0 END),
	 embhoyN = SUM(CASE WHEN m.d_embarque_man=:ad_fecha AND m.c_merdes_man<>'E' THEN IsNull(p.n_bulxpa_pal,0) ELSE 0 END),
	 embacuE = SUM(CASE WHEN m.d_embarque_man<:ad_fecha AND m.c_merdes_man='E' THEN IsNull(p.n_bulxpa_pal,0) ELSE 0 END),
	 embacuN = SUM(CASE WHEN m.d_embarque_man<:ad_fecha AND m.c_merdes_man<>'E' THEN IsNull(p.n_bulxpa_pal,0) ELSE 0 END),
	 sobhoy = 0, sobayer = 0, sobacu = 0, reehoy = 0, reeayer = 0, reeacu = 0, 
	 merhoy = 0, merayer = 0, meracu = 0, acchoy = 0, accayer = 0, accacu = 0
	 from t_palet p(nolock), t_producto t(nolock), t_manifiesto m(nolock),t_temporada a(nolock)
	 where p.c_codigo_tem=:as_tem
	 and a.c_codigo_tem = p.c_codigo_tem
	 and m.c_codigo_tem = a.c_codigo_tem
	 and a.c_activo_tem = '1'
	 and p.c_codigo_pro = t.c_codigo_pro
	 and p.c_codigo_man = m.c_codigo_man
	 and m.c_codigo_tem = p.c_codigo_tem
	 and IsNull(p.c_codigo_man,'')<>''
	 GROUP BY p.c_codigo_pro, p.c_codigo_eti, t.c_merdes_pro
	 
	 UNION ALL
	 
	 select o.c_codigo_pro, o.c_codigo_eti, c_merori_pro=t.c_merdes_pro,
	 emphoy = 0, empacu = 0,  embhoyE=0, embhoyN=0, embacuE=0, embacuN=0,
	 sobhoy = SUM(CASE WHEN o.c_tipmov_otm='S' AND o.d_movimi_otm = :ad_fecha THEN IsNull(o.n_afecto_otm,0) ELSE 0 END),
	 sobayer = SUM(CASE WHEN o.c_tipmov_otm='S' AND o.d_movimi_otm = DATEADD(dd, -1,  :ad_fecha) THEN IsNull(o.n_afecto_otm,0) ELSE 0 END),
	 sobacu = SUM(CASE WHEN o.c_tipmov_otm='S' AND o.d_movimi_otm < :ad_fecha THEN IsNull(o.n_afecto_otm,0) ELSE 0 END),
	 reehoy = SUM(CASE WHEN o.c_tipmov_otm='R' AND o.d_movimi_otm = :ad_fecha THEN IsNull(o.n_afecto_otm,0) ELSE 0 END),
	 reeayer = SUM(CASE WHEN o.c_tipmov_otm='R' AND o.d_movimi_otm = DATEADD(dd, -1,  :ad_fecha) THEN IsNull(o.n_afecto_otm,0) ELSE 0 END),
	 reeacu = SUM(CASE WHEN o.c_tipmov_otm='R' AND o.d_movimi_otm < :ad_fecha THEN IsNull(o.n_afecto_otm,0) ELSE 0 END),
	 merhoy = SUM(CASE WHEN o.c_tipmov_otm='M' AND o.d_movimi_otm = :ad_fecha THEN IsNull(o.n_afecto_otm,0) ELSE 0 END),
	 merayer = SUM(CASE WHEN o.c_tipmov_otm='M' AND o.d_movimi_otm = DATEADD(dd, -1,  :ad_fecha) THEN IsNull(o.n_afecto_otm,0) ELSE 0 END),
	 meracu = SUM(CASE WHEN o.c_tipmov_otm='M' AND o.d_movimi_otm < :ad_fecha THEN IsNull(o.n_afecto_otm,0) ELSE 0 END),
	 acchoy = SUM(CASE WHEN o.c_tipmov_otm='A' AND o.d_movimi_otm = :ad_fecha THEN IsNull(o.n_afecto_otm,0) ELSE 0 END),
	 accayer = SUM(CASE WHEN o.c_tipmov_otm='A' AND o.d_movimi_otm=DATEADD(dd, -1,  :ad_fecha) THEN IsNull(o.n_afecto_otm,0) ELSE 0 END),
	 accacu = SUM(CASE WHEN o.c_tipmov_otm='A' AND o.d_movimi_otm < :ad_fecha THEN IsNull(o.n_afecto_otm,0) ELSE 0 END)
	 from t_otro_movimiento o, t_producto t,t_temporada a
	 where o.c_codigo_tem=:as_tem
	 and o.c_codigo_tem = a.c_codigo_tem
	 and a.c_activo_tem = '1'
	 and o.c_codigo_pro = t.c_codigo_pro
	 and IsNull(o.c_activo_otm,'')='1'
	 GROUP BY o.c_codigo_pro, o.c_codigo_eti, t.c_merdes_pro 
	
	) a
		LEFT JOIN t_producto pro (NOLOCK) ON a.c_codigo_pro=pro.c_codigo_pro
		LEFT JOIN t_cultivo cul (NOLOCK) ON pro.c_codigo_cul=cul.c_codigo_cul
		LEFT JOIN t_etiqueta eti (NOLOCK) ON a.c_codigo_eti=eti.c_codigo_eti
	GROUP BY a.c_codigo_pro, a.c_codigo_eti, a.c_merori_pro,
	 pro.v_nombre_pro, pro.c_codigo_cul, cul.v_nombre_cul, eti.v_nombre_eti
	USING SQLCA;
	If f_SqlError( SqlCa, 'No se pudo eliminar la tabla t_acumulado_aux).') < 0 Then 
		ROLLBACK USING SQLCA;
		RETURN 0
	END If
	
	dw_list.DataObject = 'd_rpt_acumulado_eye_nvo'
	dw_list.SetTransObject( SqlCa )
	dw_list.Retrieve( ad_fecha )
Else
	dw_list.DataObject = 'd_rpt_acumulado_eye'
	dw_list.SetTransObject( SqlCa )
	dw_list.Retrieve( gs_codtem )
End If


This.SetFocus( )
f_Preview( dw_list )

Return dw_list.RowCount( )
end function

public function long wf_acuproducciondecampo ();/* wf_AcuProduccionDeCampo( )*/

gd_sys = f_GetSysDate( )
dw_list.DataObject = 'd_rpt_acumulado_produccion_campo'
dw_list.SetTransObject( SqlCa )
dw_list.Retrieve( gs_codtem, gd_sys )

This.SetFocus( )
f_Preview( dw_list )

Return dw_list.RowCount( )
end function

public function long wf_acugral ();/* wf_AcuGral( )*/

dw_list.DataObject = 'd_rpt_acumulado_gral'
dw_list.SetTransObject( SqlCa )
dw_list.Retrieve( gs_codtem )

f_Preview( dw_list )

Return dw_list.RowCount( )
end function

public function long wf_acueye_bk ();/* wf_AcuEyE( )*/
Dec{2}	ldc_emphoy, ldc_embhoy, ldc_merhoy, ldc_sobhoy, ldc_reehoy
Long		i
String	ls_cul, ls_pro, ls_eti

dw_list.DataObject = 'd_rpt_acumulado_eye'
dw_list.SetTransObject( SqlCa )
dw_list.Retrieve( gs_codtem )


For i = 1 To dw_list.RowCount( )
	/* Variables Key */
	ls_cul = dw_list.Object.c_codigo_cul[ i]
	ls_pro = dw_list.Object.c_codigo_pro[ i]
	ls_eti = dw_list.Object.c_codigo_eti[ i]
	/* Variables Totales */
	ldc_emphoy = 0; ldc_embhoy = 0; ldc_merhoy = 0; ldc_sobhoy = 0; ldc_reehoy = 0
		
	/* Informacion de Empaque */
	Select	Sum( n_bulxpa_pal )
	Into		:ldc_emphoy
	From		t_palet
	Where		c_codigo_tem = :gs_codtem
	And		c_codigo_pro = :ls_pro
	And		c_codigo_eti = :ls_eti
	And		c_contab_pal = '0'
	And		c_activo_pal = '1' ;
	//	And		d_empaque_pal = :gd_sys
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_palet. (Sum)' ) = -1 Then
		Return -1
	End If
	
	/* Informacion de Embarque */
	Select	Sum( n_bulxpa_pal )
	Into		:ldc_embhoy
	From		t_palet,
				t_manifiesto
	Where		t_palet.c_codigo_man = t_manifiesto.c_codigo_man
	And		t_palet.c_codigo_tem = :gs_codtem
	And		t_manifiesto.c_codigo_tem = :gs_codtem
	And		c_codigo_pro = :ls_pro
	And		c_codigo_eti = :ls_eti
	And		c_contab_pal = '0'
	And		c_activo_pal = '1'
	And		c_activo_man = '1' ;
	//	And		d_embarque_man = :gd_sys
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_palet, t_manifiesto. (Sum)' ) = -1 Then
		Return -1
	End If

	/* Informacion de Mermas */
	Select	Sum( n_afecto_otm )
	Into		:ldc_merhoy
	From		t_otro_movimiento
	Where		c_codigo_tem = :gs_codtem
	And		c_codigo_pro = :ls_pro
	And		c_codigo_eti = :ls_eti
	And		c_tipmov_otm = 'M'
	And		c_contab_otm = '0'
	And		c_activo_otm = '1' ;
	//	And		d_movimi_otm = :gd_sys
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_otro_movimiento. (Sum)' ) = -1 Then
		Return -1
	End If
	
	/* Informacion de Sobrantes */
	Select	Sum( n_afecto_otm )
	Into		:ldc_sobhoy
	From		t_otro_movimiento
	Where		c_codigo_tem = :gs_codtem
	And		c_codigo_pro = :ls_pro
	And		c_codigo_eti = :ls_eti
	And		c_tipmov_otm = 'S'
	And		c_contab_otm = '0'
	And		c_activo_otm = '1' ;
	//	And		d_movimi_otm = :gd_sys
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_otro_movimiento. (Sum)' ) = -1 Then
		Return -1
	End If
	
	/* Informacion de Reempaque */
	Select	Sum( n_afecto_otm )
	Into		:ldc_reehoy
	From		t_otro_movimiento
	Where		c_codigo_tem = :gs_codtem
	And		c_codigo_pro = :ls_pro
	And		c_codigo_eti = :ls_eti
	And		c_tipmov_otm = 'R'
	And		c_contab_otm = '0'
	And		c_activo_otm = '1' ;
	//	And		d_movimi_otm = :gd_sys
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_otro_movimiento. (Sum)' ) = -1 Then
		Return -1
	End If
	dw_list.Object.n_emphoy_acu[ i] = ldc_emphoy
	dw_list.Object.n_embhoy_acu[ i] = ldc_embhoy
	dw_list.Object.n_reehoy_acu[ i] = ldc_reehoy
	dw_list.Object.n_sobhoy_acu[ i] = ldc_sobhoy
	dw_list.Object.n_merhoy_acu[ i] = ldc_merhoy
Next

dw_list.AcceptText( )
This.SetFocus( )
f_Preview( dw_list )

Return dw_list.RowCount( )
end function

public function long wf_acucostos ();DataWindow	ldw_1
Dec{4}	ldc_tc
String	ls_mer

SetPointer( HourGlass! )

ls_mer = 'E'

f_GetSysDate( )
ldc_tc = f_GetTipoCambio( gd_sys )
//CAMBIO: 20100125 AaronS - Cambio Funcion Para Procesar Costos (Puede Procesar el dia y todo Historico, Saca Costo Por Kilo y Corrige errorres varios
If f_util_procesa_costos('N', gd_sys) = 1 Then
//If f_UtilAcumulaEmpaqueyCostoDiario( ldc_tc ) = 1 Then
	If f_UtilAcumulaManoObraDiario( ldc_tc ) = 1 Then
		Commit Using SqlCa ;
	Else
		RollBack Using SqlCa ;
	End If
Else
	RollBack Using SqlCa ;
End If

This.SetFocus( )


ldw_1 = f_PreviewXP( 'd_rpt_acumulado_empaque_costo2' )
ldw_1.Retrieve(gs_codtem, gd_sys, ldc_tc)

Return 1
end function

public function long wf_acuprod ();DataWindow	ldw_1

f_GetSysDate( )

This.SetFocus( )

ldw_1 = f_PreviewXP( 'd_rpt_acumulado_lote_cultivo' )
ldw_1.Retrieve( gs_codtem, gd_sys )


Return ldw_1.RowCount( )
end function

public function long wf_acuetiqueta ();DataWindow	ldw_1
Dec{4}	ldc_tc
String	ls_mer

SetPointer( HourGlass! )

ls_mer = 'E'

f_GetSysDate( )
ldc_tc = f_GetTipoCambio( gd_sys )

//CAMBIO: 20100125 AaronS - Cambio Funcion Para Procesar Costos (Puede Procesar el dia y todo Historico, Saca Costo Por Kilo y Corrige errorres varios
If f_util_procesa_costos('N', gd_sys) = 1 Then
//If f_UtilAcumulaEmpaqueyCostoDiario( ldc_tc ) = 1 Then
	If f_UtilAcumulaManoObraDiario( ldc_tc ) = 1 Then
		Commit Using SqlCa ;
	Else
		RollBack Using SqlCa ;
	End If
Else
	RollBack Using SqlCa ;
End If

This.SetFocus( )


ldw_1 = f_PreviewXP( 'd_rpt_acumulado_etiqueta_costo' )
ldw_1.Retrieve(gs_codtem, gd_sys, ldc_tc)

Return 1
end function

on w_rpt_acumulados.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.p_1=create p_1
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_6=create rb_6
this.rb_7=create rb_7
this.st_2=create st_2
this.em_fin=create em_fin
this.cb_fin=create cb_fin
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_3
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.rb_4
this.Control[iCurrent+6]=this.rb_5
this.Control[iCurrent+7]=this.rb_6
this.Control[iCurrent+8]=this.rb_7
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.em_fin
this.Control[iCurrent+11]=this.cb_fin
end on

on w_rpt_acumulados.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.p_1)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_6)
destroy(this.rb_7)
destroy(this.st_2)
destroy(this.em_fin)
destroy(this.cb_fin)
end on

event open;call super::open;String ls_parm

dw_1.Visible = False
dw_list.Visible = False

em_fin.visible = false
st_2.visible= false
cb_fin.visible= false

rb_1.x = 219
rb_1.y = 156

em_fin.x= 96
em_fin.y= 1024

st_2.x = 20
st_2.y = 1032

cb_fin.x = 443
cb_fin.y = 1024

ls_parm = f_trim(f_getparmvalue('089'))
If ls_parm='S' Then
	rb_1.x = 219
	rb_1.y = 64
	
	em_fin.x= 471
	em_fin.y= 152
	
	st_2.x = 375
	st_2.y = 160
	
	cb_fin.x = 818
	cb_fin.y = 152
	
	em_fin.Text = f_GetParmValue( '020' )
	
	em_fin.visible = True
	st_2.visible= True
	cb_fin.visible= True
	
	
End If


end event

type dw_list from wa_response`dw_list within w_rpt_acumulados
int X=0
int Y=1212
int Width=297
int Height=164
int TabOrder=0
string DataObject="d_rpt_acumulado"
end type

type dw_1 from wa_response`dw_1 within w_rpt_acumulados
int X=0
int Y=1120
int Width=119
int Height=84
int TabOrder=0
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_acumulados
int X=887
int Y=832
int TabOrder=40
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_acumulados
int X=507
int Y=832
boolean Enabled=true
end type

event cb_aceptar::clicked;

If rb_1.Checked Then
	wf_AcuEyE( )
ElseIf rb_2.Checked Then
	wf_AcuManoDeObra( )
ElseIf rb_3.Checked Then
	wf_AcuProduccionDeCampo( )
ElseIf rb_4.Checked Then
	wf_AcuGral( )
ElseIf rb_5.Checked Then
	wf_AcuCostos( )
ElseIf rb_6.Checked Then
	wf_AcuProd( )
Elseif rb_7.Checked then
	wf_AcuEtiqueta()
End If

Return 
end event

type rb_1 from radiobutton within w_rpt_acumulados
int X=219
int Y=80
int Width=901
int Height=56
int TabOrder=10
boolean BringToTop=true
string Text="Productos Empacados y Embarcados"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_rpt_acumulados
int X=219
int Y=252
int Width=480
int Height=56
boolean BringToTop=true
string Text="De Mano de Obra"
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

type rb_3 from radiobutton within w_rpt_acumulados
int X=219
int Y=344
int Width=859
int Height=56
boolean BringToTop=true
string Text="Reporte Acumulado de Producción"
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

type p_1 from picture within w_rpt_acumulados
int X=37
int Y=36
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type rb_4 from radiobutton within w_rpt_acumulados
int X=219
int Y=436
int Width=805
int Height=56
boolean BringToTop=true
string Text="Reporte General de Acumulados"
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

type rb_5 from radiobutton within w_rpt_acumulados
int X=219
int Y=528
int Width=581
int Height=56
boolean BringToTop=true
string Text="Acumulados de Costos"
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

type rb_6 from radiobutton within w_rpt_acumulados
int X=219
int Y=620
int Width=919
int Height=56
boolean BringToTop=true
string Text="Acumulados de Producción de Campo"
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

type rb_7 from radiobutton within w_rpt_acumulados
int X=219
int Y=720
int Width=855
int Height=56
boolean BringToTop=true
string Text="Acumulados de Costos por Etiqueta"
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

type st_2 from statictext within w_rpt_acumulados
int X=375
int Y=160
int Width=73
int Height=64
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

type em_fin from uo_editmask within w_rpt_acumulados
int X=471
int Y=152
int TabOrder=30
end type

type cb_fin from uo_cbdate within w_rpt_acumulados
int X=818
int Y=152
int TabOrder=20
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

