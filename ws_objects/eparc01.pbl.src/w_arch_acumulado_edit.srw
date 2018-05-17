$PBExportHeader$w_arch_acumulado_edit.srw
forward
global type w_arch_acumulado_edit from wa_mant_edit
end type
type st_1 from statictext within w_arch_acumulado_edit
end type
type p_1 from picture within w_arch_acumulado_edit
end type
end forward

global type w_arch_acumulado_edit from wa_mant_edit
int Width=2117
int Height=1420
boolean TitleBar=true
string Title="Acumulado - "
long BackColor=80269524
st_1 st_1
p_1 p_1
end type
global w_arch_acumulado_edit w_arch_acumulado_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function boolean wf_checkactioni ()
end prototypes

public function boolean wf_validareg ();/*DateTime	ld_mov
Dec{2}	ldc_bul
Long		ll_cnt
String	ls_ele, ls_pro, ls_bus, ls_cul, ls_eti, ls_new, ls_tip

dw_1.AcceptText( )

ls_ele = f_Trim( dw_1.Object.c_elemen_otm[ 1] )
ls_pro = f_Trim( dw_1.Object.c_codigo_pro[ 1] )
ls_cul = f_Trim( dw_1.Object.c_codigo_cul[ 1] )
ls_eti = f_Trim( dw_1.Object.c_codigo_eti[ 1] )
ls_tip = f_Trim( dw_1.Object.c_tipmov_otm[ 1] )
ldc_bul = f_Zero( dw_1.Object.n_afecto_otm[ 1] )
ld_mov = dw_1.Object.d_movimi_otm[ 1]
If ls_tip = '' Then
	MessageBox( Title, 'Debe seleccionar el tipo de movimiento para continuar.', Exclamation!)
	Return False
End If
If IsNull( ld_mov ) Then
	MessageBox( Title, 'Debe ingresar una fecha de trabajo válida para continuar.', Exclamation!)
	Return False
End If
If ls_ele = '' Then
	MessageBox( Title, 'Debe ingresar el elemento para continuar.', Exclamation!)
	Return False
End If
If ls_pro = '' Then
	MessageBox( Title, 'Debe seleccionar el producto para continuar.', Exclamation!)
	Return False
End If
If ls_cul = '' Then
	MessageBox( Title, 'Debe seleccionar el cultivo para continuar.', Exclamation!)
	Return False
End If
If ls_eti = '' Then
	MessageBox( Title, 'Debe seleccionar la etiqueta para continuar.', Exclamation!)
	Return False
End If
If ldc_bul = 0 Then
	MessageBox( Title, 'Debe ingresar los bultos afectados para continuar.', Exclamation!)
	Return False
End If

/* Se busca el producto, se utiliza ls_bus */
Select	c_codigo_pro
Into		:ls_bus
From		t_producto
Where		c_codigo_pro = :ls_pro
And		c_activo_pro = '1' ;
If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_producto (c_codigo_pro)' ) =-1 Then
	Return False
End If

If f_Trim( ls_bus ) = '' Then
	MessageBox( Title, 'Debe ingresar/seleccionar un producto existente ' + &
								'y activo para poder continuar.', Exclamation!)
	Return False
End If

ls_bus = ''
/* Se busca la etiqueta , se utiliza ls_bus */
Select	c_codigo_eti
Into		:ls_bus
From		t_etiqueta
Where		c_codigo_eti = :ls_eti
And		c_activo_eti = '1' ;
If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_etiqueta (c_codigo_eti)' ) =-1 Then
	Return False
End If

If f_Trim( ls_bus ) = '' Then
	MessageBox( Title, 'Debe ingresar/seleccionar una etiqueta existente ' + &
								'y activa para poder continuar.', Exclamation!)
	Return False
End If

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el registro ingresado no exista */
	dw_1.Object.c_codigo_tem[ 1] = gs_codtem
	Select	Count( * )
	Into 		:ll_cnt
	From		t_otro_movimiento
	Where		c_codigo_tem = :gs_codtem
	And		c_elemen_otm = :ls_ele
	And		d_movimi_otm = :ld_mov ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_otro_movimiento (Count)' ) =-1 Then
		Return False
	End If
	If f_Zero( ll_cnt ) > 0 Then
		MessageBox( Title, 'Este registro de mano de obra ya existe.~n~r' + &
							'~r~nSi desea actualizarlo, seleccionelo y haga clic en Modificar.', Exclamation!)
		Return False
	End If
	/* Genera código */
	Select	Max( c_codigo_otm )
	Into 		:ls_new
	From		t_otro_movimiento ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_otro_movimiento (Max)' ) =-1 Then
		Return False
	End If
	ls_new = f_Trim( ls_new )
	ls_new = Right( '000000' + f_Trim( String( Integer( ls_new ) + 1 )), 6 )
	dw_1.Object.c_codigo_otm[ 1] = ls_new 
End If
*/
/* Validamos que campos mandatorios esten ingresados */
/* */

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

//ls_acol[] = { '' }

//wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();
String	ls_acol[]

ls_acol[] = { 'c_tipmov_otm', 'd_movimi_otm', 'c_elemen_otm', &
				'n_afecto_otm', 'c_codigo_pro', 'c_codigo_eti', 'c_codigo_cul' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();Return wf_CheckActionE( )

end function

public function boolean wf_checkactioni ();

Return True

end function

on w_arch_acumulado_edit.create
int iCurrent
call super::create
this.st_1=create st_1
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.p_1
end on

on w_arch_acumulado_edit.destroy
call super::destroy
destroy(this.st_1)
destroy(this.p_1)
end on

event activate;dw_1.Enabled = False
end event

type dw_1 from wa_mant_edit`dw_1 within w_arch_acumulado_edit
int X=0
int Y=0
int Width=2085
int Height=1220
string DataObject="d_arch_acumulado_edit"
end type

type cb_cancelar from wa_mant_edit`cb_cancelar within w_arch_acumulado_edit
int X=1696
int Y=1220
string Text="Cerrar"
boolean Default=true
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_arch_acumulado_edit
int X=1321
int Y=1220
boolean Visible=false
end type

type st_1 from statictext within w_arch_acumulado_edit
int X=137
int Y=1236
int Width=1111
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="La información mostrada es solo de consulta"
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

type p_1 from picture within w_arch_acumulado_edit
int X=50
int Y=1236
int Width=73
int Height=56
boolean BringToTop=true
string PictureName="nota.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

