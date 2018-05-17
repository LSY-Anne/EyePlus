$PBExportHeader$wa_mant.srw
$PBExportComments$Ancestro, Ventana de Relacion
forward
global type wa_mant from window
end type
type dw_prn from datawindow within wa_mant
end type
type cb_recuperar from uo_cbother within wa_mant
end type
type cb_modificar from uo_cbaceptar within wa_mant
end type
type cb_eliminar from uo_cbother within wa_mant
end type
type cb_adicionar from uo_cbother within wa_mant
end type
type cb_cerrar from uo_cbcancelar within wa_mant
end type
type cb_autorizar from uo_cbother within wa_mant
end type
type dw_1 from uo_dw_list within wa_mant
end type
end forward

global type wa_mant from window
integer x = 1056
integer y = 484
integer width = 2569
integer height = 1184
boolean titlebar = true
string menuname = "m_principal_mant"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event constructor pbm_constructor
event ue_save pbm_custom01
event ue_print pbm_custom02
event ue_adicionar pbm_custom03
event ue_modificar pbm_custom04
event ue_eliminar pbm_custom05
event ue_recuperar pbm_custom06
event ue_buscar pbm_custom07
event ue_zoom pbm_custom08
event ue_filter pbm_custom09
dw_prn dw_prn
cb_recuperar cb_recuperar
cb_modificar cb_modificar
cb_eliminar cb_eliminar
cb_adicionar cb_adicionar
cb_cerrar cb_cerrar
cb_autorizar cb_autorizar
dw_1 dw_1
end type
global wa_mant wa_mant

type variables
s_parm istr_parm

// Boolean variable to stop recursion
Boolean	ib_exec = True, ib_activos = True, ib_retxtemp=False

// String variable para controles de AAL
String	is_aal, is_opc_man, is_opc_aut, is_ts
end variables

forward prototypes
public function boolean wf_modificar ()
public function boolean wf_eliminar ()
public function boolean wf_insertar ()
public function boolean wf_mant ()
public function boolean wf_autorizar ()
public function boolean wf_recuperar ()
public function boolean wf_checkaal (boolean ab_exec)
public function long wf_retrieve ()
public function long wf_print ()
public function boolean wf_buscar ()
public function integer wf_zoom ()
public function long wf_filter (boolean ab_filter)
public function long wf_retdata ()
end prototypes

event ue_save;dw_1.SaveAs ( )
end event

event ue_print;wf_Print( )
end event

event ue_adicionar;If wf_Insertar( ) Then
	wf_Mant( )
End If
end event

event ue_modificar;If wf_Modificar( ) Then
	wf_Mant( )
End If
end event

event ue_eliminar;If wf_Eliminar( ) Then
	wf_Mant( )
End If

end event

event ue_recuperar;If wf_Recuperar( ) Then
	wf_Mant( )
End If

end event

event ue_buscar;wf_Buscar( ) 

end event

event ue_zoom;wf_Zoom( ) 
end event

event ue_filter;wf_Filter( ib_activos )
If ib_activos Then 
	ib_activos = False
Else
	ib_activos = True
End If
end event

public function boolean wf_modificar ();Long		ll_row
String	ls_acc


ll_row = dw_1.GetRow( )

If dw_1.RowCount( ) <= 0 Then
	MessageBox( Title, 'No existen registros para modificar.' , Exclamation! )
	Return False
End If

istr_parm.s_cad[1] = 'M'
istr_parm.s_cad[2] = dw_1.Object.c_codigo[ll_row]
istr_parm.n_num[1] = ll_row

/* Control de la accion previa */
ls_acc = f_Trim( dw_1.Object.c_activo[ll_row] ) 
If ls_acc <> '1' Then
	MessageBox( Title, 'Registro se encuentra eliminado.', Exclamation! )
	Return False
End If

Enabled = False
Return True
end function

public function boolean wf_eliminar ();Long		ll_row
String	ls_acc

ll_row = dw_1.GetRow( )

If dw_1.RowCount( ) <= 0 Then
	MessageBox( Title, 'No existen registros para eliminar.' , Exclamation! )
	Return False
End If

