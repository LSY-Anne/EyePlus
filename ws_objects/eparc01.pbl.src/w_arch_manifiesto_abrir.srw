$PBExportHeader$w_arch_manifiesto_abrir.srw
forward
global type w_arch_manifiesto_abrir from wa_response
end type
type st_1 from statictext within w_arch_manifiesto_abrir
end type
type em_ini from uo_editmask within w_arch_manifiesto_abrir
end type
type cb_5 from uo_cbdate within w_arch_manifiesto_abrir
end type
type st_2 from statictext within w_arch_manifiesto_abrir
end type
type em_fin from uo_editmask within w_arch_manifiesto_abrir
end type
type cb_fin from uo_cbdate within w_arch_manifiesto_abrir
end type
type cb_buscar from uo_cbother within w_arch_manifiesto_abrir
end type
type cb_imprimir from uo_cbother within w_arch_manifiesto_abrir
end type
type cb_nuevo from uo_cbother within w_arch_manifiesto_abrir
end type
type cb_eliminar from uo_cbother within w_arch_manifiesto_abrir
end type
type cb_pornumero from uo_cbother within w_arch_manifiesto_abrir
end type
end forward

global type w_arch_manifiesto_abrir from wa_response
int Width=2725
int Height=1180
boolean TitleBar=true
string Title="Abrir Manifiesto"
st_1 st_1
em_ini em_ini
cb_5 cb_5
st_2 st_2
em_fin em_fin
cb_fin cb_fin
cb_buscar cb_buscar
cb_imprimir cb_imprimir
cb_nuevo cb_nuevo
cb_eliminar cb_eliminar
cb_pornumero cb_pornumero
end type
global w_arch_manifiesto_abrir w_arch_manifiesto_abrir

forward prototypes
public function boolean wf_actualizaacumulados (string as_acc)
end prototypes

public function boolean wf_actualizaacumulados (string as_acc);uo_DataStore	lds_1, lds_acu
DateTime	ld_emp, ld_emb
Dec{2}	ldc_bul
String	ls_tem, ls_cod, ls_mer, ls_pro, ls_eti, ls_des, ls_codori
Long		ll_row, i, ll_ret


Destroy lds_acu
Destroy lds_1

ls_cod = dw_list.Object.c_codigo_man[ dw_list.GetRow()]
ls_des = dw_list.Object.c_merdes_man[ dw_list.GetRow()]
ls_tem = dw_list.Object.c_codigo_tem[ dw_list.GetRow()]
ld_emb = dw_list.Object.d_embarque_man[ dw_list.GetRow()]


lds_1 = Create uo_DataStore
lds_1.DataObject = 'd_arch_manifiesto_det'
lds_1.SetTransObject( SqlCa )
ll_ret = lds_1.Retrieve( ls_tem, ls_cod )


lds_acu = Create uo_DataStore
lds_acu.DataObject = 'd_arch_acumulado_edit'
lds_acu.SetTransObject( SqlCa ) 

For i = 1 To lds_1.RowCount( )
	if lds_1.Object.c_excedente_pal[ i] <> '1' THEN //20091222
		ls_mer = ''
		ls_pro = f_Trim( lds_1.Object.c_codigo_pro[ i] )
		
		Select	c_merdes_pro
		Into		:ls_mer
		From		t_producto
		Where		c_codigo_pro = :ls_pro ;
		
		ls_eti = f_Trim( lds_1.Object.c_codigo_eti[ i] )
		ldc_bul = f_Zero( lds_1.Object.n_bulxpa_pal[ i] )
		ld_emp = lds_1.Object.d_empaque_pal[ i]
		ls_codori = gs_codtem + ls_pro + ls_eti + ls_mer
		ll_row = lds_acu.Retrieve( gs_codtem + ls_pro + ls_eti + ls_mer + ls_des )
		If ll_row > 0 Then
			lds_acu.Object.c_usumod[ll_row] = gs_usuario
			lds_acu.Object.d_modifi[ll_row] = DateTime( Today( ) )
			lds_acu.Object.c_activo[ll_row] = '1'
			If as_acc = 'I' Then
				lds_acu.Object.n_embhoy_acu[ll_row] = f_Zero(lds_acu.Object.n_embhoy_acu[ll_row]) + ldc_bul
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
	END IF
