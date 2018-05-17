$PBExportHeader$w_mant_producto_edit.srw
forward
global type w_mant_producto_edit from wa_mant_edit
end type
type cb_examinar from uo_cbother within w_mant_producto_edit
end type
type cb_costos from uo_cbother within w_mant_producto_edit
end type
end forward

global type w_mant_producto_edit from wa_mant_edit
int Width=2459
int Height=1400
boolean TitleBar=true
string Title="Producto - "
long BackColor=79741120
cb_examinar cb_examinar
cb_costos cb_costos
end type
global w_mant_producto_edit w_mant_producto_edit

type variables

end variables

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function boolean wf_checkactioni ()
public function boolean wf_valkeyenter ()
public function string wf_modificar (string as_cod)
end prototypes

public function boolean wf_validareg ();String	ls_codigo, ls_newcod, ls_cultivo,ls_pro
long ll_pro


dw_1.AcceptText( )

ls_codigo = f_Trim( dw_1.Object.c_codigo_pro[ 1])
ls_cultivo = f_Trim( dw_1.Object.c_codigo_cul[ 1])

If ls_cultivo = '' Then
	MessageBox( Title, 'Debe ingresar/seleccionar el cultivo.', Exclamation!)
	Return False
End If

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el codigo ingresado no exista */
	If Len( ls_codigo ) = 4 Then
		Select	v_nombre_pro
		Into 		:ls_newcod
		From		t_producto
		Where		c_codigo_pro = :ls_codigo ;
		If f_Trim( ls_newcod ) <> '' Then
			ls_codigo = ''
			MessageBox( Title, 'Código ingresado ya existe.~n~rPertenece a ' + ls_newcod + &
									'~r~n~r~nEl sistema generará el código.', Exclamation!)
		End If
	Else
		MessageBox( Title, 'Debe ingresar el código.' + '~r~n~r~nEl sistema generará el código.', Exclamation!)
	End If
	If Len( ls_codigo ) <> 4 Then
		Select	Max( c_codigo_pro )
		Into 		:ls_newcod
		From		t_producto 
		Where		c_codigo_cul = :ls_cultivo ;
		ls_newcod = f_Trim( ls_newcod )
		ls_newcod = ls_cultivo + Right( '00' + f_Trim( String( Integer( ls_newcod ) + 1 )), 2 )
		dw_1.Object.c_codigo_pro[ 1] = ls_newcod 
		Return False
	End If
End If

//=======================================
If istr_parm.s_cad[ 1] = 'E' Then
	ls_pro = (dw_1.object.c_codigo_pro[1])
	select count(c_codigo_pro)
	into :ll_pro
	from t_palet
	where c_codigo_pro = :ls_pro
	using sqlca;
	If f_SqlError( SqlCa, 'No se pudo leer la tabla  t_palet (select)' ) < 0 Then 
			RollBack Using SqlCa ;
			Return False
	End If	
	
	if ll_pro > 0 then
		messagebox(title,'No se puede eliminar el producto porque tiene movimientos',exclamation!)
		close(this)
		return false
	end if
end if