istr_parm.s_cad[1] = 'E'
istr_parm.s_cad[2] = dw_1.Object.c_codigo[ll_row]
istr_parm.n_num[1] = ll_row

/* Control de la accion previa */
ls_acc = f_Trim( dw_1.Object.c_activo[ll_row] ) 
If ls_acc <> '1' Then
	MessageBox( Title, 'Registro ya se encuentra eliminado.', Exclamation! )
	Return False
End If

Enabled = False
Return True
end function

public function boolean wf_insertar ();
istr_parm.s_cad[1] = 'I'
istr_parm.s_cad[2] = ''
istr_parm.n_num[1] = dw_1.RowCount() + 1

Enabled = False

Return True
end function

public function boolean wf_mant ();Return True
end function

public function boolean wf_autorizar ();Long	ll_row

ll_row = dw_1.GetRow( )

If dw_1.RowCount( ) <= 0 Then
	MessageBox( Title, 'No existen registros para modificar.' , Exclamation! )
	Return False
End If

istr_parm.s_cad[1] = 'A'
istr_parm.s_cad[2] = dw_1.Object.c_codigo[ll_row]
istr_parm.n_num[1] = ll_row

If f_Trim( dw_1.Object.status[ll_row] ) = 'A' Then
	MessageBox( Title, 'Registro ya se encuentra autorizado.', Exclamation! )
	Return False
End If
If f_Trim( dw_1.Object.maker[ll_row] ) = gs_usuario Then
	MessageBox( Title, 'El maker no puede ser a la vez checker.', Exclamation! )
	Return False
End If

Enabled = False
Return True
end function

public function boolean wf_recuperar ();Long		ll_row
String	ls_acc, ls_msg


ll_row = dw_1.GetRow( )

If dw_1.RowCount( ) <= 0 Then
	MessageBox( Title, 'No existen registros para modificar.' , Exclamation! )
	Return False
End If

istr_parm.s_cad[1] = 'R'
istr_parm.s_cad[2] = dw_1.Object.c_codigo[ll_row]
istr_parm.n_num[1] = ll_row

/* Control de la accion previa */
ls_acc = f_Trim( dw_1.Object.c_activo[ll_row] ) 
If ls_acc = '1' Then
	MessageBox( Title, 'Registro no se encuentra eliminado.', Exclamation! )
	Return False
End If

Enabled = False
Return True
end function

public function boolean wf_checkaal (boolean ab_exec);/*s_parm	lstr_parm

If Not ab_exec Then /* Si no se desea la ejecucion del modulo de seguridad */
	is_ts = ''
	Return True
End If

/* Esta estructura controla los accesos para el AAL */
lstr_parm = Message.PowerObjectParm

If Not IsValid( lstr_parm ) Then Return False

is_aal = lstr_parm.s_cad[1]
is_opc_man = lstr_parm.s_cad[2]
is_opc_aut = lstr_parm.s_cad[3]

If Not f_F2A( is_aal, is_ts ) Then
	Return False
End If
*/
Return True
end function

public function long wf_retrieve ();//
////If Not ib_retxtemp Then
////	dw_1.Retrieve( )
////Else
//	dw_1.Retrieve( gs_codtem )
////End If
//
//If dw_1.RowCount( ) > 0 Then
//	dw_1.SetFocus( )
//Else
//	cb_adicionar.SetFocus( )
//End If
//
//istr_parm.dw_dat[1] = dw_1
//istr_parm.w_win[1] = This
//
//If ib_activos Then
//	If f_GetParmValue( '24' ) <> 'S' Then
//		dw_1.SetFilter( 'c_activo = "1"' )
//		dw_1.Filter( )
//	End If
//Else
//	dw_1.SetFilter( '' )
//	dw_1.Filter( )
//End If

Return dw_1.RowCount( )
end function

public function long wf_print ();Long	ll_rows


//If Not ib_retxtemp Then
//	ll_rows = dw_prn.Retrieve(  )
//Else
//	ll_rows = dw_prn.Retrieve( gs_codtem )
//End If

f_Preview( dw_prn )

Return ll_rows
end function

public function boolean wf_buscar ();Long		ll_row
String	ls_acc, ls_msg


ll_row = dw_1.GetRow( )

