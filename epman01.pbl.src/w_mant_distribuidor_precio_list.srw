$PBExportHeader$w_mant_distribuidor_precio_list.srw
forward
global type w_mant_distribuidor_precio_list from wa_mant
end type
end forward

global type w_mant_distribuidor_precio_list from wa_mant
boolean TitleBar=true
string Title="Distribuidor - Precio"
long BackColor=81324524
end type
global w_mant_distribuidor_precio_list w_mant_distribuidor_precio_list

type variables
w_mant_distribuidor_precio_edit  iw_edit
end variables

forward prototypes
public function boolean wf_mant ()
end prototypes

public function boolean wf_mant ();OpenSheetWithParm( iw_edit, istr_parm, gw_frame, 0, Original! )
Return True
end function

on w_mant_distribuidor_precio_list.create
call super::create
end on

on w_mant_distribuidor_precio_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_prn from wa_mant`dw_prn within w_mant_distribuidor_precio_list
string DataObject="d_rpt_distribuidor_precio"
end type

type dw_1 from wa_mant`dw_1 within w_mant_distribuidor_precio_list
string DataObject="d_mant_distribuidor_precio_list"
end type

