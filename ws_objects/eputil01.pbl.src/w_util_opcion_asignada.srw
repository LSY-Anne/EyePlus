$PBExportHeader$w_util_opcion_asignada.srw
forward
global type w_util_opcion_asignada from wa_response
end type
end forward

global type w_util_opcion_asignada from wa_response
int Width=1659
int Height=1388
boolean TitleBar=true
string Title="Menu de Opciones Asignadas"
long BackColor=80269524
end type
global w_util_opcion_asignada w_util_opcion_asignada

on w_util_opcion_asignada.create
call super::create
end on

on w_util_opcion_asignada.destroy
call super::destroy
end on

event open;call super::open;dw_list.Retrieve( gs_usuario )
end event

type dw_list from wa_response`dw_list within w_util_opcion_asignada
int X=37
int Y=32
int Width=1577
int Height=1120
string DataObject="d_util_opcion_asignada"
end type

type dw_1 from wa_response`dw_1 within w_util_opcion_asignada
int X=654
int Y=1172
int Width=128
int Height=100
boolean Visible=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_util_opcion_asignada
int X=1266
int Y=1184
string Text="Cerrar"
boolean Default=true
end type

type cb_aceptar from wa_response`cb_aceptar within w_util_opcion_asignada
int X=887
int Y=1184
boolean Visible=false
boolean Default=false
end type

