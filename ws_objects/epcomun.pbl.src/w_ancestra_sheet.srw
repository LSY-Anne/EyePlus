$PBExportHeader$w_ancestra_sheet.srw
forward
global type w_ancestra_sheet from window
end type
type dw_1 from uo_dw_list within w_ancestra_sheet
end type
end forward

global type w_ancestra_sheet from window
integer x = 823
integer y = 360
integer width = 2016
integer height = 1208
boolean titlebar = true
string menuname = "m_sheet"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
dw_1 dw_1
end type
global w_ancestra_sheet w_ancestra_sheet

type variables
Boolean	ib_resizew, ib_resizeh, ib_activate=False
s_parm 	istr_parm
String	is_codigo, is_tipo, is_doc_name, is_accion
Boolean	ib_modifica = False
DataWindow	idw_print
end variables

forward prototypes
public function integer wf_refresh ()
public function integer wf_resize_object (windowobject awo_object, boolean ab_resizeh, boolean ab_resizew)
public function integer wf_graph ()
public function integer wf_graph_style ()
public function integer wf_popmenu ()
public function integer wf_graph_colors ()
public function integer wf_save ()
public function integer wf_print ()
public function integer wf_print_preview ()
public function integer wf_save_as ()
public function integer wf_pre_popmenu ()
public function integer wf_new ()
public function integer wf_open ()
public function integer wf_search ()
public function integer wf_insert ()
public function integer wf_edit ()
public function integer wf_delete ()
public function integer wf_pre_print ()
public function integer wf_zoom ()
public function integer wf_pre_popmenu_rpt ()
public function integer wf_query ()
public function integer wf_search_value ()
public function integer wf_filter ()
end prototypes

public function integer wf_refresh ();Return 1
end function

public function integer wf_resize_object (windowobject awo_object, boolean ab_resizeh, boolean ab_resizew);DataWindow	ldw_1
Picture		lp_1
ListView		llv_1
Long			ll_height, ll_width
Object		lobj_class
Tab			ltab_1

If Not ab_resizew And Not ab_resizew Then 
	Return -1
End If

lobj_class = awo_object.TypeOf()
ll_height = This.height - 110
ll_width = This.width - 40

CHOOSE CASE lobj_class
	CASE DataWindow!
		ldw_1 = awo_object
		If ab_resizeh Then ldw_1.height = ll_height
		If ab_resizew Then ldw_1.width = ll_width
	CASE ListView!
		llv_1 = awo_object
		If ab_resizeh Then llv_1.height = ll_height
		If ab_resizew Then llv_1.width = ll_width
END CHOOSE

Return 1
end function

public function integer wf_graph ();Return 1
end function

public function integer wf_graph_style ();//OpenWithParm( w_graph_type, dw_1 )
Return 1
end function

public function integer wf_popmenu ();m_sheet	lm_menu

If wf_Pre_PopMenu( ) = 1 Then

	lm_menu = MenuID
	lm_menu.m_opcionsheet.PopMenu( &
		gw_frame.PointerX(), gw_frame.PointerY())
End If

Return 1
end function

public function integer wf_graph_colors ();//OpenWithParm( w_graph_color, dw_1 )
Return 1
end function

public function integer wf_save ();dw_1.SaveAs()
Return  1
end function

public function integer wf_print ();Integer	li_printed

If wf_pre_print() <= 0 Then Return -1
//If idw_print.RowCount() <= 0 Then
//	MessageBox( gs_aplicacion, 'No existe información para poder imprimir.', Exclamation!)
//	Return -1
//End If

If is_doc_name = "" Then
	is_doc_name = This.Title
End If

OpenWithParm(w_dw_print_options, idw_print )
li_printed = message.doubleparm
If li_printed = 1 Then 
	idw_print.Modify( "datawindow.print.DocumentName='" + is_doc_name + "'" )
	li_printed = idw_print.Print( True )
	If IsValid( w_presentacion_preliminar ) Then
		If ProfileString( gs_ini, 'System', 'CerrarModoPrevio', 'N') = 'S' Then
			Close( w_presentacion_preliminar )
		End If
	End If
Else
	li_printed = -1
End If

Return li_printed

end function

