$PBExportHeader$w_arch_palet_eliminar.srw
forward
global type w_arch_palet_eliminar from wa_response
end type
type p_1 from picture within w_arch_palet_eliminar
end type
end forward

global type w_arch_palet_eliminar from wa_response
int Width=1701
int Height=680
boolean TitleBar=true
string Title="Eliminación de Palet"
long BackColor=16777215
p_1 p_1
end type
global w_arch_palet_eliminar w_arch_palet_eliminar

event open;call super::open;s_parm lstr_parm
string ls_pal

dw_1.Visible = true
dw_list.Visible = False

lstr_parm = Message.PowerObjectParm
ls_pal =  f_trim(lstr_parm.s_cad[1]  )

dw_1.DataObject = 'd_arch_palet_eliminado'
dw_1.SetTransObject( SqlCa )

lstr_parm = Message.PowerObjectParm

dw_1.Retrieve(ls_pal)
dw_1.SetTransObject( SqlCa )
dw_1.InsertRow(1)
dw_1.AcceptText( )

dw_1.SetColumn( 'c_motivo_pal' )
end event

on w_arch_palet_eliminar.create
int iCurrent
call super::create
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
end on

on w_arch_palet_eliminar.destroy
call super::destroy
destroy(this.p_1)
end on

type dw_list from wa_response`dw_list within w_arch_palet_eliminar
int X=919
int Y=700
int Width=128
int Height=108
int TabOrder=0
boolean Enabled=false
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean VScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_arch_palet_eliminar
int X=41
int Y=56
int Width=1591
int Height=324
int TabOrder=0
string DataObject="d_arch_palet_eliminado"
end type

type cb_cancelar from wa_response`cb_cancelar within w_arch_palet_eliminar
int X=814
int Y=440
int TabOrder=20
end type

