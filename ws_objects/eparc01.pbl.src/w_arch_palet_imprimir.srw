$PBExportHeader$w_arch_palet_imprimir.srw
forward
global type w_arch_palet_imprimir from wa_response
end type
type rb_1 from radiobutton within w_arch_palet_imprimir
end type
type rb_2 from radiobutton within w_arch_palet_imprimir
end type
type p_1 from picture within w_arch_palet_imprimir
end type
type rb_3 from radiobutton within w_arch_palet_imprimir
end type
type gb_1 from groupbox within w_arch_palet_imprimir
end type
type st_copias from statictext within w_arch_palet_imprimir
end type
type p_2 from picture within w_arch_palet_imprimir
end type
end forward

global type w_arch_palet_imprimir from wa_response
int Width=1202
int Height=772
boolean TitleBar=true
string Title="Impresión de Pallet"
rb_1 rb_1
rb_2 rb_2
p_1 p_1
rb_3 rb_3
gb_1 gb_1
st_copias st_copias
p_2 p_2
end type
global w_arch_palet_imprimir w_arch_palet_imprimir

event open;call super::open;String	ls_copias

dw_1.Visible = False
dw_list.Visible = False


If Message.StringParm <> 'L' Then //L = Listado P = Pallet
	rb_1.Enabled = False
	rb_2.Checked = True
	cb_aceptar.Enabled = True
	If Upper( f_GetParmValue( '21' ) ) = 'S' Then
		cb_aceptar.SetFocus( )
	End If
End If

ls_copias = f_GetParmValue( '38' )
If Integer( ls_copias ) < 1 Then ls_copias = '1'

st_copias.Text = st_copias.Text + ls_copias
	
end event

on w_arch_palet_imprimir.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.p_1=create p_1
this.rb_3=create rb_3
this.gb_1=create gb_1
this.st_copias=create st_copias
this.p_2=create p_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.rb_3
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.st_copias
this.Control[iCurrent+7]=this.p_2
end on

on w_arch_palet_imprimir.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.p_1)
destroy(this.rb_3)
destroy(this.gb_1)
destroy(this.st_copias)
destroy(this.p_2)
end on

type dw_list from wa_response`dw_list within w_arch_palet_imprimir
int X=1015
int Y=24
int Width=128
int Height=108
int TabOrder=0
boolean Enabled=false
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean VScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_arch_palet_imprimir
int X=1006
int Y=152
int Width=137
int Height=108
int TabOrder=0
end type

type cb_cancelar from wa_response`cb_cancelar within w_arch_palet_imprimir
int X=759
int Y=400
int TabOrder=20
end type

type cb_aceptar from wa_response`cb_aceptar within w_arch_palet_imprimir
int X=379
int Y=400
int TabOrder=10
end type

event cb_aceptar::clicked;String	ls_opc


If rb_1.Checked Then
	ls_opc = '1'
ElseIf rb_2.Checked Then
	ls_opc = '2'
ElseIf rb_3.Checked Then
	ls_opc = '3'
End If

CloseWithReturn( Parent, ls_opc )


end event

type rb_1 from radiobutton within w_arch_palet_imprimir
int X=256
int Y=84
int Width=681
int Height=76
int TabOrder=30
boolean BringToTop=true
string Text="Imprimir el &listado de pallets"
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

event clicked;cb_aceptar.Enabled = True
end event

type rb_2 from radiobutton within w_arch_palet_imprimir
int X=256
int Y=176
int Width=658
int Height=76
boolean BringToTop=true
string Text="Imprimir el &pallet"
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

event clicked;cb_aceptar.Enabled = True
end event

type p_1 from picture within w_arch_palet_imprimir
int X=41
int Y=44
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type rb_3 from radiobutton within w_arch_palet_imprimir
int X=256
int Y=268
int Width=731
int Height=76
boolean BringToTop=true
string Text="Imprimir el pallet (&Vista Previa)"
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

event clicked;cb_aceptar.Enabled = True
end event

type gb_1 from groupbox within w_arch_palet_imprimir
int X=41
int Y=512
int Width=1097
int Height=120
int TabOrder=30
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

type st_copias from statictext within w_arch_palet_imprimir
int X=169
int Y=556
int Width=933
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="N° de Copias de pallets a Imprimir "
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

type p_2 from picture within w_arch_palet_imprimir
int X=64
int Y=556
int Width=73
int Height=56
boolean BringToTop=true
string PictureName="nota.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

