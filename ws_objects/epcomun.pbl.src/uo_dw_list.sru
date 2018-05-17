$PBExportHeader$uo_dw_list.sru
forward
global type uo_dw_list from datawindow
end type
end forward

global type uo_dw_list from datawindow
integer width = 1856
integer height = 704
integer taborder = 1
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event nkey pbm_dwnkey
end type
global uo_dw_list uo_dw_list

type variables
String	is_columna = '', is_order, is_colant = '', is_ordant
end variables

event rowfocuschanged;Long		ll_row, ll_filas

ll_filas = This.RowCount()

If ll_filas > 0 then
	This.SelectRow( 0, False )
	This.SelectRow( currentrow, True )
End If

gw_frame.SetMicroHelp( "Fila: " + String(currentrow) + "/" + String(RowCount()))

end event

event clicked;/*	Autor		: César Vilela Requena
	Fecha		: 01/Agosto/1997
	Objetivo	: Ordenar una lista con la cabecera de la misma
*/
String ls_name, ls_sort, ls_sortant

If Not KeyDown( KeySpaceBar! ) Then
	If dwo.Type = "text" Then
		ls_name = dwo.Name
		If Right(ls_name, 2) <> '_t' Then 
			Return
		End If
		dwo.Border = '5'
		ls_name = Left(ls_name, Len(ls_name) - 2)
		If ls_name <> is_columna Then
			If is_colant <> is_columna And is_columna <> "" Then 
				is_colant = is_columna
				is_ordant = is_order
				ls_sortant = ", " + is_colant + is_ordant
			End If
			is_order		= ' A '
			is_columna	= ls_name 
		Else
			If is_order	= ' D ' Then
				is_order	= ' A '
			Else
				is_order	= ' D ' 
			End If
		End If
		ls_sort = is_columna + is_order + ls_sortant 
		This.SetSort( ls_sort )
		This.Sort()
		dwo.Border = '6'
		is_columna = ls_name
	End If
End If
If row > 0 Then 
	This.SetRow( row )
	gw_frame.SetMicroHelp( "Fila: " + String(row) + "/" + String(RowCount()))
End If

end event

event retrieveend;If rowcount >0 Then 
	SelectRow(0, False)
	SelectRow(1, True)
	SetFocus( )
End If

gw_frame.SetMicroHelp( "Filas Recuperadas: " + String(rowcount))
end event

event retrievestart;gw_frame.SetMicroHelp( "Espere por favor...")
end event

event destructor;gw_frame.SetMicroHelp( "Listo")
end event

event constructor;SetTransObject( SqlCa )
end event

on uo_dw_list.create
end on

on uo_dw_list.destroy
end on