type cb_aceptar from wa_response`cb_aceptar within w_arch_palet_eliminar
int X=430
int Y=440
int TabOrder=10
end type

event cb_aceptar::clicked;String	ls_opc, ls_mot, ls_exp, ls_pal, ls_tem,ls_codsec, ls_pro, ls_eti, ls_col, ls_lot, ls_staemp, ls_merdes, ls_staemb, ls_man, ls_env
String   ls_codrlq, ls_hora, ls_codcot, ls_exc, ls_contab, ls_motivo, ls_otro, ls_cultivo, ls_motivos, ls_mer,ls_sec
Dec {4} ldc_bulxpa, ldc_precmn, ldc_precme, ldc_contab, ldc_peso, ldc_precioliq, ldc_kilosliq
datetime ld_hoy, ld_pal, ld_contab
s_parm lstr_parm

dw_1.AcceptText( )

ld_hoy=datetime(today())

lstr_parm = Message.PowerObjectParm
ls_pal =  f_trim(lstr_parm.s_cad[1]  )
ls_sec=  f_trim(lstr_parm.s_cad[2]  )

ls_mot = f_trim(dw_1.object.c_motivo_pal[1])
ls_exp = f_trim(dw_1.object.v_explicacion_pal[1])

If ls_mot  = '' Then
	MessageBox( 'Eliminar Palet', 'Debe elegir motivo de eliminación de palet.', Exclamation! )
	return 0
End IF

If ls_exp = '' Then
	MessageBox( 'Eliminar Palet', 'Debe llenar explicación de eliminación de palet.', Exclamation! )
	dw_1.SetColumn( 'v_explicacion_pal' )
	return 0
End IF


select 	c_codigo_tem, c_codigo_pal, c_codsec_pal, 	c_codigo_pro, 	c_codigo_eti, c_codigo_col, c_codigo_lot, d_empaque_pal, c_staemp_pal, c_merdes_pal,
			c_staemb_pal, c_codigo_man, c_codigo_env, 	n_bulxpa_pal, 	n_precmn_pal, n_precme_pal, isnull(c_contab_pal,''), isnull(d_contab_pal,'19000101'), 
			c_codigo_rlq, n_peso_pal, 	 n_precioliq_pal, n_kilosliq_pal, c_hora_pal, c_codigo_cot, c_excedente_pal 
into 		:ls_tem,			:ls_pal,			:ls_codsec,		:ls_pro,			:ls_eti,			:ls_col,		:ls_lot,			:ld_pal,			:ls_staemp,		:ls_merdes,
			:ls_staemb,		:ls_man,			:ls_env,			:ldc_bulxpa,	:ldc_precmn,	:ldc_precme,:ls_contab,						:ld_contab,	
			:ls_codrlq,		:ldc_peso,		:ldc_precioliq,:ldc_kilosliq, :ls_hora,		:ls_codcot,	:ls_exc
From     t_palet (nolock)
where c_codigo_pal = :ls_pal
and 	c_codsec_pal=:ls_sec
Using SqlCa;
If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_palet 1' ) =-1 Then
Return -1 
End If
//
//Insert into t_paleteliminado
//(c_codigo_tem,	c_codigo_pal,	c_codsec_pal,	c_codigo_pro,		c_codigo_eti,	c_codigo_col,		c_codigo_lot,	d_empaque_pal,	c_staemp_pal,	c_merdes_pal,
//c_staemb_pal,	c_codigo_man,	c_codigo_env,	n_bulxpa_pal,		n_precmn_pal,	n_precme_pal,		c_contab_pal,	d_contab_pal,	c_codigo_usu,	d_creacion_pal,
//c_activo_pal,	c_codigo_rlq,	n_peso_pal,		n_precioliq_pal,	n_kilosliq_pal,c_hora_pal,			c_codigo_cot, 	c_excedente_pal,c_motivo_pal,	v_explicacion_pal)
//Values 
//(:ls_tem,			:ls_pal,		:ls_codsec,		:ls_pro,				:ls_eti,			:ls_col,				:ls_lot,			:ld_pal,			:ls_staemp,		:ls_merdes,
//:ls_staemb,			:ls_man,		:ls_env,			:ldc_bulxpa,		:ldc_precmn,	:ldc_precme,		:ls_contab,		:ld_contab,		:gs_usuario,	:ld_hoy,
//'1',					:ls_codrlq,	:ldc_peso,		:ldc_precioliq,	:ldc_kilosliq, :ls_hora,			:ls_codcot,		:ls_exc,			:ls_mot,			:ls_exp)
Insert into t_paleteliminado
(c_codigo_tem,	c_codigo_pal,	c_codsec_pal,	c_codigo_pro,		c_codigo_eti,	c_codigo_col,c_codigo_lot,	d_empaque_pal,	c_staemp_pal,	c_merdes_pal,
c_staemb_pal,	c_codigo_man,	c_codigo_env,	n_bulxpa_pal,		n_precmn_pal,	n_precme_pal,c_contab_pal,	d_contab_pal,	c_codigo_usu,	d_creacion_pal,
c_activo_pal,	c_codigo_rlq,	n_peso_pal,		n_precioliq_pal,	n_kilosliq_pal,c_hora_pal,	c_codigo_cot, 	c_excedente_pal,c_motivo_pal,	v_explicacion_pal)
select c_codigo_tem,	c_codigo_pal,	c_codsec_pal,	c_codigo_pro,		c_codigo_eti,	c_codigo_col,c_codigo_lot,	d_empaque_pal,	c_staemp_pal,	c_merdes_pal,
c_staemb_pal,	c_codigo_man,	c_codigo_env,	n_bulxpa_pal,		n_precmn_pal,	n_precme_pal,c_contab_pal,	d_contab_pal,	c_codigo_usu,	d_creacion_pal,
c_activo_pal,	c_codigo_rlq,	n_peso_pal,		n_precioliq_pal,	n_kilosliq_pal,c_hora_pal,	c_codigo_cot, 	c_excedente_pal,:ls_mot,:ls_exp
from t_palet(nolock)
where c_codigo_pal = :ls_pal
using sqlca;	
If f_SqlError( SqlCa, 'No se pudo obtener insertar registro de la tabla t_paleteliminado 2' ) = -1 Then 
	RollBack Using SqlCa ;
	Return -1
End If
		

If ls_mot  =  '02' or ls_mot = '03' Then
	Select	IsNull(Max( c_codigo_otm ),'000000')
	Into		:ls_otro
	From		t_otro_movimiento (NOLOCK)
	Using		SqlCa ;	
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_otro_movimiento 3.' ) = -1 Then 
		RollBack Using SqlCa ;
		Return -1
	End If		
	ls_otro =String(long(ls_otro) + 1)
	ls_otro = Right( '000000' + ls_otro, 6 )	
	
	select c_codigo_cul , c_merdes_pro
	into :ls_cultivo, :ls_mer
	from t_producto (nolock)
	where c_codigo_pro = :ls_pro
	Using		SqlCa ;	
		If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_producto 4.' ) = -1 Then 
		RollBack Using SqlCa ;
		Return -1
	End If
	
	If ls_mot = '02' Then
		ls_motivos = 'R'
	elseif ls_mot = '03' Then
		ls_motivos = 'M'
	End IF
	
	Insert into t_otro_movimiento
	(c_codigo_otm, c_codigo_tem, c_elemen_otm, c_codigo_pro, c_codigo_cul, c_codigo_eti, c_tipmov_otm, d_movimi_otm, c_contab_otm,n_afecto_otm, c_codigo_usu, d_creacion_otm, c_activo_otm)
	Values 
	(:ls_otro,		:ls_Tem,		:ls_pro + :ls_eti,	:ls_pro,			:ls_cultivo,	:ls_eti,			:ls_motivos, :ld_hoy,'0',			:ldc_bulxpa,	:gs_usuario,		:ld_hoy,   '1'	)
	using sqlca;	
	If f_SqlError( SqlCa, 'No se pudo obtener insertar registro de la tabla t_otro_movimiento 5' ) = -1 Then 
		RollBack Using SqlCa ;
		Return -1
	End If
	
	If ls_mot = '02'  Then // Ree
     	update t_acumulado
//		set n_reehoy_acu  = :ldc_bulxpa
		set n_reehoy_acu  = n_reehoy_acu + :ldc_bulxpa
		where c_codigo_tem = :ls_tem
		and c_codigo_pro = :ls_pro
		and c_codigo_eti = :ls_eti
		and c_merori_acu = :ls_mer
		and c_merdes_acu = :ls_mer
		using sqlca;	
		If f_SqlError( SqlCa, 'No se pudo obtener actualizar registro de la tabla t_acumulado 6' ) = -1 Then 
			RollBack Using SqlCa ;
			Return -1
		End If
	
	End If
	
	If ls_mot = '03' Then  //Merma
		update t_acumulado
//		set n_merhoy_acu  = :ldc_bulxpa
		set n_merhoy_acu  = n_merhoy_acu + :ldc_bulxpa
		where c_codigo_tem = :ls_tem
		and c_codigo_pro = :ls_pro
		and c_codigo_eti = :ls_eti
		and c_merori_acu = :ls_mer
		and c_merdes_acu = :ls_mer
		using sqlca;	
		If f_SqlError( SqlCa, 'No se pudo obtener actualizar registro de la tabla t_acumulado 7' ) = -1 Then 
			RollBack Using SqlCa ;
			Return -1
		End If
	End If
	
End IF


CloseWithReturn( Parent, ls_pal )
/* If ls_mot = '02'  Then // Ree
      update t_acumulado
  set n_reehoy_acu  = n_reehoy_acu + :ldc_bulxpa
  where c_codigo_tem = :ls_tem
  and c_codigo_pro = :ls_pro
  and c_codigo_eti = :ls_eti
  and c_merori_acu = :ls_mer
  and c_merdes_acu = :ls_mer
  using sqlca; 
  If f_SqlError( SqlCa, 'No se pudo obtener actualizar registro de la tabla t_acumulado' ) = -1 Then 
   RollBack Using SqlCa ;
   Return -1
  End If
 
 End If
 
 If ls_mot = '03' Then  //Merma
  update t_acumulado
  set n_merhoy_acu  = n_merhoy_acu + :ldc_bulxpa
  where c_codigo_tem = :ls_tem
  and c_codigo_pro = :ls_pro
  and c_codigo_eti = :ls_eti
  and c_merori_acu = :ls_mer
  and c_merdes_acu = :ls_mer
  using sqlca; 
  If f_SqlError( SqlCa, 'No se pudo obtener actualizar registro de la tabla t_acumulado' ) = -1 Then 
   RollBack Using SqlCa ;
   Return -1
  End If
 End If
 
End IF

CloseWithReturn( Parent, ls_pal ) */


end event

type p_1 from picture within w_arch_palet_eliminar
int X=1294
int Y=664
int Width=146
int Height=128
boolean BringToTop=true
string PictureName="eliminar.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

