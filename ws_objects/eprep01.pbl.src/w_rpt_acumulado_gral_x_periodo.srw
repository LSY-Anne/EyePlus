$PBExportHeader$w_rpt_acumulado_gral_x_periodo.srw
forward
global type w_rpt_acumulado_gral_x_periodo from wa_response
end type
type p_1 from picture within w_rpt_acumulado_gral_x_periodo
end type
type st_mess from statictext within w_rpt_acumulado_gral_x_periodo
end type
type em_ini from uo_editmask within w_rpt_acumulado_gral_x_periodo
end type
type cb_5 from uo_cbdate within w_rpt_acumulado_gral_x_periodo
end type
type st_2 from statictext within w_rpt_acumulado_gral_x_periodo
end type
type em_fin from uo_editmask within w_rpt_acumulado_gral_x_periodo
end type
type cb_fin from uo_cbdate within w_rpt_acumulado_gral_x_periodo
end type
type st_1 from statictext within w_rpt_acumulado_gral_x_periodo
end type
end forward

global type w_rpt_acumulado_gral_x_periodo from wa_response
int Width=1477
int Height=568
long BackColor=80269524
p_1 p_1
st_mess st_mess
em_ini em_ini
cb_5 cb_5
st_2 st_2
em_fin em_fin
cb_fin cb_fin
st_1 st_1
end type
global w_rpt_acumulado_gral_x_periodo w_rpt_acumulado_gral_x_periodo

type variables
String	is_rpt
end variables

event open;call super::open;is_rpt = Message.StringParm

Choose Case is_rpt
	Case 'MAN' 
		Title = 'Reporte de Manifiestos por Fecha'
		dw_list.DataObject = 'd_rpt_manifiesto_x_fechas'
	Case 'EXE' 
		Title = 'Empaques por Etiqueta'
		dw_list.DataObject = 'd_rpt_estadistica_empaque_etiqueta'
	Case 'PXF' /*  */
		Title = 'Pallets por Fecha de Empaque'
		dw_list.DataObject = 'd_rpt_pallet_x_fechas'
	Case 'ESE' /*  */
		Title = 'Estadística de Empaque'
		dw_list.DataObject = 'd_rpt_estadistica_empaque'
	Case 'ESP' /*  */
		Title = 'Estadística de Empaque por Producto'
		dw_list.DataObject = 'd_rpt_estadistica_empaque_prod'
	Case 'AEF' /*  */
		Title = 'Acumulado de Empaque'
		dw_list.DataObject = 'd_rpt_acumulado_empaque_x_fechas'
	Case 'PEF' /*  */
		Title = 'Productos Empacados por Fechas'
		dw_list.DataObject = 'd_rpt_acumulado_empaque_prod_x_fechas'
	Case 'EEC' /*  */
		Title = 'Empaque, Embarques y Costos por Fechas'
		dw_list.DataObject = 'd_rpt_producto_costo_x_fecha'
End Choose
dw_1.Visible = False
dw_list.Visible = False

em_ini.Text = f_GetParmValue( '20' )
em_fin.Text = f_GetParmValue( '20' )

end event

on w_rpt_acumulado_gral_x_periodo.create
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
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_mess
this.Control[iCurrent+3]=this.em_ini
this.Control[iCurrent+4]=this.cb_5
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_fin
this.Control[iCurrent+7]=this.cb_fin
this.Control[iCurrent+8]=this.st_1
end on

on w_rpt_acumulado_gral_x_periodo.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_mess)
destroy(this.em_ini)
destroy(this.cb_5)
destroy(this.st_2)
destroy(this.em_fin)
destroy(this.cb_fin)
destroy(this.st_1)
end on

type dw_list from wa_response`dw_list within w_rpt_acumulado_gral_x_periodo
int X=0
int Y=600
int Width=2423
int Height=1148
int TabOrder=0
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_acumulado_gral_x_periodo
int X=151
int Y=320
int Width=155
int Height=124
int TabOrder=0
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_acumulado_gral_x_periodo
int X=1056
int Y=352
int TabOrder=40
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_acumulado_gral_x_periodo
int X=677
int Y=352
int TabOrder=30
boolean Enabled=true
end type

event cb_aceptar::clicked;DataWindow	ldw_1

SetPointer( HourGlass! )

ldw_1 = f_PreviewXP( 'd_rpt_acumulado_gral_x_periodo' )
ldw_1.Retrieve( gs_codtem, f_StringToDate( em_ini.Text ), f_StringToDate( em_fin.Text ) )

SetPointer( Arrow! )

end event

type p_1 from picture within w_rpt_acumulado_gral_x_periodo
int X=37
int Y=32
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_mess from statictext within w_rpt_acumulado_gral_x_periodo
int X=219
int Y=36
int Width=1198
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

type em_ini from uo_editmask within w_rpt_acumulado_gral_x_periodo
int X=338
int Y=208
end type

type cb_5 from uo_cbdate within w_rpt_acumulado_gral_x_periodo
int X=686
int Y=212
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_2 from statictext within w_rpt_acumulado_gral_x_periodo
int X=850
int Y=212
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

type em_fin from uo_editmask within w_rpt_acumulado_gral_x_periodo
int X=983
int Y=208
int TabOrder=20
end type

type cb_fin from uo_cbdate within w_rpt_acumulado_gral_x_periodo
int X=1326
int Y=212
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type st_1 from statictext within w_rpt_acumulado_gral_x_periodo
int X=219
int Y=212
int Width=119
int Height=76
boolean Enabled=false
string Text="Del:"
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