//=======================================
/* Validamos que campos mandatorios esten ingresados */
/* Descripcion */
If f_Trim( dw_1.Object.v_nombre_pro[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar nombre/descripción.', Exclamation!)
	Return False
End If

If f_Trim( dw_1.Object.c_merdes_pro[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar el mercado destino (solo como referencia).', Exclamation!)
	Return False
End If

If f_Zero( dw_1.Object.n_pesbul_pro[ 1]) = 0 Then
	MessageBox( Title, 'Deberá ingresar el peso por bulto(caja).', Exclamation!)
End If

If f_Zero( dw_1.Object.n_bulxpa_pro[ 1]) = 0 Then
	MessageBox( Title, 'Deberá ingresar la cantidad de bultos(cajas) por palet.', Exclamation!)
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[],ls_pro
long ll_pro

ls_pro = (dw_1.object.c_codigo_pro[1])
select count(c_codigo_pro)
into :ll_pro
from t_palet
where c_codigo_pro = :ls_pro
using sqlca;
If f_SqlError( SqlCa, 'No se pudo leer la tabla  t_palet (select)' ) < 0 Then 
		RollBack Using SqlCa ;
		Return False
End If	

if ll_pro > 0 then
	ls_acol[] = { 'c_codigo_pro', 'c_codigo_cul', 'c_merdes_pro' }
else
	ls_acol[] = { 'c_codigo_pro', 'c_codigo_cul' }
end if


//ls_acol[] = { 'c_codigo_pro', 'c_codigo_cul', 'c_merdes_pro' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]


ls_acol[] = { 'c_codigo_pro', 'v_nombre_pro', 'c_codigo_cul', 'v_nomext_pro', &
					'c_merdes_pro', 'c_codigo_env', 'n_pesuni_pro', 'n_pesbul_pro', &
					'n_bulxpa_pro', 'v_imagen_pro', 'c_codigo_tam' }

wf_ColEnabled( ls_acol[] , False )
cb_examinar.Enabled = False
Return True


end function

public function boolean wf_checkactionr ();Return wf_CheckActionE( )
end function

public function boolean wf_checkactioni ();
/* Asigna por default el mercado como origen, el usuario puede cambiarlo */
dw_1.Object.c_merdes_pro[1] = gs_mercado
cb_costos.Enabled = False

Return True

end function

public function boolean wf_valkeyenter ();Integer	i
String	ls_ult

is_cols[] = { 'c_codigo_cul', 'c_codigo_pro', 'v_nombre_pro', 'v_nomext_pro', &
					'c_codigo_env', 'c_merdes_pro', 'c_codigo_tam', 'n_pesuni_pro', &
					'n_pesbul_pro', 'n_bulxpa_pro', 'v_imagen_pro' }

ls_ult = is_cols[ UpperBound( is_cols[] )]
If ls_ult = dw_1.GetColumnName( ) Then
	Return True
End If

For i = 1 To UpperBound( is_cols[] )
	If is_cols[ i] = dw_1.GetColumnName( ) Then
		dw_1.SetColumn( is_cols[ i + 1]  )
		dw_1.SetFocus( )
		Return False
	End If
Next

Return True
end function

public function string wf_modificar (string as_cod);String ls_activo

select c_activo_acu
into :ls_activo
from t_acumulado
where c_codigo_pro =: as_cod
using SQLCA;

Return ls_activo
end function

on w_mant_producto_edit.create
int iCurrent
call super::create
this.cb_examinar=create cb_examinar
this.cb_costos=create cb_costos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_examinar
this.Control[iCurrent+2]=this.cb_costos
end on

on w_mant_producto_edit.destroy
call super::destroy
destroy(this.cb_examinar)
destroy(this.cb_costos)
end on

event open;call super::open;String ls_codigo, ls_activo

dw_1.AcceptText( )

ls_codigo = f_Trim( dw_1.Object.c_codigo_pro[ 1])

If istr_parm.s_cad[ 1] = 'M' Then
	ls_activo = wf_modificar(ls_codigo)
	
	if ls_activo = '1' Then
		f_colenabled(dw_1,'c_merdes_pro',False)
	End If

End if

	
	
	
end event

type dw_1 from wa_mant_edit`dw_1 within w_mant_producto_edit
int X=0
int Y=4
int Width=2414
int Height=1116
string DataObject="d_mant_producto_edit"
end type

event dw_1::itemchanged;call super::itemchanged;String	ls_dato, ls_cul, ls_nom

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
	Select	v_imagen_cul,
				v_nombre_cul
	Into 		:ls_cul,
				:ls_nom
	From		t_cultivo
	Where		c_codigo_cul = :ls_dato
	And		c_activo_cul = '1' ;
	
	If f_SqlError( SqlCa, 'No se pudo obtener información de t_cultivo.') = -1 Then Return
	If f_Trim( ls_nom ) = '' Then
		MessageBox( Parent.Title, 'Cultivo ingresado/seleccionado no existe o está eliminado.', Exclamation!)
		Return -1
	End If
	Object.v_imagen_pro[row] = f_Trim( ls_cul )
End If
end event

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_producto_edit
int X=2043
int Y=1136
int TabOrder=50
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_producto_edit
int X=1669
int Y=1136
int TabOrder=40
end type

type cb_examinar from uo_cbother within w_mant_producto_edit
int X=2039
int Y=976
int TabOrder=20
boolean BringToTop=true
string Text="&Examinar..."
end type

event clicked;Integer	li_value
String	ls_docname, ls_named



li_value = GetFileOpenName("Select File", ls_docname, ls_named, "DOC", &
	+ "Bitmap Files (*.BMP),*.BMP" )

If li_value = 1 Then
	dw_1.Object.v_imagen_pro[1] = f_Trim( ls_docname )
	cb_aceptar.Enabled = True
	
End If
end event

type cb_costos from uo_cbother within w_mant_producto_edit
int X=1289
int Y=1136
int TabOrder=30
boolean BringToTop=true
string Text="&Costos..."
end type

event clicked;OpenSheetWithParm( w_mant_producto_costo_edit, istr_parm, gw_frame, 0, Original! )
//OpenWithParm( w_mant_producto_costo_edit, istr_parm )

end event

