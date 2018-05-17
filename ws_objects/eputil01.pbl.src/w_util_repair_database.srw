$PBExportHeader$w_util_repair_database.srw
forward
global type w_util_repair_database from wa_sheet
end type
type mle_1 from multilineedit within w_util_repair_database
end type
type st_horizontal from statictext within w_util_repair_database
end type
end forward

global type w_util_repair_database from wa_sheet
boolean TitleBar=true
string Title="Repair DataBase"
string MenuName="m_principal_repair"
event ue_exec pbm_custom01
event ue_upddb pbm_custom02
event ue_save pbm_custom03
mle_1 mle_1
st_horizontal st_horizontal
end type
global w_util_repair_database w_util_repair_database

type variables

// The following are used for the resizing service
boolean		ib_debug=False	//Debug mode
long		il_hiddencolor=0	//Bar hidden color to match the window background
long		il_OldHeight	//Save the height of the window
integer		ii_barthickness=11	//Bar Thickness
integer		ii_windowborder=15	//Window border to be used on all sides
dragobject	idrg_Vertical	//Reference to the vertical control on the left of the window
dragobject	idrg_Horizontal[2]	//Reference to the horizontal controls on the right of the window

end variables

forward prototypes
public function integer wf_resizepanels ()
public function integer wf_resizebar ()
public function integer wf_exec ()
public function integer wf_upddb ()
end prototypes

event ue_exec;wf_Exec( )
end event

event ue_upddb;wf_upddb( )
end event

event ue_save;dw_1.SaveAs ( )
end event

public function integer wf_resizepanels ();//Resize the panels according to the Lines, 
//BarThickness, and WindowBorder.

Integer	li_Cnt, li_X, li_Y, li_HHeight, li_HWidth
Long		ll_Width, ll_Height

ll_Width = this.WorkSpaceWidth()
ll_Height = this.WorkspaceHeight()

idrg_Horizontal[ 1] = mle_1
idrg_Horizontal[ 2] = dw_1

// Horizontal object processing
For li_Cnt = 1 To 2
	//li_X = st_vertical.X + ii_BarThickness
	If li_Cnt = 1 Then
		li_Y = ii_WindowBorder
	Else
		li_Y = st_horizontal.Y + ii_BarThickness
	End If
	
	idrg_Horizontal[li_Cnt].Move (li_X, li_Y)
	
	li_HWidth = st_horizontal.Width
	If li_Cnt = 1 Then
		li_HHeight = st_horizontal.Y - ii_WindowBorder
	ElseIf li_Cnt = 2 Then
		li_HHeight = ll_Height - st_horizontal.Y + ii_BarThickness - ii_WindowBorder
	Else		
		li_HHeight = st_horizontal.Y - (st_horizontal.Y + ii_BarThickness)
	End If

	idrg_Horizontal[li_Cnt].Resize (li_HWidth, li_HHeight)
Next

Return 1

end function

public function integer wf_resizebar ();Integer	li_Cnt

//Force appropriate order
st_horizontal.SetPosition(ToTop!)

//Make sure the Width is not lost
st_horizontal.Height = ii_BarThickness

Return 1

end function

public function integer wf_exec ();String	ls_sql, ls_dw, ls_err


ls_sql = Lower( f_Trim( mle_1.Text ) )

If Left( ls_sql, 6 ) = 'select' Then
	ls_dw = SqlCa.SyntaxFromSQL( ls_sql, "style(type=grid)", ls_err )
	If f_Trim( ls_err ) <> '' Then
		MessageBox( Title, 'Error: ' + ls_err )
		Return -1
	End If
	dw_1.Create( ls_dw, ls_err )
	If f_Trim( ls_err ) <> '' Then
		MessageBox( Title, 'Error: ' + ls_err )
		Return -1
	End If
	dw_1.SetTransObject( SqlCa )
	dw_1.Retrieve( )
Else
	Execute Immediate :ls_sql ;
End If


Return 1
end function

public function integer wf_upddb ();If dw_1.Update( ) <> 1 Then
	MessageBox( Title, 'No se pudo actualizar información de la consulta', StopSign! )
	Return -1
End If

Commit Using SqlCa ;
Return 1
end function

on w_util_repair_database.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_principal_repair" then this.MenuID = create m_principal_repair
this.mle_1=create mle_1
this.st_horizontal=create st_horizontal
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_1
this.Control[iCurrent+2]=this.st_horizontal
end on

on w_util_repair_database.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mle_1)
destroy(this.st_horizontal)
end on

event resize;call super::resize;mle_1.Width = newwidth
mle_1.X = 0
st_horizontal.X = 0
st_horizontal.Width = newwidth

//Resize Bars
wf_ResizeBar()

//Resize the panels
wf_ResizePanels()

end event

event open;call super::open;idrg_Horizontal[ 1] = mle_1
idrg_Horizontal[ 2] = dw_1

ib_resizew = True

// Set the color of the bars to make them invisible
il_HiddenColor = This.BackColor
st_horizontal.BackColor = il_HiddenColor

//Resize Bars
wf_ResizeBar()

//Resize the panels
wf_ResizePanels()


end event

type dw_1 from wa_sheet`dw_1 within w_util_repair_database
int X=0
int Y=424
int Height=300
end type

type mle_1 from multilineedit within w_util_repair_database
int Y=24
int Width=1170
int Height=336
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Courier New"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type st_horizontal from statictext within w_util_repair_database
event mousedown pbm_lbuttondown
event mouseup pbm_lbuttonup
event mousemove pbm_mousemove
int X=443
int Y=380
int Width=914
int Height=76
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="--------------------"
boolean FocusRectangle=false
long TextColor=1090519039
long BackColor=33554432
string Pointer="SizeNS!"
int TextSize=-9
int Weight=400
string FaceName="Courier New"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

event mousedown;If Not ib_Debug Then This.BackColor = 0  //show Bar in Black

end event

event mouseup;//Hide the bar
If Not ib_Debug Then This.BackColor = il_HiddenColor

//Resize Bars
wf_ResizeBar()

//Resize the panels
wf_ResizePanels()

end event

event mousemove;//Check for move in progess
If KeyDown(keyLeftButton!) Then
	If Not ib_debug Then This.BackColor = 0  //show Bar in Black
	This.Y = Parent.PointerY()
End If

end event

