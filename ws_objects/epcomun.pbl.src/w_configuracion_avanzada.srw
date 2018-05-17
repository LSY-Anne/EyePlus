$PBExportHeader$w_configuracion_avanzada.srw
forward
global type w_configuracion_avanzada from wa_response
end type
type tab_1 from tab within w_configuracion_avanzada
end type
type tabpage_1 from userobject within tab_1
end type
type st_1 from statictext within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type st_5 from statictext within tabpage_1
end type
type st_6 from statictext within tabpage_1
end type
type st_7 from statictext within tabpage_1
end type
type st_8 from statictext within tabpage_1
end type
type sle_1 from singlelineedit within tabpage_1
end type
type sle_2 from singlelineedit within tabpage_1
end type
type sle_3 from singlelineedit within tabpage_1
end type
type sle_4 from singlelineedit within tabpage_1
end type
type sle_5 from singlelineedit within tabpage_1
end type
type sle_6 from singlelineedit within tabpage_1
end type
type sle_7 from singlelineedit within tabpage_1
end type
type sle_8 from singlelineedit within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type st_s1 from statictext within tabpage_2
end type
type sle_cia from singlelineedit within tabpage_2
end type
type st_9 from statictext within tabpage_2
end type
type st_10 from statictext within tabpage_2
end type
type st_11 from statictext within tabpage_2
end type
type st_12 from statictext within tabpage_2
end type
type st_13 from statictext within tabpage_2
end type
type st_14 from statictext within tabpage_2
end type
type sle_9 from singlelineedit within tabpage_2
end type
type sle_10 from singlelineedit within tabpage_2
end type
type sle_11 from singlelineedit within tabpage_2
end type
type sle_12 from singlelineedit within tabpage_2
end type
type sle_13 from singlelineedit within tabpage_2
end type
type sle_14 from singlelineedit within tabpage_2
end type
type tabpage_1 from userobject within tab_1
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
sle_1 sle_1
sle_2 sle_2
sle_3 sle_3
sle_4 sle_4
sle_5 sle_5
sle_6 sle_6
sle_7 sle_7
sle_8 sle_8
end type
type tabpage_2 from userobject within tab_1
st_s1 st_s1
sle_cia sle_cia
st_9 st_9
st_10 st_10
st_11 st_11
st_12 st_12
st_13 st_13
st_14 st_14
sle_9 sle_9
sle_10 sle_10
sle_11 sle_11
sle_12 sle_12
sle_13 sle_13
sle_14 sle_14
end type
type tab_1 from tab within w_configuracion_avanzada
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_configuracion_avanzada from wa_response
int Width=1998
int Height=1308
boolean TitleBar=true
string Title="Configuración Avanzada"
long BackColor=81324524
tab_1 tab_1
end type
global w_configuracion_avanzada w_configuracion_avanzada

on w_configuracion_avanzada.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_configuracion_avanzada.destroy
call super::destroy
destroy(this.tab_1)
end on

event open;call super::open;tab_1.tabpage_1.sle_1.Text = ProfileString( gs_ini, 'Database', 'DBMS', '' )
tab_1.tabpage_1.sle_2.Text = ProfileString( gs_ini, 'Database', 'Database', '' )
tab_1.tabpage_1.sle_3.Text = ProfileString( gs_ini, 'Database', 'UserId', '' )
tab_1.tabpage_1.sle_4.Text = ProfileString( gs_ini, 'Database', 'DatabasePassword', '' )
tab_1.tabpage_1.sle_5.Text = ProfileString( gs_ini, 'Database', 'LogPassword', '' )
tab_1.tabpage_1.sle_6.Text = ProfileString( gs_ini, 'Database', 'ServerName', '' )
tab_1.tabpage_1.sle_7.Text = ProfileString( gs_ini, 'Database', 'LogId', '' )
tab_1.tabpage_1.sle_8.Text = ProfileString( gs_ini, 'Database', 'UserId', '' )



end event

type dw_list from wa_response`dw_list within w_configuracion_avanzada
int TabOrder=50
boolean Visible=false
end type

type dw_1 from wa_response`dw_1 within w_configuracion_avanzada
int Y=436
int Width=151
int Height=80
boolean Visible=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_configuracion_avanzada
int X=1582
int Y=1092
int TabOrder=40
end type

