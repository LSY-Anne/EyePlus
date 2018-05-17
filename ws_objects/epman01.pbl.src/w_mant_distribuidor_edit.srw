$PBExportHeader$w_mant_distribuidor_edit.srw
forward
global type w_mant_distribuidor_edit from wa_mant_edit
end type
end forward

global type w_mant_distribuidor_edit from wa_mant_edit
int Width=2053
int Height=1560
WindowType WindowType=response!
boolean TitleBar=true
string Title="Distribuidor - "
long BackColor=81324524
boolean ControlMenu=true
end type
global w_mant_distribuidor_edit w_mant_distribuidor_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function integer wf_buscarctacli (string as_cod)
public function integer wf_buscarctaacre (string as_cod)
public function integer wf_buscarctaacre2 (string as_cod)
public function integer wf_buscarctacli2 (string as_cod)
end prototypes

public function boolean wf_validareg ();String	ls_codigo, ls_newcod,ls_cta,ls_eje,ls_cta1,ls_nomcta,ls_nomcta1
Datetime ld_eje
long ll_eje

ls_codigo = f_trim( dw_1.Object.c_codigo_dis[ 1])
dw_1.AcceptText( )

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el codigo ingresado no exista */
	If ls_codigo <> '' Then
		ls_codigo = right('000000'+ls_codigo,6)
		dw_1.Object.c_codigo_dis[ 1] = ls_codigo
		Select	v_nombre_dis
		Into 		:ls_newcod
		From		t_distribuidor
		Where		c_codigo_dis = :ls_codigo ;
		If f_Trim( ls_newcod ) <> '' Then
			ls_codigo = ''
			MessageBox( Title, 'Código ingresado ya existe.~n~rPertenece a ' + ls_newcod + &
									'~r~n~r~nEl sistema generará el código.', Exclamation!)
		End If
	Else
		MessageBox( Title, 'Debe ingresar el código.' + '~r~n~r~nEl sistema generará el código.', Exclamation!)
	End If
	If ls_codigo = '' Then
		Select	Max( c_codigo_dis )
		Into 		:ls_newcod
		From		t_distribuidor ;
		ls_newcod = f_Trim( ls_newcod )
		ls_newcod = Right( '000000' + f_Trim( String( Integer( ls_newcod ) + 1 )), 6 )
		dw_1.Object.c_codigo_dis[ 1] = ls_newcod 
		Return False
	End If
End If

