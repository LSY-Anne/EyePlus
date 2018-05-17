$PBExportHeader$w_util_configuracion_avanzada.srw
forward
global type w_util_configuracion_avanzada from wa_response
end type
type tab_1 from tab within w_util_configuracion_avanzada
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
type sle_pn from singlelineedit within tabpage_2
end type
type sle_pm from singlelineedit within tabpage_2
end type
type sle_fac from singlelineedit within tabpage_2
end type
type sle_fnac from singlelineedit within tabpage_2
end type
type sle_for from singlelineedit within tabpage_2
end type
type sle_via from singlelineedit within tabpage_2
end type
type st_nota from statictext within w_util_configuracion_avanzada
end type
type p_nota from picture within w_util_configuracion_avanzada
end type
type gb_1 from groupbox within w_util_configuracion_avanzada
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
sle_pn sle_pn
sle_pm sle_pm
sle_fac sle_fac
sle_fnac sle_fnac
sle_for sle_for
sle_via sle_via
end type
type tab_1 from tab within w_util_configuracion_avanzada
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_util_configuracion_avanzada from wa_response
int Width=1970
int Height=1408
boolean TitleBar=true
string Title="Configuración Avanzada"
long BackColor=81324524
tab_1 tab_1
st_nota st_nota
p_nota p_nota
gb_1 gb_1
end type
global w_util_configuracion_avanzada w_util_configuracion_avanzada

on w_util_configuracion_avanzada.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.st_nota=create st_nota
this.p_nota=create p_nota
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_nota
this.Control[iCurrent+3]=this.p_nota
this.Control[iCurrent+4]=this.gb_1
end on

on w_util_configuracion_avanzada.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.st_nota)
destroy(this.p_nota)
destroy(this.gb_1)
end on

event open;call super::open;tab_1.tabpage_1.sle_1.Text = ProfileString( gs_ini, 'Database', 'DBMS', '' )
tab_1.tabpage_1.sle_2.Text = ProfileString( gs_ini, 'Database', 'Database', '' )
tab_1.tabpage_1.sle_3.Text = ProfileString( gs_ini, 'Database', 'UserId', '' )
tab_1.tabpage_1.sle_4.Text = ProfileString( gs_ini, 'Database', 'DatabasePassword', '' )
tab_1.tabpage_1.sle_5.Text = ProfileString( gs_ini, 'Database', 'LogPassword', '' )
tab_1.tabpage_1.sle_6.Text = ProfileString( gs_ini, 'Database', 'ServerName', '' )
tab_1.tabpage_1.sle_7.Text = ProfileString( gs_ini, 'Database', 'LogId', '' )
tab_1.tabpage_1.sle_8.Text = ProfileString( gs_ini, 'Database', 'UserId', '' )


tab_1.tabpage_2.sle_cia.Text = ProfileString( gs_ini, 'System', 'Cia', '' )
tab_1.tabpage_2.sle_pn.Text = ProfileString( gs_ini, 'System', 'dwPallet', '' )
tab_1.tabpage_2.sle_pm.Text = ProfileString( gs_ini, 'System', 'dwPalletMix', '' )
tab_1.tabpage_2.sle_fac.Text = ProfileString( gs_ini, 'System', 'dwFactura', '' )
tab_1.tabpage_2.sle_fnac.Text = ProfileString( gs_ini, 'System', 'dwFacturaNacional', '' )
tab_1.tabpage_2.sle_for.Text = ProfileString( gs_ini, 'System', 'dwFormato', '' )
tab_1.tabpage_2.sle_via.Text = ProfileString( gs_ini, 'System', 'dwControl', '' )


end event

type dw_list from wa_response`dw_list within w_util_configuracion_avanzada
int Y=1200
int Height=124
int TabOrder=50
boolean Visible=false
end type

event dw_list::destructor;/* No hacer nada */

end event

type dw_1 from wa_response`dw_1 within w_util_configuracion_avanzada
int Y=436
int Width=151
int Height=80
int TabOrder=20
boolean Visible=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_util_configuracion_avanzada
int X=1568
int Y=1200
int TabOrder=40
end type

