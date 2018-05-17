$PBExportHeader$w_mant_buscar.srw
forward
global type w_mant_buscar from wa_response
end type
type sle_1 from singlelineedit within w_mant_buscar
end type
type st_1 from statictext within w_mant_buscar
end type
type cbx_1 from checkbox within w_mant_buscar
end type
type cbx_ignorar from checkbox within w_mant_buscar
end type
end forward

global type w_mant_buscar from wa_response
int Width=1664
int Height=484
boolean TitleBar=true
string Title="Buscar"
sle_1 sle_1
st_1 st_1
cbx_1 cbx_1
cbx_ignorar cbx_ignorar
end type
global w_mant_buscar w_mant_buscar

type variables
Long il_row
end variables

forward prototypes
public function long wf_find ()
end prototypes

public function long wf_find ();Long		ll_row
String	ls_criterio, ls_col, ls_dato, ls_len
wa_mant	lw_mant


ls_col = 'c_codigo'
ls_dato = sle_1.text


lw_mant = gw_frame.GetActiveSheet( )

ls_len = String( Len(ls_dato) )

Do While True
	If cbx_ignorar.Checked Then
		ls_criterio = "Lower(Left(String(" + ls_col + "), " + &
							ls_len + ")) = '" + Lower(ls_dato) + "'"
	Else
		ls_criterio = "Left(String(" + ls_col + "), " + &
							ls_len + ") = '" + ls_dato + "'"
	End If
	gw_frame.SetMicroHelp( "Buscando " + ls_dato + &
						" en " + ls_col + "..." )
						
	ll_row = lw_mant.dw_1.Find( ls_criterio, il_row + 1, &
						lw_mant.dw_1.RowCount())
						
	il_row = ll_row 
	If ll_row > 0 Then 
		Exit
	Else	
		If ls_col = 'v_nombre' Then
			Exit
		End If
		ls_col = 'v_nombre'
	End If
Loop

If ll_row > 0 Then 
	lw_mant.dw_1.ScrollToRow(ll_row)
	gw_frame.SetMicroHelp( "Encontrado " + ls_dato + &
					" en " + ls_col  )
Else
	Beep(1)
	gw_frame.SetMicroHelp( "No se encontró " + ls_dato + &
									" en " + ls_col )
End If

Return ll_row
end function

on w_mant_buscar.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.cbx_1=create cbx_1
this.cbx_ignorar=create cbx_ignorar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cbx_1
this.Control[iCurrent+4]=this.cbx_ignorar
end on

on w_mant_buscar.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.cbx_1)
destroy(this.cbx_ignorar)
end on

type dw_list from wa_response`dw_list within w_mant_buscar
boolean Visible=false
end type

type dw_1 from wa_response`dw_1 within w_mant_buscar
int X=325
int Y=488
int Width=320
int Height=212
boolean Visible=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_mant_buscar
int X=1239
int Y=188
end type

type cb_aceptar from wa_response`cb_aceptar within w_mant_buscar
int X=1239
int Y=64
boolean Enabled=true
string Text="Buscar"
end type

event cb_aceptar::clicked;If wf_Find() > 0 Then
	Close( Parent )
Else
	sle_1.SetFocus( )
End If
end event

type sle_1 from singlelineedit within w_mant_buscar
int X=274
int Y=64
int Width=901
int Height=88
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_mant_buscar
int X=59
int Y=72
int Width=206
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Buscar:"
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

type cbx_1 from checkbox within w_mant_buscar
int X=59
int Y=196
int Width=937
int Height=76
boolean BringToTop=true
string Text="&Realizar la búsqueda desde el principio"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wa_mant	lw_mant

If Not Checked Then
	lw_mant = gw_frame.GetActiveSheet( )
	il_row = lw_mant.dw_1.GetRow()
Else
	il_row = 0
End If

end event

type cbx_ignorar from checkbox within w_mant_buscar
int X=59
int Y=288
int Width=937
int Height=76
boolean BringToTop=true
string Text="&Ignorar Mayúsculas"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

