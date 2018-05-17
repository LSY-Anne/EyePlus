$PBExportHeader$uo_progressbar.sru
forward
global type uo_progressbar from UserObject
end type
type st_avance from statictext within uo_progressbar
end type
end forward

global type uo_progressbar from UserObject
int Width=1157
int Height=80
BorderStyle BorderStyle=StyleLowered!
long BackColor=80269524
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
st_avance st_avance
end type
global uo_progressbar uo_progressbar

type variables
Integer ii_size = 1120
end variables

forward prototypes
public subroutine uof_setpercent (long al_percent, long al_total)
public subroutine uof_initbar ()
end prototypes

public subroutine uof_setpercent (long al_percent, long al_total);st_avance.Width = (( ( al_percent * 100 ) / al_total ) / 100 ) * ii_size
end subroutine

public subroutine uof_initbar ();st_avance.Width = 0

end subroutine

event constructor;
ii_size = This.Width - 27
st_avance.Width = 0

end event

on uo_progressbar.create
this.st_avance=create st_avance
this.Control[]={this.st_avance}
end on

on uo_progressbar.destroy
destroy(this.st_avance)
end on

type st_avance from statictext within uo_progressbar
int X=5
int Y=4
int Width=174
int Height=56
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=8388608
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

