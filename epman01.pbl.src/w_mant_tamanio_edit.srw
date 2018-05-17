$PBExportHeader$w_mant_tamanio_edit.srw
forward
global type w_mant_tamanio_edit from wa_mant_edit
end type
end forward

global type w_mant_tamanio_edit from wa_mant_edit
int Width=1819
int Height=516
boolean TitleBar=true
string Title="Tamaño - "
long BackColor=79741120
end type
global w_mant_tamanio_edit w_mant_tamanio_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
end prototypes

public function boolean wf_validareg ();String	ls_codigo, ls_newcod
long ll_pro


dw_1.AcceptText( )
ls_codigo = f_trim( dw_1.Object.c_codigo_tam[ 1])

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el codigo ingresado no exista */
	If ls_codigo <> '' Then
		ls_codigo = right('0000'+ls_codigo,4)
		Select	v_nombre_tam
		Into 		:ls_newcod
		From		t_tamanio
		Where		c_codigo_tam = :ls_codigo ;
		If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_tamanio (Where)' ) =-1 Then
			Return False
		End If
		If f_Trim( ls_newcod ) <> '' Then
			ls_codigo = ''
			MessageBox( Title, 'Código ingresado ya existe.~n~rPertenece a ' + ls_newcod + &
									'~r~n~r~nEl sistema generará el código.', Exclamation!)
		else
			dw_1.Object.c_codigo_tam[ 1] = ls_codigo 
		End If
	Else
		MessageBox( Title, 'Debe ingresar el código.' + '~r~n~r~nEl sistema generará el código.', Exclamation!)
	End If
	
	If ls_codigo = '' Then
		Select	Max( c_codigo_tam )
		Into 		:ls_newcod
		From		t_tamanio ;
		If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_tamanio (Max)' ) =-1 Then
			Return False
		End If
		ls_newcod = f_Trim( ls_newcod )
		ls_newcod = Right( '0000' + f_Trim( String( Integer( ls_newcod ) + 1 )), 4 )
		dw_1.Object.c_codigo_tam[ 1] = ls_newcod 
		Return False
	End If
End If

//=======================================
If istr_parm.s_cad[ 1] = 'E' Then
	select count(c_codigo_pro)
	into :ll_pro
	from t_producto
	where c_codigo_tam = :ls_codigo
	using sqlca;
	If f_SqlError( SqlCa, 'No se pudo leer la tabla  t_producto (select)' ) < 0 Then 
			RollBack Using SqlCa ;
			Return False
	End If	
	
	if ll_pro > 0 then
		messagebox(title,'No se puede eliminar el tamaño porque tiene movimientos',exclamation!)
		close(this)
		return false
	end if
end if

/* Validamos que campos mandatorios esten ingresados */
/* Descripcion */
if f_trim( dw_1.Object.v_nombre_tam[ 1])= '' Then
	MessageBox( Title, 'Debe ingresar nombre/descripción.', Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo_tam' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();String	ls_acol[]

ls_acol[] = { 'c_codigo_tam', 'v_nombre_tam' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();
Return wf_CheckActionE( )

end function

on w_mant_tamanio_edit.create
call super::create
end on

on w_mant_tamanio_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_mant_tamanio_edit
int X=0
int Y=0
int Width=1760
int Height=280
string DataObject="d_mant_tamanio_edit"
end type

type cb_cancelar from wa_mant_edit`cb_cancelar within w_mant_tamanio_edit
int X=1385
int Y=292
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_mant_tamanio_edit
int X=1010
int Y=292
end type

