$PBExportHeader$w_arch_factura_flete.srw
forward
global type w_arch_factura_flete from wa_response
end type
type p_ind from picture within w_arch_factura_flete
end type
type dw_prn from datawindow within w_arch_factura_flete
end type
type cb_imprimir from uo_cbother within w_arch_factura_flete
end type
type cb_nuevo from uo_cbother within w_arch_factura_flete
end type
type cb_eliminar from uo_cbother within w_arch_factura_flete
end type
type cb_agregar from uo_cbother within w_arch_factura_flete
end type
type cb_guardar from commandbutton within w_arch_factura_flete
end type
end forward

global type w_arch_factura_flete from wa_response
int X=5
int Y=4
int Width=3218
int Height=1972
WindowType WindowType=main!
boolean TitleBar=true
string Title="Entrada"
string MenuName="m_principal_arch_manifiesto"
long BackColor=1090519039
boolean MinBox=true
boolean MaxBox=true
boolean VScrollBar=true
boolean Resizable=true
WindowState WindowState=maximized!
event ue_save pbm_custom01
event ue_new pbm_custom02
event ue_open pbm_custom03
event vscroll pbm_vscroll
event ue_print pbm_custom04
p_ind p_ind
dw_prn dw_prn
cb_imprimir cb_imprimir
cb_nuevo cb_nuevo
cb_eliminar cb_eliminar
cb_agregar cb_agregar
cb_guardar cb_guardar
end type
global w_arch_factura_flete w_arch_factura_flete

type variables
Boolean ib_saved = True, ib_new = True

Integer ii_height = 72 /* Alto de cada registro */

String is_cursor= '0'
end variables

forward prototypes
public function boolean wf_save ()
public function boolean wf_aceptar ()
public function integer wf_agregar ()
public function integer wf_eliminar ()
public function integer wf_new ()
public function integer wf_open ()
public function long wf_print ()
public function boolean wf_savechanges ()
public subroutine wf_enabled (boolean ab_enabled)
public subroutine wf_configurardoc ()
public function integer wf_busca_pro (string as_cod)
public function integer wf_busca_mat (string as_cod)
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

ib_saved = f_Arch_factura(  title, ib_new, dw_1, dw_list )

If Not ib_saved Then Return False

ib_new = False

MessageBox( Title, 'Factura de Flete guardada correctamente.' )


//wf_Enabled( False )
gw_frame.SetMicroHelp('Listo')


Return True
end function

public function boolean wf_aceptar ();// Va saltando de campo con el enter.
String	ls_col,ls_cod

dw_1.AcceptText( )
ls_col='c_codigo_lit'

Choose Case dw_1.GetColumnName( )
   Case 'c_codigo_lit'
		ls_cod = f_trim(dw_1.Object.c_codigo_lit[1])
		wf_busca_pro(ls_cod)
		ls_col='c_codigo_flt'
   Case 'c_codigo_flt'
		ls_col='d_fecha_flt'
	Case 'd_fecha_flt'
		ls_col='c_codref_flt'
	Case 'c_codref_flt'
		ls_col = 'n_importe_flt'
	Case 'n_importe_flt'
		ls_col = 'n_iva_flt'
	Case 'n_iva_flt'
		ls_col = 'n_retencion_flt'
	Case 'n_retencion_flt'
		ls_col = 'c_codigo_man'
	Case 'c_codigo_man'
		ls_cod = dw_1.Object.c_codigo_man[1]
		wf_busca_mat(ls_cod)
		ls_col = 'n_totalflete_man'
	Case 'n_totalflete_man'
		ls_col = 'c_codigo_flt'
	End Choose

dw_1.SetColumn(ls_col) 
dw_1.SetFocus( )

Return True
end function

public function integer wf_agregar ();
Datetime ld_fecfac, ld_fecman, ld_null
Dec{4}    ldc_can, ldc_imp, ldc_iva, ldc_ret, ldc_impman, ldc_implist, ldc_total, ldc_porc
integer   i
String	 ls_mat,ls_pro,ls_nompro, ls_cod, ls_fac, ls_fec, ls_ref
long ll_row
DataWindowChild ldwc_x

