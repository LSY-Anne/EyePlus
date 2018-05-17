$PBExportHeader$w_arch_acumulado_mano_obra_list.srw
forward
global type w_arch_acumulado_mano_obra_list from wa_response
end type
end forward

global type w_arch_acumulado_mano_obra_list from wa_response
int Width=3515
int Height=1184
boolean TitleBar=true
string Title="Acumulado de Costos Generales"
long BackColor=80269524
end type
global w_arch_acumulado_mano_obra_list w_arch_acumulado_mano_obra_list

on w_arch_acumulado_mano_obra_list.create
call super::create
end on

on w_arch_acumulado_mano_obra_list.destroy
call super::destroy
end on

event open;call super::open;dw_list.Retrieve( gs_codtem )
end event

type dw_list from wa_response`dw_list within w_arch_acumulado_mano_obra_list
int X=32
int Y=32
int Width=3433
int Height=908
int TabOrder=10
string DataObject="d_arch_acumulado_mano_obra_list"
end type

event dw_list::retrieveend;call super::retrieveend;If rowcount > 0 Then
	cb_aceptar.Enabled = True
End If
end event

type dw_1 from wa_response`dw_1 within w_arch_acumulado_mano_obra_list
int X=91
int Y=572
int Width=123
int Height=116
int TabOrder=20
boolean Visible=false
boolean Enabled=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_arch_acumulado_mano_obra_list
int X=3118
int Y=972
int TabOrder=40
end type

type cb_aceptar from wa_response`cb_aceptar within w_arch_acumulado_mano_obra_list
int X=2752
int Y=972
int TabOrder=30
string Text="Imprimir"
end type

event cb_aceptar::clicked;Dec{4}	ldc_tc
String	ls_mer


dw_1.DataObject = 'd_rpt_mano_obra_acumulado'
dw_1.SetTransObject( SqlCa )
dw_1.Retrieve( gs_codtem )

f_Preview( dw_1 )


end event

