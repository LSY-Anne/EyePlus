$PBExportHeader$w_rpt_etiquetas.srw
forward
global type w_rpt_etiquetas from wa_response
end type
type cb_buscar from uo_cbother within w_rpt_etiquetas
end type
type em_ini from uo_editmask within w_rpt_etiquetas
end type
type cb_5 from uo_cbdate within w_rpt_etiquetas
end type
type st_2 from statictext within w_rpt_etiquetas
end type
type em_fin from uo_editmask within w_rpt_etiquetas
end type
type cb_fin from uo_cbdate within w_rpt_etiquetas
end type
type rb_2 from radiobutton within w_rpt_etiquetas
end type
type sle_1 from singlelineedit within w_rpt_etiquetas
end type
type rb_1 from radiobutton within w_rpt_etiquetas
end type
end forward

global type w_rpt_etiquetas from wa_response
int Width=1970
int Height=1056
boolean TitleBar=true
string Title="Reimpresión de Etiquetas (papeletas)"
cb_buscar cb_buscar
em_ini em_ini
cb_5 cb_5
st_2 st_2
em_fin em_fin
cb_fin cb_fin
rb_2 rb_2
sle_1 sle_1
rb_1 rb_1
end type
global w_rpt_etiquetas w_rpt_etiquetas

type variables
String	is_rpt
end variables

event open;call super::open;is_rpt = Message.StringParm

Choose Case is_rpt
	Case 'ESE' /*  */
		Title = 'Estadística de Empaque'
		dw_1.DataObject = 'd_rpt_estadistica_empaque'
End Choose
dw_1.Visible = False

em_ini.uof_SetToday( )
em_fin.uof_SetToday( )

end event

on w_rpt_etiquetas.create
int iCurrent
call super::create
this.cb_buscar=create cb_buscar
this.em_ini=create em_ini
this.cb_5=create cb_5
this.st_2=create st_2
this.em_fin=create em_fin
this.cb_fin=create cb_fin
this.rb_2=create rb_2
this.sle_1=create sle_1
this.rb_1=create rb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_buscar
this.Control[iCurrent+2]=this.em_ini
this.Control[iCurrent+3]=this.cb_5
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.em_fin
this.Control[iCurrent+6]=this.cb_fin
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.sle_1
this.Control[iCurrent+9]=this.rb_1
end on

on w_rpt_etiquetas.destroy
call super::destroy
destroy(this.cb_buscar)
destroy(this.em_ini)
destroy(this.cb_5)
destroy(this.st_2)
destroy(this.em_fin)
destroy(this.cb_fin)
destroy(this.rb_2)
destroy(this.sle_1)
destroy(this.rb_1)
end on

type dw_list from wa_response`dw_list within w_rpt_etiquetas
int X=41
int Y=264
int Width=1870
int Height=556
int TabOrder=50
string DataObject="d_rpt_lista_etiquetas_aux"
end type

event dw_list::getfocus;cb_buscar.Default = False
cb_aceptar.Default = True
end event

type dw_1 from wa_response`dw_1 within w_rpt_etiquetas
int X=55
int Y=848
int Width=91
int Height=76
int TabOrder=0
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_etiquetas
int X=1563
int Y=844
int TabOrder=70
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_etiquetas
int X=1184
int Y=844
int TabOrder=60
boolean Enabled=true
end type

event cb_aceptar::clicked;Integer	li_tipo
String	ls_tem, ls_cod, ls_dwp, ls_pallet, ls_print

SetPointer( HourGlass! )

If dw_list.RowCount( ) <= 0 Then
	MessageBox( Title, 'No existe ningún pallet en el listado', Exclamation! )
	Return
End If

ls_cod = dw_list.Object.c_codigo_pal[ dw_list.GetRow()]
ls_tem = dw_list.Object.c_codigo_tem[ dw_list.GetRow()]


ls_dwp = ProfileString( gs_ini, 'System', 'dwPallet', 'd_rpt_pallet_std' )
If li_tipo > 1 Then 
	ls_dwp = ProfileString( gs_ini, 'System', 'dwPalletMix', 'd_rpt_pallet_mixto' )
End If
dw_1.DataObject = ls_dwp

dw_1.SetTransObject( SqlCa )
dw_1.Retrieve( ls_tem, ls_cod ) 

SetPointer( Arrow! )

ls_pallet = ProfileString ( gs_ini, 'Printers', 'P-'+f_getpcname(), "")

If ls_pallet = '' Then
	MessageBox('ATENCION:', 'No se ha seleccionado la impresora de default para imprimir pallets.', Information!)
Else
	ls_print = f_getprinter('N', "")
	f_getPrinter('S', ls_pallet)
End If	

f_Preview( dw_1 )

//f_getPrinter('S', ls_print)
end event

type cb_buscar from uo_cbother within w_rpt_etiquetas
int X=1550
int Y=140
int TabOrder=40
string Text="&Buscar"
end type

event clicked;DateTime	ld_ini, ld_fin
String	ls_pal

ls_pal = f_Trim( sle_1.Text ) + '%'
If rb_1.Checked Then
	If ls_pal = '%' Then 
		MessageBox( Title, 'Debe ingresar el número de pallet o parte de este.', Exclamation! )
		Return
	Else
		SetNull( ld_ini )
		SetNull( ld_fin )
	End If
Else
	SetNull( ls_pal )
	ld_ini = f_StringToDate( em_ini.Text )
	ld_fin = f_StringToDate( em_fin.Text )
End If

dw_list.Retrieve( ld_ini, ld_fin, ls_pal )
dw_list.SetFocus( )
end event

type em_ini from uo_editmask within w_rpt_etiquetas
int X=457
int Y=144
int TabOrder=20
end type

event getfocus;rb_2.Checked = True
cb_buscar.Default = True
cb_aceptar.Default = False
end event

type cb_5 from uo_cbdate within w_rpt_etiquetas
int X=805
int Y=148
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_2 from statictext within w_rpt_etiquetas
int X=955
int Y=148
int Width=73
int Height=76
boolean Enabled=false
string Text="Al:"
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

type em_fin from uo_editmask within w_rpt_etiquetas
int X=1088
int Y=144
int TabOrder=30
end type

event modified;rb_2.Checked = True
cb_buscar.Default = True
cb_aceptar.Default = False
end event

type cb_fin from uo_cbdate within w_rpt_etiquetas
int X=1435
int Y=148
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type rb_2 from radiobutton within w_rpt_etiquetas
int X=37
int Y=144
int Width=407
int Height=76
boolean BringToTop=true
string Text="Empacadas el:"
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

type sle_1 from singlelineedit within w_rpt_etiquetas
int X=457
int Y=32
int Width=425
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

event getfocus;rb_1.Checked = True
cb_buscar.Default = True
cb_aceptar.Default = False
end event

type rb_1 from radiobutton within w_rpt_etiquetas
int X=37
int Y=36
int Width=416
int Height=76
boolean BringToTop=true
string Text="Del Pallet Nro:"
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

