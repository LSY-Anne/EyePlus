$PBExportHeader$w_sqlerror.srw
forward
global type w_sqlerror from wa_response
end type
end forward

global type w_sqlerror from wa_response
int Width=2025
int Height=1188
boolean TitleBar=true
string Title="Operación Fallida"
long BackColor=80269524
end type
global w_sqlerror w_sqlerror

event open;call super::open;s_parm	lstr_parm

lstr_parm = Message.PowerObjectParm

dw_1.InsertRow(0)

dw_1.Object.DataBase[1] = lstr_parm.s_cad[1]
dw_1.Object.usertext[1] = lstr_parm.s_cad[2] 
dw_1.Object.sqldbcode[1] = lstr_parm.s_cad[3]
dw_1.Object.sqlerrtext[1] = lstr_parm.s_cad[4]

dw_1.AcceptText( )
dw_1.RowsCopy( 1, 1, Primary!, dw_list, 1, Primary! )
dw_list.Visible = False
end event

on w_sqlerror.create
call super::create
end on

on w_sqlerror.destroy
call super::destroy
end on

type dw_list from wa_response`dw_list within w_sqlerror
int X=32
int Y=888
string DataObject="d_rpt_sqlerror"
end type

type dw_1 from wa_response`dw_1 within w_sqlerror
int X=0
int Y=0
int Width=2021
int Height=956
string DataObject="d_sqlerror"
end type

type cb_cancelar from wa_response`cb_cancelar within w_sqlerror
int X=1614
int Y=972
string Text="Cerrar"
end type

type cb_aceptar from wa_response`cb_aceptar within w_sqlerror
int X=1234
int Y=972
boolean Enabled=true
string Text="Imprimir"
end type

event cb_aceptar::clicked;f_Preview( dw_list )

end event

