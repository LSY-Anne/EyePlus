$PBExportHeader$w_mant_etiqueta_edit.srw
forward
global type w_mant_etiqueta_edit from wa_mant_edit
end type
type cb_examinar from uo_cbother within w_mant_etiqueta_edit
end type
end forward

global type w_mant_etiqueta_edit from wa_mant_edit
integer width = 2085
integer height = 960
string title = "Etiqueta - "
long backcolor = 79741120
cb_examinar cb_examinar
end type
global w_mant_etiqueta_edit w_mant_etiqueta_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
end prototypes

public function boolean wf_validareg ();String	ls_codigo, ls_newcod


dw_1.AcceptText( )
ls_codigo = f_trim( dw_1.Object.c_codigo_eti[ 1])

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el codigo ingresado no exista */
	If ls_codigo <> '' Then
		Select	v_nombre_eti
		Into 		:ls_newcod
		From		t_etiqueta
		Where		c_codigo_eti = :ls_codigo ;
		If f_Trim( ls_newcod ) <> '' Then
			ls_codigo = ''
			MessageBox( Title, 'Código ingresado ya existe.~n~rPertenece a ' + ls_newcod + &
									'~r~n~r~nEl sistema generará el código.', Exclamation!)
		End If
	Else
		MessageBox( Title, 'Debe ingresar el código.' + '~r~n~r~nEl sistema generará el código.', Exclamation!)
	End If
	If ls_codigo = '' Then
		Select	Max( c_codigo_eti )
		Into 		:ls_newcod
		From		t_etiqueta ;
		ls_newcod = f_Trim( ls_newcod )
		ls_newcod = Right( '00' + f_Trim( String( Integer( ls_newcod ) + 1 )), 2 )
		dw_1.Object.c_codigo_eti[ 1] = ls_newcod 
		Return False
	End If
End If

/* Validamos que campos mandatorios esten ingresados */
/* Descripcion */
if f_trim( dw_1.Object.v_nombre_eti[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar nombre/descripción.', Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo_eti' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'c_codigo_eti', 'v_nombre_eti', 'v_imagen_eti' }

wf_ColEnabled( ls_acol[] , False )
cb_examinar.Enabled = False


Return True

end function

public function boolean wf_checkactionr ();String	ls_acol[]

ls_acol[] = { 'c_codigo_eti', 'v_nombre_eti' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

on w_mant_etiqueta_edit.create
int iCurrent
call super::create
this.cb_examinar=create cb_examinar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_examinar
end on

on w_mant_etiqueta_edit.destroy
call super::destroy
destroy(this.cb_examinar)
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_etiqueta_edit
integer x = 0
integer y = 0
integer width = 2048
integer height = 672
string dataobject = "d_mant_etiqueta_edit"
end type

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_etiqueta_edit
integer x = 1687
integer y = 700
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_etiqueta_edit
integer x = 1312
integer y = 700
end type

type cb_examinar from uo_cbother within w_mant_etiqueta_edit
integer x = 1687
integer y = 544
integer taborder = 20
boolean bringtotop = true
string text = "&Examinar..."
end type

event clicked;Integer	li_value
String	ls_docname, ls_named



li_value = GetFileOpenName("Select File", ls_docname, ls_named, "DOC", &
	+ "Bitmap Files (*.BMP),*.BMP" )

If li_value = 1 Then
	dw_1.Object.v_imagen_eti[1] = f_Trim( ls_docname )
	cb_aceptar.Enabled = True
	
End If
end event

