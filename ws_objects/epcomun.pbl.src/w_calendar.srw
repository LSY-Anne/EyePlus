$PBExportHeader$w_calendar.srw
forward
global type w_calendar from Window
end type
type uo_cal from uo_calendar within w_calendar
end type
end forward

global type w_calendar from Window
int X=1056
int Y=484
int Width=759
int Height=616
long BackColor=81254359
WindowType WindowType=response!
uo_cal uo_cal
end type
global w_calendar w_calendar

on w_calendar.create
this.uo_cal=create uo_cal
this.Control[]={this.uo_cal}
end on

on w_calendar.destroy
destroy(this.uo_cal)
end on

event open;/* Autor: Cesar Vilela */
String	ls_mess
s_parm	lstr_parm

lstr_parm = Message.PowerObjectParm

ls_mess = lstr_parm.s_cad[1]
This.X = lstr_parm.n_num[1]
This.Y = lstr_parm.n_num[2]

uo_cal.uof_SetDate(  Integer( Left(ls_mess, 4)), Integer( Mid( ls_mess, 5, 2) ), Integer( Right( ls_mess, 2)) )
end event

type uo_cal from uo_calendar within w_calendar
event destroy ( )
int X=0
int Y=0
int Width=850
int Height=700
int TabOrder=10
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=81254359
end type

on uo_cal.destroy
call uo_calendar::destroy
end on

event doubleclicked;call super::doubleclicked;close( parent )
end event

