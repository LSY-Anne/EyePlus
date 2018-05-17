$PBExportHeader$w_mant_usupunto_list.srw
forward
global type w_mant_usupunto_list from wa_mant
end type
end forward

global type w_mant_usupunto_list from wa_mant
boolean TitleBar=true
string Title="Usuario -Punto de Embarque"
long BackColor=82899184
end type
global w_mant_usupunto_list w_mant_usupunto_list

type variables
w_mant_usupunto_edit  iw_edit
end variables

forward prototypes
public function boolean wf_mant ()
end prototypes

public function boolean wf_mant ();OpenSheetWithParm( iw_edit, istr_parm, gw_frame, 0, Original! )
Return True
end function

on w_mant_usupunto_list.create
call super::create
end on

on w_mant_usupunto_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_prn from wa_mant`dw_prn within w_mant_usupunto_list
string DataObject="d_rpt_usuembarque"
end type

type dw_1 from wa_mant`dw_1 within w_mant_usupunto_list
string DataObject="d_mant_usupunto_list"
end type

