$PBExportHeader$w_arch_mano_obra_gral_list.srw
forward
global type w_arch_mano_obra_gral_list from wa_proc
end type
end forward

global type w_arch_mano_obra_gral_list from wa_proc
boolean TitleBar=true
string Title="Mano de Obra General"
long BackColor=81324524
end type
global w_arch_mano_obra_gral_list w_arch_mano_obra_gral_list

type variables
w_arch_mano_obra_gral_edit  iw_edit
end variables

forward prototypes
public function boolean wf_mant ()
end prototypes

public function boolean wf_mant ();OpenSheetWithParm( iw_edit, istr_parm, gw_frame, 0, Original! )
Return True
end function

on w_arch_mano_obra_gral_list.create
call super::create
end on

on w_arch_mano_obra_gral_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event tab_1::selectionchanged;call super::selectionchanged;DateTime	ld_ini, ld_fin


ld_fin = DateTime( RelativeDate( Date( gd_sys ), -1 ) )
If newindex = 2 Then
	If dw_ant.RowCount( ) = 0 Then 
		dw_ant.Retrieve( gs_codtem, ld_ini, ld_fin )
	End If
End If


end event

type tabpage_1 from wa_proc`tabpage_1 within tab_1
int X=18
int Y=100
int Width=2437
int Height=736
end type

type dw_1 from wa_proc`dw_1 within tabpage_1
string DataObject="d_arch_mano_obra_gral_list"
end type

type tabpage_2 from wa_proc`tabpage_2 within tab_1
int X=18
int Y=100
int Width=2437
int Height=736
end type

type dw_ant from wa_proc`dw_ant within tabpage_2
string DataObject="d_arch_mano_obra_gral_list"
end type

type dw_prn from wa_proc`dw_prn within w_arch_mano_obra_gral_list
int TabOrder=0
string DataObject="d_rpt_mano_obra_gral"
end type

type cb_cerrar from wa_proc`cb_cerrar within w_arch_mano_obra_gral_list
int TabOrder=70
end type

type cb_autorizar from wa_proc`cb_autorizar within w_arch_mano_obra_gral_list
int TabOrder=60
end type