SetNull(ld_null)
ib_saved = False

dw_1.AcceptText( )
dw_1.SetFocus( )


ls_cod = f_trim(dw_1.Object.c_codigo_lit[1])
if ls_cod='' Then
	MessageBox( title, 'Debe tener un Codigo de Linea de Transporte', Exclamation! )
	dw_1.SetColumn( 'c_codigo_lit' )
	Return 0
End If

ls_fac = f_trim(dw_1.Object.c_codigo_flt[1])
if ls_fac='' Then
	MessageBox( title, 'Debe tener un Codigo de Factura', Exclamation! )
	dw_1.SetColumn( 'c_codigo_flt' )
	Return 0
End If
ld_fecfac = dw_1.Object.d_fecha_flt[1]
ls_fec = f_trim(string(ld_fecfac,'dd/mm/yyyy'))
if (ls_fec ='') or (ls_fec = '00/00/0000') Then
	MessageBox( title, 'Debe tener una Fecha para la Factura', Exclamation! )
	dw_1.SetColumn( 'd_fecha_flt' )
	Return 0
End If

ls_ref = f_trim(dw_1.Object.c_codref_flt[1])
if ls_ref ='' Then
	MessageBox( title, 'Debe tener una Referencia de Pago', Exclamation! )
	dw_1.SetColumn( 'c_codref_flt' )
	Return 0
End If

ldc_imp = f_zero(dw_1.Object.n_importe_flt[1])
if ldc_imp <=0 Then
	MessageBox( title, 'El importe debe ser mayor que cero', Exclamation! )
	dw_1.SetColumn( 'n_importe_flt' )
	Return 0
End If

ldc_iva = f_zero(dw_1.Object.n_iva_flt[1])
if ldc_iva <=0 Then
	MessageBox( title, 'El IVA debe ser mayor que cero', Exclamation! )
	dw_1.SetColumn( 'n_iva_flt' )
	Return 0
End If

ldc_ret = f_zero(dw_1.Object.n_retencion_flt[1])
if ldc_ret <0 Then
	MessageBox( title, 'La retencion NO debe ser menor que cero', Exclamation! )
	dw_1.SetColumn( 'n_retencion_flt' )
	Return 0
End If

if ldc_iva >= ldc_imp Then
	MessageBox( title, 'El IVA debe ser menor que el importe', Exclamation! )
	dw_1.SetColumn( 'n_iva_flt' )
	Return 0
End If

if ldc_ret >= ldc_imp Then
	MessageBox( title, 'La retencion debe ser menor que el importe', Exclamation! )
	dw_1.SetColumn( 'n_retencion_flt' )
	Return 0
End If

ld_fecman = dw_1.Object.d_embarque_man[1]
if ld_fecman > ld_fecfac Then
	MessageBox( title, 'La fecha de la factura No puede ser menor a la fecha del manifiesto', Exclamation! )
	dw_1.SetColumn('d_fecha_flt')
	Return 0
End If
ldc_impman = dw_1.object.n_totalflete_man[1]

ll_row = dw_list.rowcount()
if ll_row = 0 then
	if ldc_impman > ldc_imp then
		MessageBox( title, 'El importe parcial del manifiesto NO debe superar el importe total de la Factura', Exclamation! )
		dw_1.SetColumn('n_totalflete_man')
		Return 0
	end if
else
	ldc_implist = dw_list.object.sumimpo[1]
	ldc_total = ldc_implist + ldc_impman
	if ldc_total > ldc_imp then
		MessageBox( title, 'La suma de los importes parciales NO debe superar el importe total de la Factura', Exclamation! )
		dw_1.SetColumn('n_totalflete_man')
		Return 0
	end if
end if

ldc_porc = ldc_impman / ldc_imp
		
i = dw_list.InsertRow(0)

dw_list.SetRow( i )
dw_list.ScrollToRow( i )