Next


Destroy lds_acu
Destroy lds_1
		
Return True
end function

on w_arch_manifiesto_abrir.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_ini=create em_ini
this.cb_5=create cb_5
this.st_2=create st_2
this.em_fin=create em_fin
this.cb_fin=create cb_fin
this.cb_buscar=create cb_buscar
this.cb_imprimir=create cb_imprimir
this.cb_nuevo=create cb_nuevo
this.cb_eliminar=create cb_eliminar
this.cb_pornumero=create cb_pornumero
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_ini
this.Control[iCurrent+3]=this.cb_5
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.em_fin
this.Control[iCurrent+6]=this.cb_fin
this.Control[iCurrent+7]=this.cb_buscar
this.Control[iCurrent+8]=this.cb_imprimir
this.Control[iCurrent+9]=this.cb_nuevo
this.Control[iCurrent+10]=this.cb_eliminar
this.Control[iCurrent+11]=this.cb_pornumero
end on

on w_arch_manifiesto_abrir.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_ini)
destroy(this.cb_5)
destroy(this.st_2)
destroy(this.em_fin)
destroy(this.cb_fin)
destroy(this.cb_buscar)
destroy(this.cb_imprimir)
destroy(this.cb_nuevo)
destroy(this.cb_eliminar)
destroy(this.cb_pornumero)
end on

event open;call super::open;em_ini.Text = String( gd_sys, 'dd/mm/yyyy' )
em_fin.Text = String( gd_sys, 'dd/mm/yyyy' )
dw_1.Visible = False

If f_Trim( Message.StringParm ) = 'NEW' Then 
	cb_buscar.TriggerEvent( Clicked! )
	cb_nuevo.SetFocus( ) 
End If
end event

type dw_list from wa_response`dw_list within w_arch_manifiesto_abrir
int X=37
int Y=152
int Width=2629
int Height=780
int TabOrder=50
string DataObject="d_arch_manifiesto_abrir"
end type

event dw_list::retrieveend;call super::retrieveend;If rowcount > 0  Then cb_aceptar.Enabled = True
end event

event dw_list::doubleclicked;cb_aceptar.TriggerEvent( Clicked! )
end event

event dw_list::getfocus;cb_aceptar.Default = True
end event

type dw_1 from wa_response`dw_1 within w_arch_manifiesto_abrir
int X=46
int Y=936
int Width=306
int Height=136
int TabOrder=0
string DataObject="d_rpt_manifiesto_x_fechas"
end type

type cb_cancelar from wa_response`cb_cancelar within w_arch_manifiesto_abrir
int X=2318
int Y=960
int TabOrder=90
end type

event cb_cancelar::clicked;s_parm	lstr_parm


CloseWithReturn( Parent, lstr_parm )
end event

type cb_aceptar from wa_response`cb_aceptar within w_arch_manifiesto_abrir
int X=855
int Y=960
int TabOrder=60
end type

event cb_aceptar::clicked;s_parm	lstr_parm

If dw_list.RowCount ( ) <= 0  Then 
	Beep( 1)
	Return
End If

If dw_list.Object.c_activo_man[dw_list.GetRow( )] = '0' Then
	MessageBox( Title, 'El registro se encuentra eliminado/cancelado.' )
	dw_list.SetFocus( )
	Return
End If

lstr_parm.s_cad[1] = dw_list.Object.c_codigo_tem[dw_list.GetRow( )]
lstr_parm.s_cad[2] = dw_list.Object.c_codigo_man[dw_list.GetRow( )]

CloseWithReturn( Parent, lstr_parm )

end event

type st_1 from statictext within w_arch_manifiesto_abrir
int X=46
int Y=40
int Width=123
int Height=76
boolean Enabled=false
string Text="&Del:"
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

type em_ini from uo_editmask within w_arch_manifiesto_abrir
int X=178
int Y=36
int Accelerator=100
end type

event getfocus;cb_buscar.Default = True
end event

type cb_5 from uo_cbdate within w_arch_manifiesto_abrir
int X=521
int Y=40
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_2 from statictext within w_arch_manifiesto_abrir
int X=690
int Y=40
int Width=91
int Height=76
boolean Enabled=false
string Text="&Al:"
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

