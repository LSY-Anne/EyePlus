$PBExportHeader$w_arch_acumulado_costos_prod_list.srw
forward
global type w_arch_acumulado_costos_prod_list from wa_response
end type
type cb_1 from uo_cbother within w_arch_acumulado_costos_prod_list
end type
end forward

global type w_arch_acumulado_costos_prod_list from wa_response
int Width=3515
int Height=1132
boolean TitleBar=true
string Title="Acumulado de Costos por Producto"
long BackColor=80269524
cb_1 cb_1
end type
global w_arch_acumulado_costos_prod_list w_arch_acumulado_costos_prod_list

on w_arch_acumulado_costos_prod_list.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_arch_acumulado_costos_prod_list.destroy
call super::destroy
destroy(this.cb_1)
end on

event open;call super::open;String	ls_cul

ls_cul = Message.StringParm

dw_list.Retrieve( gs_codtem, ls_cul )
end event

type dw_list from wa_response`dw_list within w_arch_acumulado_costos_prod_list
int X=32
int Y=32
int Width=3433
int Height=856
int TabOrder=10
string DataObject="d_arch_acumulado_costos_prod_list"
end type

event dw_list::retrieveend;call super::retrieveend;If rowcount > 0 Then
	cb_aceptar.Enabled = True
End If
end event

type dw_1 from wa_response`dw_1 within w_arch_acumulado_costos_prod_list
int X=91
int Y=572
int Width=123
int Height=116
int TabOrder=20
boolean Visible=false
boolean Enabled=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_arch_acumulado_costos_prod_list
int X=3118
int Y=916
int TabOrder=50
end type

type cb_aceptar from wa_response`cb_aceptar within w_arch_acumulado_costos_prod_list
int X=2377
int Y=916
int TabOrder=30
string Text="Mat.y Gastos"
end type

event cb_aceptar::clicked;String	ls_cod

If dw_list.RowCount() <= 0 Then
	MessageBox( Title, 'No existen registros a consultar.', Exclamation! )
	Return
End If

ls_cod = dw_list.Object.c_codigo_pro[ dw_list.GetRow()]

OpenWithParm( w_arch_acumulado_costos_prod_desglo_list, ls_cod )
end event

type cb_1 from uo_cbother within w_arch_acumulado_costos_prod_list
int X=2747
int Y=916
int TabOrder=40
boolean BringToTop=true
string Text="&Imprimir"
end type

event clicked;DataWindow	ldw_1

ldw_1 = f_PreviewXP( 'd_rpt_acumulado_empaque_costo' )
ldw_1.Retrieve(gs_codtem, gd_sys, w_arch_acumulado_costos_list.idc_tc)

f_Preview( dw_1 )


end event