dw_list.Object.c_codigo_man[ i] = dw_1.Object.c_codigo_man[1]
dw_list.Object.d_embarque_man[ i] = dw_1.Object.d_embarque_man[1]
dw_list.Object.c_codref_flt[ i] = dw_1.object.c_codref_flt[1]
dw_list.Object.iva[i] =  f_zero((dw_1.Object.n_iva_flt[ 1]) * (ldc_porc))
dw_list.Object.retencion[i] = f_zero((dw_1.Object.n_retencion_flt[ 1]) * (ldc_porc))
dw_list.Object.n_totalflete_man[ i] = f_zero(dw_1.Object.n_totalflete_man[ 1]) 


dw_1.Object.c_codigo_man[1] = ''
dw_1.Object.d_embarque_man[1] = ld_null
dw_1.object.n_totalflete_man[1] = 0.00

dw_1.setcolumn('c_codigo_man')

Return 1
end function

public function integer wf_eliminar ();ib_saved = False

If dw_list.RowCount( ) <= 0 Then
	Return 0
End If

dw_list.DeleteRow( 0 )

If dw_list.RowCount( ) > 0 Then
	dw_list.SetFocus( )
End If

Return 1
end function

public function integer wf_new ();
If Not wf_SaveChanges( ) Then
	Return 0
End If

ib_new = True

dw_1.DataObject = 'd_arch_factura_flete'
dw_1.Reset( )
dw_1.SetTransObject( SqlCa )

dw_list.Reset( )
dw_list.SetTransObject( SqlCa )

dw_1.InsertRow(0)
wf_Enabled( True )

dw_1.object.d_fecha_flt[1] =datetime(today())
dw_1.object.c_codigo_lit[1] = ''
dw_1.SetColumn( 'c_codigo_lit' )
dw_1.AcceptText( )


dw_1.SetFocus( )

dw_list.SetRowFocusIndicator( p_ind )
p_ind.Visible = False

Return 1
end function

public function integer wf_open ();DateTime ld_fin, ld_null
Integer	li_opc
String	ls_doc
s_parm	lstr_parm
w_arch_factura_flete	lw_win

SetNull( Message.PowerObjectParm )
SetNull(ld_null)

OpenWithParm( w_arch_documento_abrir, 'FLT' )

lstr_parm = Message.PowerObjectParm

If Not IsValid( lstr_parm ) Then Return 0

If IsNull( lstr_parm ) Then Return 0

If UpperBound( lstr_parm.s_cad[] ) = 0 Then Return 0

If f_trim(lstr_parm.s_cad[1])  = '' Then Return 0

If f_trim(lstr_parm.s_cad[2])  = '' Then Return 0

If lstr_parm.s_cad[ 1] = 'NEW' Then
	OpenSheet( lw_win, gw_frame, gi_poswin, Original! )
	lw_win.dw_1.Object.c_mensaje[1] = 'POLIZA NUEVA'
Else
	
	OpenSheet( lw_win, gw_frame, gi_poswin, Original! )
	
	lw_win.dw_1.Retrieve( lstr_parm.s_cad[1],lstr_parm.s_cad[2])
	
	if isnull(lw_win.dw_1.object.v_direcc_lit[1]) then
		lw_win.dw_1.object.v_direcc_lit[1] = 'S/d'
	end if
	
	if isnull(lw_win.dw_1.object.v_codpos_lit[1]) then
		lw_win.dw_1.object.v_codpos_lit[1] = 'S/d'
	end if
	
	if isnull(lw_win.dw_1.object.v_ciudad_lit[1]) then
		lw_win.dw_1.object.v_ciudad_lit[1] = 'S/d'
	end if
	
	if isnull(lw_win.dw_1.object.c_rfc_lit[1]) then
		lw_win.dw_1.object.c_rfc_lit[1] = 'S/d'
	end if
	
	if isnull(lw_win.dw_1.object.v_telef1_lit[1]) then
		lw_win.dw_1.object.v_telef1_lit[1] = 'S/d'
	end if
	
	if isnull(lw_win.dw_1.object.c_clavescac_lit[1]) then
		lw_win.dw_1.object.c_clavescac_lit[1] = 'S/d'
	end if
	
	lw_win.dw_1.object.c_codigo_man[1] = ''
	lw_win.dw_1.object.d_embarque_man[1]= ld_null
	lw_win.dw_1.object.n_totalflete_man[1] = 0.00


	lw_win.dw_list.Retrieve(lstr_parm.s_cad[1], lstr_parm.s_cad[2])
	
	
	
	lw_win.ib_new = False

	lw_win.wf_Enabled( True ) 

