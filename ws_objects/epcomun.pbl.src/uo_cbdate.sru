$PBExportHeader$uo_cbdate.sru
forward
global type uo_cbdate from commandbutton
end type
end forward

global type uo_cbdate from commandbutton
int Width=82
int Height=76
int TabOrder=10
string Text="..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global uo_cbdate uo_cbdate

type variables
Long il_x, il_y
String is_fec

end variables

forward prototypes
public subroutine uof_gettext (string as_fec)
public subroutine uof_posxy (window aw_fec, editmask aem_fec)
public subroutine uof_calendar (window aw_win, editmask aem_fec)
end prototypes

public subroutine uof_gettext (string as_fec);is_fec = as_fec
end subroutine

public subroutine uof_posxy (window aw_fec, editmask aem_fec);Environment	lenv_env                                // holds environment information
Window		lw_win

// Get the environment information
If ( GetEnvironment(lenv_env) <> 1 ) then
End If

il_x = aw_fec.X + aem_fec.X
il_y = aw_fec.Y + aem_fec.Y + ( aem_fec.Height * 2 )

If aw_fec.WindowType = Response! Then
	Return
End If
lw_win = gw_frame.GetActiveSheet( )

//Si es sheet
If IsValid( lw_win ) Then
	il_y = il_y + ( aw_fec.WorkSpaceY( ) - aw_fec.Y - aem_fec.Height) //Aprox( 250 ) 
End If



end subroutine

public subroutine uof_calendar (window aw_win, editmask aem_fec);String	ls_mess
s_parm	lstr_parm

uof_PosXY( aw_win, aem_fec )

is_fec = aem_fec.Text
ls_mess = is_fec
If ls_mess = '' Or Not IsDate( ls_mess ) Then
	ls_mess = String( Today( ), 'dd/mm/yyyy' )
	is_fec = ls_mess 
End If
ls_mess = Right( ls_mess, 4) + Mid( ls_mess, 4, 2) + Left( ls_mess, 2)
lstr_parm.s_cad[1] = ls_mess
lstr_parm.n_num[1] = il_x 
lstr_parm.n_num[2] = il_y 

OpenWithParm( w_calendar, lstr_parm )
ls_mess = Message.StringParm

aem_fec.SetFocus( )
If ls_mess = '' Then Return

aem_fec.Text = Right( ls_mess, 2) + '/' +  Mid( ls_mess, 5, 2) + '/' + Left( ls_mess, 4)

end subroutine

event constructor;TabOrder = 0
end event

