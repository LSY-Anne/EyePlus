$PBExportHeader$w_mant_linea_transporte_edit.srw
forward
global type w_mant_linea_transporte_edit from wa_mant_edit
end type
type st_1 from statictext within w_mant_linea_transporte_edit
end type
end forward

global type w_mant_linea_transporte_edit from wa_mant_edit
int Width=2098
int Height=1244
WindowType WindowType=response!
boolean TitleBar=true
string Title="Linea de Transorte - "
long BackColor=81324524
boolean ControlMenu=true
st_1 st_1
end type
global w_mant_linea_transporte_edit w_mant_linea_transporte_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
end prototypes

public function boolean wf_validareg ();String	ls_codigo, ls_newcod


dw_1.AcceptText( )
ls_codigo = f_trim( dw_1.Object.c_codigo_lit[ 1])

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el codigo ingresado no exista */
	If ls_codigo <> '' Then
		Select	v_nombre_lit
		Into 		:ls_newcod
		From		t_linea_transporte
		Where		c_codigo_lit = :ls_codigo ;
		If f_Trim( ls_newcod ) <> '' Then
			ls_codigo = ''
			MessageBox( Title, 'Código ingresado ya existe.~n~rPertenece a ' + ls_newcod + &
									'~r~n~r~nEl sistema generará el código.', Exclamation!)
		End If
	Else
		MessageBox( Title, 'Debe ingresar el código.' + '~r~n~r~nEl sistema generará el código.', Exclamation!)
	End If
	If ls_codigo = '' Then
		Select	Max( c_codigo_lit )
		Into 		:ls_newcod
		From		t_linea_transporte ;
		ls_newcod = f_Trim( ls_newcod )
		ls_newcod = Right( '00' + f_Trim( String( Integer( ls_newcod ) + 1 )), 2 )
		dw_1.Object.c_codigo_lit[ 1] = ls_newcod 
		Return False
	End If
End If

/* Validamos que campos mandatorios esten ingresados */
/* Descripcion */
if f_trim( dw_1.Object.v_nombre_lit[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar nombre/descripción.', Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo_lit' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'c_codigo_lit', 'v_nombre_lit', 'v_nomcom_lit', 'c_rfc_lit', &
				'c_origen_lit', 'v_direcc_lit', 'v_ciudad_lit', 'v_apapos_lit', &
				'v_codpos_lit', 'v_telef1_lit', 'v_telef2_lit', 'v_ptoemb_lit','c_claveSCAC_lit' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();Return wf_CheckActionE( )

end function

on w_mant_linea_transporte_edit.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_mant_linea_transporte_edit.destroy
call super::destroy
destroy(this.st_1)
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_linea_transporte_edit
int X=0
int Y=0
int Width=2048
int Height=1004
string DataObject="d_mant_linea_transporte_edit"
end type

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_linea_transporte_edit
int X=1641
int Y=1016
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_linea_transporte_edit
int X=1266
int Y=1016
end type

type st_1 from statictext within w_mant_linea_transporte_edit
int X=69
int Y=1008
int Width=1166
int Height=124
boolean Enabled=false
boolean BringToTop=true
string Text="Nota: El campo referencia es un campo alterno que puede utilizarle para informacion de papeleria"
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

