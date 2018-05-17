$PBExportHeader$w_arch_controlcorteacarreo.srw
forward
global type w_arch_controlcorteacarreo from wa_response
end type
type p_ind from picture within w_arch_controlcorteacarreo
end type
type dw_prn from datawindow within w_arch_controlcorteacarreo
end type
type cb_imprimir from uo_cbother within w_arch_controlcorteacarreo
end type
type cb_nuevo from uo_cbother within w_arch_controlcorteacarreo
end type
type cb_guardar from uo_cbother within w_arch_controlcorteacarreo
end type
type cb_eliminar from uo_cbother within w_arch_controlcorteacarreo
end type
type cb_agregar from uo_cbother within w_arch_controlcorteacarreo
end type
end forward

global type w_arch_controlcorteacarreo from wa_response
integer x = 5
integer y = 4
integer width = 3200
integer height = 2092
string title = "Manifiesto"
string menuname = "m_principal_arch_manifiesto"
boolean controlmenu = false
boolean vscrollbar = true
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
cb_agregar cb_agregar
end type
global w_arch_controlcorteacarreo w_arch_controlcorteacarreo

type variables
Boolean ib_saved = True, ib_new = True

Integer ii_height = 72 /* Alto de cada registro */
end variables

forward prototypes
public function boolean wf_save ()
public function boolean wf_aceptar ()
public function integer wf_agregar ()
public function integer wf_eliminar ()
public function integer wf_new ()
public function integer wf_open ()
public function long wf_print ()
public function integer wf_setimporte ()
public function long wf_printfact ()
public function boolean wf_savechanges ()
public subroutine wf_enabled (boolean ab_enabled)
public function boolean wf_codigos ()
public function integer wf_buscar_lote (string as_cod)
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

public function boolean wf_save ();String	ls_doc

If ib_saved   Then 
	Beep(1)
	SetMicroHelp( 'Documento no modificado' )
	Return False
End If

ib_saved = f_Arch_corteacarreo(  title, ib_new, dw_1, dw_list )

If Not ib_saved Then Return False

ib_new = False
ls_doc = f_Trim( dw_1.Object.c_codigo_cot[1] )


MessageBox( Title, 'Captura No. ' + ls_doc + ' guardado correctamente.' )


wf_Enabled( True )
gw_frame.SetMicroHelp( 'Listo' )


Return True
end function

public function boolean wf_aceptar ();String	ls_col,ls_lug,ls_desc

dw_1.AcceptText( )
Choose Case dw_1.GetColumnName( )
	Case 'c_codigo_cot' 
		ls_col = 'c_codigo_lot'
	Case 'c_codigo_lot' 
		ls_col = 'v_tinacarro_cot'
	Case 'v_tinacarro_cot'
		ls_col = 'v_tabla_cot'
	Case 'v_tabla_cot' 
		ls_col = 'n_cajascorte_cot'
	Case 'n_cajascorte_cot' 
		ls_col = 'n_peso_cot'
	Case 'n_peso_cot' 
		ls_col = 'd_fechacorte_cot'
	Case 'd_fechacorte_cot'
		ls_col = 'c_horacorte_cot'
	Case 'c_horacorte_cot'
		ls_col = 'c_horasalcampo_cot'
	Case 'c_horasalcampo_cot'
		ls_col = 'd_recempaque_cot'
	Case 'd_recempaque_cot'
		ls_col = 'c_horarecep_cot'	
	Case 'c_horarecep_cot'
		ls_col = 'd_procempaque_cot'	
	Case 'd_procempaque_cot'
		ls_col = 'c_status_cot'	
	Case 'c_status_cot'
		ls_col = 'v_nommayo_cot'	
	Case 'v_nommayo_cot'
		ls_col = 'v_nomoper_cot'
	Case 'v_nomoper_cot'
		ls_col = 'v_nomrecep_cot'
	Case 'v_nomrecep_cot'
		ls_col = 'v_nomrecep_cot'
End Choose

dw_1.SetColumn( ls_col )
dw_1.SetFocus( )
Return True
end function

public function integer wf_agregar ();
Return 1
end function

public function integer wf_eliminar ();Long		ll_find, i, j
String	ls_pal, ls_man,ls_pesm
dec{4} ldc_peso

ib_saved = False

If dw_list.RowCount( ) <= 0 Then
	Return 0
End If


Return 1
end function

public function integer wf_new ();uo_DataStore	lds_1 

If Not wf_SaveChanges( ) Then
	Return 0
End If

ib_new = True

