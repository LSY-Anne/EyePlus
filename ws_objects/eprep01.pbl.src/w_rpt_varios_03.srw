$PBExportHeader$w_rpt_varios_03.srw
$PBExportComments$Por Mercado
forward
global type w_rpt_varios_03 from wa_response
end type
type p_1 from picture within w_rpt_varios_03
end type
type st_1 from statictext within w_rpt_varios_03
end type
type ddlb_1 from dropdownlistbox within w_rpt_varios_03
end type
type st_2 from statictext within w_rpt_varios_03
end type
end forward

global type w_rpt_varios_03 from wa_response
int Width=1577
int Height=512
boolean TitleBar=true
string Title="Tabla de Productos por Costo"
p_1 p_1
st_1 st_1
ddlb_1 ddlb_1
st_2 st_2
end type
global w_rpt_varios_03 w_rpt_varios_03

type variables
String	is_rpt
end variables

event open;call super::open;is_rpt = Message.StringParm

Choose Case is_rpt

	Case 'ECD' /* Productos x Costo Diario */
		Title = 'Reporte de Costos de Empaque'
		dw_list.DataObject = 'd_rpt_acumulado_empaque_costo'
End Choose
dw_1.Visible = False
dw_list.Visible = False

If gs_mercado = 'E' Then
	ddlb_1.Text = 'Extranjero'
Else
	ddlb_1.Text = 'Nacional'
End If	
end event

on w_rpt_varios_03.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.ddlb_1
this.Control[iCurrent+4]=this.st_2
end on

on w_rpt_varios_03.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.st_2)
end on

type dw_list from wa_response`dw_list within w_rpt_varios_03
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

type dw_1 from wa_response`dw_1 within w_rpt_varios_03
int X=178
int Y=320
int Width=155
int Height=124
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_varios_03
int X=1125
int Y=204
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_varios_03
int X=1125
int Y=76
boolean Enabled=true
end type

event cb_aceptar::clicked;Dec{4}	ldc_tc
String	ls_mer


If ddlb_1.Text = 'Extranjero' Then
	ls_mer = 'E'
Else
	ls_mer = 'N'
End If	

SetPointer( HourGlass! )

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

dw_list.SetTransObject( SqlCa )
dw_list.Retrieve( gs_codtem, ls_mer, gd_sys, ldc_tc )
SetPointer( Arrow! )

f_Preview( dw_list )
end event

type p_1 from picture within w_rpt_varios_03
int X=37
int Y=32
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_1 from statictext within w_rpt_varios_03
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

type ddlb_1 from dropdownlistbox within w_rpt_varios_03
int X=384
int Y=212
int Width=640
int Height=228
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Extranjero",&
"Nacional"}
end type

type st_2 from statictext within w_rpt_varios_03
int X=87
int Y=228
int Width=247
int Height=76
boolean Enabled=false
boolean BringToTop=true
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

