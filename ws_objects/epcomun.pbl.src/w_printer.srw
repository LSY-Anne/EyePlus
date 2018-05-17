$PBExportHeader$w_printer.srw
forward
global type w_printer from window
end type
type st_1 from statictext within w_printer
end type
type cb_1 from commandbutton within w_printer
end type
end forward

global type w_printer from window
integer width = 2533
integer height = 1408
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_1 cb_1
end type
global w_printer w_printer

type variables
datawindow idw_dw
end variables

on w_printer.create
this.st_1=create st_1
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.cb_1}
end on

on w_printer.destroy
destroy(this.st_1)
destroy(this.cb_1)
end on

event open;idw_dw = message.powerobjectparm
messagebox('',idw_dw.dataobject)
st_1.text = idw_dw.describe("datawindow.printer")
end event

type st_1 from statictext within w_printer
integer x = 64
integer y = 292
integer width = 1934
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_printer
integer x = 320
integer y = 1000
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "printsetup"
end type

event clicked;printsetup()

st_1.text = idw_dw.object.datawindow.printer
end event

