$PBExportHeader$uo_cbcancelar.sru
forward
global type uo_cbcancelar from commandbutton
end type
end forward

global type uo_cbcancelar from commandbutton
int Width=347
int Height=92
int TabOrder=10
string Text="Cancelar"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global uo_cbcancelar uo_cbcancelar

event clicked;Close( Parent )
end event

