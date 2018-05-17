$PBExportHeader$uo_calendar.sru
forward
global type uo_calendar from UserObject
end type
type cb_2 from commandbutton within uo_calendar
end type
type cb_1 from commandbutton within uo_calendar
end type
type st_mess from statictext within uo_calendar
end type
type dw_1 from datawindow within uo_calendar
end type
end forward

global type uo_calendar from UserObject
int Width=750
int Height=604
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event doubleclicked pbm_dwnlbuttondblclk
cb_2 cb_2
cb_1 cb_1
st_mess st_mess
dw_1 dw_1
end type
global uo_calendar uo_calendar

type variables
String is_oday, is_nday

Integer ii_anio, ii_mes, ii_dia
end variables

forward prototypes
public function integer uof_daysm (integer ai_mes, integer ai_anio)
public function integer uof_setdate (integer ai_anio, integer ai_mes, integer ai_dia)
public subroutine uof_setday (string as_day, boolean ab_set)
end prototypes

event doubleclicked;close( parent )
end event

public function integer uof_daysm (integer ai_mes, integer ai_anio);Integer	li_daysm, li_days[12] = {31,28,31,30,31,30,31,31,30,31,30,31}

// dias por mes 
li_daysm = li_Days[ ai_mes ]

// Check for a leap year.
If ai_mes = 2 Then
	//	Year divisible by 4, but not by 100, unless it is also divisible by 400
	If ( (Mod(ai_anio,4) = 0 And Mod(ai_anio,100) <> 0) Or (Mod(ai_anio,400) = 0) ) Then
		li_daysm = 29
	End If
End If

Return li_daysm
end function

public function integer uof_setdate (integer ai_anio, integer ai_mes, integer ai_dia);Boolean	lb_cta = False
Date	ld_new, ld_1er
Integer	i, j, li_new, li_1er, li_max, li_con
String	ls_1er, ls_new, ls_sem[7] = { 'su', 'mo', 'tu', 'we', 'th', 'fr', 'sa' }, ls_col, ls_dia


st_mess.Text = f_Mes( ai_mes ) +  ' ' + String( ai_anio )

ld_new = Date( String(ai_anio) + '/' + String(ai_mes) + '/' + String(ai_dia) )
ls_dia = String(ai_anio) + '/' + String(ai_mes) + '/' + String(ai_dia) 
ld_1er = Date( String(ai_anio) + '/' + String(ai_mes) + '/01' )

ii_anio = ai_anio
ii_mes = ai_mes
ii_dia = ai_dia

li_max = uof_daysm( ai_mes, ai_anio )

ls_new = DayName( ld_new )
ls_1er = DayName( ld_1er )
li_new = DayNumber( ld_new )
li_1er = DayNumber( ld_1er )

dw_1.SetRedraw( False )
For i = 1 To 7
	For j = 1 To 6
		ls_col = ls_sem[i]  + String(j)
		dw_1.Modify( ls_col + '.Text = ""' )
		uof_setday( ls_col, False )
	Next
Next

For i = 1 To 6
	For j = 1 To 7
		ls_col = ls_sem[j]  + String(i)
		If j = li_1er And i = 1 Then
			lb_cta = True
		End If
		If lb_cta Then 
			li_con ++
			If li_con <= li_max Then
				dw_1.Modify( ls_col + '.Text = "' + String(li_con) + '"' )
				If li_con = ai_dia Then
					is_nday = ls_col
					uof_setday( ls_col, True )
				End If
			Else
				dw_1.Modify( ls_col + '.Text = ""' )
			End If
		Else
			dw_1.Modify( ls_col + '.Text = ""' )
		End If
	Next
Next

dw_1.SetFocus( )
dw_1.SetRedraw( True )
Return 1
end function

public subroutine uof_setday (string as_day, boolean ab_set);If ab_set Then
	dw_1.Modify( as_day + '.Color = "' + String( f_Color( 'blanco' ) ) + '"' )
	dw_1.Modify( as_day + '.BackGround.Color = "' + String( f_Color( 'azul' ) ) + '"' )
Else
	dw_1.Modify( as_day + '.Color = "' + String( f_Color( '17' ) ) + '"' )
	dw_1.Modify( as_day + '.BackGround.Color = "' + String( f_Color( '16' ) ) + '"' )
End If
end subroutine

on uo_calendar.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_mess=create st_mess
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_mess,&
this.dw_1}
end on

on uo_calendar.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_mess)
destroy(this.dw_1)
end on

event constructor;/* Autor: Cesar Vilela */
dw_1.InsertRow(0)

ii_anio = Year(Today( ) )
ii_mes = Month( Today( ) )
ii_dia = Day( Today( ) )

uof_SetDate( ii_anio, ii_mes, ii_dia )

end event

type cb_2 from commandbutton within uo_calendar
int X=631
int Width=105
int Height=76
string Text=">"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ii_mes ++
If ii_mes > 12 Then 
	ii_mes = 1
	ii_anio ++
End If

If uof_DaysM( ii_mes, ii_anio ) < ii_dia Then
	ii_dia = uof_DaysM( ii_mes, ii_anio )
End If

is_oday = ''
is_nday = ''

uof_SetDate( ii_anio, ii_mes, ii_dia )


end event

type cb_1 from commandbutton within uo_calendar
int Width=105
int Height=76
string Text="<"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ii_mes --
If ii_mes < 1 Then 
	ii_mes = 12
	ii_anio --
End If

If uof_DaysM( ii_mes, ii_anio ) < ii_dia Then
	ii_dia = uof_DaysM( ii_mes, ii_anio )
End If

is_oday = ''
is_nday = ''

uof_SetDate( ii_anio, ii_mes, ii_dia )

end event

type st_mess from statictext within uo_calendar
int X=91
int Width=549
int Height=76
boolean Enabled=false
string Text="Aqui Mes"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within uo_calendar
event key pbm_dwnkey
int Y=72
int Width=736
int Height=524
int TabOrder=10
string DataObject="d_uo_calendar"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event key;
If KeyDown( KeyEscape! ) Then
	CloseWithReturn( w_Calendar , '' )
End If


end event

event clicked;If dwo.Type = 'text' Then
	
	If f_Trim( dwo.Name ) = '' Then Return
	If f_Trim( dwo.Text ) = '' Then Return
	If Left( GetBandAtPointer ( ), 6 ) <> 'detail' Then Return
	If is_nday <> dwo.Name Then
		is_oday = is_nday
		is_nday = dwo.Name
	End If
	ii_dia = Integer( dwo.Text )
	uof_SetDay( is_oday, False )
	uof_SetDay( is_nday, True )
End If	

end event

event doubleclicked;
String	ls_mess

ls_mess = String( ii_anio, '0000' ) + String( ii_mes, '00' ) + String( ii_dia, '00' ) 

CloseWithReturn( w_Calendar , ls_mess )


end event

