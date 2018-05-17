$PBExportHeader$w_rpt_etiquetas_x_rango_pallet.srw
forward
global type w_rpt_etiquetas_x_rango_pallet from wa_response
end type
type sle_1 from singlelineedit within w_rpt_etiquetas_x_rango_pallet
end type
type sle_2 from singlelineedit within w_rpt_etiquetas_x_rango_pallet
end type
type st_1 from statictext within w_rpt_etiquetas_x_rango_pallet
end type
type st_2 from statictext within w_rpt_etiquetas_x_rango_pallet
end type
type gb_1 from groupbox within w_rpt_etiquetas_x_rango_pallet
end type
end forward

global type w_rpt_etiquetas_x_rango_pallet from wa_response
int Width=1266
int Height=548
boolean TitleBar=true
string Title="Impresión de Etiquetas (papeletas)"
long BackColor=80269524
sle_1 sle_1
sle_2 sle_2
st_1 st_1
st_2 st_2
gb_1 gb_1
end type
global w_rpt_etiquetas_x_rango_pallet w_rpt_etiquetas_x_rango_pallet

type variables
String	is_rpt
end variables

event open;call super::open;
dw_1.Visible = False

dw_list.Visible = False


end event

on w_rpt_etiquetas_x_rango_pallet.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.sle_2=create sle_2
this.st_1=create st_1
this.st_2=create st_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.sle_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.gb_1
end on

on w_rpt_etiquetas_x_rango_pallet.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_1)
end on

type dw_list from wa_response`dw_list within w_rpt_etiquetas_x_rango_pallet
int X=1083
int Y=296
int Width=110
int Height=88
int TabOrder=0
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean VScrollBar=false
boolean HSplitScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_etiquetas_x_rango_pallet
int X=841
int Y=292
int Width=155
int Height=112
int TabOrder=0
string DataObject="d_rpt_pallet_std_list_no_codebar"
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_etiquetas_x_rango_pallet
int X=846
int Y=188
int TabOrder=40
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_etiquetas_x_rango_pallet
int X=841
int Y=72
int TabOrder=30
boolean Enabled=true
end type

event cb_aceptar::clicked;Long		ll_rows
String	ls_cia, ls_dir

SetPointer( HourGlass! )


ls_cia = f_GetParmValue('4')
ls_dir = f_GetParmValue('5')

//dw_1.DataObject = 'd_rpt_pallet_std_no_codebar'

dw_1.SetTransObject( SqlCa )
ll_rows = dw_1.Retrieve( gs_codtem, sle_1.Text, sle_2.Text, ls_cia, ls_dir ) 

SetPointer( Arrow! )

f_Preview( dw_1 )
end event

type sle_1 from singlelineedit within w_rpt_etiquetas_x_rango_pallet
int X=306
int Y=140
int Width=425
int Height=84
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_rpt_etiquetas_x_rango_pallet
int X=306
int Y=260
int Width=425
int Height=84
int TabOrder=20
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_rpt_etiquetas_x_rango_pallet
int X=91
int Y=148
int Width=197
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="Del Nro:"
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

type st_2 from statictext within w_rpt_etiquetas_x_rango_pallet
int X=91
int Y=268
int Width=197
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="Al Nro:"
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

type gb_1 from groupbox within w_rpt_etiquetas_x_rango_pallet
int X=37
int Y=44
int Width=763
int Height=360
string Text="Ingrese el rango de Pallets"
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