type em_fin from uo_editmask within w_arch_manifiesto_abrir
int X=823
int Y=36
int TabOrder=20
int Accelerator=97
end type

event getfocus;cb_buscar.Default = True
end event

type cb_fin from uo_cbdate within w_arch_manifiesto_abrir
int X=1166
int Y=40
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type cb_buscar from uo_cbother within w_arch_manifiesto_abrir
int X=1321
int Y=32
int TabOrder=40
string Text="&Buscar"
end type

event clicked;String	ls_null

SetNull( ls_null )
IF gs_tipo='' then
	gs_tipo='%'
end if
dw_list.Retrieve( gs_codtem, f_StringToDate( em_ini.Text ), f_StringToDate( em_fin.Text ), ls_null,gs_tipo )
dw_list.SetFocus( )
end event

type cb_imprimir from uo_cbother within w_arch_manifiesto_abrir
event ue_imprimirfac pbm_custom01
event ue_imprimiraarc pbm_custom02
int X=1221
int Y=960
int TabOrder=70
boolean BringToTop=true
string Text="&Imprimir"
end type

event clicked;String	ls_man, ls_tem, ls_mer,ls_rem
long ll_row,li_opc

ls_rem = upper(f_trim(f_getparmvalue('071')))

If dw_list.RowCount ( ) <= 0  Then 
	MessageBox( Title, 'El listado se encuentra vacio.', Exclamation! )
	Beep( 1)
	Return
End If

If dw_list.Object.c_activo_man[dw_list.GetRow( )] = '0' Then
	MessageBox( Title, 'El registro se encuentra eliminado/cancelado.' )
	dw_list.SetFocus( )
	Return
End If

istr_parm.s_cad[ 1] = 'L' // ---> Listado por default
istr_parm.s_cad[ 2] = em_ini.Text
istr_parm.s_cad[ 3] = em_fin.Text

//20080522 preguntar si es con importe
ll_row = dw_list.getrow()
ls_mer = f_trim(dw_list.object.c_merdes_man[ll_row])
if ls_mer = 'N' then
	if ls_rem = 'S' then
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
end if


////20080521
//ll_row = dw_list.getrow()
//ls_dis = f_trim(dw_list.object.c_codigo_dis[ll_row])
//ls_mer = f_trim(dw_list.object.c_merdes_man[ll_row])
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
////

istr_parm.dw_dat[ 1] = dw_list
OpenWithParm( w_arch_manifiesto_imprimir, istr_parm )

end event

type cb_nuevo from uo_cbother within w_arch_manifiesto_abrir
int X=1586
int Y=960
int TabOrder=80
boolean BringToTop=true
string Text="&Nuevo"
end type

event clicked;String	ls_pal
s_parm	lstr_parm


lstr_parm.s_cad[1] = 'NEW'
lstr_parm.s_cad[2] = 'NEW'

CloseWithReturn( Parent, lstr_parm )

end event

type cb_eliminar from uo_cbother within w_arch_manifiesto_abrir
int X=1952
int Y=960
int TabOrder=30
boolean BringToTop=true
string Text="&Eliminar"
end type

event clicked;DateTime	ld_hoy, ld_emb
String	ls_man, ls_tem, ls_mer, ls_rem
long ll_rem, ll_pal

If dw_list.RowCount ( ) <= 0  Then 
	MessageBox( Title, 'El listado se encuentra vacio.', Exclamation! )
	Beep( 1)
	Return
End If

If dw_list.Object.c_activo_man[dw_list.GetRow( )] = '0' Then
	MessageBox( Title, 'El registro ya se encuentra eliminado/cancelado.' )
	dw_list.SetFocus( )
	Return
End If

ls_tem = dw_list.Object.c_codigo_tem[dw_list.GetRow( )]
ls_man = dw_list.Object.c_codigo_man[dw_list.GetRow( )]
ld_emb = dw_list.Object.d_embarque_man[ dw_list.GetRow()]

//=====Brenda: No eliminar el manifiesto si esta relacionado con una liquidacion Modulo de CxC
select isnull(count(*),0)
Into :ll_pal
From t_palet 
Where isnull(c_codigo_rlq,'') <> ''
And isnull(c_codigo_man,'') = :ls_man
using sqlca;
If f_SqlError( SqlCa, 'No se pudo leer la tabla t_manifiesto. [select]') < 0 Then 
 RollBack Using SqlCa ;
 Return
