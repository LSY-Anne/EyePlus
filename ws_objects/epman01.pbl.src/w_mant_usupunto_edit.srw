$PBExportHeader$w_mant_usupunto_edit.srw
forward
global type w_mant_usupunto_edit from wa_mant_edit
end type
end forward

global type w_mant_usupunto_edit from wa_mant_edit
int Width=1801
int Height=564
boolean TitleBar=true
string Title="Usuario Punto de Embarque  - "
long BackColor=82899184
end type
global w_mant_usupunto_edit w_mant_usupunto_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function integer wf_busca_puntoembarque (string as_cod)
end prototypes

public function boolean wf_validareg ();String	ls_codigo, ls_newcod


dw_1.AcceptText( )
ls_codigo = f_trim( dw_1.Object.c_codigo[ 1])

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el codigo ingresado no exista */
//	If ls_codigo <> '' Then
//		Select	c_codigo_pte
//		Into 		:ls_newcod
//		From		t_usuarioembarque
//		Where		c_codigo_pte = :ls_codigo ;
//		If f_Trim( ls_newcod ) <> '' Then
//			ls_codigo = ''
//			MessageBox( Title, 'Código ingresado ya existe.~n~rPertenece a ' + ls_newcod + &
//									'~r~n~r~nEl sistema generará el código.', Exclamation!)
//		End If
//	Else
//		MessageBox( Title, 'Debe ingresar el código.' + '~r~n~r~nEl sistema generará el código.', Exclamation!)
//	End If
	If ls_codigo = '' Then
		Select	Max( c_codigo_upu )
		Into 		:ls_newcod
		From		t_usuarioembarque ;
		ls_newcod = f_Trim( ls_newcod )
		ls_newcod = Right( '00' + f_Trim( String( Integer( ls_newcod ) + 1 )), 2)
		dw_1.Object.c_codigo[ 1] = ls_newcod 
		Return False
	End If
End If

/* Validamos que campos mandatorios esten ingresados */
/* usuario */
if f_trim( dw_1.Object.c_usupun_upu[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar el usuario.', Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo_act' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'c_codigo_act', 'v_nombre_act' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();
Return wf_CheckActionE( )

end function

public function integer wf_busca_puntoembarque (string as_cod);String	ls_nompro, ls_parm, ls_act
as_cod = f_Trim( as_cod )
dw_1.AcceptText( )
dw_1.SetFocus( )
	
If as_cod = '' Then
	OpenWithParm( w_mant_buscar_x_nombre, 'PTE' )
	ls_parm = Message.StringParm
	
	ls_parm = f_Trim( ls_parm )
	If Not ls_parm = '' Then
		as_cod = ls_parm
		dw_1.Object.c_codigo_pte[ 1] = ls_parm
//		dw_1.Object.nombre[ 1] = f_Getpuntoembarque( ls_parm )
//    
		 
	End If
Else
	as_cod=Trim(Right( '00' + Trim(as_cod),2))
	Select	c_activo_pte 
	Into     :ls_act 
	From		t_puntoembarque
	Where		c_codigo_usu = :as_cod
	Using SqlCa;

	If ls_act = '0' Then
		MessageBox( Title, 'Código de punto de embarque esta eliminado.', Exclamation! )
//		dw_1.Object.nombre[ 1]=''
		as_cod=''
		dw_1.SetColumn( 'c_codigo_pte' )
	Else
		ls_nompro = f_Getpuntoembarque( as_cod )   
		If ls_nompro = '' Then
			dw_1.SetColumn( 'c_codigo_pte' )
			MessageBox( Title, 'Código de punto de embarque no encontrado.', Exclamation! )
		End If
//	dw_1.Object.nombre[ 1] = ls_nompro
	
	End If
End If

cb_aceptar.Enabled = True

Return 1

end function

on w_mant_usupunto_edit.create
call super::create
end on

on w_mant_usupunto_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_usupunto_edit
int X=0
int Y=0
int Width=1751
int Height=336
string DataObject="d_mant_usupunto_edit"
end type

event dw_1::itemfocuschanged;call super::itemfocuschanged;
string ls_cod
ls_cod=f_trim(dw_1.Object.c_codigo_pte[1] )
If ls_cod <> '' Then
	dw_1.Object.c_codigo_pte[1] = Trim(Right( '00' + Trim(ls_cod),2))
	wf_busca_puntoembarque(ls_cod)
End IF
end event

event dw_1::buttonclicked;call super::buttonclicked;If dwo.name='cb_pte' Then
	wf_busca_puntoembarque('')
End If
end event

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_usupunto_edit
int X=1394
int Y=356
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_usupunto_edit
int X=1019
int Y=356
end type

