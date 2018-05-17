$PBExportHeader$w_rpt_tipo_pallet.srw
$PBExportComments$para elegir si es nacional o extranjero en la impresion de pallet
forward
global type w_rpt_tipo_pallet from wa_response
end type
type p_1 from picture within w_rpt_tipo_pallet
end type
type st_1 from statictext within w_rpt_tipo_pallet
end type
type rb_1 from radiobutton within w_rpt_tipo_pallet
end type
type rb_2 from radiobutton within w_rpt_tipo_pallet
end type
end forward

global type w_rpt_tipo_pallet from wa_response
int Width=910
int Height=696
boolean TitleBar=true
string Title="Pallet a Imprimir"
long BackColor=82899184
p_1 p_1
st_1 st_1
rb_1 rb_1
rb_2 rb_2
end type
global w_rpt_tipo_pallet w_rpt_tipo_pallet

type variables
String	is_rpt
end variables

event open;call super::open;is_rpt = Message.StringParm

Choose Case is_rpt
	Case 'PXC' /* Productos x Costo */
		Title = 'Tabla de Productos por Costo'
		dw_list.DataObject = 'd_rpt_producto_costo'
	Case 'ECD' /* Productos x Costo Diario */
		Title = 'Empaque por Costo Diario'
		dw_list.DataObject = 'd_rpt_acumulado_empaque_costo'
	Case 'DEE' /* Diario de Empaque y embarque */
		Title = 'Diario de Empaque y Embarque '
		dw_list.DataObject = 'd_rpt_acumulado_eye_espe'	
End Choose
dw_1.Visible = False
dw_list.Visible = False

end event

on w_rpt_tipo_pallet.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_1=create st_1
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
end on

on w_rpt_tipo_pallet.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.rb_2)
end on

type dw_list from wa_response`dw_list within w_rpt_tipo_pallet
int X=9
int Y=648
int Width=137
int Height=112
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean VScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_tipo_pallet
int X=178
int Y=648
int Width=155
int Height=124
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_tipo_pallet
int X=489
int Y=444
end type

event cb_cancelar::clicked;call super::clicked;Closewithreturn( w_rpt_tipo_pallet,'' )
end event

type cb_aceptar from wa_response`cb_aceptar within w_rpt_tipo_pallet
int X=110
int Y=444
boolean Enabled=true
end type

event cb_aceptar::clicked;string ls_tipo

If rb_1.checked then
	ls_tipo = 'N'
else
	ls_tipo = 'E'
end if

Closewithreturn( w_rpt_tipo_pallet,ls_tipo )
end event

type p_1 from picture within w_rpt_tipo_pallet
int X=37
int Y=32
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_1 from statictext within w_rpt_tipo_pallet
int X=219
int Y=44
int Width=608
int Height=116
boolean Enabled=false
boolean BringToTop=true
string Text="Tipo de pallet a imprimir ?"
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

type rb_1 from radiobutton within w_rpt_tipo_pallet
int X=261
int Y=168
int Width=293
int Height=80
boolean BringToTop=true
string Text="Nacional"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean RightToLeft=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_rpt_tipo_pallet
int X=261
int Y=300
int Width=293
int Height=80
boolean BringToTop=true
string Text="Extranjero"
BorderStyle BorderStyle=StyleLowered!
boolean RightToLeft=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

