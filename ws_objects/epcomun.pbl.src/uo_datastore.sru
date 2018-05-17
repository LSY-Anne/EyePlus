$PBExportHeader$uo_datastore.sru
forward
global type uo_datastore from datastore
end type
end forward

global type uo_datastore from datastore
end type
global uo_datastore uo_datastore

event dberror;s_parm	lstr_parm


lstr_parm.s_cad[1] = SqlCa.DataBase
lstr_parm.s_cad[2] = DataObject
lstr_parm.s_cad[3] = String( SqlDBCode )
lstr_parm.s_cad[4] = SqlErrText + '~r~n~r~nSQL Syntax: ' + sqlsyntax

RollBack ;
OpenWithParm( w_sqlerror, lstr_parm )

end event

on uo_datastore.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on uo_datastore.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

