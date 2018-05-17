$PBExportHeader$w_logo.srw
forward
global type w_logo from window
end type
type dw_1 from datawindow within w_logo
end type
type r_1 from rectangle within w_logo
end type
type st_mess from statictext within w_logo
end type
end forward

global type w_logo from window
integer x = 823
integer y = 360
integer width = 2926
integer height = 1352
boolean border = false
windowtype windowtype = popup!
long backcolor = 16777215
event ue_connect ( )
dw_1 dw_1
r_1 r_1
st_mess st_mess
end type
global w_logo w_logo

type variables

end variables

event ue_connect();String ls_bd, ls_usuario, ls_pass, ls_server	

If gb_connect Then Return
//If f_conecta_new(SqlCa, '0', 'Database', '', '', '', '', 'S')<>1 Then
//	Halt Close
//	Return
//End If

//ls_server		= ProfileString (gs_ini, 'Database', "servername", "")
//ls_bd			= ProfileString (gs_ini, 'Database', "database", "")
//ls_usuario	= ProfileString (gs_ini, 'Database', "logid", "")
//ls_pass		= ProfileString (gs_ini, 'Database', "LogPassWord", "")

//SQLCA.DBMS  ='SNC10'
//SQLCA.Servername=ls_server	
//SQLCA.logid		= ls_usuario
//SQLCA.logpass	= ls_pass
//SQLCA.DBParm = "Provider='SQLNCLI10', Database='"+ls_bd+"', CommitOnDisconnect = 'No', TrimSpaces=1"
////SQLCA.LOCK = 'RC'
//SQLCA.AutoCommit = False


//SQLCA.DBMS = "ODBC"
//SQLCA.AutoCommit = False
//SQLCA.DBParm = "ConnectString='DSN=ODBC_SQL;UID=sa;PWD=inventum'"

//Connect using SQLCA;
//If SQLCA.sqlcode <> 0 Then
//	MessageBox ( gs_aplicacion, 'No se pudo conectar a la BD: ['+ls_bd+']~n' + SqlCa.sqlerrtext, StopSign!)
//	Halt
//End If

gb_connect = True
f_Delay( 1 )

//Open ( w_acceso )		

//If f_Trim( Message.StringParm ) = '1' Then
	Open ( w_app_frame )	
//End If

Close( This )

end event

on w_logo.create
this.dw_1=create dw_1
this.r_1=create r_1
this.st_mess=create st_mess
this.Control[]={this.dw_1,&
this.r_1,&
this.st_mess}
end on

on w_logo.destroy
destroy(this.dw_1)
destroy(this.r_1)
destroy(this.st_mess)
end on

event open;String	ls_server, ls_db

f_CenterWindow( This )

ls_server = ProfileString ( gs_ini, "database", "servername", 	"") 
ls_db = ProfileString ( gs_ini, "database", "database", 	"") 

st_mess.Text = gs_version + ' Servidor: [' + ls_server + '] Base datos: [' + ls_db + ']'

PostEvent( 'ue_connect' )
end event

type dw_1 from datawindow within w_logo
integer width = 2926
integer height = 1284
integer taborder = 10
string dataobject = "d_logo_new"
boolean border = false
boolean livescroll = true
end type

type r_1 from rectangle within w_logo
integer linethickness = 8
long fillcolor = 15793151
integer width = 1765
integer height = 652
end type

type st_mess from statictext within w_logo
integer y = 1280
integer width = 2926
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 65535
long backcolor = 0
boolean enabled = false
string text = "gs_version"
alignment alignment = center!
boolean focusrectangle = false
end type

