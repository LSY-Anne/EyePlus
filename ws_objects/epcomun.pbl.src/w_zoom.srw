$PBExportHeader$w_zoom.srw
forward
global type w_zoom from wa_response
end type
type rb_1 from radiobutton within w_zoom
end type
type gb_1 from groupbox within w_zoom
end type
type rb_2 from radiobutton within w_zoom
end type
type rb_3 from radiobutton within w_zoom
end type
type rb_4 from radiobutton within w_zoom
end type
type rb_5 from radiobutton within w_zoom
end type
type rb_6 from radiobutton within w_zoom
end type
type em_1 from editmask within w_zoom
end type
type st_1 from statictext within w_zoom
end type
end forward

global type w_zoom from wa_response
int Width=1248
int Height=836
boolean TitleBar=true
string Title="Ampliar (Zoom)"
rb_1 rb_1
gb_1 gb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_5 rb_5
rb_6 rb_6
em_1 em_1
st_1 st_1
end type
global w_zoom w_zoom

type variables
String is_zoom = '100'
end variables

on w_zoom.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.gb_1=create gb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_6=create rb_6
this.em_1=create em_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_3
this.Control[iCurrent+5]=this.rb_4
this.Control[iCurrent+6]=this.rb_5
this.Control[iCurrent+7]=this.rb_6
this.Control[iCurrent+8]=this.em_1
this.Control[iCurrent+9]=this.st_1
end on

on w_zoom.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.gb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_6)
destroy(this.em_1)
destroy(this.st_1)
end on

event open;call super::open;dw_1.Visible = False
dw_list.Visible = False
end event

type dw_list from wa_response`dw_list within w_zoom
int X=850
int Y=340
int TabOrder=0
end type

type dw_1 from wa_response`dw_1 within w_zoom
int X=846
int Y=560
int Width=197
int Height=116
int TabOrder=0
end type

type cb_cancelar from wa_response`cb_cancelar within w_zoom
int X=841
int Y=168
end type

type cb_aceptar from wa_response`cb_aceptar within w_zoom
int X=841
int Y=52
boolean Enabled=true
end type

event cb_aceptar::clicked;If rb_6.Checked Then
	If em_1.text = "" Or em_1.text = "0" Then
		MessageBox( gs_aplicacion, "Debe Ingresar el Porcentaje de Ampliación", Exclamation! )
		em_1.SetFocus()
		Return
	End If
	is_zoom = em_1.text
End If


CloseWithReturn(Parent, is_zoom )
end event

type rb_1 from radiobutton within w_zoom
int X=101
int Y=88
int Width=247
int Height=76
boolean BringToTop=true
string Text="200 %"
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

event clicked;is_zoom = '200'
end event

type gb_1 from groupbox within w_zoom
int X=37
int Y=20
int Width=759
int Height=688
int TabOrder=10
string Text="Ampliación"
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

type rb_2 from radiobutton within w_zoom
int X=101
int Y=188
int Width=247
int Height=76
boolean BringToTop=true
string Text="100 %"
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

event clicked;is_zoom = '100'
end event

type rb_3 from radiobutton within w_zoom
int X=101
int Y=288
int Width=247
int Height=76
boolean BringToTop=true
string Text="70 %"
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

event clicked;is_zoom = '70'
end event

type rb_4 from radiobutton within w_zoom
int X=101
int Y=388
int Width=247
int Height=76
boolean BringToTop=true
string Text="60 %"
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

event clicked;is_zoom = '60'
end event

type rb_5 from radiobutton within w_zoom
int X=101
int Y=488
int Width=247
int Height=76
boolean BringToTop=true
string Text="50 %"
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

event clicked;is_zoom = '50'
end event

type rb_6 from radiobutton within w_zoom
int X=101
int Y=588
int Width=421
int Height=76
boolean BringToTop=true
string Text="Personalizada "
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

type em_1 from editmask within w_zoom
int X=512
int Y=584
int Width=192
int Height=88
int TabOrder=40
boolean BringToTop=true
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="###"
boolean Spin=true
double Increment=5
string Text="100"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;rb_6.Checked = True
end event

type st_1 from statictext within w_zoom
int X=713
int Y=596
int Width=59
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="%"
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

