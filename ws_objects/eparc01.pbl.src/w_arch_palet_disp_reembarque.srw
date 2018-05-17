$PBExportHeader$w_arch_palet_disp_reembarque.srw
forward
global type w_arch_palet_disp_reembarque from wa_response
end type
type cbx_1 from checkbox within w_arch_palet_disp_reembarque
end type
end forward

global type w_arch_palet_disp_reembarque from wa_response
int Width=2885
int Height=1052
boolean TitleBar=true
string Title="Pallet Disponibles"
cbx_1 cbx_1
end type
global w_arch_palet_disp_reembarque w_arch_palet_disp_reembarque

type variables
String is_mess
end variables

on w_arch_palet_disp_reembarque.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on w_arch_palet_disp_reembarque.destroy
call super::destroy
destroy(this.cbx_1)
end on

event open;call super::open;string ls_tipo

is_mess = Message.StringParm
	
if gs_tipo='' then
	ls_tipo='%'
else
	if gs_tipo='F' then
		ls_tipo='1'
	else
		ls_tipo='0'
	end if
end if

dw_list.Retrieve( gs_codtem,ls_tipo,is_mess )

If is_mess = 'PALLET' Then
	cb_aceptar.Text = 'Imprimir'
	cb_cancelar.Text = 'Cerrar'
	dw_list.Object.c_checked.Visible = '0'
	dw_list.SelectRow( 0, False )
	cbx_1.Visible = False
End If

If Not (f_GetParmValue( '39' ) = 'S' ) Then
	dw_list.Object.c_codigo_col.Visible = 0
	dw_list.Object.c_codigo_col_t.Visible = 0
End If
end event

type dw_list from wa_response`dw_list within w_arch_palet_disp_reembarque
int X=37
int Y=32
int Width=2789
int Height=780
string DataObject="d_arch_palet_disp_reem"
end type

event dw_list::retrieveend;call super::retrieveend;If rowcount > 0  Then cb_aceptar.Enabled = True
end event

event dw_list::doubleclicked;//cb_aceptar.TriggerEvent( Clicked! )
end event

type dw_1 from wa_response`dw_1 within w_arch_palet_disp_reembarque
int X=1481
int Y=860
int Width=306
int Height=136
boolean Visible=false
string DataObject="d_rpt_pallet_disponibles"
end type

type cb_cancelar from wa_response`cb_cancelar within w_arch_palet_disp_reembarque
int X=2482
int Y=840
end type

type cb_aceptar from wa_response`cb_aceptar within w_arch_palet_disp_reembarque
int X=2103
int Y=840
end type

event cb_aceptar::clicked;Long		i, j, k
String	ls_pal[], ls_cod
s_parm	lstr_parm

If dw_list.RowCount ( ) <= 0  Then 
	Beep( 1)
	Return
End If

If is_mess = 'PALLET' Then
	dw_1.Retrieve( gs_codtem )
	f_Preview( dw_1 )
	Return
End If

For i = 1 To dw_list.RowCount ( ) 
	ls_cod = dw_list.Object.c_codigo_pal[ i]
	If Not f_Trim( dw_list.Object.c_checked[ i] ) = '1' Then
		Continue
	End If
	For k = 1 To UpperBound( ls_pal[] )
		If ls_cod = ls_pal[k] Then
			ls_cod = ''
			Exit
		End If
	Next
	If ls_cod = '' Then
		Continue
	End If
	j ++
	ls_pal[j] = ls_cod
Next

/* Se tiene ya cargada el array con los pallets a pegar */
lstr_parm.s_cad[] = ls_pal[]
CloseWithReturn( Parent, lstr_parm )

end event

type cbx_1 from checkbox within w_arch_palet_disp_reembarque
int X=46
int Y=856
int Width=713
int Height=76
boolean BringToTop=true
string Text="Seleccionar &Todos"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long	i
String	ls_check

If Checked Then
	ls_check = '1'
	cb_aceptar.SetFocus( )
	Text = 'Desmarcar &Todos'
Else
	ls_check = '0'
	dw_list.SetFocus( )
	Text = 'Seleccionar &Todos'
End If
For i = 1 To dw_list.RowCount ( ) 
	dw_list.Object.c_checked[ i] = ls_check
Next

dw_list.AcceptText( )


end event