public function integer wf_print_preview ();If wf_pre_print() <= 0 Then Return -1

If is_doc_name = "" Then
	is_doc_name = This.Title
End If

idw_print.Modify( "DataWindow.Print.DocumentName='" + is_doc_name + "'" )

Return f_preview(idw_print)


end function

public function integer wf_save_as ();Return 1
end function

public function integer wf_pre_popmenu ();Boolean	lb_enabled = True
m_sheet	lm_menu


lm_menu = MenuID

If IsValid(lm_menu) Then
Choose Case Left( lm_menu.Classname ( ), 6 )
	Case 'm_mant'
		If dw_1.RowCount() <= 0 Then
			lb_enabled = False
		End If
		lm_menu.m_opcionsheet.m_opcionsheet2.Enabled = lb_enabled
		lm_menu.m_opcionsheet.m_opcionsheet3.Enabled = lb_enabled
		lm_menu.m_opcionsheet.m_opcionsheet4.Enabled = lb_enabled
		lm_menu.m_opcionsheet.m_opcionsheet5.Enabled = lb_enabled
		lm_menu.m_opcionsheet.m_opcionsheet6.Enabled = lb_enabled
		lm_menu.m_opcionsheet.m_opcionsheet7.Enabled = lb_enabled
End Choose		
		
End If

Return 1
end function

public function integer wf_new ();Return 1
end function

public function integer wf_open ();Return 1
end function

public function integer wf_search ();Return 1
end function

public function integer wf_insert ();Return 1
end function

public function integer wf_edit ();Return 1
end function

public function integer wf_delete ();Return 1
end function

public function integer wf_pre_print ();Return 1
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

public function integer wf_pre_popmenu_rpt ();m_principal lm_menu


lm_menu = This.MenuId

lm_menu.m_opcionsheet.m_opcionsheet4.visible = True
lm_menu.m_opcionsheet.m_opcionsheet5.visible = True
lm_menu.m_opcionsheet.m_opcionsheet6.visible = True
lm_menu.m_opcionsheet.m_opcionsheet7.visible = True
lm_menu.m_opcionsheet.m_opcionsheet8.visible = True
lm_menu.m_opcionsheet.m_opcionsheet9.visible = True

Return 1
end function

public function integer wf_query ();Return 1
end function

public function integer wf_search_value ();Integer	li_col
String	ls_col, ls_text
s_parm	lstr_parm

li_col = dw_1.GetClickedColumn()

ls_col = dw_1.Describe( "#" + String(li_col) + ".name")

If ls_col = "" Then ls_col = dw_1.is_columna

If ls_col = "!" Then Return 0

ls_text = ls_col + "_t"
ls_text = dw_1.Describe( ls_text + ".text")


lstr_parm.s_cad[1] = ls_col
lstr_parm.s_cad[2] = ls_text
//OpenWithParm(w_mant_buscar_valor, lstr_parm)

Return 1
end function

public function integer wf_filter ();String ls_null

SetNull( ls_null )

If dw_1.SetFilter( ls_null) > 0 Then
	dw_1.Filter()
	gw_frame.SetMicroHelp( "Son " + String(dw_1.FilteredCount()) + &
									"/" + String(dw_1.RowCount()))
End If

Return dw_1.FilteredCount()
end function

on w_ancestra_sheet.create
if this.MenuName = "m_sheet" then this.MenuID = create m_sheet
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_ancestra_sheet.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

event open;dw_1.SetTransObject( SqlCa )
idw_print = dw_1
end event

event resize;If ib_resizeh Then dw_1.height	= newheight - 10
If ib_resizew Then dw_1.width		= newwidth - 10
end event

event key;If KeyDown( KeyF5! ) Then wf_refresh()
end event

event activate;If Not ib_activate Then
	ib_activate = True
	wf_refresh()
End If
end event

type dw_1 from uo_dw_list within w_ancestra_sheet
integer x = 18
integer y = 16
integer taborder = 20
end type

event nkey;call super::nkey;If KeyDown( KeyF5! ) Then wf_refresh()
end event

event rbuttondown;call super::rbuttondown;If row > 0 Then ScrollToRow(row)
wf_PopMenu()
end event

