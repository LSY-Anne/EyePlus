$PBExportHeader$w_arch_mano_obra_edit.srw
forward
global type w_arch_mano_obra_edit from wa_mant_edit
end type
end forward

global type w_arch_mano_obra_edit from wa_mant_edit
int Width=1737
int Height=792
boolean TitleBar=true
string Title="Mano de Obra - "
long BackColor=79741120
end type
global w_arch_mano_obra_edit w_arch_mano_obra_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function boolean wf_checkactioni ()
public function long wf_retrievelist ()
end prototypes

public function boolean wf_validareg ();DateTime	ld_mao
Long		ll_cnt
String	ls_cul, ls_act, ls_new

dw_1.AcceptText( )

ls_cul = f_Trim( dw_1.Object.c_codigo_cul[ 1])
ls_act = f_Trim( dw_1.Object.c_codigo_act[ 1])
ld_mao = dw_1.Object.d_trabajo_mao[ 1]
If ls_cul = '' Then
	MessageBox( Title, 'Debe seleccionar el cultivo para continuar.', Exclamation!)
	Return False
End If
If ls_act = '' Then
	MessageBox( Title, 'Debe seleccionar la actividad para continuar.', Exclamation!)
	Return False
End If
If IsNull( ld_mao ) Then
	MessageBox( Title, 'Debe ingresar una fecha de trabajo válida para continuar.', Exclamation!)
	Return False
End If

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el registro ingresado no exista */
	dw_1.Object.c_codigo_tem[ 1] = gs_codtem
	Select	Count( * )
	Into 		:ll_cnt
	From		t_mano_obra
	Where		c_codigo_tem = :gs_codtem
	And		c_codigo_cul = :ls_cul
	And		c_codigo_act = :ls_act
	And		d_trabajo_mao = :ld_mao ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_mano_obra (Count)' ) =-1 Then
		Return False
	End If
	If f_Zero( ll_cnt ) > 0 Then
		MessageBox( Title, 'Este registro de mano de obra ya existe.~n~r' + &
							'~r~nSi desea actualizarlo, seleccionelo y haga clic en Modificar.', Exclamation!)
		Return False
	End If
	/* Genera código */
	Select	Max( c_codigo_mao )
	Into 		:ls_new
	From		t_mano_obra ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_produccion_campo (Max)' ) =-1 Then
		Return False
	End If
	ls_new = f_Trim( ls_new )
	ls_new = Right( '000000' + f_Trim( String( Integer( ls_new ) + 1 )), 6 )
	dw_1.Object.c_codigo_mao[ 1] = ls_new 
End If

/* Validamos que campos mandatorios esten ingresados */
/* n_numjor_mao y n_monjor_mao */

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

//ls_acol[] = { '' }

//wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();
String	ls_acol[]

ls_acol[] = { 'c_codigo_cul', 'c_codigo_act', 'd_trabajo_mao', &
				'n_numjor_mao', 'n_monjor_mao', 'c_elemento' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();Return wf_CheckActionE( )

end function

public function boolean wf_checkactioni ();f_GetSysDate( )
dw_1.Object.c_codigo_tem[1] = gs_codtem
dw_1.Object.d_trabajo_mao[1] = gd_sys

Return True

end function

public function long wf_retrievelist ();If UpperBound( istr_parm.dw_dat[ ] ) > 0 Then
	Return istr_parm.dw_dat[ 1].Retrieve( gs_codtem, gd_sys, gd_sys)
End If

Return 0

end function

on w_arch_mano_obra_edit.create
call super::create
end on

on w_arch_mano_obra_edit.destroy
call super::destroy
end on

type dw_1 from wa_mant_edit`dw_1 within w_arch_mano_obra_edit
int X=0
int Y=0
int Width=1719
int Height=556
string DataObject="d_arch_mano_obra_edit"
end type

event dw_1::itemchanged;call super::itemchanged;DataWindowChild	ldwc_x
String	ls_dato


/* Asignacion de datos segun el campo modificado */
Choose Case dwo.Name
	Case 'c_elemento' /* <--- Identificador del elemento */
		data = Left( f_Trim(data) + Space(6), 6 )
		ls_dato = Left( data, 2 ) 
		This.Object.c_codigo_cul[row] = ls_dato 
		ls_dato = Right( data, 4 )
		This.Object.c_codigo_act[row] = ls_dato 
	Case 'c_codigo_act'
		ls_dato = f_Trim( This.Object.c_codigo_cul[row] )
		This.Object.c_elemento[row] = ls_dato + data
	Case 'c_codigo_cul'
		ls_dato = f_Trim( This.Object.c_codigo_act[row] )
		This.Object.c_elemento[row] = data + ls_dato

End Choose


end event

type cb_cancelar from wa_mant_edit`cb_cancelar within w_arch_mano_obra_edit
int Y=576
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_arch_mano_obra_edit
int X=946
int Y=576
end type

