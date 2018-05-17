$PBExportHeader$uo_editmask.sru
forward
global type uo_editmask from editmask
end type
end forward

global type uo_editmask from editmask
int Width=334
int Height=84
int TabOrder=10
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateMask!
boolean AutoSkip=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event enable pbm_enable
end type
global uo_editmask uo_editmask

forward prototypes
public subroutine uof_settoday ()
end prototypes

public subroutine uof_settoday ();This.Text = String( Today(), 'dd/mm/yyyy' )
end subroutine

