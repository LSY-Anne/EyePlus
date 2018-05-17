$PBExportHeader$w_arch_acarreo_gral_list.srw
forward
global type w_arch_acarreo_gral_list from wa_mant
end type
end forward

global type w_arch_acarreo_gral_list from wa_mant
boolean TitleBar=true
string Title="Acarreo General"
end type
global w_arch_acarreo_gral_list w_arch_acarreo_gral_list

type variables
w_arch_acarreo_gral_edit  iw_edit
end variables

forward prototypes
public function boolean wf_mant ()
end prototypes

public function boolean wf_mant ();OpenSheetWithParm( iw_edit, istr_parm, gw_frame, 0, Original! )
Return True
end function

on w_arch_acarreo_gral_list.create
call super::create
end on

on w_arch_acarreo_gral_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ib_retxtemp = True
end event

type dw_prn from wa_mant`dw_prn within w_arch_acarreo_gral_list
string DataObject="d_rpt_acarreo_gral"
end type

type dw_1 from wa_mant`dw_1 within w_arch_acarreo_gral_list
string DataObject="d_arch_acarreo_gral_list"
end type