dw_1.DataObject = 'd_arch_corteyacarreo'
dw_1.Reset( )
dw_1.SetTransObject( SqlCa )

dw_list.Reset( )
dw_list.SetTransObject( SqlCa )

dw_1.InsertRow(0)
wf_Enabled( True )

dw_1.SetColumn( 'c_codigo_cot' )
dw_1.AcceptText( )

dw_1.SetFocus( )

dw_list.SetRowFocusIndicator( p_ind )
p_ind.Visible = False

Return 1
end function

public function integer wf_open ();Boolean	lb_cont = True
Dec {4}	ldc_desct, ldc_total
DateTime ld_fin, ld_ini, ld_pol,ld_fecha
Integer	li_opc
String	ls_doc, ls_auts,ls_ejercicio, ls_sem
s_parm	lstr_parm
w_arch_controlcorteacarreo	lw_win

SetNull( Message.PowerObjectParm )

OpenWithParm( w_arch_documento_abrir, 'COR' )
lstr_parm = Message.PowerObjectParm

If Not IsValid( lstr_parm ) Then Return 0

If IsNull( lstr_parm ) Then Return 0

//If UpperBound( lstr_parm.s_cad[1] ) = '' Then Return 0

If lstr_parm.s_cad[ 1] = 'NEW' Then
	OpenSheet( lw_win, gw_frame, gi_poswin, Original! )
Else
	OpenSheet( lw_win, gw_frame, gi_poswin, Original! )
	lw_win.dw_1.Retrieve( lstr_parm.s_cad[ 1] )
	lw_win.ib_new = False
End If

Return 1
end function

public function long wf_print ();Long	ll_rows,li_opc
string ls_mer,ls_cot

ls_cot =f_Trim( dw_1.Object.c_codigo_cot[1] ) 
If Not ib_saved Then
	MessageBox( Title, 'El Nro.' + f_Trim( dw_1.Object.c_codigo_cot[1] ) + &
								' no ha sido guardado.~r~nPara poder imprimir, revise/complete' + &
								' el documento y haga clic en guardar y reintente.', Exclamation! )
	Return -1
End If

dw_prn.DataObject = 'd_rpt_corteyacarreo_lleno'
dw_prn.SetTransObject( SqlCa )
ll_rows = dw_prn.Retrieve(ls_cot)
f_Preview( dw_prn )


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
	ls_man = f_Trim( dw_1.Object.c_codigo_cot[1] )
	If ls_man <> '' Then
		ls_man = 'Nro ' + ls_man
	End If
	li_opc = MessageBox( Title, '¿Desea guardar los cambios efectuados en el ' + &
								'Documento ' + ls_man + '?', Question!, YesNoCancel! )
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
If Not ab_enabled Then
	ib_new = False
	ib_saved = True
End If
end subroutine

public function boolean wf_codigos ();string ls_cod


ls_cod= f_trim(dw_1.Object.c_codigo_cot[1])
if ls_cod <> '' then 
	dw_1.Object.c_codigo_cot[1]= Trim(Right( '0000000000' + Trim(dw_1.Object.c_codigo_cot[1]),10))
end if

dw_1.AcceptText( )

Return true
end function

public function integer wf_buscar_lote (string as_cod);string ls_cul
	
Select	l.c_codigo_cul
Into		:ls_cul
From		t_lote l(nolock),
			t_cultivo c (nolock)			
Where		l.c_codigo_lot = :as_cod
and 		l.c_codigo_cul=c.c_codigo_cul
Using		SqlCa ;
If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla cosLote' ) = -1 Then
	Return 2
End If
if ls_cul <> '' then
	dw_1.object.c_codigo_cul[1]=ls_cul
else
	MessageBox( Title, 'Código de cultivo no existe.', Exclamation! )
	dw_1.Object.c_codigo_cul[ 1] = ''
End If	

return 1
end function

on w_arch_controlcorteacarreo.create
int iCurrent
call super::create
if this.MenuName = "m_principal_arch_manifiesto" then this.MenuID = create m_principal_arch_manifiesto
this.p_ind=create p_ind
this.dw_prn=create dw_prn
this.cb_imprimir=create cb_imprimir
this.cb_nuevo=create cb_nuevo
this.cb_guardar=create cb_guardar
this.cb_eliminar=create cb_eliminar
this.cb_agregar=create cb_agregar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_ind
this.Control[iCurrent+2]=this.dw_prn
this.Control[iCurrent+3]=this.cb_imprimir
this.Control[iCurrent+4]=this.cb_nuevo
this.Control[iCurrent+5]=this.cb_guardar
this.Control[iCurrent+6]=this.cb_eliminar
this.Control[iCurrent+7]=this.cb_agregar
end on

