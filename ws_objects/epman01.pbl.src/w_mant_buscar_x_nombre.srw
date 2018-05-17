$PBExportHeader$w_mant_buscar_x_nombre.srw
forward
global type w_mant_buscar_x_nombre from wa_response
end type
type st_1 from statictext within w_mant_buscar_x_nombre
end type
type sle_1 from singlelineedit within w_mant_buscar_x_nombre
end type
type cb_buscar from uo_cbother within w_mant_buscar_x_nombre
end type
type cbx_1 from checkbox within w_mant_buscar_x_nombre
end type
end forward

global type w_mant_buscar_x_nombre from wa_response
int Width=1975
int Height=1348
boolean TitleBar=true
string Title="Buscar en Catálogo"
long BackColor=81324524
st_1 st_1
sle_1 sle_1
cb_buscar cb_buscar
cbx_1 cbx_1
end type
global w_mant_buscar_x_nombre w_mant_buscar_x_nombre

type variables
string is_tabla
end variables

on w_mant_buscar_x_nombre.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_buscar=create cb_buscar
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.cb_buscar
this.Control[iCurrent+4]=this.cbx_1
end on

on w_mant_buscar_x_nombre.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_buscar)
destroy(this.cbx_1)
end on

event open;call super::open;
//Ventana invocada con un valor, y el val lo recibe is_tabla

is_tabla = Message.StringParm

Choose Case is_tabla
	Case 'MAN'
		This.Title = 'Búsqueda de Manifiesto'
		dw_list.dataobject = 'd_mant_busca_man'
		dw_list.settransobject(sqlca)
		dw_list.retrieve('%')
	Case 'MAE'
		This.Title = 'Búsqueda de Manifiesto para Desembarcar'
		dw_list.dataobject = 'd_mant_busca_mane'
		dw_list.settransobject(sqlca)
		dw_list.retrieve('%')
	Case 'PAL'
		This.Title = 'Búsqueda de Pallet Sin Confirmar'
		dw_list.dataobject = 'd_mant_busca_pallet_sc'
		dw_list.settransobject(sqlca)
		dw_list.retrieve('%')
	Case 'PRO'
		This.Title = 'Búsqueda de Productos'
		dw_list.dataobject = 'd_mant_producto_basico'
		dw_list.settransobject(sqlca)
		dw_list.retrieve('%')
	Case 'CUL'
		This.Title = 'Búsqueda de Cultivos'
		dw_list.dataobject = 'd_mant_cultivo_basico'
		dw_list.settransobject(sqlca)
		dw_list.retrieve('%')
	Case 'MAT'
		This.Title = 'Búsqueda de Materiales'
		dw_list.dataobject = 'd_mant_material_basico'
		dw_list.settransobject(sqlca)
		dw_list.retrieve('%')
	Case 'LIT'
		This.Title = 'Búsqueda de Linea de Transporte'
		dw_list.dataobject = 'd_mant_busca_lt'
		dw_list.settransobject(sqlca)
		dw_list.retrieve('%')
	Case 'DIS'
		This.Title = 'Búsqueda de Distribuidor'
		dw_list.dataobject = 'd_mant_busca_distribuidor'
		dw_list.settransobject(sqlca)
		dw_list.retrieve('%')		
	Case 'EMB'
		This.Title = 'Búsqueda de Embarcador'
		dw_list.dataobject = 'd_mant_busca_embarcador'
		dw_list.settransobject(sqlca)
		dw_list.retrieve('%')		
	Case 'PTE'
		This.Title = 'Búsqueda de Punto de Embarque'
		dw_list.dataobject = 'd_mant_busca_puntoembarque'
		dw_list.settransobject(sqlca)
		dw_list.retrieve('%')		
End Choose

//dw_list.SetTransObject (SqlCa)

If ProfileString( gs_ini, gs_usuario, 'Buscar', '0' ) = '0' Then
	cbx_1.Checked = False
End If

end event

type dw_list from wa_response`dw_list within w_mant_buscar_x_nombre
int X=27
int Y=164
int Width=1888
int Height=928
int TabOrder=30
string DataObject="d_mant_cuentacontable_basica"
end type

event dw_list::doubleclicked;// Aqui estoy utilizando un comportamiento especifico de otro objeto
// Para este caso el evento es clicked del objeto cb_aceptar

cb_aceptar.TriggerEvent(Clicked!)

end event

event dw_list::getfocus;cb_buscar.Default = False
cb_aceptar.Default = True
end event

type dw_1 from wa_response`dw_1 within w_mant_buscar_x_nombre
int X=37
int Y=928
int Width=229
int Height=104
int TabOrder=40
boolean Visible=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_mant_buscar_x_nombre
int X=1563
int Y=1128
int TabOrder=60
end type

type cb_aceptar from wa_response`cb_aceptar within w_mant_buscar_x_nombre
int X=1184
int Y=1128
int TabOrder=50
boolean Enabled=true
end type

event cb_aceptar::clicked;string ls_code

//Si no hay nada de nada, pues no regresa nada, mas solo un beep 

If (dw_list.RowCount() <= 0) Then
	Beep(1)
	Return
End if

// Del dw_list lee la row seleccionado, lo asigna como objeto dw_list para
// asignarlo a un parametro luego se regresa al padre que lo llama.
ls_code = dw_list.Object.c_codigo[ dw_list.GetRow( ) ]

 
CloseWithReturn( Parent, ls_code )
end event

type st_1 from statictext within w_mant_buscar_x_nombre
int X=27
int Y=52
int Width=219
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="&Nombre:"
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

type sle_1 from singlelineedit within w_mant_buscar_x_nombre
int X=251
int Y=48
int Width=1294
int Height=84
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int Accelerator=110
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;cb_buscar.Default = True
cb_aceptar.Default = False
end event

type cb_buscar from uo_cbother within w_mant_buscar_x_nombre
int X=1563
int Y=44
int TabOrder=20
boolean BringToTop=true
string Text="&Buscar"
end type

event clicked;String	ls_texto
is_tabla = Message.StringParm

ls_texto = f_Trim( sle_1.Text ) + '%'
If Not cbx_1.Checked Then ls_texto = '%' + ls_texto

Choose Case is_tabla
	Case 'MAN'
		dw_list.dataobject = 'd_mant_busca_man'
		dw_list.settransobject(sqlca)
	Case 'PAL'
		dw_list.dataobject = 'd_mant_busca_pallet_sc'
		dw_list.settransobject(sqlca)
	Case 'PRO'
		dw_list.dataobject = 'd_mant_producto_basico'
		dw_list.settransobject(sqlca)
		messagebox(title,'1',exclamation!)
	Case 'CUL'
		dw_list.dataobject = 'd_mant_cultivo_basico'
		dw_list.settransobject(sqlca)
	Case 'MAT'
		dw_list.dataobject = 'd_mant_material_basico'
		dw_list.settransobject(sqlca)
		messagebox(title,'2',exclamation!)
	Case 'LIT'
		dw_list.dataobject = 'd_mant_busca_lt'
		dw_list.settransobject(sqlca)
End Choose

dw_list.Retrieve( ls_texto )
end event

type cbx_1 from checkbox within w_mant_buscar_x_nombre
int X=27
int Y=1128
int Width=1051
int Height=80
boolean BringToTop=true
string Text="Buscar &sólo desde el principio de la cadena"
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

event clicked;If Checked Then
	SetProfileString( gs_ini, gs_usuario, 'Buscar', '1' )
Else
	SetProfileString( gs_ini, gs_usuario, 'Buscar', '0' )
End If


end event

