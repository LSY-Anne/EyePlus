$PBExportHeader$w_mant_cultivo_edit.srw
forward
global type w_mant_cultivo_edit from wa_mant_edit
end type
type cb_examinar from uo_cbother within w_mant_cultivo_edit
end type
end forward

global type w_mant_cultivo_edit from wa_mant_edit
int Width=2455
int Height=1636
boolean TitleBar=true
string Title="Cultivo - "
long BackColor=79741120
cb_examinar cb_examinar
end type
global w_mant_cultivo_edit w_mant_cultivo_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function boolean wf_checkactioni ()
public function integer wf_buscarcta (string as_cod)
public function integer wf_buscarcta2 (string as_cod)
end prototypes

public function boolean wf_validareg ();String	ls_codigo, ls_newcod,ls_cta,ls_aux,ls_ejecta,ls_ultimo,ls_vigente,ls_eje,ls_nomcta
datetime ld_eje
long ll_eje

ls_codigo = f_trim( dw_1.Object.c_codigo_cul[ 1])
dw_1.AcceptText( )

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el codigo ingresado no exista */
	If ls_codigo <> '' Then
		Select	v_nombre_cul
		Into 		:ls_newcod
		From		t_cultivo
		Where		c_codigo_cul = :ls_codigo ;
		If f_Trim( ls_newcod ) <> '' Then
			ls_codigo = ''
			MessageBox( Title, 'Código ingresado ya existe.~n~rPertenece a ' + ls_newcod + &
									'~r~n~r~nEl sistema generará el código.', Exclamation!)
		End If
	Else
		MessageBox( Title, 'Debe ingresar el código.' + '~r~n~r~nEl sistema generará el código.', Exclamation!)
	End If
	If ls_codigo = '' Then
		Select	Max( c_codigo_cul )
		Into 		:ls_newcod
		From		t_cultivo ;
		ls_newcod = f_Trim( ls_newcod )
		ls_newcod = Right( '00' + f_Trim( String( Integer( ls_newcod ) + 1 )), 2 )
		dw_1.Object.c_codigo_cul[ 1] = ls_newcod 
		Return False
	End If
End If