/* Validamos que campos mandatorios esten ingresados */
/* Descripcion */
if f_trim( dw_1.Object.v_nombre_dis[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar nombre/descripción.', Exclamation!)
	Return False
End If

ls_cta = f_trim(dw_1.Object.c_ctacliente_dis[1])
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
	If f_SqlError( SqlCa, 'No se pudo consultar la concuenta  [wf_validareg].' ) < 0 Then 
		Return false
	End If
	
	dw_1.Object.nomcli[1]= ls_nomcta
End If
ls_cta ='';ls_nomcta='';
ls_cta = f_trim(dw_1.Object.c_ctaclienteme_dis[1])
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
	If f_SqlError( SqlCa, 'No se pudo consultar la concuenta [wf_validareg].' ) < 0 Then 
		Return false
	End If
	
	dw_1.Object.nomclime[1]= ls_nomcta
End If

ls_cta1 = f_trim(dw_1.Object.c_ctaacredor_dis[1])
If ls_cta1 <> '' Then
	ld_eje = f_getsysdate()
	ll_eje = Year(Date(ld_eje)) 
	ls_eje = Right('0000' +String(ll_eje),4)
	
	SELECT isnull(v_nombre_cta,'')
	INTO  :ls_nomcta1
	FROM concuenta(nolock)
	WHERE c_codigo_cta = :ls_cta1
	AND  v_ejercicio_cta =:ls_eje
	USING SQLCA;
	If f_SqlError( SqlCa, 'No se pudo consultar la concuenta  [wf_validareg].' ) < 0 Then 
		Return false
	End If
	
	dw_1.Object.nomacre[1]= ls_nomcta1
End If
ls_cta1='';ls_nomcta1=''
ls_cta1 = f_trim(dw_1.Object.c_ctaacredorme_dis[1])
If ls_cta1 <> '' Then
	ld_eje = f_getsysdate()
	ll_eje = Year(Date(ld_eje)) 
	ls_eje = Right('0000' +String(ll_eje),4)
	
	SELECT isnull(v_nombre_cta,'')
	INTO  :ls_nomcta1
	FROM concuenta(nolock)
	WHERE c_codigo_cta = :ls_cta1
	AND  v_ejercicio_cta =:ls_eje
	USING SQLCA;
	If f_SqlError( SqlCa, 'No se pudo consultar la concuenta  [wf_validareg].' ) < 0 Then 
		Return false
	End If
	
	dw_1.Object.nomacreme[1]= ls_nomcta1
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo_dis' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[],ls_codi
long ll_count

If istr_parm.s_cad[ 1] = 'E' Then
	ls_codi= f_trim(dw_1.Object.c_codigo_dis[1])
	
	Select Count(*)
	Into  :ll_count
	From t_manifiesto
	where c_codigo_dis = :ls_codi
	and c_activo_man = '1'
	Using SqlCA;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla invproveedor(wf_checkactione)' ) =-1 Then
		Return False
	End If
	
	
	ll_count = f_zero(ll_count)
	
	If (ll_count > 0)  Then
		MessageBox(Title,'No se puede eliminar el Distribuidor porque ya tiene Manifiestos relacionados')
		cb_aceptar.enabled = False
		cb_cancelar.SetFocus()
		Return False
	End IF
	
End IF


ls_acol[] = { 'c_codigo_dis', 'v_nombre_dis', 'v_nomcom_dis', 'c_rfc_dis', &
				'c_origen_dis', 'v_direcc_dis', 'v_ciudad_dis', 'v_apapos_dis', &
				'v_codpos_dis', 'v_telef1_dis', 'v_telef2_dis', 'v_ptoemb_dis','c_tipo_dis','c_claveasoc_dis' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();Return wf_CheckActionE( )

end function

public function integer wf_buscarctacli (string as_cod);String ls_parm,ls_aux,ls_ejecta,ls_ultimo,ls_vigente,ls_cta,ls_eje,ls_nomcta
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
	as_cod=Trim(dw_1.Object.c_ctacliente_dis[1])
	ls_cta = as_cod
	
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
	dw_1.Object.c_ctacliente_dis[ 1] = ''
	dw_1.Object.nomcli[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctacliente_dis')
	Return 0
	
ElseIF ls_ejecta <> ls_eje Then
	MessageBox('Verificando Cuentas','El ejercicio de la cuenta ['+ls_cta+'] No corresponde con el ejercicio de la fecha de póliza'+ '~n~r'+ &
					'Revise su Catálogo Contable y su fecha de exportación',Exclamation!)
	dw_1.Object.c_ctacliente_dis[ 1] = ''
	dw_1.Object.nomcli[1]=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctacliente_dis')
	Return 0

ElseIF ls_ultimo <> 'S' Then
	MessageBox('Verificando Cuentas','La cuenta ['+ls_cta+'] No es de último nivel'+ '~n~r'+ &
				  'Revise su Catálogo Contable',Exclamation!)
	dw_1.Object.c_ctacliente_dis[ 1] = ''
	dw_1.Object.nomcli[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctacliente_dis')
	Return 0
	
ElseIF ls_vigente <> 'S' Then
	MessageBox('Verificando Cuentas','La cuenta ['+ls_cta+'] No esta vigente'+ '~n~r'+ &
				  'Revise su Catálogo Contable',Exclamation!)
	dw_1.Object.c_ctacliente_dis[ 1] = ''
	dw_1.Object.nomcli[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctacliente_dis')
	Return 0	
End IF
dw_1.Object.c_ctacliente_dis[ 1] = ls_cta
dw_1.Object.nomcli[1]= ls_nomcta
Return 1
end function

public function integer wf_buscarctaacre (string as_cod);String ls_parm,ls_aux,ls_ejecta,ls_ultimo,ls_vigente,ls_cta,ls_eje,ls_nomcta
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
	as_cod=Trim(dw_1.Object.c_ctaacredor_dis[1])
	ls_cta = as_cod
	
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
	dw_1.Object.c_ctaacredor_dis[ 1] = ''
	dw_1.Object.nomacre[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctaacredor_dis')
	Return 0
	
ElseIF ls_ejecta <> ls_eje Then
	MessageBox('Verificando Cuentas','El ejercicio de la cuenta ['+ls_cta+'] No corresponde con el ejercicio de la fecha de póliza'+ '~n~r'+ &
					'Revise su Catálogo Contable y su fecha de exportación',Exclamation!)
	dw_1.Object.c_ctaacredor_dis[ 1] = ''
	dw_1.Object.nomacre[1]=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctaacredor_dis')
	Return 0

ElseIF ls_ultimo <> 'S' Then
	MessageBox('Verificando Cuentas','La cuenta ['+ls_cta+'] No es de último nivel'+ '~n~r'+ &
				  'Revise su Catálogo Contable',Exclamation!)
	dw_1.Object.c_ctaacredor_dis[ 1] = ''
	dw_1.Object.nomacre[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctaacredor_dis')
	Return 0
	
ElseIF ls_vigente <> 'S' Then
	MessageBox('Verificando Cuentas','La cuenta ['+ls_cta+'] No esta vigente'+ '~n~r'+ &
				  'Revise su Catálogo Contable',Exclamation!)
	dw_1.Object.c_ctaacredor_dis[ 1] = ''
	dw_1.Object.nomacre[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctaacredor_dis')
	Return 0	
End IF
dw_1.Object.c_ctaacredor_dis[ 1] = ls_cta
dw_1.Object.nomacre[1]= ls_nomcta
Return 1
end function

public function integer wf_buscarctaacre2 (string as_cod);String ls_parm,ls_aux,ls_ejecta,ls_ultimo,ls_vigente,ls_cta,ls_eje,ls_nomcta
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
	as_cod=Trim(dw_1.Object.c_ctaacredorme_dis[1])
	ls_cta = as_cod
	
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
	dw_1.Object.c_ctaacredorme_dis[ 1] = ''
	dw_1.Object.nomacreme[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctaacredorme_dis')
	Return 0
	
ElseIF ls_ejecta <> ls_eje Then
	MessageBox('Verificando Cuentas','El ejercicio de la cuenta ['+ls_cta+'] No corresponde con el ejercicio de la fecha de póliza'+ '~n~r'+ &
					'Revise su Catálogo Contable y su fecha de exportación',Exclamation!)
	dw_1.Object.c_ctaacredorme_dis[ 1] = ''
	dw_1.Object.nomacreme[1]=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctaacredorme_dis')
	Return 0

ElseIF ls_ultimo <> 'S' Then
	MessageBox('Verificando Cuentas','La cuenta ['+ls_cta+'] No es de último nivel'+ '~n~r'+ &
				  'Revise su Catálogo Contable',Exclamation!)
	dw_1.Object.c_ctaacredorme_dis[ 1] = ''
	dw_1.Object.nomacreme[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctaacredorme_dis')
	Return 0
	
ElseIF ls_vigente <> 'S' Then
	MessageBox('Verificando Cuentas','La cuenta ['+ls_cta+'] No esta vigente'+ '~n~r'+ &
				  'Revise su Catálogo Contable',Exclamation!)
	dw_1.Object.c_ctaacredorme_dis[ 1] = ''
	dw_1.Object.nomacreme[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctaacredorme_dis')
	Return 0	
End IF
dw_1.Object.c_ctaacredorme_dis[ 1] = ls_cta
dw_1.Object.nomacreme[1]= ls_nomcta
Return 1
end function

public function integer wf_buscarctacli2 (string as_cod);String ls_parm,ls_aux,ls_ejecta,ls_ultimo,ls_vigente,ls_cta,ls_eje,ls_nomcta
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
	as_cod=Trim(dw_1.Object.c_ctaclienteme_dis[1])
	ls_cta = as_cod
	
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
	dw_1.Object.c_ctaclienteme_dis[ 1] = ''
	dw_1.Object.nomclime[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctaclienteme_dis')
	Return 0
	
ElseIF ls_ejecta <> ls_eje Then
	MessageBox('Verificando Cuentas','El ejercicio de la cuenta ['+ls_cta+'] No corresponde con el ejercicio de la fecha de póliza'+ '~n~r'+ &
					'Revise su Catálogo Contable y su fecha de exportación',Exclamation!)
	dw_1.Object.c_ctaclienteme_dis[ 1] = ''
	dw_1.Object.nomclime[1]=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctaclienteme_dis')
	Return 0

ElseIF ls_ultimo <> 'S' Then
	MessageBox('Verificando Cuentas','La cuenta ['+ls_cta+'] No es de último nivel'+ '~n~r'+ &
				  'Revise su Catálogo Contable',Exclamation!)
	dw_1.Object.c_ctaclienteme_dis[ 1] = ''
	dw_1.Object.nomclime[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctaclienteme_dis')
	Return 0
	
ElseIF ls_vigente <> 'S' Then
	MessageBox('Verificando Cuentas','La cuenta ['+ls_cta+'] No esta vigente'+ '~n~r'+ &
				  'Revise su Catálogo Contable',Exclamation!)
	dw_1.Object.c_ctaclienteme_dis[ 1] = ''
	dw_1.Object.nomclime[1]=''
	ls_cta='';ls_nomcta=''
	dw_1.SetFocus()
	dw_1.Setcolumn('c_ctaclienteme_dis')
	Return 0	
End IF
dw_1.Object.c_ctaclienteme_dis[ 1] = ls_cta
dw_1.Object.nomclime[1]= ls_nomcta
Return 1
end function

on w_mant_distribuidor_edit.create
call super::create
end on

on w_mant_distribuidor_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_distribuidor_edit
int X=0
int Y=0
int Width=2048
int Height=1320
string DataObject="d_mant_distribuidor_edit"
end type

event dw_1::buttonclicked;call super::buttonclicked;If dwo.Name = 'cb_cli' Then
	wf_Buscarctacli( '' )
End If

If dwo.Name = 'cb_cli2' Then
	wf_Buscarctacli2( '' )
End If

If dwo.Name = 'cb_acre' Then
	wf_Buscarctaacre( '' )
End If	

If dwo.Name = 'cb_acre2' Then
	wf_Buscarctaacre2( '' )
End If	
end event

event dw_1::itemchanged;call super::itemchanged;String ls_cli,ls_acre


dw_1.AcceptText()
ls_cli = f_trim(dw_1.Object.c_ctacliente_dis[1])
ls_acre = f_trim(dw_1.Object.c_ctaacredor_dis[1])
Choose Case dwo.Name
		
	Case 'c_ctacliente_dis'
		If ls_cli = '' Then
			wf_buscarctacli('')
		Else
			wf_buscarctacli(ls_cli)
		End IF
		
	Case 'c_ctaacredor_dis'
		If ls_acre = '' Then
			wf_buscarctaacre('')
		Else
			wf_buscarctaacre(ls_cli)
		End IF
		
End Choose

Return 0
		
end event

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_distribuidor_edit
int X=1646
int Y=1348
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_distribuidor_edit
int X=1271
int Y=1348
end type

