$PBExportHeader$w_rpt_embarcado_x_color.srw
forward
global type w_rpt_embarcado_x_color from wa_response
end type
type p_1 from picture within w_rpt_embarcado_x_color
end type
type st_mess from statictext within w_rpt_embarcado_x_color
end type
type em_ini from uo_editmask within w_rpt_embarcado_x_color
end type
type cb_5 from uo_cbdate within w_rpt_embarcado_x_color
end type
type st_2 from statictext within w_rpt_embarcado_x_color
end type
type em_fin from uo_editmask within w_rpt_embarcado_x_color
end type
type cb_fin from uo_cbdate within w_rpt_embarcado_x_color
end type
type st_1 from statictext within w_rpt_embarcado_x_color
end type
type ddlb_mer from dropdownlistbox within w_rpt_embarcado_x_color
end type
type st_4 from statictext within w_rpt_embarcado_x_color
end type
type cbx_1 from checkbox within w_rpt_embarcado_x_color
end type
type st_3 from statictext within w_rpt_embarcado_x_color
end type
type cbx_2 from checkbox within w_rpt_embarcado_x_color
end type
type st_5 from statictext within w_rpt_embarcado_x_color
end type
type dw_2 from datawindow within w_rpt_embarcado_x_color
end type
type st_6 from statictext within w_rpt_embarcado_x_color
end type
type man1 from singlelineedit within w_rpt_embarcado_x_color
end type
type st_7 from statictext within w_rpt_embarcado_x_color
end type
type man2 from singlelineedit within w_rpt_embarcado_x_color
end type
type cb_6 from uo_cbdate within w_rpt_embarcado_x_color
end type
type cb_7 from uo_cbdate within w_rpt_embarcado_x_color
end type
type st_nota from statictext within w_rpt_embarcado_x_color
end type
type cbx_3 from checkbox within w_rpt_embarcado_x_color
end type
end forward

global type w_rpt_embarcado_x_color from wa_response
int Width=1646
int Height=720
boolean TitleBar=true
string Title="Reporte de Embarques por Embarcador y Cultivo"
long BackColor=80269524
p_1 p_1
st_mess st_mess
em_ini em_ini
cb_5 cb_5
st_2 st_2
em_fin em_fin
cb_fin cb_fin
st_1 st_1
ddlb_mer ddlb_mer
st_4 st_4
cbx_1 cbx_1
st_3 st_3
cbx_2 cbx_2
st_5 st_5
dw_2 dw_2
st_6 st_6
man1 man1
st_7 st_7
man2 man2
cb_6 cb_6
cb_7 cb_7
st_nota st_nota
cbx_3 cbx_3
end type
global w_rpt_embarcado_x_color w_rpt_embarcado_x_color

type variables
String	is_rpt
end variables

event open;call super::open;is_rpt = Message.StringParm


dw_1.InsertRow( 0 )

dw_list.Visible = true


dw_list.dataobject='d_rpt_embarcado_x_color'


em_ini.Text = f_GetParmValue( '20' )
em_fin.Text = f_GetParmValue( '20' )

end event

on w_rpt_embarcado_x_color.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_mess=create st_mess
this.em_ini=create em_ini
this.cb_5=create cb_5
this.st_2=create st_2
this.em_fin=create em_fin
this.cb_fin=create cb_fin
this.st_1=create st_1
this.ddlb_mer=create ddlb_mer
this.st_4=create st_4
this.cbx_1=create cbx_1
this.st_3=create st_3
this.cbx_2=create cbx_2
this.st_5=create st_5
this.dw_2=create dw_2
this.st_6=create st_6
this.man1=create man1
this.st_7=create st_7
this.man2=create man2
this.cb_6=create cb_6
this.cb_7=create cb_7
this.st_nota=create st_nota
this.cbx_3=create cbx_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_mess
this.Control[iCurrent+3]=this.em_ini
this.Control[iCurrent+4]=this.cb_5
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_fin
this.Control[iCurrent+7]=this.cb_fin
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.ddlb_mer
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.cbx_1
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.cbx_2
this.Control[iCurrent+14]=this.st_5
this.Control[iCurrent+15]=this.dw_2
this.Control[iCurrent+16]=this.st_6
this.Control[iCurrent+17]=this.man1
this.Control[iCurrent+18]=this.st_7
this.Control[iCurrent+19]=this.man2
this.Control[iCurrent+20]=this.cb_6
this.Control[iCurrent+21]=this.cb_7
this.Control[iCurrent+22]=this.st_nota
this.Control[iCurrent+23]=this.cbx_3
end on

on w_rpt_embarcado_x_color.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_mess)
destroy(this.em_ini)
destroy(this.cb_5)
destroy(this.st_2)
destroy(this.em_fin)
destroy(this.cb_fin)
destroy(this.st_1)
destroy(this.ddlb_mer)
destroy(this.st_4)
destroy(this.cbx_1)
destroy(this.st_3)
destroy(this.cbx_2)
destroy(this.st_5)
destroy(this.dw_2)
destroy(this.st_6)
destroy(this.man1)
destroy(this.st_7)
destroy(this.man2)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.st_nota)
destroy(this.cbx_3)
end on

