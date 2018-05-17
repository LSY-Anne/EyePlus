$PBExportHeader$w_arch_acumulado_costos_list.srw
forward
global type w_arch_acumulado_costos_list from wa_response
end type
type cb_imprimir from uo_cbother within w_arch_acumulado_costos_list
end type
type cb_manodeobra from uo_cbother within w_arch_acumulado_costos_list
end type
end forward

global type w_arch_acumulado_costos_list from wa_response
int Width=3515
int Height=1316
boolean TitleBar=true
string Title="Acumulado de Costos Generales"
long BackColor=80269524
cb_imprimir cb_imprimir
cb_manodeobra cb_manodeobra
end type
global w_arch_acumulado_costos_list w_arch_acumulado_costos_list

type variables
Dec{4}	idc_tc
end variables

on w_arch_acumulado_costos_list.create
int iCurrent
call super::create
this.cb_imprimir=create cb_imprimir
this.cb_manodeobra=create cb_manodeobra
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_imprimir
this.Control[iCurrent+2]=this.cb_manodeobra
end on

on w_arch_acumulado_costos_list.destroy
call super::destroy
destroy(this.cb_imprimir)
destroy(this.cb_manodeobra)
end on

event open;call super::open;String	ls_mer


SetPointer( HourGlass! )

f_GetSysDate( )
idc_tc = f_GetTipoCambio( gd_sys )
If f_UtilAcumulaEmpaqueyCostoDiario( idc_tc ) = 1 Then
	If f_UtilAcumulaManoObraDiario( idc_tc ) = 1 Then
		Commit Using SqlCa ;
	Else
		RollBack Using SqlCa ;
	End If
Else
	RollBack Using SqlCa ;
End If
dw_list.Retrieve( gs_codtem )

end event

type dw_list from wa_response`dw_list within w_arch_acumulado_costos_list
int X=32
int Y=32
int Width=3433
int Height=1032
int TabOrder=10
string DataObject="d_arch_acumulado_costos_list"
end type

event dw_list::retrieveend;call super::retrieveend;If rowcount > 0 Then
	cb_aceptar.Enabled = True
End If
end event

type dw_1 from wa_response`dw_1 within w_arch_acumulado_costos_list
int X=91
int Y=572
int Width=123
int Height=116
int TabOrder=20
boolean Visible=false
boolean Enabled=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_arch_acumulado_costos_list
int X=3118
int Y=1100
int TabOrder=50
end type

type cb_aceptar from wa_response`cb_aceptar within w_arch_acumulado_costos_list
int X=1984
int Y=1100
int TabOrder=30
string Text="Detallar"
end type

event cb_aceptar::clicked;String	ls_cul

If dw_list.RowCount() <= 0 Then
	MessageBox( Title, 'No existen registros a consultar.', Exclamation! )
	Return
End If

ls_cul = dw_list.Object.c_codigo_cul[ dw_list.GetRow()]

OpenWithParm( w_arch_acumulado_costos_prod_list, ls_cul )
end event

type cb_imprimir from uo_cbother within w_arch_acumulado_costos_list
int X=2752
int Y=1100
int TabOrder=40
boolean BringToTop=true
string Text="&Imprimir"
end type

event clicked;DataWindow	ldw_1

ldw_1 = f_PreviewXP( 'd_rpt_acumulado_empaque_costo' )
ldw_1.Retrieve(gs_codtem, gd_sys, idc_tc)

end event

type cb_manodeobra from uo_cbother within w_arch_acumulado_costos_list
int X=2350
int Y=1100
int Width=384
int TabOrder=20
boolean BringToTop=true
string Text="&Mano de Obra"
end type

event clicked;Open( w_arch_acumulado_mano_obra_list )
end event

