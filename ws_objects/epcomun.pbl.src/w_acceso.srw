$PBExportHeader$w_acceso.srw
forward
global type w_acceso from window
end type
type st_4 from statictext within w_acceso
end type
type st_version from statictext within w_acceso
end type
type p_1 from picture within w_acceso
end type
type st_3 from statictext within w_acceso
end type
type st_2 from statictext within w_acceso
end type
type sle_2 from singlelineedit within w_acceso
end type
type sle_1 from singlelineedit within w_acceso
end type
type st_1 from statictext within w_acceso
end type
type cb_cancelar from uo_cbcancelar within w_acceso
end type
type cb_aceptar from uo_cbaceptar within w_acceso
end type
end forward

global type w_acceso from window
integer x = 1056
integer y = 484
integer width = 1518
integer height = 740
boolean titlebar = true
string title = "Inicio de sesión"
windowtype windowtype = response!
long backcolor = 80269524
st_4 st_4
st_version st_version
p_1 p_1
st_3 st_3
st_2 st_2
sle_2 sle_2
sle_1 sle_1
st_1 st_1
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
end type
global w_acceso w_acceso

forward prototypes
public function boolean wf_checkusers ()
end prototypes

public function boolean wf_checkusers ();/* wf_CheckUsers( ) */

DateTime	ld_hoy
Long		ll_existe
String	ls_sqlerror, ls_msgerror

ld_hoy		= DateTime( Today( ) )
ls_sqlerror = 'No se pudo obtener información de la tabla assusuario'
ls_msgerror = 'Revise la conección al servidor de base de datos o~r~n' + &
					'el acceso y estado a la tabla assusuario.~r~n~r~n' + &
					'No se puede continuar con la ejecución del sistema.'

Select	Count(*)
Into 		:ll_existe
From		assusuario
Using SqlCa;
If f_SqlError( SqlCa, ls_sqlerror + '(Count)') = -1 Then
	MessageBox( Title, ls_msgerror, StopSign!)
	Halt Close
End If

ll_existe = f_Zero( ll_existe )

If ll_existe = 0 Then
	ls_sqlerror = 'No se pudo crear el usuario "ADMIN" en assusuario (Insert)'
	Insert Into assusuario
	(c_codigo_usu, v_nombre_usu, v_passwo_usu, c_admin_usu, &
	c_usucre_usu, d_creacion_usu, c_activo_usu )
	Values
	( 'ADMIN', 'ADMINISTRATOR', '', '1', 'ADMIN', :ld_hoy, '1' ) ;
	If f_SqlError( SqlCa, ls_sqlerror ) = -1 Then
		MessageBox( Title, ls_msgerror, StopSign!)
		Halt Close
	End If
End If


ll_existe = 0

ls_sqlerror = 'No se pudo obtener información de la tabla asssistema'

Select	Count(*)
Into 		:ll_existe
From		asssistema 
Where		c_codigo_sis = '00' ;

If f_SqlError( SqlCa, ls_sqlerror + '(Count)') = -1 Then
	MessageBox( Title, ls_msgerror, StopSign!)
	Halt Close
End If

ll_existe = f_Zero( ll_existe )

If ll_existe = 0 Then
	ls_sqlerror = 'No se pudo crear el registro "ADMINISTRACION DE SISTEMAS SOFTCOMM" en asssitema (Insert)'
	Insert Into asssistema
	(c_codigo_sis, v_nombre_sis, c_codigo_usu, d_creacion_sis, c_activo_sis )
	Values
	( '00', 'ADMINISTRACION DE SISTEMAS SOFTCOMM', 'ADMIN', :ld_hoy, '1' ) ;
	If f_SqlError( SqlCa, ls_sqlerror ) = -1 Then
		MessageBox( Title, ls_msgerror, StopSign!)
		Halt Close
	End If
End If

Return True
end function

on w_acceso.create
this.st_4=create st_4
this.st_version=create st_version
this.p_1=create p_1
this.st_3=create st_3
this.st_2=create st_2
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_1=create st_1
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.Control[]={this.st_4,&
this.st_version,&
this.p_1,&
this.st_3,&
this.st_2,&
this.sle_2,&
this.sle_1,&
this.st_1,&
this.cb_cancelar,&
this.cb_aceptar}
end on