on w_arch_controlcorteacarreo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_ind)
destroy(this.dw_prn)
destroy(this.cb_imprimir)
destroy(this.cb_nuevo)
destroy(this.cb_guardar)
destroy(this.cb_eliminar)
destroy(this.cb_agregar)
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


//
cb_agregar.x = ((newwidth - cb_agregar.Width ) / 2) -200
//cb_agregar.y = dw_1.height 

//
cb_guardar.x = ((newwidth - cb_guardar.Width ) / 2) -200
//cb_guardar.y = cb_agregar.y + cb_guardar.height + 30

cb_nuevo.x = cb_guardar.x + cb_nuevo.Width + 40
cb_nuevo.y = cb_guardar.y

cb_imprimir.x = cb_nuevo.x + cb_nuevo.Width + 40
cb_imprimir.y = cb_guardar.y

cb_cancelar.x = cb_imprimir.x + cb_imprimir.Width + 40
cb_cancelar.y = cb_guardar.y
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

type dw_list from wa_response`dw_list within w_arch_controlcorteacarreo
boolean visible = false
integer x = 256
integer y = 2664
integer width = 2825
integer height = 1120
integer taborder = 90
string dataobject = "d_arch_manifiesto_det"
boolean border = false
boolean hsplitscroll = false
borderstyle borderstyle = stylebox!
end type

event dw_list::rowfocuschanged;call super::rowfocuschanged;//This.SelectRow( 0, False )


end event

event dw_list::retrieveend;call super::retrieveend;This.SelectRow( 0, False )
end event

type dw_1 from wa_response`dw_1 within w_arch_controlcorteacarreo
integer x = 87
integer y = 52
integer width = 2866
integer height = 1572
string dataobject = "d_arch_corteyacarreo"
end type

event dw_1::itemchanged;call super::itemchanged;Dec{2}	ldc_imp, ldc_iva
Long		i
String   ls_desc,ls_lug
ib_saved = False
dw_1.AcceptText( )


Choose Case dwo.name
	Case 'c_codigo_lot'
		wf_buscar_lote(data)

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

event dw_1::itemfocuschanged;wf_codigos()
end event

type cb_cancelar from wa_response`cb_cancelar within w_arch_controlcorteacarreo
integer x = 2386
integer y = 1692
integer width = 462
integer height = 80
integer taborder = 80
boolean cancel = false
end type

type cb_aceptar from wa_response`cb_aceptar within w_arch_controlcorteacarreo
integer x = 0
integer y = 312
integer width = 46
integer height = 36
integer taborder = 70
boolean enabled = true
string text = ""
end type

event cb_aceptar::clicked;wf_Aceptar( )
end event

type p_ind from picture within w_arch_controlcorteacarreo
integer x = 55
integer y = 236
integer width = 27
integer height = 44
boolean bringtotop = true
boolean originalsize = true
string picturename = "ind.bmp"
boolean focusrectangle = false
end type

type dw_prn from datawindow within w_arch_controlcorteacarreo
integer width = 224
integer height = 132
string dataobject = "d_rpt_manifiesto_gral"
boolean border = false
boolean livescroll = true
end type

event constructor;SetTransObject( SqlCa )
end event

type cb_imprimir from uo_cbother within w_arch_controlcorteacarreo
integer x = 1861
integer y = 1688
integer width = 462
integer height = 80
integer taborder = 60
boolean bringtotop = true
string text = "&Imprimir"
end type

event clicked;wf_Print( )
end event

type cb_nuevo from uo_cbother within w_arch_controlcorteacarreo
integer x = 1353
integer y = 1688
integer width = 462
integer height = 80
integer taborder = 50
boolean bringtotop = true
string text = "&Nuevo"
end type

event clicked;wf_New( )
end event

type cb_guardar from uo_cbother within w_arch_controlcorteacarreo
integer x = 850
integer y = 1688
integer width = 462
integer height = 80
integer taborder = 40
boolean bringtotop = true
string text = "&Guardar"
end type

event clicked;
wf_Save( )

end event

type cb_eliminar from uo_cbother within w_arch_controlcorteacarreo
boolean visible = false
integer x = 2249
integer y = 2568
integer width = 549
integer height = 80
integer taborder = 30
boolean bringtotop = true
string text = "&Eliminar Seleccionado"
end type

event clicked;ib_saved = False
wf_Eliminar( )
end event

type cb_agregar from uo_cbother within w_arch_controlcorteacarreo
boolean visible = false
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