/* Validamos que campos mandatorios esten ingresados */
/* Descripcion */
if f_trim( dw_1.Object.v_nombre_cul[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar nombre/descripción.', Exclamation!)
	Return False
End If

ls_cta = f_trim(dw_1.Object.c_codigo_cta[1])
If ls_cta <> '' Then
	ld_eje = f_getsysdate()
	ll_eje = Year(Date(ld_eje)) 
	ls_eje = Right('0000' +String(ll_eje),4)
	
	SELECT isnull(v_nombre_cta,'')
	INTO  :ls_nomcta
	FROM concuenta(nolock)
	WHERE c_codigo_cta = :ls_cta
	AND  v_ejercicio_cta =:ls_eje
	USING SQLCA;
	If f_SqlError( SqlCa, 'No se pudo consultar la concuenta [f_verificarcta].' ) < 0 Then 
		Return false
	End If
	
	dw_1.Object.nomcta[1]= ls_nomcta
End If
ls_cta = '';ls_nomcta=''
ls_cta = f_trim(dw_1.Object.c_ctavta_cta[1])
If ls_cta <> '' Then
	ld_eje = f_getsysdate()
	ll_eje = Year(Date(ld_eje)) 
	ls_eje = Right('0000' +String(ll_eje),4)
	
	SELECT isnull(v_nombre_cta,'')
	INTO  :ls_nomcta
	FROM concuenta(nolock)
	WHERE c_codigo_cta = :ls_cta
	AND  v_ejercicio_cta =:ls_eje
	USING SQLCA;
	If f_SqlError( SqlCa, 'No se pudo consultar la concuenta [f_verificarcta].' ) < 0 Then 
		Return false
	End If
	
	dw_1.Object.nomctame[1]= ls_nomcta
End If


Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo_aga' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'c_codigo_cul', 'v_nombre_cul', 'v_nomext_cul', 'n_superf_cul', 'n_produc_cul', &
				'n_porcen_cul', 'n_pronos_cul', 'n_precme_cul', 'n_precmn_cul', &
				'v_imagen_cul', 'v_target_cul', 'n_kgsxur_cul', 'n_cospro_cul', 'n_coscom_cul','c_codigo_cta' }

wf_ColEnabled( ls_acol[] , False )
cb_examinar.Enabled = False
Return True

end function

public function boolean wf_checkactionr ();Return wf_CheckActionE( )

end function

public function boolean wf_checkactioni ();
/* Asigna por default el mercado como origen, el usuario puede cambiarlo */
//dw_1.Object.c_origen_pro[1] = gs_mercado

Return True

end function

public function integer wf_buscarcta (string as_cod);String ls_parm,ls_aux,ls_ejecta,ls_ultimo,ls_vigente,ls_cta,ls_eje,ls_nomcta
Datetime ld_eje
long ll_eje
as_cod = f_Trim( as_cod )
dw_1.AcceptText( )
dw_1.SetFocus()

ld_eje = f_getsysdate()
ll_eje = Year(Date(ld_eje)) 
ls_eje = Right('0000' +String(ll_eje),4)

If as_cod = ''   Then
	OpenWithParm( w_mant_buscar_x_nomcta, 'CTA' )
	ls_parm = Message.StringParm	
	ls_parm = f_Trim( ls_parm )
	
	If Not ls_parm = '' Then
		as_cod = ls_parm
		ls_cta = ls_parm
	End If
	
Else
	as_cod=Trim(dw_1.Object.c_codigo_cta[1])
	ls_cta = as_cod
//	Select	IsNull(c_activo_cta,''), c_ultimonivel_cta
//	Into     :ls_act,:ls_nivel
//	From		concuenta
//	Where		c_codigo_cta= :as_cod
//	And      v_ejercicio_cta = :ls_ejercicio
//	And 		c_activo_cta='1'
//	Using 	SqlCa;
//	If f_SqlError( SqlCa, 'No se pudo consultar la concuenta [f_verificarcta].' ) < 0 Then 
//		Return false
//	End If
//	
//	If ls_act = ''  Or ls_act = '0'Then
//		MessageBox( Title, 'Código de cuenta no encontrado.', Exclamation! )
//		dw_1.Object.c_cuenta_cta[ 1]=''
//		Return 0
//	End If
//	
//	If f_trim(ls_nivel)='N' Then
//		MessageBox( 'Mensaje...', 'Debe ser cuenta de ultimo nivel.', Exclamation! )
//		dw_1.Object.c_cuenta_cta[ 1]=''
//   	Return 0
//	End If
	
End If
dw_1.AcceptText( )

SELECT isnull(c_codigo_cta,''),isnull(v_ejercicio_cta,''), isnull(c_ultimonivel_cta,''),isnull(c_vigente_cta,''),isnull(v_nombre_cta,'')
INTO :ls_aux,:ls_ejecta,:ls_ultimo,:ls_vigente,:ls_nomcta
FROM concuenta(nolock)
WHERE c_codigo_cta = :ls_cta
AND  v_ejercicio_cta =:ls_eje
USING SQLCA;
If f_SqlError( SqlCa, 'No se pudo consultar la concuenta [f_verificarcta].' ) < 0 Then 
	Return 0
End If

ls_aux = f_trim(ls_aux)
ls_ejecta= f_trim(ls_ejecta)
ls_ultimo= f_trim(ls_ultimo)
ls_vigente= f_trim(ls_vigente)

If ls_aux ='' Then
	MessageBox('Verificando Cuentas','La cuenta ['+ls_cta+'] No existe.'+ '~n~r'+ &
					' Revise su Catálogo Contable',Exclamation!)
	dw_1.Object.c_codigo_cta[ 1] = ''
	dw_1.Object.nomcta[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_codigo_cta')
	Return 0
	
ElseIF ls_ejecta <> ls_eje Then
	MessageBox('Verificando Cuentas','El ejercicio de la cuenta ['+ls_cta+'] No corresponde con el ejercicio de la fecha de póliza'+ '~n~r'+ &
					'Revise su Catálogo Contable y su fecha de exportación',Exclamation!)
	dw_1.Object.c_codigo_cta[ 1] = ''
	dw_1.Object.nomcta[1]=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_codigo_cta')
	Return 0

ElseIF ls_ultimo <> 'S' Then
	MessageBox('Verificando Cuentas','La cuenta ['+ls_cta+'] No es de último nivel'+ '~n~r'+ &
				  'Revise su Catálogo Contable',Exclamation!)
	dw_1.Object.c_codigo_cta[ 1] = ''
	dw_1.Object.nomcta[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_codigo_cta')
	Return 0
	
ElseIF ls_vigente <> 'S' Then
	MessageBox('Verificando Cuentas','La cuenta ['+ls_cta+'] No esta vigente'+ '~n~r'+ &
				  'Revise su Catálogo Contable',Exclamation!)
	dw_1.Object.c_codigo_cta[ 1] = ''
	dw_1.Object.nomcta[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_codigo_cta')
	Return 0	
End IF
dw_1.Object.c_codigo_cta[ 1] = ls_cta
dw_1.Object.nomcta[1]= ls_nomcta
Return 1
end function

public function integer wf_buscarcta2 (string as_cod);String ls_parm,ls_aux,ls_ejecta,ls_ultimo,ls_vigente,ls_cta,ls_eje,ls_nomctame
Datetime ld_eje
long ll_eje
as_cod = f_Trim( as_cod )
dw_1.AcceptText( )
dw_1.SetFocus()

ld_eje = f_getsysdate()
ll_eje = Year(Date(ld_eje)) 
ls_eje = Right('0000' +String(ll_eje),4)

If as_cod = ''   Then
	OpenWithParm( w_mant_buscar_x_nomcta, 'CTA' )
	ls_parm = Message.StringParm	
	ls_parm = f_Trim( ls_parm )
	
	If Not ls_parm = '' Then
		as_cod = ls_parm
		ls_cta = ls_parm
	End If
	
Else
	as_cod=Trim(dw_1.Object.c_ctavta_cta[1])
	ls_cta = as_cod
	
End If
dw_1.AcceptText( )

SELECT isnull(c_codigo_cta,''),isnull(v_ejercicio_cta,''), isnull(c_ultimonivel_cta,''),isnull(c_vigente_cta,''),isnull(v_nombre_cta,'')
INTO :ls_aux,:ls_ejecta,:ls_ultimo,:ls_vigente,:ls_nomctame
FROM concuenta(nolock)
WHERE c_codigo_cta = :ls_cta
AND  v_ejercicio_cta =:ls_eje
USING SQLCA;
If f_SqlError( SqlCa, 'No se pudo consultar la concuenta [f_verificarcta].' ) < 0 Then 
	Return 0
End If

ls_aux = f_trim(ls_aux)
ls_ejecta= f_trim(ls_ejecta)
ls_ultimo= f_trim(ls_ultimo)
ls_vigente= f_trim(ls_vigente)

If ls_aux ='' Then
	MessageBox('Verificando Cuentas','La cuenta ['+ls_cta+'] No existe.'+ '~n~r'+ &
					' Revise su Catálogo Contable',Exclamation!)
	dw_1.Object.c_ctavta_cta[ 1] = ''
	dw_1.Object.nomctame[1]=''
	ls_cta='';ls_nomctame=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctavta_cta')
	Return 0
	
ElseIF ls_ejecta <> ls_eje Then
	MessageBox('Verificando Cuentas','El ejercicio de la cuenta ['+ls_cta+'] No corresponde con el ejercicio de la fecha de póliza'+ '~n~r'+ &
					'Revise su Catálogo Contable y su fecha de exportación',Exclamation!)
	dw_1.Object.c_ctavta_cta[ 1] = ''
	dw_1.Object.nomctame[1]=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctavta_cta')
	Return 0

ElseIF ls_ultimo <> 'S' Then
	MessageBox('Verificando Cuentas','La cuenta ['+ls_cta+'] No es de último nivel'+ '~n~r'+ &
				  'Revise su Catálogo Contable',Exclamation!)
	dw_1.Object.c_ctavta_cta[ 1] = ''
	dw_1.Object.nomctame[1]=''
	ls_cta='';ls_nomctame=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctavta_cta')
	Return 0
	
ElseIF ls_vigente <> 'S' Then
	MessageBox('Verificando Cuentas','La cuenta ['+ls_cta+'] No esta vigente'+ '~n~r'+ &
				  'Revise su Catálogo Contable',Exclamation!)
	dw_1.Object.c_ctavta_cta[ 1] = ''
	dw_1.Object.nomctame[1]=''
	ls_cta='';ls_nomctame=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctavta_cta')
	Return 0	
End IF
dw_1.Object.c_ctavta_cta[ 1] = ls_cta
dw_1.Object.nomctame[1]= ls_nomctame
Return 1
end function

on w_mant_cultivo_edit.create
int iCurrent
call super::create
this.cb_examinar=create cb_examinar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_examinar
end on

on w_mant_cultivo_edit.destroy
call super::destroy
destroy(this.cb_examinar)
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_cultivo_edit
int X=0
int Y=0
int Width=2432
int Height=1376
string DataObject="d_mant_cultivo_edit"
end type

event dw_1::buttonclicked;call super::buttonclicked;If dwo.Name = 'cb_cta' Then
	wf_Buscarcta( '' )
End If
If dwo.Name = 'cb_cta2' Then
	wf_Buscarcta2( '' )
End If
end event

event dw_1::itemchanged;call super::itemchanged;String ls_cta,ls_cta2


dw_1.AcceptText()
ls_cta = f_trim(dw_1.Object.c_codigo_cta[1])
ls_cta2 = f_trim(dw_1.Object.c_ctavta_cta[1])
Choose Case dwo.Name
		
	Case 'c_codigo_cta'
		If ls_cta = '' Then
			wf_buscarcta('')
			
		Else
			 wf_buscarcta(ls_cta)
			
		End IF
	Case 'c_ctavta_cta'
		If ls_cta2 = '' Then
			wf_buscarcta2('')
			
		Else
			 wf_buscarcta2(ls_cta2)
			
		End IF
End Choose

Return 0
		
end event

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_cultivo_edit
int X=2039
int Y=1404
int TabOrder=40
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_cultivo_edit
int X=1664
int Y=1404
end type

type cb_examinar from uo_cbother within w_mant_cultivo_edit
int X=1998
int Y=1232
int TabOrder=30
boolean BringToTop=true
string Text="&Examinar..."
end type

event clicked;Integer	li_value
String	ls_docname, ls_named



li_value = GetFileOpenName("Select File", ls_docname, ls_named, "DOC", &
	+ "Bitmap Files (*.BMP),*.BMP" )

If li_value = 1 Then
	dw_1.Object.v_imagen_cul[1] = f_Trim( ls_docname )
	cb_aceptar.Enabled = True
	
End If
end event