on w_acceso.destroy
destroy(this.st_4)
destroy(this.st_version)
destroy(this.p_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
end on

event open;String	ls_value

//if f_validaa(gs_nomsis) = 0 then
//	close(w_acceso)
//	return
//end if
st_4.Text = f_GetPcName( )
f_CenterWindow( This )

///////////////////////////////////appeon comment///////////
//wf_CheckUsers( )
//
//f_GetRegistry( 'LastUser', ls_value )
//sle_1.Text = ls_value
//
//If sle_1.Text <> '' Then
//	sle_2.SetFocus( )
//End If
///////////////////////////////////appeon end  comment///////////
st_version.Text = gs_version
Title = 'Inventum ' + gs_nomsis + ' - ' + Title 

end event

type st_4 from statictext within w_acceso
integer x = 64
integer y = 524
integer width = 517
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_version from statictext within w_acceso
integer x = 41
integer y = 172
integer width = 425
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 0
boolean enabled = false
string text = "gs_version"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_1 from picture within w_acceso
integer x = 37
integer y = 32
integer width = 434
integer height = 200
boolean originalsize = true
string picturename = "softlogo.bmp"
boolean focusrectangle = false
end type

type st_3 from statictext within w_acceso
integer x = 512
integer y = 52
integer width = 923
integer height = 168
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Para poder iniciar ingrese el usuario que tiene asignado y su contraseña"
boolean focusrectangle = false
end type

type st_2 from statictext within w_acceso
integer x = 192
integer y = 392
integer width = 283
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "&Contraseña"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_acceso
integer x = 517
integer y = 384
integer width = 914
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
integer accelerator = 99
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_acceso
integer x = 517
integer y = 256
integer width = 914
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
integer accelerator = 117
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_acceso
integer x = 192
integer y = 264
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "&Usuario:"
boolean focusrectangle = false
end type

type cb_cancelar from uo_cbcancelar within w_acceso
integer x = 1083
integer y = 508
integer taborder = 40
end type

event clicked;If IsValid( w_app_frame ) Then
	Close( w_app_frame ) 
End If

Close( Parent )
end event

type cb_aceptar from uo_cbaceptar within w_acceso
integer x = 713
integer y = 508
integer taborder = 30
end type

event clicked;DateTime	ld_hoy
Long		ll_count
String	ls_pass, ls_error, ls_pcname, ls_admin,ls_val


gs_usuario = Upper( sle_1.Text )

//If f_Trim( gs_usuario ) = '' Then
//	MessageBox( Title, 'Debe ingresar el ID del usuario.', Exclamation!)
//	Return 
//End If
//
//SetProfileString(gs_ini, "System", "LastUser", gs_usuario )
//f_SetRegistry( 'LastUser', gs_usuario )
//
//Select	v_passwo_usu
//Into 		:ls_pass
//From		assusuario
//Where		c_codigo_usu = :gs_usuario ;
//If SqlCa.SqlCode <> 0 Then
//	gs_usuario = ''
//	MessageBox( Title, 'Identificador de usuario o password incorrecto.', Exclamation!)
//	Return
//End If
//
//If Upper( f_Trim( ls_pass ) ) <> Upper( f_Trim( sle_2.Text ) ) Then
//	gs_usuario = ''
//	MessageBox( Title, 'Identificador de usuario o password incorrecto.', Exclamation!)
//	Return
//End If

/* Se verifica si est'a dentro del minuto ultimo de coneccion del dia */
ld_hoy = DateTime( Today( ) )
gs_hini = String( Now( ), 'hhmm' )
ll_count = 0
ls_pcname = f_GetPcName( )

//Select	Count(*)
//Into		:ll_count
//From		assusuariosistemamenu
//Where		c_codigo_usu = :gs_usuario 
//And		c_codigo_sis = :gs_codsis ;
//
//If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla assusuariosistemamenu (Count)') = -1 Then
//	gs_usuario = ''
//	Return
//End If

///* Determina si es administrator */
//Select	c_admin_usu
//Into		:ls_admin
//From		assusuario
//Where		c_codigo_usu = :gs_usuario ;
//If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla assusuario.' ) = -1 Then
//	Return
//End If
//
ls_admin = f_Trim(ls_admin)

//If Not ls_admin = '1' Then
//	/* Si no administrador se verifica si puede entrar al sistema */
//	If f_Zero( ll_count ) = 0 Then
//		MessageBox( Parent.Title, 'No tiene acceso a este sistema', Exclamation! )
//		Halt Close
//	End If
//End If

//ll_count = 0
//
//Select	Count(*)
//Into		:ll_count
//From		assusuariosesion
//Where		c_codigo_usu = :gs_usuario 
//And		c_codigo_sis = :gs_codsis
//And		d_acceso_use = :ld_hoy
//And		c_horini_use = :gs_hini ;
//
//If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla assusuariosesion (Count)') = -1 Then
//	gs_usuario = ''
//	Return
//End If

//If f_Zero( ll_count ) = 0 Then
//	/* Actualiza la fecha y hora de ingreso al sistema */
//	Insert Into assusuariosesion
//		(	c_codigo_usu, c_codigo_sis, d_acceso_use, c_horini_use, v_estacion_use )
//	Values 
//		( :gs_usuario, :gs_codsis, :ld_hoy, :gs_hini, :ls_pcname ) ;
//	
//	If f_SqlError( SqlCa, 'No se pudo insertar en la tabla assusuariosesion.') = -1 Then
//		gs_usuario = ''
//		Return
//	End If
//End If
//
//Commit Using SqlCa ;
gs_tipo=''

//SetProfileString( gs_ini, 'System', 'CerrarModoPrevio', f_GetParmValue('25') )
//
//if f_getparmvalue('106')='S' then
//	select top 1 (isnull(c_usupun_upu,''))
//	into	 :ls_val
//	from	 t_usuarioembarque
//	where	 c_usupun_upu=:gs_usuario
//	using sqlca;
//
//	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla assusuariosesion (Count)') = -1 Then
//		Return
//	End If
//	if ls_val='' and ls_admin <> '1' then
//		gs_usuario = ''
//		MessageBox( Title, 'Este usuario no cuenta con puertos Capturados.', Exclamation!)
//		Return
//	end if
//	
//	select top 1 (isnull(c_usupun_upu,''))
//	into	 :ls_val
//	from	 t_usuarioembarque
//	using sqlca;
//
//	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla assusuariosesion (Count)') = -1 Then
//		Return
//	End If
//	IF ls_val='' then
//		MessageBox( Title, 'Debe de ingresar puertos para la captura', Exclamation!)
//	else
//		Open ( w_puntoembarque)	
//	end if
//end if
debugbreak()
gb_connect = True
CloseWithReturn( Parent, '1' )


end event

