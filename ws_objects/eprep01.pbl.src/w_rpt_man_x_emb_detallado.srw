$PBExportHeader$w_rpt_man_x_emb_detallado.srw
forward
global type w_rpt_man_x_emb_detallado from wa_response
end type
type p_1 from picture within w_rpt_man_x_emb_detallado
end type
type st_mess from statictext within w_rpt_man_x_emb_detallado
end type
type em_ini from uo_editmask within w_rpt_man_x_emb_detallado
end type
type cb_5 from uo_cbdate within w_rpt_man_x_emb_detallado
end type
type st_2 from statictext within w_rpt_man_x_emb_detallado
end type
type em_fin from uo_editmask within w_rpt_man_x_emb_detallado
end type
type cb_fin from uo_cbdate within w_rpt_man_x_emb_detallado
end type
type st_1 from statictext within w_rpt_man_x_emb_detallado
end type
type st_3 from statictext within w_rpt_man_x_emb_detallado
end type
type ddlb_mer from dropdownlistbox within w_rpt_man_x_emb_detallado
end type
type st_4 from statictext within w_rpt_man_x_emb_detallado
end type
end forward

global type w_rpt_man_x_emb_detallado from wa_response
int Width=1979
int Height=680
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
st_3 st_3
ddlb_mer ddlb_mer
st_4 st_4
end type
global w_rpt_man_x_emb_detallado w_rpt_man_x_emb_detallado

type variables
String	is_rpt
end variables

event open;call super::open;is_rpt = Message.StringParm


dw_1.InsertRow( 0 )
dw_1.Object.c_codigo_emb.Width = 1050



dw_list.Visible = true

dw_list.dataobject='d_rpt_man_x_emb_detallado'

em_ini.Text = f_GetParmValue( '20' )
em_fin.Text = f_GetParmValue( '20' )

end event

on w_rpt_man_x_emb_detallado.create
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
this.st_3=create st_3
this.ddlb_mer=create ddlb_mer
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_mess
this.Control[iCurrent+3]=this.em_ini
this.Control[iCurrent+4]=this.cb_5
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_fin
this.Control[iCurrent+7]=this.cb_fin
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.ddlb_mer
this.Control[iCurrent+11]=this.st_4
end on

on w_rpt_man_x_emb_detallado.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_mess)
destroy(this.em_ini)
destroy(this.cb_5)
destroy(this.st_2)
destroy(this.em_fin)
destroy(this.cb_fin)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.ddlb_mer)
destroy(this.st_4)
end on

type dw_list from wa_response`dw_list within w_rpt_man_x_emb_detallado
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

type dw_1 from wa_response`dw_1 within w_rpt_man_x_emb_detallado
int X=430
int Y=188
int Width=1065
int Height=92
string DataObject="d_ext_embarcador"
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_man_x_emb_detallado
int X=1568
int Y=176
int TabOrder=50
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_man_x_emb_detallado
int X=1568
int Y=56
int TabOrder=40
boolean Enabled=true
end type

event cb_aceptar::clicked;String	ls_emb, ls_mer

ls_emb = f_Trim( dw_1.Object.c_codigo_emb[1] )

If ls_emb = '' Then
	If MessageBox( Title, 'No especificó el embarcador.~r~n' + &
								'¿Desea el reporte con todos los embarcadores?', Question!, YesNo! ) <> 1 Then
		dw_1.SetFocus( )
		Return
	End If
	ls_emb = '%'
End If

ls_mer = Upper( Left( ddlb_mer.Text, 1 ) )
If ls_mer = 'A' Then
	ls_mer = '%'
End If

SetPointer( HourGlass! )
dw_list.SetTransObject( SqlCa )
dw_list.Retrieve( gs_codtem, f_StringToDate( em_ini.Text ), f_StringToDate( em_fin.Text ), ls_emb, ls_mer )
SetPointer( Arrow! )

f_Preview( dw_list )
end event

type p_1 from picture within w_rpt_man_x_emb_detallado
int X=37
int Y=32
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_mess from statictext within w_rpt_man_x_emb_detallado
int X=219
int Y=36
int Width=1289
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

type em_ini from uo_editmask within w_rpt_man_x_emb_detallado
int X=430
int Y=316
int TabOrder=20
end type

type cb_5 from uo_cbdate within w_rpt_man_x_emb_detallado
int X=777
int Y=320
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_2 from statictext within w_rpt_man_x_emb_detallado
int X=942
int Y=328
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

type em_fin from uo_editmask within w_rpt_man_x_emb_detallado
int X=1074
int Y=316
int TabOrder=30
end type

type cb_fin from uo_cbdate within w_rpt_man_x_emb_detallado
int X=1417
int Y=320
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type st_1 from statictext within w_rpt_man_x_emb_detallado
int X=73
int Y=328
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

type st_3 from statictext within w_rpt_man_x_emb_detallado
int X=78
int Y=200
int Width=283
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Embarcador:"
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

type ddlb_mer from dropdownlistbox within w_rpt_man_x_emb_detallado
int X=430
int Y=448
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

type st_4 from statictext within w_rpt_man_x_emb_detallado
int X=73
int Y=464
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