type cb_aceptar from wa_response`cb_aceptar within w_configuracion_avanzada
int X=1202
int Y=1092
int TabOrder=30
boolean Enabled=true
end type

type tab_1 from tab within w_configuracion_avanzada
int X=27
int Y=24
int Width=1902
int Height=1048
int TabOrder=20
boolean BringToTop=true
boolean RaggedRight=true
int SelectedTab=1
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
int X=18
int Y=100
int Width=1865
int Height=932
long BackColor=81324524
string Text="Conexión"
long TabBackColor=81324524
long TabTextColor=33554432
long PictureMaskColor=536870912
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
sle_1 sle_1
sle_2 sle_2
sle_3 sle_3
sle_4 sle_4
sle_5 sle_5
sle_6 sle_6
sle_7 sle_7
sle_8 sle_8
end type

on tabpage_1.create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.sle_1=create sle_1
this.sle_2=create sle_2
this.sle_3=create sle_3
this.sle_4=create sle_4
this.sle_5=create sle_5
this.sle_6=create sle_6
this.sle_7=create sle_7
this.sle_8=create sle_8
this.Control[]={this.st_1,&
this.st_2,&
this.st_3,&
this.st_4,&
this.st_5,&
this.st_6,&
this.st_7,&
this.st_8,&
this.sle_1,&
this.sle_2,&
this.sle_3,&
this.sle_4,&
this.sle_5,&
this.sle_6,&
this.sle_7,&
this.sle_8}
end on

on tabpage_1.destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.sle_3)
destroy(this.sle_4)
destroy(this.sle_5)
destroy(this.sle_6)
destroy(this.sle_7)
destroy(this.sle_8)
end on

type st_1 from statictext within tabpage_1
int X=73
int Y=52
int Width=219
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="DBMS:"
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

type st_2 from statictext within tabpage_1
int X=73
int Y=152
int Width=233
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Database:"
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

type st_3 from statictext within tabpage_1
int X=73
int Y=252
int Width=233
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="UserId:"
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

type st_4 from statictext within tabpage_1
int X=73
int Y=352
int Width=443
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="DatabasePassword:"
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

type st_5 from statictext within tabpage_1
int X=73
int Y=452
int Width=443
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="LogPassword:"
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

type st_6 from statictext within tabpage_1
int X=73
int Y=552
int Width=443
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="ServerName:"
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

type st_7 from statictext within tabpage_1
int X=73
int Y=652
int Width=443
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="LogId:"
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

type st_8 from statictext within tabpage_1
int X=73
int Y=752
int Width=443
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="DbParm:"
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

type sle_1 from singlelineedit within tabpage_1
int X=558
int Y=52
int Width=1234
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

type sle_2 from singlelineedit within tabpage_1
int X=558
int Y=152
int Width=1234
int Height=84
int TabOrder=30
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

type sle_3 from singlelineedit within tabpage_1
int X=558
int Y=252
int Width=1234
int Height=84
int TabOrder=40
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

type sle_4 from singlelineedit within tabpage_1
int X=558
int Y=352
int Width=1234
int Height=84
int TabOrder=50
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

type sle_5 from singlelineedit within tabpage_1
int X=558
int Y=452
int Width=1234
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

type sle_6 from singlelineedit within tabpage_1
int X=558
int Y=552
int Width=1234
int Height=84
int TabOrder=60
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

type sle_7 from singlelineedit within tabpage_1
int X=558
int Y=652
int Width=1234
int Height=84
int TabOrder=70
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

type sle_8 from singlelineedit within tabpage_1
int X=558
int Y=752
int Width=1234
int Height=84
int TabOrder=80
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

type tabpage_2 from userobject within tab_1
int X=18
int Y=100
int Width=1865
int Height=932
long BackColor=81324524
string Text="Sistema"
long TabBackColor=81324524
long TabTextColor=33554432
long PictureMaskColor=536870912
st_s1 st_s1
sle_cia sle_cia
st_9 st_9
st_10 st_10
st_11 st_11
st_12 st_12
st_13 st_13
st_14 st_14
sle_9 sle_9
sle_10 sle_10
sle_11 sle_11
sle_12 sle_12
sle_13 sle_13
sle_14 sle_14
end type

on tabpage_2.create
this.st_s1=create st_s1
this.sle_cia=create sle_cia
this.st_9=create st_9
this.st_10=create st_10
this.st_11=create st_11
this.st_12=create st_12
this.st_13=create st_13
this.st_14=create st_14
this.sle_9=create sle_9
this.sle_10=create sle_10
this.sle_11=create sle_11
this.sle_12=create sle_12
this.sle_13=create sle_13
this.sle_14=create sle_14
this.Control[]={this.st_s1,&
this.sle_cia,&
this.st_9,&
this.st_10,&
this.st_11,&
this.st_12,&
this.st_13,&
this.st_14,&
this.sle_9,&
this.sle_10,&
this.sle_11,&
this.sle_12,&
this.sle_13,&
this.sle_14}
end on

on tabpage_2.destroy
destroy(this.st_s1)
destroy(this.sle_cia)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.st_13)
destroy(this.st_14)
destroy(this.sle_9)
destroy(this.sle_10)
destroy(this.sle_11)
destroy(this.sle_12)
destroy(this.sle_13)
destroy(this.sle_14)
end on

type st_s1 from statictext within tabpage_2
int X=73
int Y=52
int Width=219
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Cia:"
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

type sle_cia from singlelineedit within tabpage_2
int X=558
int Y=52
int Width=1234
int Height=84
int TabOrder=30
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

type st_9 from statictext within tabpage_2
int X=73
int Y=152
int Width=306
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Pallet Normal:"
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

type st_10 from statictext within tabpage_2
int X=73
int Y=252
int Width=270
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Pallet Mixto:"
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

type st_11 from statictext within tabpage_2
int X=73
int Y=352
int Width=219
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Factura:"
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

type st_12 from statictext within tabpage_2
int X=73
int Y=452
int Width=393
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Factura Nacional:"
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

type st_13 from statictext within tabpage_2
int X=73
int Y=552
int Width=219
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Formato:"
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

type st_14 from statictext within tabpage_2
int X=73
int Y=652
int Width=315
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Control Viajes:"
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

type sle_9 from singlelineedit within tabpage_2
int X=558
int Y=152
int Width=1234
int Height=84
int TabOrder=40
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

type sle_10 from singlelineedit within tabpage_2
int X=558
int Y=252
int Width=1234
int Height=84
int TabOrder=50
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

type sle_11 from singlelineedit within tabpage_2
int X=558
int Y=352
int Width=1234
int Height=84
int TabOrder=60
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

type sle_12 from singlelineedit within tabpage_2
int X=558
int Y=452
int Width=1234
int Height=84
int TabOrder=30
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

type sle_13 from singlelineedit within tabpage_2
int X=558
int Y=552
int Width=1234
int Height=84
int TabOrder=70
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

type sle_14 from singlelineedit within tabpage_2
int X=558
int Y=652
int Width=1234
int Height=84
int TabOrder=80
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