End If

Return 1
end function

public function long wf_print ();Long	ll_rows
String ls_lit, ls_fac


If Not ib_saved Then
	MessageBox( Title, 'La Factura Nro.' + f_Trim( dw_1.Object.c_codigo_flt[1] ) + &
								' no ha sido guardada.~r~nPara poder imprimir, revise/complete' + &
								' el documento y haga clic en guardar y reintente.', Exclamation! )
	Return -1
End If

//ld_fecha = (dw_1.Object.d_fecha_pol[ 1])

ls_lit = f_Trim(dw_1.Object.c_codigo_lit[1])
ls_fac = f_Trim(dw_1.Object.c_codigo_flt[1])

dw_prn.DataObject = 'd_rpt_facturalt'
dw_prn.SetTransObject( SqlCa )
ll_rows = dw_prn.Retrieve(ls_lit, ls_fac)
f_Preview( dw_prn )


Return ll_rows
end function

public function boolean wf_savechanges ();Integer	li_opc
String	ls_doc


If Not ib_saved Then 
	ls_doc = f_Trim( dw_1.Object.c_codigo_flt[1] )
	If ls_doc <> '' Then
		ls_doc = 'Nro ' + ls_doc
	End If
	li_opc = MessageBox( Title, '¿Desea guardar los cambios efectuados en la ' + &
								'Factura ' + ls_doc + '?', Question!, YesNoCancel! )
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
	dw_1.Object.DataWindow.ReadOnly = 'Yes'
	dw_list.Object.DataWindow.ReadOnly = 'Yes'
Else
	dw_1.Object.DataWindow.ReadOnly = 'No'
	dw_list.Object.DataWindow.ReadOnly = 'No'
End If

cb_agregar.Enabled = ab_enabled
//cb_modificar.Enabled = ab_enabled
cb_eliminar.Enabled = ab_enabled
cb_guardar.Enabled = ab_enabled
cb_nuevo.Enabled = ab_enabled


If Not ab_enabled Then
	ib_new = False
	ib_saved = True
End If
end subroutine

public subroutine wf_configurardoc ();This.Title = 'Facturas de Fletes'
This.WindowState = Maximized!

p_ind.Visible = False
dw_prn.Visible = False

cb_aceptar.Width = 0
cb_aceptar.Height = 0

dw_list.SetRowFocusIndicator( p_ind )
wf_New( )
Show( )
end subroutine

public function integer wf_busca_pro (string as_cod);/* Linea de transporte */
String	ls_parm,ls_cod, ls_nom, ls_dir, ls_cp, ls_cd, ls_rfc, ls_tel, ls_cve

ls_cod = f_Trim( as_cod )
If ls_cod = '' Then
	OpenWithParm( w_mant_buscar_x_nombre, 'LIT' )
	
	ls_parm = Message.StringParm
	
	ls_parm = f_Trim( ls_parm )
	
	If Not ls_parm = '' Then
		ls_cod = ls_parm
		dw_1.Object.c_codigo_lit[1] = ls_parm
      
		Select v_nombre_lit, v_direcc_lit, v_codpos_lit, v_ciudad_lit, c_rfc_lit, v_telef1_lit, c_clavescac_lit
		Into :ls_nom, :ls_dir, :ls_cp, :ls_cd, :ls_rfc, :ls_tel, :ls_cve
		From	t_linea_transporte (Nolock)
		Where		c_codigo_lit = :ls_cod
		Using		SqlCa ;

		If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_linea_transporte' ) = -1 Then
			Return 0
		End If
	else
		ls_cod = ''
		ls_nom = ''
		ls_dir = ''
		ls_cp = ''
		ls_cd = ''
		ls_rfc = ''
		ls_tel = ''
		ls_cve = ''
	End If