If dw_1.RowCount( ) <= 0 Then
	MessageBox( Title, 'No existen registros para modificar.' , Exclamation! )
	Return False
End If

Open( w_mant_buscar )

Return True
end function

public function integer wf_zoom ();String	ls_zoom

Open(w_zoom)
ls_zoom = Message.StringParm

If ls_zoom = "" Or IsNull(ls_zoom ) Then
	Return 0
End If

dw_1.Object.Datawindow.Zoom = ls_zoom

Return 1
end function

public function long wf_filter (boolean ab_filter);ib_activos = ab_filter

If ib_activos Then
	//If f_GetParmValue( '24' ) <> 'S' Then
		dw_1.SetFilter( 'c_activo = "1"' )
		dw_1.Filter( )
	//End If
Else
	dw_1.SetFilter( '' )
	dw_1.Filter( )
	dw_1.SetSort( 'c_codigo A' )
	dw_1.Sort( )
End If



Return dw_1.RowCount( )
end function

public function long wf_retdata ();Long	ll_rows

//If Not ib_retxtemp Then
//	ll_rows = dw_1.Retrieve( )
//Else
//	ll_rows = dw_1.Retrieve( gs_codtem )
//End If

Return ll_rows
end function

event open;String ls_c1, ls_c2, ls_fmt


//ls_c1 = String( f_Color( 'rojo' ) )
//ls_c2 = String( f_Color( 'verde' ) )

//dw_1.Modify( "c_activo.Color = '0~tIf ( c_activo = ~~'0~~', " + ls_c1 + ', '+ ls_c2 +")'" )
//
//
//ls_fmt = "c_activo.format = '[general]~tIf( c_activo = ~~'0~~', ~~'û~~', ~~'ü~~' )'" 
//dw_1.Modify( ls_fmt )
//dw_1.Object.c_activo.Font.Face = "Wingdings"
//
//dw_prn.Visible = False
//wf_Retrieve( )

end event

on wa_mant.create
if this.MenuName = "m_principal_mant" then this.MenuID = create m_principal_mant
this.dw_prn=create dw_prn
this.cb_recuperar=create cb_recuperar
this.cb_modificar=create cb_modificar
this.cb_eliminar=create cb_eliminar
this.cb_adicionar=create cb_adicionar
this.cb_cerrar=create cb_cerrar
this.cb_autorizar=create cb_autorizar
this.dw_1=create dw_1
this.Control[]={this.dw_prn,&
this.cb_recuperar,&
this.cb_modificar,&
this.cb_eliminar,&
this.cb_adicionar,&
this.cb_cerrar,&
this.cb_autorizar,&
this.dw_1}
end on

on wa_mant.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_prn)
destroy(this.cb_recuperar)
destroy(this.cb_modificar)
destroy(this.cb_eliminar)
destroy(this.cb_adicionar)
destroy(this.cb_cerrar)
destroy(this.cb_autorizar)
destroy(this.dw_1)
end on

event resize;If ib_exec Then
	dw_1.width = newwidth - (dw_1.x * 2 )
	dw_1.height = newheight - (dw_1.x * 2 ) - (cb_cerrar.height)
	cb_cerrar.x = newwidth - dw_1.x - cb_cerrar.width 
	cb_cerrar.y = dw_1.height + dw_1.x + (dw_1.x/2) 
	cb_autorizar.y = cb_cerrar.y 
	cb_autorizar.x = cb_cerrar.x - cb_cerrar.width - (dw_1.x/2)
	cb_recuperar.y = cb_cerrar.y 
	cb_recuperar.x = cb_autorizar.x - cb_autorizar.width - (dw_1.x/2)
	cb_eliminar.y = cb_cerrar.y 
	cb_eliminar.x = cb_recuperar.x - cb_recuperar.width - (dw_1.x/2)
	cb_modificar.y = cb_cerrar.y 
	cb_modificar.x = cb_eliminar.x - cb_eliminar.width - (dw_1.x/2)
	cb_adicionar.y = cb_cerrar.y 
	cb_adicionar.x = cb_modificar.x - cb_modificar.width - (dw_1.x/2)
End If
end event

