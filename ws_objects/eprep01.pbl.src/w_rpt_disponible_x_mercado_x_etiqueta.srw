$PBExportHeader$w_rpt_disponible_x_mercado_x_etiqueta.srw
forward
global type w_rpt_disponible_x_mercado_x_etiqueta from wa_response
end type
type p_1 from picture within w_rpt_disponible_x_mercado_x_etiqueta
end type
type st_mess from statictext within w_rpt_disponible_x_mercado_x_etiqueta
end type
type st_4 from statictext within w_rpt_disponible_x_mercado_x_etiqueta
end type
type ddlb_mer from dropdownlistbox within w_rpt_disponible_x_mercado_x_etiqueta
end type
type dw_2 from datawindow within w_rpt_disponible_x_mercado_x_etiqueta
end type
end forward

global type w_rpt_disponible_x_mercado_x_etiqueta from wa_response
int Width=1559
int Height=624
boolean TitleBar=true
string Title="Pallets Disponibles por Mercado y/o Etiqueta"
long BackColor=81324524
p_1 p_1
st_mess st_mess
st_4 st_4
ddlb_mer ddlb_mer
dw_2 dw_2
end type
global w_rpt_disponible_x_mercado_x_etiqueta w_rpt_disponible_x_mercado_x_etiqueta

type variables
String	is_rpt
end variables

event open;call super::open;is_rpt = Message.StringParm


dw_1.InsertRow( 0 )

dw_2.Visible = true

dw_list.dataobject='d_rpt_pallet_disponible_mercado_etiqueta'

end event

on w_rpt_disponible_x_mercado_x_etiqueta.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_mess=create st_mess
this.st_4=create st_4
this.ddlb_mer=create ddlb_mer
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_mess
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.ddlb_mer
this.Control[iCurrent+5]=this.dw_2
end on

on w_rpt_disponible_x_mercado_x_etiqueta.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_mess)
destroy(this.st_4)
destroy(this.ddlb_mer)
destroy(this.dw_2)
end on

type dw_list from wa_response`dw_list within w_rpt_disponible_x_mercado_x_etiqueta
int X=448
int Y=76
int Width=1755
int Height=152
int TabOrder=0
boolean Visible=false
string DataObject="d_rpt_embarques_x_embarcador_x_cul"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_disponible_x_mercado_x_etiqueta
int X=283
int Y=152
int Width=119
int Height=44
boolean Visible=false
boolean Enabled=false
boolean LiveScroll=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_disponible_x_mercado_x_etiqueta
int X=1157
int Y=380
int TabOrder=50
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_disponible_x_mercado_x_etiqueta
int X=791
int Y=380
int TabOrder=40
boolean Enabled=true
end type

event cb_aceptar::clicked;String ls_mer
datetime ld_fin

ls_mer = Upper( Left( ddlb_mer.Text, 1 ) )
If ls_mer = 'A' Then
	ls_mer = '%'
End If

ld_fin = datetime(today() )

SetPointer( HourGlass! )

dw_2.dataobject = 'd_rpt_disponible_mercado_etiqueta'
dw_2.SetTransObject( SqlCa )
dw_2.Retrieve(ls_mer, ld_fin  )
SetPointer( Arrow! )

f_Preview( dw_2 )
end event

type p_1 from picture within w_rpt_disponible_x_mercado_x_etiqueta
int X=37
int Y=32
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_mess from statictext within w_rpt_disponible_x_mercado_x_etiqueta
int X=219
int Y=36
int Width=1289
int Height=120
boolean Enabled=false
boolean BringToTop=true
string Text="Para emitir el reporte, complete los datos solicitados y luego haga clic en el botón Aceptar"
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

type st_4 from statictext within w_rpt_disponible_x_mercado_x_etiqueta
int X=283
int Y=232
int Width=242
int Height=76
boolean Enabled=false
string Text="Mercado:"
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

type ddlb_mer from dropdownlistbox within w_rpt_disponible_x_mercado_x_etiqueta
int X=526
int Y=212
int Width=978
int Height=324
int TabOrder=20
boolean BringToTop=true
string Text="Ambos"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Ambos",&
"Exportacion",&
"Nacional"}
end type

type dw_2 from datawindow within w_rpt_disponible_x_mercado_x_etiqueta
int X=2171
int Y=224
int Width=55
int Height=48
int TabOrder=30
boolean BringToTop=true
string DataObject="d_rpt_disponible_mercado_etiqueta"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

