$PBExportHeader$w_caracter_especial.srw
forward
global type w_caracter_especial from Window
end type
type sle_1 from singlelineedit within w_caracter_especial
end type
type dw_1 from datawindow within w_caracter_especial
end type
end forward

global type w_caracter_especial from Window
int X=1056
int Y=484
int Width=1289
int Height=540
boolean TitleBar=true
string Title="Carácteres Especiales"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
sle_1 sle_1
dw_1 dw_1
end type
global w_caracter_especial w_caracter_especial

event open;dw_1.InsertRow(0)
end event

on w_caracter_especial.create
this.sle_1=create sle_1
this.dw_1=create dw_1
this.Control[]={this.sle_1,&
this.dw_1}
end on

on w_caracter_especial.destroy
destroy(this.sle_1)
destroy(this.dw_1)
end on

type sle_1 from singlelineedit within w_caracter_especial
int X=274
int Y=36
int Width=146
int Height=92
int TabOrder=20
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

type dw_1 from datawindow within w_caracter_especial
int Width=1271
int Height=444
int TabOrder=10
string DataObject="d_caracter_especial"
boolean Border=false
boolean LiveScroll=true
end type

event buttonclicked;If dwo.Name = "cb_mayuscula" Then
	AcceptText( )
	Object.caracter[1] = Upper( Object.caracter[1] )
Else
	Object.caracter[1] = dwo.Text
End If

AcceptText( )

sle_1.Text = Object.caracter[1]
sle_1.SelectText(1, 1)
sle_1.Copy( )
sle_1.SetFocus( )
end event

