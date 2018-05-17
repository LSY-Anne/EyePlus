$PBExportHeader$w_mant_producto_costo_edit.srw
forward
global type w_mant_producto_costo_edit from wa_mant_edit
end type
type st_1 from statictext within w_mant_producto_costo_edit
end type
type sle_1 from singlelineedit within w_mant_producto_costo_edit
end type
type st_2 from statictext within w_mant_producto_costo_edit
end type
type gb_1 from groupbox within w_mant_producto_costo_edit
end type
type p_1 from picture within w_mant_producto_costo_edit
end type
end forward

global type w_mant_producto_costo_edit from wa_mant_edit
int Width=1655
int Height=1384
boolean TitleBar=true
string Title="Costo por Producto - "
long BackColor=79741120
st_1 st_1
sle_1 sle_1
st_2 st_2
gb_1 gb_1
p_1 p_1
end type
global w_mant_producto_costo_edit w_mant_producto_costo_edit

type variables
String	is_columna = '', is_order, is_colant = '', is_ordant
end variables

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function boolean wf_checkactioni ()
public function boolean wf_setcosto ()
end prototypes

public function boolean wf_validareg ();Integer	i
String	ls_nom

For i = 1 To dw_1.RowCount( )
	ls_nom = f_Trim( dw_1.Object.v_nombre_cos[ i] )
	If f_Zero( dw_1.Object.n_importe_prc[ i]) < 0 Then
		dw_1.SetRow( i)
		MessageBox( Title, 'El importe ingresado del costo ' + ls_nom + &
								'es incorrecto, el valor debe ser cero o mayor a cero.', Exclamation!)
		Return False
	End If
Next

Return True
end function

public function boolean wf_checkactionm ();
Return wf_SetCosto( )

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'n_importe_prc' }

wf_ColEnabled( ls_acol[] , False )

wf_SetCosto( )
cb_aceptar.Visible = False
cb_cancelar.Text = 'Cerrar'
cb_cancelar.SetFocus( )
dw_1.Enabled = True
Title = 'Costo por Producto - Solo Consulta'
Return True

end function

public function boolean wf_checkactionr ();Return wf_CheckActionE( )
end function

public function boolean wf_checkactioni ();
Return wf_SetCosto( )

end function

public function boolean wf_setcosto ();/* wf_SetCosto( ) */
uo_DataStore	lds_1
Integer			i, j
String			ls_cos, ls_nom, ls_cod, ls_pro, ls_mer, ls_fil
Destroy	lds_1

lds_1 = Create uo_DataStore
lds_1.DataObject = 'd_dddw_costo'
lds_1.SetTransObject( SqlCa )
lds_1.Retrieve( )

ls_cod = istr_parm.s_cad[2]

Select	v_nombre_pro, c_merdes_pro
Into		:ls_pro, :ls_mer
From		t_producto
Where		c_codigo_pro = :ls_cod 
Using		SqlCa ;

If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_producto.') = -1 Then
	Return False
End If

ls_pro = ls_cod + ' - ' + ls_pro
sle_1.Text = ls_pro

/* Se filtra el listado para el mercado del costo o para mercado "Ambos" -> 'A'
       
		 Ya no aplica el filtro, pero puede reactivarse
		 
ls_fil = 'c_mercado_cos In ("A", "' + ls_mer + '")' 
lds_1.SetFilter( ls_fil )
lds_1.Filter( )
*/
For i = 1 To lds_1.RowCount( )
	ls_cos = lds_1.Object.c_codigo_cos[i]
	ls_nom = lds_1.Object.v_nombre_cos[i]
	If dw_1.Find( 'c_codigo_cos = "' + ls_cos + '"', 1, dw_1.RowCount( ) ) > 0 Then Continue
	j = dw_1.InsertRow(0)
	dw_1.Object.c_codigo_pro[ j] = ls_cod
	dw_1.Object.c_codigo_cos[ j] = ls_cos
	dw_1.Object.v_nombre_cos[ j] = ls_nom
	dw_1.Object.c_codigo_usu[ j] = gs_usuario
	dw_1.Object.d_creacion[ j] = Today( )
	dw_1.Object.c_activo[ j] = '1'
Next
dw_1.AcceptText( )

Destroy lds_1
Return True
end function

on w_mant_producto_costo_edit.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_1=create sle_1
this.st_2=create st_2
this.gb_1=create gb_1
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.p_1
end on

on w_mant_producto_costo_edit.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.p_1)
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_producto_costo_edit
int X=37
int Y=124
int Width=1563
int Height=888
string DataObject="d_mant_producto_costo_edit"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

event dw_1::itemchanged;call super::itemchanged;String	ls_dato, ls_cul

Choose Case dwo.name
	Case "c_codigo_cul"
		ls_dato = data + f_Trim( Right( Object.c_codigo_pro[row], 2 ) )
		Object.c_codigo_pro[row] = ls_dato 
	Case "c_codigo_pro"
		ls_dato = f_Trim( Left( data, 2 ) )
		Object.c_codigo_cul[row] = ls_dato 
End Choose


If dwo.name = 'c_codigo_cul' Or dwo.name = 'c_codigo_pro' Then
	ls_dato = Left( data, 2 )
	/* Busca el codigo del envase */
	Select	v_imagen_cul
	Into 		:ls_cul
	From		t_cultivo
	Where		c_codigo_cul = :ls_dato
	And		c_activo_cul = '1' ;
	
	If f_SqlError( SqlCa, 'No se pudo obtener información de t_cultivo.') = -1 Then Return
	If f_Trim( ls_cul ) = '' Then
		MessageBox( Title, 'Producto ingresado/seleccionado no existe o está eliminado.', Exclamation!)
		Return -1
	End If
	Object.v_imagen_pro[row] = ls_cul
End If
end event

event dw_1::clicked;/*	Autor		: César Vilela Requena
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

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_producto_costo_edit
int X=1253
int Y=1040
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_producto_costo_edit
int X=878
int Y=1040
end type

type st_1 from statictext within w_mant_producto_costo_edit
int X=37
int Y=40
int Width=238
int Height=56
boolean Enabled=false
boolean BringToTop=true
string Text="Producto:"
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

type sle_1 from singlelineedit within w_mant_producto_costo_edit
int X=288
int Y=32
int Width=1312
int Height=76
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_mant_producto_costo_edit
int X=187
int Y=1192
int Width=1381
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="Los Costos deben especificarse en Dólares Americanos"
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

type gb_1 from groupbox within w_mant_producto_costo_edit
int X=46
int Y=1144
int Width=1563
int Height=132
int TabOrder=20
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

type p_1 from picture within w_mant_producto_costo_edit
int X=82
int Y=1196
int Width=73
int Height=56
boolean BringToTop=true
string PictureName="nota.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

