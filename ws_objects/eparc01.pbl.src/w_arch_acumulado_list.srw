$PBExportHeader$w_arch_acumulado_list.srw
forward
global type w_arch_acumulado_list from wa_mant
end type
end forward

global type w_arch_acumulado_list from wa_mant
boolean TitleBar=true
string Title="Acumulados"
string MenuName="m_principal_arch_acumulado"
long BackColor=80269524
end type
global w_arch_acumulado_list w_arch_acumulado_list

type variables
w_arch_acumulado_edit  iw_edit
end variables

forward prototypes
public function boolean wf_mant ()
end prototypes

public function boolean wf_mant ();OpenSheetWithParm( iw_edit, istr_parm, gw_frame, 0, Original! )
Return True
end function

on w_arch_acumulado_list.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_principal_arch_acumulado" then this.MenuID = create m_principal_arch_acumulado
end on

on w_arch_acumulado_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ib_retxtemp = True
end event

type dw_prn from wa_mant`dw_prn within w_arch_acumulado_list
string DataObject="d_rpt_acumulado_eye"
boolean Border=true
BorderStyle BorderStyle=StyleBox!
boolean Resizable=true
end type

type cb_recuperar from wa_mant`cb_recuperar within w_arch_acumulado_list
boolean Visible=false
boolean Enabled=false
end type

type cb_modificar from wa_mant`cb_modificar within w_arch_acumulado_list
boolean Visible=false
boolean Enabled=false
end type

type cb_eliminar from wa_mant`cb_eliminar within w_arch_acumulado_list
boolean Visible=false
boolean Enabled=false
end type

type cb_adicionar from wa_mant`cb_adicionar within w_arch_acumulado_list
boolean Visible=false
boolean Enabled=false
end type

type dw_1 from wa_mant`dw_1 within w_arch_acumulado_list
string DataObject="d_arch_acumulado_list"
end type

