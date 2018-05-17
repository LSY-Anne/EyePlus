$PBExportHeader$w_util_contactos.srw
forward
global type w_util_contactos from wa_mant
end type
end forward

global type w_util_contactos from wa_mant
boolean TitleBar=true
string Title="Contactos"
string MenuName=""
end type
global w_util_contactos w_util_contactos

on w_util_contactos.create
call super::create
end on

on w_util_contactos.destroy
call super::destroy
end on

type dw_prn from wa_mant`dw_prn within w_util_contactos
string DataObject="d_util_contactos"
end type

type dw_1 from wa_mant`dw_1 within w_util_contactos
string DataObject="d_util_contactos"
end type