End If

If f_zero(ll_pal) > 0 Then
 MessageBox( 'Eliminar Manifiesto', 'El manifiesto a eliminar esta relacionado con un Liquidación.', Exclamation! )
 Return 0
End If

////20080607====================================================================
select c_numfac_man
into :ls_rem
from t_manifiesto
where c_codigo_man = :ls_man
and c_codigo_Tem = :ls_tem
using sqlca;
If f_SqlError( SqlCa, 'No se pudo leer la tabla t_manifiesto. [select]') < 0 Then 
	RollBack Using SqlCa ;
	Return
End If

select count(c_codigo_fac)
into :ll_rem
from cxcfacturaremision
where c_remision_far = :ls_rem
using sqlca;
If f_SqlError( SqlCa, 'No se pudo leer la tabla cxcfacturaremision. [select]') < 0 Then 
	RollBack Using SqlCa ;
	Return
End If

if ll_rem > 0 then
	messagebox(title,'No se puede eliminar el manifiesto porque ya tiene movimientos de facturación')
	return 0
else
	delete cxcfacturaremision
	where c_remision_far = :ls_rem
	using sqlca;
	If f_SqlError( SqlCa, 'No se pudo eliminar la tabla cxcfacturaremision. [select]') < 0 Then 
		RollBack Using SqlCa ;
		Return
	End If
end if
//////////====================================================================================================================
If Not gd_sys = ld_emb Then
	MessageBox( 'Eliminar Manifiesto', 'El manifiesto a eliminar tiene una fecha distinta a la del sistema.', Exclamation! )
End If

If MessageBox( 'Eliminar Manifiesto', '¿Confirma la eliminación de este manifiesto?', &
					Question!, YesNo!, 2 ) <> 1 Then
	dw_list.SetFocus( )
	Return
End If

ld_hoy = DateTime( Today() )				

If Not wf_ActualizaAcumulados( 'E' ) Then
	MessageBox( 'Eliminar Manifiesto', 'No se pudo actualizar la tabla de acumulados', StopSign! )
	RollBack Using SqlCa ;
	Return
End If

/* Se liberan los pallets del manifiesto al que estaban vinculados */
Update	t_palet
Set		c_codigo_man = '',
			c_usumod_pal = :gs_usuario,
			c_staemb_pal = '0',
			d_modifi_pal = :ld_hoy,
			c_excedente_pal='0'			
Where		c_codigo_tem = :ls_tem 
And		c_codigo_man = :ls_man 
Using		SqlCa ;

If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_palet. (c_codigo_man = "")' ) < 0 Then 
	RollBack Using SqlCa ;
	Return
End If

/* Actualiza el estado del manifiesto a eliminado = inactivo */
Update	t_manifiesto
Set		c_activo_man = '0',
			c_usumod_man = :gs_usuario,
			d_modifi_man = :ld_hoy
Where		c_codigo_tem = :ls_tem 
And		c_codigo_man = :ls_man 
Using		SqlCa ;

If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_manifiesto. (c_activo_man = "0")' ) < 0 Then 
	RollBack Using SqlCa ;
	Return
End If

Commit Using SqlCa ;

dw_list.Object.c_activo_man[dw_list.GetRow( )] = '0' 
dw_list.SetFocus( )


end event

type cb_pornumero from uo_cbother within w_arch_manifiesto_abrir
int X=1701
int Y=32
int TabOrder=30
string Text="&Por Número..."
end type

event clicked;DateTime	ld_null
String	ls_numdoc

Open( w_arch_ingresar_numero_doc )
IF gs_tipo='' then
	gs_tipo='%'
end if

ls_numdoc = f_Trim( Message.StringParm )

If ls_numdoc = '' Then Return

If Len( ls_numdoc ) <= 2 Then
	MessageBox( Title, 'Para buscar por número de documento por lo menos ' + & 
							'debe ingresar 3 caracteres consecutivos', Exclamation! )
	Return
End If

ls_numdoc = '%' + ls_numdoc + '%'

SetNull( ld_null )
dw_list.Retrieve( gs_codtem, ld_null, ld_null, ls_numdoc,gs_tipo)
dw_list.SetFocus( )


end event

