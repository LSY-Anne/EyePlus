$PBExportHeader$w_presentacion_preliminar.srw
forward
global type w_presentacion_preliminar from window
end type
end forward

global type w_presentacion_preliminar from window
integer width = 2903
integer height = 1920
boolean titlebar = true
string title = "Presentación Preliminar"
string menuname = "m_presentacion_preliminar"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 79741120
end type
global w_presentacion_preliminar w_presentacion_preliminar

on w_presentacion_preliminar.create
if this.MenuName = "m_presentacion_preliminar" then this.MenuID = create m_presentacion_preliminar
end on

on w_presentacion_preliminar.destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;s_parm lstr_parm


lstr_parm = Message.PowerObjectParm
//Appeon comment begin
//Appeon have changed the windowtype from mdihelp to the main.
//OpenSheetWithParm( w_presentacion_preliminar_dw, lstr_parm, This, 1, Original! )
OpensheetWithParm( w_presentacion_preliminar_dw, lstr_parm,w_app_frame,1,original!)

//Appeon comment end

end event

event activate;gw_frame.Hide()

end event

event close;gw_frame.Show()
end event

