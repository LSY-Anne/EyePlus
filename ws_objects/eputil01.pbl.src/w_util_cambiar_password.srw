$PBExportHeader$w_util_cambiar_password.srw
forward
global type w_util_cambiar_password from wa_response
end type
end forward

global type w_util_cambiar_password from wa_response
int Width=1477
int Height=848
boolean TitleBar=true
string Title="Cambiar Contraseña"
end type
global w_util_cambiar_password w_util_cambiar_password

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_aceptar ()
end prototypes

public function boolean wf_validareg ();dw_1.AcceptText( )

If f_trim( dw_1.Object.v_passwx_usu[ 1]) <> f_trim( dw_1.Object.v_passwo_usu[ 1]) Then
	MessageBox( Title, 'Contraseña anterior es incorrecta.', Exclamation!)
	Return False
End If

If f_Trim( dw_1.Object.v_passw1_usu[ 1]) <> f_Trim( dw_1.Object.v_passw2_usu[ 1]) Then
	MessageBox( Title, 'Contraseña de confirmación es incorrecta.', Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_aceptar ();String	ls_codigo, ls_newcod

If Not wf_ValidaReg( ) Then Return False


dw_1.Object.v_passwo_usu[ 1] = f_trim( dw_1.Object.v_passw1_usu[ 1]) 
dw_1.Object.c_usumod_usu[ 1] = gs_usuario
dw_1.Object.d_modifi_usu[ 1] = DateTime( Today( ) )
dw_1.AcceptText( )
If dw_1.Update( ) <> 1 Then
	RollBack Using SqlCa ;
	MessageBox( Title, 'No se pudo actualizar la tabla aasusuario para el cambio de contraseña.', StopSign! )
	Return False
End If
Commit Using SqlCa ;
MessageBox( Title, 'Contraseña Actualizada.' )

Return True
end function

on w_util_cambiar_password.create
call super::create
end on

on w_util_cambiar_password.destroy
call super::destroy
end on

event open;call super::open;dw_list.Visible = False

dw_1.SetTransObject( SqlCa ) 
dw_1.Retrieve( gs_usuario )
dw_1.SetFocus( )
end event

type dw_list from wa_response`dw_list within w_util_cambiar_password
int X=0
int Y=664
end type

type dw_1 from wa_response`dw_1 within w_util_cambiar_password
int X=0
int Y=0
int Width=1472
int Height=632
string DataObject="d_util_cambiar_password"
end type

type cb_cancelar from wa_response`cb_cancelar within w_util_cambiar_password
int X=1029
int Y=640
end type

type cb_aceptar from wa_response`cb_aceptar within w_util_cambiar_password
int X=649
int Y=640
end type

event cb_aceptar::clicked;If wf_Aceptar( ) Then
	Close( Parent ) 
End If
end event

