$PBExportHeader$w_rpt_varios_01.srw
$PBExportComments$para reportes sin parametros
forward
global type w_rpt_varios_01 from wa_response
end type
type p_1 from picture within w_rpt_varios_01
end type
type st_1 from statictext within w_rpt_varios_01
end type
end forward

global type w_rpt_varios_01 from wa_response
int Width=1166
int Height=456
boolean TitleBar=true
string Title="Tabla de Productos por Costo"
p_1 p_1
st_1 st_1
end type
global w_rpt_varios_01 w_rpt_varios_01

type variables
String	is_rpt
end variables

event open;call super::open;is_rpt = Message.StringParm

Choose Case is_rpt
	Case 'PXC' /* Productos x Costo */
		Title = 'Tabla de Productos por Costo'
		dw_list.DataObject = 'd_rpt_producto_costo'
	Case 'ECD' /* Productos x Costo Diario */
		Title = 'Empaque por Costo Diario'
		dw_list.DataObject = 'd_rpt_acumulado_empaque_costo'
	Case 'DEE' /* Diario de Empaque y embarque */
		Title = 'Diario de Empaque y Embarque '
		dw_list.DataObject = 'd_rpt_acumulado_eye_espe'	
End Choose
dw_1.Visible = False
dw_list.Visible = False

end event

on w_rpt_varios_01.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_1
end on

on w_rpt_varios_01.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_1)
end on

type dw_list from wa_response`dw_list within w_rpt_varios_01
int X=9
int Y=320
int Width=137
int Height=112
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean VScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_varios_01
int X=178
int Y=320
int Width=155
int Height=124
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_varios_01
int X=754
int Y=232
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_varios_01
int X=375
int Y=232
boolean Enabled=true
end type

event cb_aceptar::clicked;DataWindow	ldw_1
Dec{4}	ldc_tc

SetPointer( HourGlass! )
dw_list.SetTransObject( SqlCa )

Choose Case is_rpt
	Case 'PXC' /* Productos x Costo */
		ldw_1 = f_PreviewXP( 'd_rpt_producto_costo' )
		ldw_1.Retrieve( )
	Case 'ECD' /* Productos x Costo Diario */
		f_GetSysDate( )
		ldc_tc = f_GetTipoCambio( gd_sys )
		
		//CAMBIO: 20100125 AaronS - Cambio Funcion Para Procesar Costos (Puede Procesar el dia y todo Historico, Saca Costo Por Kilo y Corrige errorres varios
		If f_util_procesa_costos('N', gd_sys) = 1 Then
			//If f_UtilAcumulaEmpaqueyCostoDiario( ldc_tc ) = 1 Then
			If f_UtilAcumulaManoObraDiario( ldc_tc ) = 1 Then
				Commit Using SqlCa ;
			Else
				RollBack Using SqlCa ;
			End If
		Else
			RollBack Using SqlCa ;
		End If
		ldw_1 = f_PreviewXP( 'd_rpt_acumulado_empaque_costo' )
		ldw_1.Retrieve(gs_codtem, gd_sys, ldc_tc)
   Case 'DEE' /* Diario de Empaque y Embarque por producto etiqueta */
		ldw_1 = f_PreviewXP( 'd_rpt_acumulado_eye_espe' )
		ldw_1.Retrieve( gs_codtem )
End Choose

SetPointer( HourGlass! )

Close( Parent )
end event

type p_1 from picture within w_rpt_varios_01
int X=37
int Y=32
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_1 from statictext within w_rpt_varios_01
int X=247
int Y=44
int Width=841
int Height=120
boolean Enabled=false
boolean BringToTop=true
string Text="Para emitir el reporte, debe de hacer clic en el botón Aceptar"
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

