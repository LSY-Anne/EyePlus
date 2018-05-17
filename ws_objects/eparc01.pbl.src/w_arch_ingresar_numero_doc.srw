$PBExportHeader$w_arch_ingresar_numero_doc.srw
forward
global type w_arch_ingresar_numero_doc from wa_response
end type
type em_1 from editmask within w_arch_ingresar_numero_doc
end type
type st_1 from statictext within w_arch_ingresar_numero_doc
end type
end forward

global type w_arch_ingresar_numero_doc from wa_response
int Width=1083
int Height=416
boolean TitleBar=true
string Title="Buscar Documento"
long BackColor=80269524
em_1 em_1
st_1 st_1
end type
global w_arch_ingresar_numero_doc w_arch_ingresar_numero_doc

on w_arch_ingresar_numero_doc.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_1
end on

on w_arch_ingresar_numero_doc.destroy
call super::destroy
destroy(this.em_1)
destroy(this.st_1)
end on

type dw_list from wa_response`dw_list within w_arch_ingresar_numero_doc
int X=37
int Y=332
int TabOrder=50
boolean Visible=false
end type

type dw_1 from wa_response`dw_1 within w_arch_ingresar_numero_doc
int X=283
int Y=528
int Width=512
int Height=156
int TabOrder=40
boolean Visible=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_arch_ingresar_numero_doc
int X=658
int Y=180
end type

type cb_aceptar from wa_response`cb_aceptar within w_arch_ingresar_numero_doc
int X=279
int Y=180
boolean Enabled=true
end type

event cb_aceptar::clicked;If em_1.Text = '' Then Return
CloseWithReturn( Parent, em_1.Text )
end event

type em_1 from editmask within w_arch_ingresar_numero_doc
int X=279
int Y=64
int Width=722
int Height=84
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
MaskDataType MaskDataType=StringMask!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_arch_ingresar_numero_doc
int X=37
int Y=68
int Width=229
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Nº Doc.:"
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

