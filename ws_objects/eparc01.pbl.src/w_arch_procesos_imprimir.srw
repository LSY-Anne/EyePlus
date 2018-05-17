$PBExportHeader$w_arch_procesos_imprimir.srw
forward
global type w_arch_procesos_imprimir from wa_response
end type
type rb_1 from radiobutton within w_arch_procesos_imprimir
end type
type rb_2 from radiobutton within w_arch_procesos_imprimir
end type
type p_1 from picture within w_arch_procesos_imprimir
end type
type rb_3 from radiobutton within w_arch_procesos_imprimir
end type
end forward

global type w_arch_procesos_imprimir from wa_response
int Width=1161
int Height=680
boolean TitleBar=true
string Title="Impresión de Pallet"
rb_1 rb_1
rb_2 rb_2
p_1 p_1
rb_3 rb_3
end type
global w_arch_procesos_imprimir w_arch_procesos_imprimir

event open;call super::open;String	ls_copias

dw_1.Visible = False
dw_list.Visible = False


	
end event

on w_arch_procesos_imprimir.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.p_1=create p_1
this.rb_3=create rb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.rb_3
end on

on w_arch_procesos_imprimir.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.p_1)
destroy(this.rb_3)
end on

type dw_list from wa_response`dw_list within w_arch_procesos_imprimir
int X=987
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

type dw_1 from wa_response`dw_1 within w_arch_procesos_imprimir
int X=978
int Y=152
int Width=137
int Height=108
int TabOrder=0
end type

type cb_cancelar from wa_response`cb_cancelar within w_arch_procesos_imprimir
int X=731
int Y=444
int TabOrder=20
end type

type cb_aceptar from wa_response`cb_aceptar within w_arch_procesos_imprimir
int X=352
int Y=444
int TabOrder=10
boolean Enabled=true
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

type rb_1 from radiobutton within w_arch_procesos_imprimir
int X=229
int Y=84
int Width=750
int Height=76
int TabOrder=30
boolean BringToTop=true
string Text="Imprimir Información del &Día"
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

type rb_2 from radiobutton within w_arch_procesos_imprimir
int X=229
int Y=188
int Width=718
int Height=76
boolean BringToTop=true
string Text="Imprimir Información &Anterior"
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

type p_1 from picture within w_arch_procesos_imprimir
int X=41
int Y=44
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type rb_3 from radiobutton within w_arch_procesos_imprimir
int X=229
int Y=292
int Width=731
int Height=76
boolean BringToTop=true
string Text="Imprimir &Todo"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
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