Else
	as_cod = f_Trim( as_cod )
	ls_cod =  right('00' + as_cod,2)
	
	Select v_nombre_lit
	Into :ls_nom
	From	t_linea_transporte (Nolock)
	Where		c_codigo_lit = :ls_cod
	Using		SqlCa ;

	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_linea_transporte' ) = -1 Then
		Return 0
	End If
	
	
	If (f_trim(ls_nom)) = '' Then
		MessageBox( Title, 'Código de Linea de Transporte NO encontrado.', Exclamation! )
		return 0
	End If
	
	Select v_direcc_lit, v_codpos_lit, v_ciudad_lit, c_rfc_lit, v_telef1_lit, c_clavescac_lit
	Into :ls_dir, :ls_cp, :ls_cd, :ls_rfc, :ls_tel, :ls_cve
	From	t_linea_transporte (Nolock)
	Where		c_codigo_lit = :ls_cod
	Using		SqlCa ;

	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_linea_transporte' ) = -1 Then
		Return 0
	end if
End If

	if isnull(ls_nom) then
	ls_nom = 'S/d'
	end if
	if isnull(ls_dir) then
	ls_dir = 'S/d'
	end if
	if isnull(ls_cp) then
	ls_cp = 'S/d'
	end if
	if isnull(ls_cd) then
	ls_cd = 'S/d'
	end if
	if isnull(ls_rfc) then
	ls_rfc = 'S/d'
	end if
	if isnull(ls_tel) then
	ls_tel = 'S/d'
	end if
	if isnull(ls_cve) then
	ls_cve = 'S/d'
	end if

dw_1.object.c_codigo_lit[1] = ls_cod
dw_1.Object.v_nombre_lit[1] = ls_nom
dw_1.Object.v_direcc_lit[1] = ls_dir
dw_1.Object.v_codpos_lit[1] = ls_cp
dw_1.Object.v_ciudad_lit[1] = ls_cd
dw_1.Object.c_rfc_lit[1] = ls_rfc
dw_1.Object.v_telef1_lit[1] = ls_tel
dw_1.Object.c_clavescac_lit[1] = ls_cve

ib_saved = False

Return 1
end function

public function integer wf_busca_mat (string as_cod);/* Manifiesto */
String	ls_parm,ls_cod, ls_man, ls_lt, ls_lit
Datetime ld_fecman

ls_cod = f_trim(as_cod)
ls_lt = dw_1.object .c_codigo_lit[1]

If ls_cod = '' Then
	OpenWithParm( w_mant_buscar_x_nombre,'MAN')
	ls_parm = Message.StringParm
	
	ls_parm = f_Trim( ls_parm )
	
	If Not ls_parm = '' Then
		ls_cod = ls_parm
		
		Select c_codigo_lit,d_embarque_man
		Into :ls_lit, :ld_fecman
		From	t_manifiesto (Nolock)
		Where		c_codigo_man = :ls_cod
		Using		SqlCa ;

		If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_manifiesto' ) = -1 Then
			Return 0
		End If
		
		
		if ls_lt <> ls_lit then
			messagebox(title,'el manifiesto: '+ls_cod+' tiene registrada la linea de transporte: '+ls_lit+' la cual no corresponde con la seleccionada',exclamation!)
			dw_1.Object.c_codigo_man[1] = ''
			return 0	
		else
			dw_1.Object.c_codigo_man[1] = ls_cod
			dw_1.Object.d_embarque_man[1] = ld_fecman
		end if		
	End If
