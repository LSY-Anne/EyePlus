$PBExportHeader$w_rpt_varios_02.srw
$PBExportComments$Para rpt con rango de fechas
forward
global type w_rpt_varios_02 from wa_response
end type
type p_1 from picture within w_rpt_varios_02
end type
type st_mess from statictext within w_rpt_varios_02
end type
type em_ini from uo_editmask within w_rpt_varios_02
end type
type cb_5 from uo_cbdate within w_rpt_varios_02
end type
type st_2 from statictext within w_rpt_varios_02
end type
type em_fin from uo_editmask within w_rpt_varios_02
end type
type cb_fin from uo_cbdate within w_rpt_varios_02
end type
type st_1 from statictext within w_rpt_varios_02
end type
type cbx_1 from checkbox within w_rpt_varios_02
end type
type em_1 from editmask within w_rpt_varios_02
end type
type em_2 from editmask within w_rpt_varios_02
end type
type st_5 from statictext within w_rpt_varios_02
end type
type st_6 from statictext within w_rpt_varios_02
end type
type cb_1 from commandbutton within w_rpt_varios_02
end type
type cb_2 from commandbutton within w_rpt_varios_02
end type
type dw_2 from datawindow within w_rpt_varios_02
end type
end forward

global type w_rpt_varios_02 from wa_response
int Width=1687
int Height=644
long BackColor=80269524
p_1 p_1
st_mess st_mess
em_ini em_ini
cb_5 cb_5
st_2 st_2
em_fin em_fin
cb_fin cb_fin
st_1 st_1
cbx_1 cbx_1
em_1 em_1
em_2 em_2
st_5 st_5
st_6 st_6
cb_1 cb_1
cb_2 cb_2
dw_2 dw_2
end type
global w_rpt_varios_02 w_rpt_varios_02

type variables
String	is_rpt
end variables

forward prototypes
public function integer wf_buscar_pro1 (string as_cod)
public function integer wf_buscar_pro2 (string as_cod)
end prototypes

public function integer wf_buscar_pro1 (string as_cod);/* wf_BuscarProducto( as_cod ) */

String	ls_nom, ls_parm,ls_cod

as_cod = f_Trim( as_cod )

If as_cod='' Then
	OpenWithParm( w_mant_buscar_x_nombre, 'PRO' )
	ls_parm = Message.StringParm
	
	ls_parm = f_Trim( ls_parm )	
	If Not ls_parm = '' Then
		as_cod = ls_parm
			ls_parm= Trim(Right( '0000' + Trim(ls_parm),4))
		em_1.Text=ls_parm
	End If
Else
	ls_cod= Trim(Right( '0000' + Trim(as_cod),4))
	ls_nom=f_getproducto(ls_cod)
	ls_parm=ls_cod
	If ls_parm <> '' Then
		em_1.Text=ls_parm
	Else
		MessageBox('Mensaje','No se encontro el producto.',Exclamation!)
		em_1.Text=''
	End If
End IF



Return 1
end function

public function integer wf_buscar_pro2 (string as_cod);/* wf_BuscarProducto( as_cod ) */

String	ls_nom, ls_parm,ls_cod

as_cod = f_Trim( as_cod )

If as_cod='' Then
	OpenWithParm( w_mant_buscar_x_nombre, 'PRO' )
	ls_parm = Message.StringParm
	
	ls_parm = f_Trim( ls_parm )	
	If Not ls_parm = '' Then
		as_cod = ls_parm
		em_2.Text=ls_parm
	End If
Else
//	ls_cod=f_FormateaCodigo(as_cod,8)
	ls_nom=f_getproducto(ls_cod)
	ls_parm=ls_cod
	If ls_parm <> '' Then
		em_2.Text=ls_parm
	Else
		MessageBox('Mensaje','No se encontro el producto.',Exclamation!)
		em_2.Text=''
	End If
End IF



Return 1
end function

event open;call super::open;is_rpt = Message.StringParm
datawindowchild ldwc_x
cbx_1.visible = false
dw_2.visible=false
st_6.visible=false
st_1.visible=false
em_1.visible=false
em_2.visible=false
cb_1.visible=false
cb_2.visible=false
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
		cbx_1.visible = true
		dw_2.visible=true
		
		dw_2.SetTransObject( SqlCa )
		dw_2.InsertRow(1)
		dw_2.AcceptText( )
		dw_2.GetChild( 'c_codigo_lot', ldwc_x )
		ldwc_x.SetItem( 1, 'c_codigo_lot', '%' )	
		ldwc_x.SetItem( 1, 'v_nombre_lot', 'Todos' )
		dw_2.Object.c_codigo_lot[1]='%'
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
		st_6.visible=true
		st_1.visible=true
		em_1.visible=true
		em_2.visible=true
		cb_1.visible=true
		cb_2.visible=true
	Case 'EEC' /*  */
		Title = 'Empaque, Embarques y Costos por Fechas'
		dw_list.DataObject = 'd_rpt_producto_costo_x_fecha'
	Case 'REN' /*  */
		Title = 'Empaque, Rendimiento Corte/Empaque'
		dw_list.DataObject = 'd_rpt_rendimiento_x_lote'	
	Case 'AGP' /*  */
		Title = 'Acumulado General por Periodo'
		dw_list.DataObject = 'd_rpt_acumulado_gral_x_periodo'	
	Case 'AET' /*  */
		Title = 'Acumulado de Embarque por Tamaños'
		dw_list.DataObject = 'd_rpt_acumulado_embarcado_x_fechas_tam'
	Case 'ETI' /*  */
		Title = 'Etiquetas Para Clam'
		dw_list.DataObject = 'd_rpt_etiqueta_clam_hortinver'
		em_fin.Visible = False
		st_2.Visible = False
		cb_fin.Visible = False
