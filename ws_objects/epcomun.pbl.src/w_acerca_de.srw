$PBExportHeader$w_acerca_de.srw
forward
global type w_acerca_de from Window
end type
type st_8 from statictext within w_acerca_de
end type
type st_server from statictext within w_acerca_de
end type
type cb_aceptar from uo_cbaceptar within w_acerca_de
end type
type st_db from statictext within w_acerca_de
end type
type st_servidor from statictext within w_acerca_de
end type
type st_7 from statictext within w_acerca_de
end type
type st_cia from statictext within w_acerca_de
end type
type st_5 from statictext within w_acerca_de
end type
type st_4 from statictext within w_acerca_de
end type
type st_3 from statictext within w_acerca_de
end type
type st_2 from statictext within w_acerca_de
end type
type st_1 from statictext within w_acerca_de
end type
type gb_1 from groupbox within w_acerca_de
end type
type p_2 from picture within w_acerca_de
end type
end forward

global type w_acerca_de from Window
int X=1257
int Y=716
int Width=1239
int Height=1152
boolean TitleBar=true
string Title="Acerca de "
long BackColor=81324524
WindowType WindowType=response!
st_8 st_8
st_server st_server
cb_aceptar cb_aceptar
st_db st_db
st_servidor st_servidor
st_7 st_7
st_cia st_cia
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
gb_1 gb_1
p_2 p_2
end type
global w_acerca_de w_acerca_de

event open;String	ls_key

Title = Title + gs_aplicacion 
cb_aceptar.SetFocus()

f_CenterWindow( This )

ls_key = 'HKEY_CURRENT_USER\Software\ODBC\ODBC.INI\EyePlusDB'

st_server.Text = ProfileString( gs_ini, "DataBase", "ServerName", "")
st_db.Text = ProfileString( gs_ini, "DataBase", "database", "")
st_cia.Text = ProfileString( gs_ini, "system", "cia", "")

st_1.text = 'EyEplus ' + gs_version


end event

on w_acerca_de.create
this.st_8=create st_8
this.st_server=create st_server
this.cb_aceptar=create cb_aceptar
this.st_db=create st_db
this.st_servidor=create st_servidor
this.st_7=create st_7
this.st_cia=create st_cia
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.p_2=create p_2
this.Control[]={this.st_8,&
this.st_server,&
this.cb_aceptar,&
this.st_db,&
this.st_servidor,&
this.st_7,&
this.st_cia,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.gb_1,&
this.p_2}
end on

on w_acerca_de.destroy
destroy(this.st_8)
destroy(this.st_server)
destroy(this.cb_aceptar)
destroy(this.st_db)
destroy(this.st_servidor)
destroy(this.st_7)
destroy(this.st_cia)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.p_2)
end on

type st_8 from statictext within w_acerca_de
int X=82
int Y=672
int Width=311
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="DataBase:"
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

type st_server from statictext within w_acerca_de
int X=398
int Y=564
int Width=750
int Height=76
boolean Enabled=false
boolean BringToTop=true
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

type cb_aceptar from uo_cbaceptar within w_acerca_de
int X=439
int Y=932
boolean Cancel=true
end type

event clicked;Close( Parent )
end event

type st_db from statictext within w_acerca_de
int X=398
int Y=672
int Width=750
int Height=76
boolean Enabled=false
boolean BringToTop=true
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

type st_servidor from statictext within w_acerca_de
int X=82
int Y=564
int Width=311
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Servidor DB:"
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

type st_7 from statictext within w_acerca_de
int X=82
int Y=832
int Width=955
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Derechos Reservados Enero 2008"
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

type st_cia from statictext within w_acerca_de
int X=398
int Y=404
int Width=750
int Height=112
boolean Enabled=false
boolean BringToTop=true
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

type st_5 from statictext within w_acerca_de
int X=82
int Y=404
int Width=311
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Organización:"
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

type st_4 from statictext within w_acerca_de
int X=398
int Y=292
int Width=750
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Inventum S.A."
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

type st_3 from statictext within w_acerca_de
int X=82
int Y=292
int Width=311
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Desarrollo:"
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

type st_2 from statictext within w_acerca_de
int X=261
int Y=72
int Width=896
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="Sistema de Empaque y Embarques"
boolean FocusRectangle=false
long TextColor=128
long BackColor=67108864
int TextSize=-5
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_acerca_de
int X=270
int Y=144
int Width=859
int Height=68
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_acerca_de
int X=46
int Y=16
int Width=1134
int Height=228
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

type p_2 from picture within w_acerca_de
int X=82
int Y=76
int Width=155
int Height=132
boolean BringToTop=true
string PictureName="eyeplus.bmp"
boolean Border=true
boolean FocusRectangle=false
boolean OriginalSize=true
end type