Else
	
	Select c_codigo_man, c_codigo_lit, d_embarque_man
	Into :ls_man, :ls_lit, :ld_fecman
	From	t_manifiesto (Nolock)
	Where	c_codigo_man = :ls_cod
	Using	SqlCa ;

	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_manifiesto' ) = -1 Then
		Return 0
	End If
	
	
	If (f_trim(ls_man)) = '' Then
		MessageBox( Title, 'Código de Manifiesto NO encontrado.', Exclamation! )
		return 0
	End If
	
	if ls_lt <> ls_lit then
		messagebox(title,'el manifiesto: '+ls_cod+' tiene registrada la linea de transporte: '+ls_lit+' la cual no corresponde con la seleccionada',exclamation!)
		dw_1.Object.c_codigo_man[1] = ''
		return 0	
	else
		dw_1.Object.c_codigo_man[1] = ls_man
		dw_1.Object.d_embarque_man[1] = ld_fecman
	end if	
End If



ib_saved = False

Return 1
end function

on w_arch_factura_flete.create
int iCurrent
call super::create
if this.MenuName = "m_principal_arch_manifiesto" then this.MenuID = create m_principal_arch_manifiesto
this.p_ind=create p_ind
this.dw_prn=create dw_prn
this.cb_imprimir=create cb_imprimir
this.cb_nuevo=create cb_nuevo
this.cb_eliminar=create cb_eliminar
this.cb_agregar=create cb_agregar
this.cb_guardar=create cb_guardar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_ind
this.Control[iCurrent+2]=this.dw_prn
this.Control[iCurrent+3]=this.cb_imprimir
this.Control[iCurrent+4]=this.cb_nuevo
this.Control[iCurrent+5]=this.cb_eliminar
this.Control[iCurrent+6]=this.cb_agregar
this.Control[iCurrent+7]=this.cb_guardar
end on

on w_arch_factura_flete.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_ind)
destroy(this.dw_prn)
destroy(this.cb_imprimir)
destroy(this.cb_nuevo)
destroy(this.cb_eliminar)
destroy(this.cb_agregar)
destroy(this.cb_guardar)
end on

event open;call super::open;String ls_protect


is_cursor='0'
cb_guardar.visible= true
cb_cancelar.visible = true

wf_New( )
wf_ConfigurarDoc( )

dw_1.SetFocus( )

// ls_protect = ProfileString ( gs_ini, "System", "protect_det", 	"0") 
// dw_1.Modify( 'v_nombre_pro.Protect = "' + ls_protect + '"' )

end event

event resize;

dw_1.X = (newwidth - dw_1.Width ) / 2
dw_list.X = (newwidth - dw_list.Width ) / 2



cb_eliminar.x = dw_1.x + dw_1.Width - cb_eliminar.Width
cb_agregar.y = cb_eliminar.y
cb_agregar.x = cb_eliminar.x - cb_agregar.Width


cb_cancelar.x = dw_list.x + dw_list.Width - cb_cancelar.Width  - 40

cb_nuevo.x = dw_list.x + dw_list.Width - cb_nuevo.Width  - 40 - cb_cancelar.Width - 40

cb_imprimir.x = dw_list.x + dw_list.Width - cb_imprimir.Width  - 40 - cb_nuevo.Width - 40 - cb_cancelar.Width - 40

cb_guardar.x = dw_list.x + dw_list.Width - cb_guardar.Width  - 40 - cb_imprimir.Width - 40 - cb_nuevo.Width - 40 - cb_cancelar.Width - 40


end event

event closequery;
If wf_SaveChanges( ) Then
	Return 0
Else
	Return 1
End If
end event

type dw_list from wa_response`dw_list within w_arch_factura_flete
int X=274
int Y=892
int Width=2651
int Height=732
string DataObject="d_arch_factura_flete_list"
end type

event dw_list::rowfocuschanged;call super::rowfocuschanged;This.SelectRow( 0, False )
end event

event dw_list::clicked;If row > 0 Then 
	This.SetRow( row )
	gw_frame.SetMicroHelp( "Fila: " + String(row) + "/" + String(RowCount()))
End If
end event

event dw_list::retrieveend;call super::retrieveend;This.SelectRow( 0, False )
end event

event dw_list::getfocus;cb_aceptar.Default = False
end event

event dw_list::editchanged;ib_saved = False

end event

type dw_1 from wa_response`dw_1 within w_arch_factura_flete
event key pbm_dwnkey
int X=78
int Y=56
int Width=2967
int Height=764
string DataObject="d_arch_factura_flete"
end type

