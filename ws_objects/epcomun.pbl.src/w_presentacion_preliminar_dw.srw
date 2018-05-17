$PBExportHeader$w_presentacion_preliminar_dw.srw
forward
global type w_presentacion_preliminar_dw from w_ancestra_sheet
end type
end forward

global type w_presentacion_preliminar_dw from w_ancestra_sheet
integer x = 0
integer y = 0
integer width = 2912
integer height = 1948
string menuname = "m_presentacion_preliminar"
boolean minbox = false
boolean maxbox = false
windowstate windowstate = maximized!
end type
global w_presentacion_preliminar_dw w_presentacion_preliminar_dw

forward prototypes
public function integer wf_zoom ()
public function integer wf_rulers ()
public function integer wf_scrollpage (integer ai_scroll)
public function integer wf_save_as ()
public function integer wf_pre_popmenu ()
public function integer wf_zoomrpt ()
end prototypes

public function integer wf_zoom ();String	ls_zoom

Open(w_zoom)
ls_zoom = Message.StringParm

If ls_zoom = "" Or IsNull(ls_zoom ) Then
	Return 0
End If

dw_1.Object.Datawindow.Print.Preview.Zoom = ls_zoom
Return 1
end function

public function integer wf_rulers ();If is_tipo <> '1' Then
	dw_1.Modify('DataWindow.Print.Preview.Rulers=Yes')
	is_tipo = '1' 
Else
	is_tipo = '0' 
	dw_1.Modify('DataWindow.Print.Preview.Rulers=No')
End if

Return 1
end function

public function integer wf_scrollpage (integer ai_scroll);CHOOSE CASE ai_scroll
	CASE 1
		dw_1.ScrollToRow(0)
	CASE 2
		dw_1.ScrollPriorPage()
	CASE 3
		dw_1.ScrollNextPage()
	CASE 4
		dw_1.ScrollToRow(dw_1.RowCount())
End CHOOSE

Return 1
end function

public function integer wf_save_as ();dw_1.SaveAs()
Return 1
end function

public function integer wf_pre_popmenu ();m_presentacion_preliminar lm_menu

lm_menu = w_presentacion_preliminar.MenuID
lm_menu.m_archivo.PopMenu( &
		w_presentacion_preliminar.PointerX(), w_presentacion_preliminar.PointerY())

Return 0
end function

public function integer wf_zoomrpt ();String	ls_zoom

Open(w_zoom)
ls_zoom = Message.StringParm

If ls_zoom = "" Or IsNull(ls_zoom ) Then
	Return 0
End If

dw_1.Object.Datawindow.Zoom = ls_zoom
Return 1
end function

event open;call super::open;DataWindow ldw_1
String ls_zoom
integer ll_zoom

SetPointer( HourGlass! )

istr_parm = Message.PowerObjectParm

ib_resizeh = True
ib_resizew = True

If Not Upper( istr_parm.s_cad[ 1] ) = 'XP' Then
	ldw_1 = istr_parm.dw_dat[ 1]
	ldw_1.GetFullState( istr_parm.blb_data[1] )
	dw_1.SetFullState( istr_parm.blb_data[1] )
//	dw_1.GroupCalc()
	ls_zoom = f_trim(ProfileString( gs_ini, 'System', 'Zoomdwpallet', '0' ))
	ll_zoom = f_zero(integer(ls_zoom))

	if ldw_1.dataobject = "d_rpt_pallet_epsa_5secciones" and ll_zoom > 0 then
		dw_1.Modify('datawindow.zoom='+ls_zoom)
	end if
Else
	/* El DataObject viene en la cadena 2 */
	dw_1.DataObject = istr_parm.s_cad[ 2]
	dw_1.SetTransObject( SqlCa )
End If

dw_1.Modify("DataWindow.ReadOnly=YES")
dw_1.Modify("DataWindow.print.preview=YES")
is_doc_name = dw_1.Describe( "DataWindow.Print.DocumentName" )
This.Title = is_doc_name 

dw_1.SetFocus()
dw_1.SelectRow(0, False)
end event

on w_presentacion_preliminar_dw.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_presentacion_preliminar" then this.MenuID = create m_presentacion_preliminar
end on

on w_presentacion_preliminar_dw.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;SetPointer( Arrow! )

end event

type dw_1 from w_ancestra_sheet`dw_1 within w_presentacion_preliminar_dw
integer x = 0
integer y = 0
integer width = 2875
integer height = 1592
end type

event dw_1::clicked;/* No debe realizar nada */
end event

event dw_1::rowfocuschanged;/* No debe realizar nada */
end event

event dw_1::retrieveend;call super::retrieveend;SelectRow(0, False)
end event