type dw_list from wa_response`dw_list within w_rpt_embarcado_x_color
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

type dw_1 from wa_response`dw_1 within w_rpt_embarcado_x_color
int X=297
int Y=248
int Width=119
int Height=44
boolean Visible=false
boolean Enabled=false
boolean LiveScroll=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_embarcado_x_color
int X=1010
int Y=496
int TabOrder=80
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_embarcado_x_color
int X=590
int Y=496
int TabOrder=60
boolean Enabled=true
end type

event cb_aceptar::clicked;String	ls_emb, ls_mer, ls_man1, ls_man2
Integer li_count

ls_mer = Upper( Left( ddlb_mer.Text, 1 ) )
If ls_mer = 'A' Then
	ls_mer = '%'
End If

if man1.text <> '' and man2.text <> '' then
	ls_man1 = man1.text
	select count(*)
	into :li_count
	from t_manifiesto
	where c_codigo_man = :ls_man1
	using sqlca;
	
	if li_count = 0 then
		messagebox (title, 'Manifiesto Inicial No Encontrado')
		return
	end if
	
	ls_man2 = man2.text
	select count(*)
	into :li_count
	from t_manifiesto
	where c_codigo_man = :ls_man2
	using sqlca;

	if li_count = 0 then
		messagebox (title, 'Manifiesto Final No Encontrado')
		return
	end if
elseif man1.text <> '' and man2.text = '' then
	ls_man1 = man1.text
	select count(*)
	into :li_count
	from t_manifiesto
	where c_codigo_man = :ls_man1
	using sqlca;
	
	if li_count = 0 then
		messagebox (title, 'Manifiesto No Encontrado')
		return
	end if
elseif man1.text = '' and man2.text <> '' then
		ls_man2 = man2.text
		select count(*)
		into :li_count
		from t_manifiesto
		where c_codigo_man = :ls_man2
		using sqlca;
	
	if li_count = 0 then
		messagebox (title, 'Manifiesto No Encontrado')
		return
	end if	
elseif man1.text = '' and man2.text = '' then
	ls_man1 = '%'
	ls_man2 = '%' 
end if

SetPointer( HourGlass! )

if cbx_1.checked and cbx_2.checked then
	return 01
end if

if cbx_1.checked then
	dw_list.dataobject='d_rpt_emb_color'
else
	dw_list.dataobject='d_rpt_embarcado_x_color'
end if

if man1.text <> '' and man2.text <> '' and cbx_2.checked then
	ls_man1 = right(man1.text,4)
	ls_man2 = right(man2.text,4)
	if ls_man1 > ls_man2 then
		messagebox (title, 'Rango de Manifiestos Incorrecto, Manifiesto Inicial Mayor Que el Final')
		return
	end if	
	dw_list.dataobject='d_rpt_embarcado_x_color_manifiesto_2'
	dw_list.SetTransObject( SqlCa )
	dw_list.Retrieve( gs_codtem, ls_mer, ls_man1, ls_man2, f_StringToDate( em_ini.Text ), f_StringToDate( em_fin.Text ))
	SetPointer( Arrow! )
	
	f_Preview( dw_list )
	return	
elseif cbx_2.checked and man1.text = '' and man2.text <> '' then
	ls_man1 = man2.text
	dw_list.dataobject='d_rpt_embarcado_x_color_manifiesto'
	dw_list.SetTransObject( SqlCa )
	dw_list.Retrieve( gs_codtem, ls_mer, ls_man1, f_StringToDate( em_ini.Text ), f_StringToDate( em_fin.Text ))
	SetPointer( Arrow! )
	
	f_Preview( dw_list )
	return
elseif cbx_2.checked and man1.text = '' and man2.text = '' then
	messagebox (title, 'Rango de Manifiestos Incorrecto')
	return
end if

if cbx_2.checked and man1.text <> '' and man2.text = '' then
	ls_man1 = man1.text
	dw_list.dataobject='d_rpt_embarcado_x_color_manifiesto'
	dw_list.SetTransObject( SqlCa )
	dw_list.Retrieve( gs_codtem, ls_mer, ls_man1, f_StringToDate( em_ini.Text ), f_StringToDate( em_fin.Text ))
	SetPointer( Arrow! )
	
	f_Preview( dw_list )
	return
end if
	
if cbx_3.checked then
	dw_list.dataobject = 'd_rpt_embarcado_color_sanita'
	dw_list.SetTransObject( SqlCa )
	dw_list.Retrieve(gs_codtem,ls_man1)
else
	dw_list.SetTransObject( SqlCa )
	dw_list.Retrieve( gs_codtem, ls_mer, f_StringToDate( em_ini.Text ), f_StringToDate( em_fin.Text )  )
end if
	SetPointer( Arrow! )

f_Preview( dw_list )
end event

type p_1 from picture within w_rpt_embarcado_x_color
int X=37
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_mess from statictext within w_rpt_embarcado_x_color
int X=219
int Y=4
int Width=1143
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