event dw_1::itemchanged;call super::itemchanged;String ls_cod
decimal {2} ldc_val
ib_saved = False

If dwo.name='c_codigo_lit' Then
	ls_cod = f_trim(data)
	wf_busca_pro(ls_cod)//cambiar para q busque linea de transporte
End If
If dwo.name='c_codigo_man' Then
	ls_cod = f_trim(data)
	wf_busca_pro(ls_cod)//cambiar para q busque manifiestos
End If

if dwo.name= 'n_importe_flt' then
	ls_cod = f_trim (data)
	ldc_val = f_zero(dec (ls_cod))
	dw_1.object.n_iva_flt[1] = (ldc_val)*(15/100)
	dw_1.object.n_retencion_flt[1] = (ldc_val)*(4/100)
End if



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

event dw_1::buttonclicked;If dwo.Name = 'cb_lt' Then
  wf_Busca_pro('')// cambiar para que busque lineas de transporte
End If

If dwo.Name = 'cb_man' Then
  wf_Busca_mat('')// cambiar para que busque manifiestos
End If


dw_1.AcceptText( )
dw_1.SetRedraw( True )

end event

event dw_1::getfocus;cb_aceptar.Default = True

end event

event dw_1::constructor;call super::constructor;wf_aceptar()
end event

type cb_cancelar from wa_response`cb_cancelar within w_arch_factura_flete
int X=2363
int Y=1640
int Width=549
int Height=80
int TabOrder=80
boolean Cancel=false
end type

event cb_cancelar::clicked;call super::clicked;//Close(Parent)
end event

type cb_aceptar from wa_response`cb_aceptar within w_arch_factura_flete
int X=27
int Y=324
int Width=50
int Height=100
int TabOrder=0
boolean Enabled=true
string Text=""
end type

event cb_aceptar::clicked;wf_Aceptar( )
end event

type p_ind from picture within w_arch_factura_flete
int X=50
int Y=160
int Width=27
int Height=44
boolean Visible=false
boolean BringToTop=true
string PictureName="ind.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type dw_prn from datawindow within w_arch_factura_flete
int X=18
int Y=2136
int Width=224
int Height=132
boolean Border=false
boolean LiveScroll=true
end type

event constructor;SetTransObject( SqlCa )
end event

type cb_imprimir from uo_cbother within w_arch_factura_flete
int X=1737
int Y=1640
int Width=549
int Height=80
int TabOrder=70
boolean BringToTop=true
string Text="Imprimir"
end type

event clicked;wf_Print( )
end event

type cb_nuevo from uo_cbother within w_arch_factura_flete
int X=1029
int Y=1640
int Width=549
int Height=80
int TabOrder=60
boolean BringToTop=true
string Text="Nuevo"
end type

event clicked;wf_New( )
end event

type cb_eliminar from uo_cbother within w_arch_factura_flete
int X=2459
int Y=796
int Width=549
int Height=80
int TabOrder=30
boolean BringToTop=true
string Text="Eliminar de la Lista"
end type

event clicked;ib_saved = False
wf_Eliminar( )

end event

type cb_agregar from uo_cbother within w_arch_factura_flete
int X=1902
int Y=796
int Width=549
int Height=80
int TabOrder=20
boolean BringToTop=true
string Text="Agregar a la  Lista"
end type

event clicked;ib_saved = False
wf_Agregar( )

end event

type cb_guardar from commandbutton within w_arch_factura_flete
int X=261
int Y=1640
int Width=549
int Height=80
int TabOrder=50
boolean BringToTop=true
string Text="Guardar"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_Save( )
end event