End Choose
dw_1.Visible = False
dw_list.Visible = False

em_ini.Text = f_GetParmValue( '20' )
em_fin.Text = f_GetParmValue( '20' )

end event

on w_rpt_varios_02.create
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
this.cbx_1=create cbx_1
this.em_1=create em_1
this.em_2=create em_2
this.st_5=create st_5
this.st_6=create st_6
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_mess
this.Control[iCurrent+3]=this.em_ini
this.Control[iCurrent+4]=this.cb_5
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_fin
this.Control[iCurrent+7]=this.cb_fin
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.cbx_1
this.Control[iCurrent+10]=this.em_1
this.Control[iCurrent+11]=this.em_2
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.cb_1
this.Control[iCurrent+15]=this.cb_2
this.Control[iCurrent+16]=this.dw_2
end on

on w_rpt_varios_02.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_mess)
destroy(this.em_ini)
destroy(this.cb_5)
destroy(this.st_2)
destroy(this.em_fin)
destroy(this.cb_fin)
destroy(this.st_1)
destroy(this.cbx_1)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_2)
end on

type dw_list from wa_response`dw_list within w_rpt_varios_02
int X=46
int Y=796
int Width=2423
int Height=1148
int TabOrder=0
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_varios_02
int X=0
int Y=712
int Width=155
int Height=124
int TabOrder=0
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_varios_02
int X=1056
int Y=420
int TabOrder=80
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_varios_02
int X=677
int Y=420
int TabOrder=70
boolean Enabled=true
end type

event cb_aceptar::clicked;STRING ls_lot,ls_pro1,ls_pro2
DataWindow	ldw_1

SetPointer( HourGlass! )
IF cbx_1.checked THEN
	dw_list.DataObject = 'd_rpt_pallet_x_fechas_sc'
ELSEIF is_rpt = 'PXF' THEN
	dw_list.DataObject = 'd_rpt_pallet_x_fechas'
END IF


ldw_1 = f_PreviewXP( dw_list.DataObject )
If is_rpt='PXF' then
	ls_lot=f_trim(dw_2.object.c_codigo_lot[1])
	ldw_1.Retrieve( gs_codtem, f_StringToDate( em_ini.Text ), f_StringToDate( em_fin.Text ) ,ls_lot)
elseif  is_rpt='PEF' then
	ls_pro1=em_1.text
	if ls_pro1='' then
		ls_pro1='0000'
	end if
	ls_pro2=em_2.text
	if ls_pro2='' then
		ls_pro2='9999'
	end if
	ldw_1.Retrieve( gs_codtem, f_StringToDate( em_ini.Text ), f_StringToDate( em_fin.Text ) ,ls_pro1,ls_pro2)
elseif is_rpt <> 'ETI' Then
	ldw_1.Retrieve( gs_codtem, f_StringToDate( em_ini.Text ), f_StringToDate( em_fin.Text ) )

Else
	ldw_1.Retrieve( f_StringToDate( em_ini.Text ) )
End If

SetPointer( Arrow! )
end event

type p_1 from picture within w_rpt_varios_02
int X=37
int Y=32
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_mess from statictext within w_rpt_varios_02
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

type em_ini from uo_editmask within w_rpt_varios_02
int X=288
int Y=208
end type

type cb_5 from uo_cbdate within w_rpt_varios_02
int X=635
int Y=212
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_2 from statictext within w_rpt_varios_02
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

type em_fin from uo_editmask within w_rpt_varios_02
int X=983
int Y=208
int TabOrder=20
end type

type cb_fin from uo_cbdate within w_rpt_varios_02
int X=1326
int Y=212
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type st_1 from statictext within w_rpt_varios_02
int X=905
int Y=316
int Width=302
int Height=76
boolean Enabled=false
string Text="Al Producto:"
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

type cbx_1 from checkbox within w_rpt_varios_02
int X=69
int Y=440
int Width=357
int Height=80
boolean BringToTop=true
string Text="Sin Confirmar"
BorderStyle BorderStyle=StyleLowered!
boolean RightToLeft=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_rpt_varios_02
int X=453
int Y=316
int Width=261
int Height=84
int TabOrder=40
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
MaskDataType MaskDataType=StringMask!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;String	ls_cod

ls_cod = This.Text
wf_buscar_pro1(ls_cod)
end event

type em_2 from editmask within w_rpt_varios_02
int X=1230
int Y=316
int Width=261
int Height=84
int TabOrder=50
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
MaskDataType MaskDataType=StringMask!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;String	ls_cod

ls_cod = This.Text
wf_buscar_pro2(ls_cod)
end event

type st_5 from statictext within w_rpt_varios_02
int X=169
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

type st_6 from statictext within w_rpt_varios_02
int X=119
int Y=316
int Width=320
int Height=76
boolean Enabled=false
string Text="Del Producto:"
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

type cb_1 from commandbutton within w_rpt_varios_02
int X=736
int Y=316
int Width=114
int Height=84
int TabOrder=60
boolean BringToTop=true
string Text="..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_Buscar_pro1( '' )
end event

type cb_2 from commandbutton within w_rpt_varios_02
int X=1513
int Y=316
int Width=114
int Height=84
int TabOrder=50
boolean BringToTop=true
string Text="..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_Buscar_pro2( '' )
end event

type dw_2 from datawindow within w_rpt_varios_02
int X=123
int Y=320
int Width=1467
int Height=76
int TabOrder=30
boolean BringToTop=true
string DataObject="d_lote_ddlb"
boolean Border=false
boolean LiveScroll=true
end type