type em_ini from uo_editmask within w_rpt_embarcado_x_color
int X=430
int Y=120
int TabOrder=20
end type

type cb_5 from uo_cbdate within w_rpt_embarcado_x_color
int X=768
int Y=124
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_2 from statictext within w_rpt_embarcado_x_color
int X=887
int Y=132
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

type em_fin from uo_editmask within w_rpt_embarcado_x_color
int X=955
int Y=120
int TabOrder=40
end type

type cb_fin from uo_cbdate within w_rpt_embarcado_x_color
int X=1298
int Y=124
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type st_1 from statictext within w_rpt_embarcado_x_color
int X=73
int Y=132
int Width=352
int Height=76
boolean Enabled=false
string Text="Embarques Del:"
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

type ddlb_mer from dropdownlistbox within w_rpt_embarcado_x_color
int X=430
int Y=224
int Width=882
int Height=324
int TabOrder=50
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

type st_4 from statictext within w_rpt_embarcado_x_color
int X=73
int Y=244
int Width=352
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

type cbx_1 from checkbox within w_rpt_embarcado_x_color
int X=617
int Y=416
int Width=55
int Height=72
boolean BringToTop=true
string Text="Para Exportar"
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

event clicked;if cbx_1.checked then
	cbx_2.visible = true
	cbx_1.visible = true
else
	cbx_2.visible = true
	cbx_1.visible = true
end if
end event

type st_3 from statictext within w_rpt_embarcado_x_color
int X=681
int Y=424
int Width=343
int Height=52
boolean Enabled=false
boolean BringToTop=true
string Text="Para Exportar"
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

type cbx_2 from checkbox within w_rpt_embarcado_x_color
int X=1019
int Y=416
int Width=69
int Height=76
boolean BringToTop=true
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

event clicked;
if cbx_2.checked then
	cbx_2.visible = true
	cbx_1.visible = true
	cbx_3.checked = false //20071226
else
	cbx_2.visible = true
	cbx_1.visible = true
end if
end event

type st_5 from statictext within w_rpt_embarcado_x_color
int X=1088
int Y=424
int Width=306
int Height=52
boolean Enabled=false
boolean BringToTop=true
string Text="Por Manifiesto"
Alignment Alignment=Right!
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

type dw_2 from datawindow within w_rpt_embarcado_x_color
int X=1390
int Y=1112
int Width=160
int Height=96
int TabOrder=100
boolean BringToTop=true
string DataObject="d_rpt_embarcado_x_color_manifiesto"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type st_6 from statictext within w_rpt_embarcado_x_color
int X=73
int Y=344
int Width=352
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="Manifiesto:"
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

type man1 from singlelineedit within w_rpt_embarcado_x_color
int X=434
int Y=332
int Width=251
int Height=76
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

event losefocus;String ls_man
Integer li_count

if man1.text = '' then
	return
end if

ls_man = man1.text

select count(*)
into :li_count
from t_manifiesto
where c_codigo_man = :ls_man
using sqlca;

if li_count = 0 then
	messagebox (title, 'Manifiesto Inicial No Encontrado')
end if
end event

type st_7 from statictext within w_rpt_embarcado_x_color
int X=841
int Y=344
int Width=101
int Height=56
boolean Enabled=false
boolean BringToTop=true
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

type man2 from singlelineedit within w_rpt_embarcado_x_color
int X=965
int Y=336
int Width=251
int Height=76
int TabOrder=90
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

event losefocus;String ls_man
Integer li_count

if man2.text = '' then
	return
end if

ls_man = man2.text

select count(*)
into :li_count
from t_manifiesto
where c_codigo_man = :ls_man
using sqlca;

if li_count = 0 then
	messagebox (title, 'Manifiesto Final No Encontrado')
end if
end event

type cb_6 from uo_cbdate within w_rpt_embarcado_x_color
int X=695
int Y=332
int TabOrder=30
end type

event clicked;string ls_parm

open (w_arch_manifiesto_abrir_2)
	ls_parm = Message.StringParm	
	ls_parm = f_Trim( ls_parm )
	man1.text=ls_parm
end event

type cb_7 from uo_cbdate within w_rpt_embarcado_x_color
int X=1230
int Y=332
int TabOrder=20
end type

event clicked;string ls_parm

open (w_arch_manifiesto_abrir_2)
	ls_parm = Message.StringParm	
	ls_parm = f_Trim( ls_parm )
	man2.text=ls_parm
end event

type st_nota from statictext within w_rpt_embarcado_x_color
int X=23
int Y=420
int Width=549
int Height=164
boolean Enabled=false
boolean BringToTop=true
string Text="NOTA: Este reporte solo es válido si se manejan los colores."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_3 from checkbox within w_rpt_embarcado_x_color
int X=1330
int Y=336
int Width=288
int Height=80
boolean BringToTop=true
string Text="S.anita"
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

event clicked;if cbx_3.checked then
	cbx_2.checked = false
end if
end event