type dw_prn from datawindow within wa_mant
integer width = 224
integer height = 132
integer taborder = 60
boolean border = false
boolean livescroll = true
end type

event constructor;SetTransObject( SqlCa )
end event

type cb_recuperar from uo_cbother within wa_mant
integer x = 1431
integer y = 900
integer taborder = 50
string text = "Recuperar"
end type

event clicked;call super::clicked;If wf_Recuperar( ) Then
	wf_Mant( )
End If

end event

type cb_modificar from uo_cbaceptar within wa_mant
integer x = 699
integer y = 900
integer taborder = 30
string text = "Modificar"
end type

event clicked;call super::clicked;If wf_Modificar( ) Then
	wf_Mant( )
End If
end event

type cb_eliminar from uo_cbother within wa_mant
integer x = 1065
integer y = 900
integer taborder = 40
string text = "Eliminar"
end type

event clicked;call super::clicked;If wf_Eliminar( ) Then
	wf_Mant( )
End If

end event

type cb_adicionar from uo_cbother within wa_mant
integer x = 334
integer y = 900
integer taborder = 20
string text = "Adicionar"
end type

event clicked;If wf_Insertar( ) Then
	wf_Mant( )
End If
end event

type cb_cerrar from uo_cbcancelar within wa_mant
integer x = 2162
integer y = 900
integer taborder = 80
string text = "Cerrar"
end type

type cb_autorizar from uo_cbother within wa_mant
integer x = 1797
integer y = 900
integer taborder = 70
string text = "Imprimir"
end type

event clicked;/*If wf_Autorizar( ) Then
	wf_Mant( )
End If
*/

wf_Print( )
end event

type dw_1 from uo_dw_list within wa_mant
integer x = 41
integer y = 36
integer width = 2450
integer height = 832
integer taborder = 10
end type

event doubleclicked;call super::doubleclicked;cb_modificar.TriggerEvent( Clicked! )
end event

event constructor;String ls_c1, ls_c2, ls_fmt
SetTransObject( SqlCa )

//ls_c1 = String( f_Color( 'rojo' ) )
//ls_c2 = String( f_Color( 'verde' ) )

//Modify( '"status.Color = " + ls_c1')
//Modify( "status.Color = '0~tIf ( status = 'N', " + ls_c1 + ', '+ ls_c2 +")'" )

end event

event rbuttondown;m_popup_mant	lm_mant

If Row > 0 Then ScrollToRow( Row)

gi_popopc= 0

/* La ejecución del contextual cargará la variable */
lm_mant = Create m_popup_mant

lm_mant.m_opcion.m_opcion1.Enabled = cb_adicionar.Enabled
lm_mant.m_opcion.m_opcion2.Enabled = cb_modificar.Enabled
lm_mant.m_opcion.m_opcion3.Enabled = cb_eliminar.Enabled
lm_mant.m_opcion.m_opcion4.Enabled = cb_recuperar.Enabled
lm_mant.m_opcion.m_opcion5.Enabled = cb_autorizar.Enabled

lm_mant.m_opcion.m_opcion1.Visible = cb_adicionar.Visible
lm_mant.m_opcion.m_opcion2.Visible = cb_modificar.Visible
lm_mant.m_opcion.m_opcion3.Visible = cb_eliminar.Visible
lm_mant.m_opcion.m_opcion4.Visible = cb_recuperar.Visible
lm_mant.m_opcion.m_opcion5.Visible = cb_autorizar.Visible

lm_mant.m_opcion.PopMenu( gw_frame.PointerX( ), gw_frame.PointerY( ) )

Choose Case gi_popopc
	Case 1 
		If wf_Insertar( ) Then
			wf_Mant( )
		End If
	Case 2 
		If wf_Modificar( ) Then
			wf_Mant( )
		End If
	Case 3
		If wf_Eliminar( ) Then
			wf_Mant( )
		End If
	Case 4
		If wf_Recuperar( ) Then
			wf_Mant( )
		End If
	Case 5
		wf_Buscar( )
	Case 6 
		cb_cerrar.TriggerEvent( Clicked! )
End Choose
end event

event nkey;
If KeyDown( KeyF5!) Then
	wf_Retrieve( )
End If
end event

