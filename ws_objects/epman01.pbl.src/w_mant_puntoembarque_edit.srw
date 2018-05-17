$PBExportHeader$w_mant_puntoembarque_edit.srw
forward
global type w_mant_puntoembarque_edit from wa_mant_edit
end type
end forward

global type w_mant_puntoembarque_edit from wa_mant_edit
int Width=2377
int Height=1712
boolean TitleBar=true
string Title="Punto de Embarque - "
long BackColor=82899184
end type
global w_mant_puntoembarque_edit w_mant_puntoembarque_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function integer wf_buscar_embarcador (string as_cod)
end prototypes

public function boolean wf_validareg ();String	ls_codigo, ls_newcod


dw_1.AcceptText( )
ls_codigo = f_trim( dw_1.Object.c_codigo_pte[ 1])

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	If ls_codigo = '' Then
		Select	Max( c_codigo_pte )
		Into 		:ls_newcod
		From		t_puntoembarque ;
		ls_newcod = f_Trim( ls_newcod )
		ls_newcod = Right( '00' + f_Trim( String( Integer( ls_newcod ) + 1 )), 2 )
		dw_1.Object.c_codigo_pte[ 1] = ls_newcod 
		Return False
	End If
End If

/* Validamos que campos mandatorios esten ingresados */
/* Embarcador */
if f_trim( dw_1.Object.c_codigo_emb[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar el código de embarcador.', Exclamation!)
	Return False
End If
/* Mercado */
if f_trim( dw_1.Object.c_mercadosind_pte[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar el mercado.', Exclamation!)
	Return False
End If
/* No de viaje */
if f_zero( dw_1.Object.n_numeroviaje_pte[ 1])= 0 Then
	MessageBox( Title, 'Debe ingresar el numero de viaje.', Exclamation!)
	Return False
End If
/* Long Viaje*/
if f_zero( dw_1.Object.n_longitudnumeroviaje_pte[ 1])= 0 Then
	MessageBox( Title, 'Debe ingresar la longitud del numero de viaje.', Exclamation!)
	Return False
End If

/*folio man me*/
if f_zero( dw_1.Object.n_foliomanifiestome_pte[ 1])= 0 Then
	MessageBox( Title, 'Debe ingresar el folio de manifiesto de ME.', Exclamation!)
	Return False
End If

/*long man me*/
if f_zero( dw_1.Object.n_longitudmanifiestome_pte[ 1])= 0 Then
	MessageBox( Title, 'Debe ingresar la longitud de manifiesto de ME.', Exclamation!)
	Return False
End If

/*folio factura ME*/
if f_zero( dw_1.Object.n_foliofacturame_pte[ 1])= 0 Then
	MessageBox( Title, 'Debe ingresar el folio de factura de ME.', Exclamation!)
	Return False
End If

/*long factura ME*/
if f_zero( dw_1.Object.n_longitudfacturame_pte[ 1])= 0 Then
	MessageBox( Title, 'Debe ingresar la longitud de factura de ME.', Exclamation!)
	Return False
End If


/*folio man MN*/
if f_zero( dw_1.Object.n_foliomanifiestomn_pte[ 1])= 0 Then
	MessageBox( Title, 'Debe ingresar el folio de manifiesto de MN.', Exclamation!)
	Return False
End If

/*long man MN*/
if f_zero( dw_1.Object.n_longitudmanifiestomn_pte[ 1])= 0 Then
	MessageBox( Title, 'Debe ingresar la longitud de manifiesto de MN.', Exclamation!)
	Return False
End If

/*folio factura MN*/
if f_zero( dw_1.Object.n_foliofacturamn_pte[ 1])= 0 Then
	MessageBox( Title, 'Debe ingresar el folio de factura de MN.', Exclamation!)
	Return False
End If

/*long factura MN*/
if f_zero( dw_1.Object.n_longitudfacturamn_pte[ 1])= 0 Then
	MessageBox( Title, 'Debe ingresar la longitud de factura de MN.', Exclamation!)
	Return False
End If

///*FOLIO  CAADES*/
//if f_zero( dw_1.Object.c_caades_man[ 1])= 0 Then
//	MessageBox( Title, 'Debe ingresar el folio de caades.', Exclamation!)
//	Return False
//End If
/*Nombre documentador*/
if f_trim( dw_1.Object.v_embnombre_pte[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar el nombre del Documentador.', Exclamation!)
	Return False
End If
/*Telefono documentador*/
if f_trim( dw_1.Object.v_embtelefono_pte[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar el telefono del Documentador.', Exclamation!)
	Return False
End If
///*email documentador*/
//if f_zero( dw_1.Object.v_embtelefono_pte[ 1])= 0 Then
//	MessageBox( Title, 'Debe ingresar el telefono del Documentador.', Exclamation!)
//	Return False
//End If

/*Tipo de punto de embarque*/
if f_trim( dw_1.Object.c_tipopuntoembarque_pte[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar el tipo de punto de embarque.', Exclamation!)
	Return False
End If


Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo_pte' }

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

public function integer wf_buscar_embarcador (string as_cod);String	ls_nompro, ls_parm, ls_act
as_cod = f_Trim( as_cod )
dw_1.AcceptText( )
dw_1.SetFocus( )
	
If as_cod = '' Then
	OpenWithParm( w_mant_buscar_x_nombre, 'EMB' )
	ls_parm = Message.StringParm
	
	ls_parm = f_Trim( ls_parm )
	If Not ls_parm = '' Then
		as_cod = ls_parm
		dw_1.Object.c_codigo_emb[ 1] = ls_parm
		dw_1.Object.nombre[ 1] = f_Getembarcador( ls_parm )
//    
		 
	End If
Else
	as_cod=Trim(Right( '00' + Trim(as_cod),2))
	Select	c_activo_emb 
	Into     :ls_act 
	From		t_embarcador
	Where		c_codigo_usu = :as_cod
	Using SqlCa;

	If ls_act = '0' Then
		MessageBox( Title, 'Código de Embarcador esta eliminado.', Exclamation! )
		dw_1.Object.nombre[ 1]=''
		as_cod=''
		dw_1.SetColumn( 'c_codigo_emb' )
	Else
		ls_nompro = f_Getembarcador( as_cod )   
		If ls_nompro = '' Then
			dw_1.SetColumn( 'c_codigo_emb' )
			MessageBox( Title, 'Código de Embarcador no encontrado.', Exclamation! )
		End If
	dw_1.Object.nombre[ 1] = ls_nompro
	
	End If
End If

cb_aceptar.Enabled = True

Return 1

end function

on w_mant_puntoembarque_edit.create
call super::create
end on

on w_mant_puntoembarque_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_puntoembarque_edit
int X=5
int Y=0
int Width=2304
int Height=1456
string DataObject="d_mant_puntoembarque_edit"
end type

event dw_1::buttonclicked;call super::buttonclicked;If dwo.name='cb_emb' Then
	wf_buscar_embarcador('')
End If
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;
string ls_cod
ls_cod=f_trim(dw_1.Object.c_codigo_emb[1] )
If ls_cod <> '' Then
	dw_1.Object.c_codigo_emb[1] = Trim(Right( '00' + Trim(ls_cod),2))
	wf_buscar_embarcador(ls_cod)
End IF
end event

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_puntoembarque_edit
int X=1957
int Y=1488
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_puntoembarque_edit
int X=1582
int Y=1488
end type