type cb_aceptar from wa_response`cb_aceptar within w_util_configuracion_avanzada
int X=1189
int Y=1200
int TabOrder=30
boolean Enabled=true
end type

event cb_aceptar::clicked;SetProfileString( gs_ini, 'Database', 'DBMS', tab_1.tabpage_1.sle_1.Text )
SetProfileString( gs_ini, 'Database', 'Database', tab_1.tabpage_1.sle_2.Text )
SetProfileString( gs_ini, 'Database', 'UserId', tab_1.tabpage_1.sle_3.Text )
SetProfileString( gs_ini, 'Database', 'DatabasePassword', tab_1.tabpage_1.sle_4.Text )
SetProfileString( gs_ini, 'Database', 'LogPassword', tab_1.tabpage_1.sle_5.Text )
SetProfileString( gs_ini, 'Database', 'ServerName', tab_1.tabpage_1.sle_6.Text )
SetProfileString( gs_ini, 'Database', 'LogId', tab_1.tabpage_1.sle_7.Text )
SetProfileString( gs_ini, 'Database', 'UserId', tab_1.tabpage_1.sle_8.Text )


SetProfileString( gs_ini, 'System', 'Cia', tab_1.tabpage_2.sle_cia.Text )
SetProfileString( gs_ini, 'System', 'dwPallet', tab_1.tabpage_2.sle_pn.Text )
SetProfileString( gs_ini, 'System', 'dwPalletMix', tab_1.tabpage_2.sle_pm.Text )
SetProfileString( gs_ini, 'System', 'dwFactura', tab_1.tabpage_2.sle_fac.Text )
SetProfileString( gs_ini, 'System', 'dwFacturaNacional', tab_1.tabpage_2.sle_fnac.Text )
SetProfileString( gs_ini, 'System', 'dwFormato', tab_1.tabpage_2.sle_for.Text )
SetProfileString( gs_ini, 'System', 'dwControl', tab_1.tabpage_2.sle_via.Text )

Close( Parent )
end event

type tab_1 from tab within w_util_configuracion_avanzada
int X=32
int Y=24
int Width=1883
int Height=984
int TabOrder=10
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
int Width=1847
int Height=868
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
int X=87
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
int X=87
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
int X=87
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
int X=87
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
int X=87
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
int X=87
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
int X=87
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
int X=87
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
int X=571
int Y=52
int Width=1234
int Height=84
int TabOrder=10
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
int X=571
int Y=152
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

type sle_3 from singlelineedit within tabpage_1
int X=571
int Y=252
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

type sle_4 from singlelineedit within tabpage_1
int X=571
int Y=352
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

type sle_5 from singlelineedit within tabpage_1
int X=571
int Y=452
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

type sle_6 from singlelineedit within tabpage_1
int X=571
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
int X=571
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
int X=571
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
int Width=1847
int Height=868
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
sle_pn sle_pn
sle_pm sle_pm
sle_fac sle_fac
sle_fnac sle_fnac
sle_for sle_for
sle_via sle_via
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
this.sle_pn=create sle_pn
this.sle_pm=create sle_pm
this.sle_fac=create sle_fac
this.sle_fnac=create sle_fnac
this.sle_for=create sle_for
this.sle_via=create sle_via
this.Control[]={this.st_s1,&
this.sle_cia,&
this.st_9,&
this.st_10,&
this.st_11,&
this.st_12,&
this.st_13,&
this.st_14,&
this.sle_pn,&
this.sle_pm,&
this.sle_fac,&
this.sle_fnac,&
this.sle_for,&
this.sle_via}
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
destroy(this.sle_pn)
destroy(this.sle_pm)
destroy(this.sle_fac)
destroy(this.sle_fnac)
destroy(this.sle_for)
destroy(this.sle_via)
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
int TabOrder=10
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

type sle_pn from singlelineedit within tabpage_2
int X=558
int Y=152
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

type sle_pm from singlelineedit within tabpage_2
int X=558
int Y=252
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

type sle_fac from singlelineedit within tabpage_2
int X=558
int Y=352
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

type sle_fnac from singlelineedit within tabpage_2
int X=558
int Y=452
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

type sle_for from singlelineedit within tabpage_2
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

type sle_via from singlelineedit within tabpage_2
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

type st_nota from statictext within w_util_configuracion_avanzada
int X=160
int Y=1052
int Width=1705
int Height=112
boolean Enabled=false
string Text="Después de realizar los cambios debe cerrar y reiniciar el sistema para que se efectuen"
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

type p_nota from picture within w_util_configuracion_avanzada
int X=73
int Y=1056
int Width=73
int Height=56
string PictureName="nota.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type gb_1 from groupbox within w_util_configuracion_avanzada
int X=37
int Y=1008
int Width=1883
int Height=168
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

