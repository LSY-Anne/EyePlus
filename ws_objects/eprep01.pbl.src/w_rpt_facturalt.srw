$PBExportHeader$w_rpt_facturalt.srw
forward
global type w_rpt_facturalt from wa_response
end type
type p_1 from picture within w_rpt_facturalt
end type
type st_mess from statictext within w_rpt_facturalt
end type
type em_ini from uo_editmask within w_rpt_facturalt
end type
type cb_5 from uo_cbdate within w_rpt_facturalt
end type
type st_6 from statictext within w_rpt_facturalt
end type
type em_fin from uo_editmask within w_rpt_facturalt
end type
type cb_fin from uo_cbdate within w_rpt_facturalt
end type
type st_2 from statictext within w_rpt_facturalt
end type
type st_1 from statictext within w_rpt_facturalt
end type
type ddlb_mer from dropdownlistbox within w_rpt_facturalt
end type
type st_8 from statictext within w_rpt_facturalt
end type
end forward

global type w_rpt_facturalt from wa_response
int Width=1815
int Height=692
boolean TitleBar=true
string Title="Reporte de Embarques por Embarcador y Cultivo"
long BackColor=80269524
p_1 p_1
st_mess st_mess
em_ini em_ini
cb_5 cb_5
st_6 st_6
em_fin em_fin
cb_fin cb_fin
st_2 st_2
st_1 st_1
ddlb_mer ddlb_mer
st_8 st_8
end type
global w_rpt_facturalt w_rpt_facturalt

type variables
String	is_rpt
end variables

event open;call super::open;DataWindowChild ldwc_x
Long ll_row

is_rpt = Message.StringParm

Choose Case is_rpt
Case 'MSP'
		Title = 'Reporte de Manifiestos Sin Pagar'
Case 'PDF'
		Title = 'Reporte de Pago de Fletes '
End Choose


dw_1.InsertRow( 0 )
//dw_1.Object.c_codigo_emb.Width = 1050

dw_1.settransobject(sqlca)
dw_1.insertrow(0)
dw_1.GetChild('v_nombre_lit', ldwc_x)
ll_row=ldwc_x.InsertRow(0)
ldwc_x.SetItem(ll_row, 'c_codigo_lit', '%')
ldwc_x.SetItem(ll_row, 'v_nombre_lit', 'TODOS')
dw_1.object.v_nombre_lit[1]='TODOS'

dw_list.Visible = true

em_ini.Text = String( gd_sys, 'dd/mm/yyyy' )
em_fin.Text = String( gd_sys, 'dd/mm/yyyy' )
//em_ini.Text = f_GetParmValue( '20' )
//em_fin.Text = f_GetParmValue( '20' )


end event

on w_rpt_facturalt.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_mess=create st_mess
this.em_ini=create em_ini
this.cb_5=create cb_5
this.st_6=create st_6
this.em_fin=create em_fin
this.cb_fin=create cb_fin
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_mer=create ddlb_mer
this.st_8=create st_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_mess
this.Control[iCurrent+3]=this.em_ini
this.Control[iCurrent+4]=this.cb_5
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.em_fin
this.Control[iCurrent+7]=this.cb_fin
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.ddlb_mer
this.Control[iCurrent+11]=this.st_8
end on

on w_rpt_facturalt.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_mess)
destroy(this.em_ini)
destroy(this.cb_5)
destroy(this.st_6)
destroy(this.em_fin)
destroy(this.cb_fin)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_mer)
destroy(this.st_8)
end on

type dw_list from wa_response`dw_list within w_rpt_facturalt
int X=69
int Y=612
int Width=1755
int Height=152
int TabOrder=0
boolean Visible=false
string DataObject="d_rpt_embarques_x_embarcador_x_cul"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_facturalt
int X=485
int Y=152
int Width=1312
int Height=92
string DataObject="d_rpt_linea_trans"
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_facturalt
int X=983
int Y=468
int TabOrder=50
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_facturalt
int X=517
int Y=468
int TabOrder=40
boolean Enabled=true
end type

event cb_aceptar::clicked;String	ls_lit, ls_mer, ls_ini, ls_fin
Datetime ld_ini, ld_fin

is_rpt = Message.StringParm

ls_lit = f_trim(dw_1.object.v_nombre_lit[1])

ls_lit = Upper(ls_lit)

if ls_lit = 'TODOS' then
	ls_lit = '%'
end if

ls_ini = f_trim(em_ini.text)
if (em_ini.text = '') or (em_ini.text = '00/00/0000') then
	messagebox(title,'Debe escribir una fecha inicial',exclamation!)
	setfocus(em_ini)
	return 1
end if

ls_fin = f_trim(em_fin.text)
if (em_fin.text = '') or (em_fin.text = '00/00/0000') then
	messagebox(title,'Debe escribir una fecha final',exclamation!)
	setfocus(em_fin)
	return 1
end if

ld_ini = datetime(date(em_ini.text))
ld_fin = datetime(date(em_fin.text))

if ld_ini > ld_fin then
	messagebox(title,'La fecha inicial NO debe ser mayor que la fecha final',exclamation!)
	setfocus(em_ini)
	return 1
end if

ls_mer = Upper( Left( ddlb_mer.Text, 1 ) )
If ls_mer = 'A' Then
	ls_mer = '%'
End If

Choose Case is_rpt
Case 'MSP'
		dw_list.dataobject='d_rpt_facturalt_msp'
Case 'PDF'
		dw_list.dataobject='d_rpt_facturalt_pdf'
End Choose




SetPointer( HourGlass! )
dw_list.SetTransObject( SqlCa )
dw_list.Retrieve( ls_lit, ld_ini, ld_fin,ls_mer )
SetPointer( Arrow! )

f_Preview( dw_list )
end event

type p_1 from picture within w_rpt_facturalt
int X=37
int Y=32
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_mess from statictext within w_rpt_facturalt
int X=219
int Y=36
int Width=1563
int Height=120
boolean Enabled=false
boolean BringToTop=true
string Text="Para emitir el reporte, complete los datos solicitados y luego haga clic en el botón Aceptar"
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

type em_ini from uo_editmask within w_rpt_facturalt
int X=485
int Y=248
int TabOrder=20
end type

type cb_5 from uo_cbdate within w_rpt_facturalt
int X=910
int Y=252
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_6 from statictext within w_rpt_facturalt
int X=1175
int Y=256
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

type em_fin from uo_editmask within w_rpt_facturalt
int X=1257
int Y=248
int TabOrder=30
end type

type cb_fin from uo_cbdate within w_rpt_facturalt
int X=1701
int Y=252
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type st_2 from statictext within w_rpt_facturalt
int X=174
int Y=256
int Width=311
int Height=76
boolean Enabled=false
string Text="Facturas Del: "
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

type st_1 from statictext within w_rpt_facturalt
int X=9
int Y=152
int Width=471
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Linea de Transporte: "
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

type ddlb_mer from dropdownlistbox within w_rpt_facturalt
int X=485
int Y=352
int Width=1074
int Height=324
int TabOrder=30
boolean BringToTop=true
string Text="Ambos"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Ambos",&
"Extranjero",&
"Nacional"}
end type

type st_8 from statictext within w_rpt_facturalt
int X=251
int Y=360
int Width=219
int Height=76
boolean Enabled=false
string Text="Mercado:"
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

