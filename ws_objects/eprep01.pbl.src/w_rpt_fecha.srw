$PBExportHeader$w_rpt_fecha.srw
forward
global type w_rpt_fecha from wa_response
end type
type em_ini from uo_editmask within w_rpt_fecha
end type
type cb_ini from uo_cbdate within w_rpt_fecha
end type
type st_1 from statictext within w_rpt_fecha
end type
end forward

global type w_rpt_fecha from wa_response
int Width=914
int Height=492
boolean TitleBar=true
string Title="Reporte de Bultos"
long BackColor=82899184
em_ini em_ini
cb_ini cb_ini
st_1 st_1
end type
global w_rpt_fecha w_rpt_fecha

type variables
String	is_rpt
end variables

event open;call super::open;

is_rpt = Message.StringParm

em_ini.Text = f_GetParmValue( '20' )
//em_ini.enabled = false

//dw_1.InsertRow(0)


end event

on w_rpt_fecha.create
int iCurrent
call super::create
this.em_ini=create em_ini
this.cb_ini=create cb_ini
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_ini
this.Control[iCurrent+2]=this.cb_ini
this.Control[iCurrent+3]=this.st_1
end on

on w_rpt_fecha.destroy
call super::destroy
destroy(this.em_ini)
destroy(this.cb_ini)
destroy(this.st_1)
end on

type dw_list from wa_response`dw_list within w_rpt_fecha
int X=1399
int Y=836
int Width=155
int Height=96
int TabOrder=0
string DataObject="d_rpt_acumulado_diario_frame_res"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_fecha
int X=82
int Y=860
int Width=1193
int Height=96
string DataObject="d_rpt_acumulado_diario_frame_res"
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_fecha
int X=498
int Y=240
int TabOrder=40
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_fecha
int X=78
int Y=240
int TabOrder=30
boolean Enabled=true
end type

event cb_aceptar::clicked;DataWindow	ldw_1
datetime ld_fec
string ls_cul,ls_tem

SetPointer( HourGlass! )

ls_tem = f_trim(f_getparmvalue('001'))

dw_1 = f_PreviewXP( 'd_rpt_bultos_expynac2' )

dw_1.Retrieve( ls_tem,f_StringToDate( em_ini.Text ) )

SetPointer( Arrow! )
end event

type em_ini from uo_editmask within w_rpt_fecha
int X=283
int Y=72
int TabOrder=20
end type

type cb_ini from uo_cbdate within w_rpt_fecha
int X=635
int Y=72
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_1 from statictext within w_rpt_fecha
int X=123
int Y=72
int Width=178
int Height=76
boolean Enabled=false
string Text="Fecha:"
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

