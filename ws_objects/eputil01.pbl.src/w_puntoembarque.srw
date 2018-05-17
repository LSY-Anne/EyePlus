$PBExportHeader$w_puntoembarque.srw
forward
global type w_puntoembarque from window
end type
type st_2 from statictext within w_puntoembarque
end type
type st_1 from statictext within w_puntoembarque
end type
type dw_1 from datawindow within w_puntoembarque
end type
type cb_cancelar from uo_cbcancelar within w_puntoembarque
end type
type cb_aceptar from uo_cbaceptar within w_puntoembarque
end type
end forward

global type w_puntoembarque from window
integer x = 1056
integer y = 484
integer width = 1522
integer height = 432
boolean titlebar = true
string title = "Punto de Embarque"
windowtype windowtype = response!
long backcolor = 82899184
st_2 st_2
st_1 st_1
dw_1 dw_1
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
end type
global w_puntoembarque w_puntoembarque

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
From		assusuario ;

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

on w_puntoembarque.create
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.Control[]={this.st_2,&
this.st_1,&
this.dw_1,&
this.cb_cancelar,&
this.cb_aceptar}
end on

on w_puntoembarque.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
end on

event open;String	ls_value,ls_cod,ls_usu,ls_cod1,ls_admin,ls_nom
long li_count,i
datastore lds_list
Datawindowchild ldwc_x

f_CenterWindow( This )

//wf_CheckUsers( )

//dw_1.SetTransObject( SqlCa )
//dw_1.InsertRow(1)
//dw_1.AcceptText( )
//ls_usu=gs_usuario
//
//Select	c_admin_usu
//Into		:ls_admin
//From		assusuario
//Where		c_codigo_usu = :gs_usuario ;
//If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla assusuario.' ) = -1 Then
//	Return
//End If
//if ls_admin='1' then 
//	ls_usu='%'
//end if
//destroy lds_list
//lds_list=Create DataStore
//lds_list.Dataobject='d_arch_puntoembarque'
//lds_list.SetTransObject(SqlCa)
//lds_list.Retrieve(ls_usu )
//
//li_count=lds_list.RowCount()
//	dw_1.getchild('c_codigo_pte',ldwc_x)
//	dw_1.getchild('v_nombre_pte',ldwc_x)
//	ldwc_x.reset()
//For i=1 to li_count
//	ls_cod1 = f_Trim(lds_list.Object.c_codigo_pte[i])
//	ls_nom = f_Trim(lds_list.Object.v_nombre_pte[i])
//	ldwc_x.insertrow(1)
//	ldwc_x.setitem(1,'c_codigo_pte',ls_cod1)
//	ldwc_x.setitem(1,'v_nombre_pte',ls_nom)
//Next
//
// ls_cod= dw_1.Object.c_codigo_pte[1] 



end event

event closequery;//string ls_cod,ls_tipo
//ls_cod = f_trim(dw_1.Object.c_codigo_pte[1])
//
//If ls_cod = '' Then
//	MessageBox('Mensaje','Debe seleccionar un puerto de embarque para poder trabajar en el sistema',Exclamation!)
//	Return 1
//End If
//
//select c_tipopuntoembarque_pte
//into 	:ls_tipo
//from 	t_puntoembarque
//where c_codigo_pte=:ls_cod
//using sqlca;
//If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_puntoembarque 1.' ) < 0 Then 
//	RollBack Using SqlCa ;
//	Return 0
//End If
//gs_tipo=ls_tipo
//gs_punto=ls_cod
//
//
end event

type st_2 from statictext within w_puntoembarque
integer x = 55
integer y = 12
integer width = 1358
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "***Debe elegir el punto de embarque para trabajar"
boolean focusrectangle = false
end type

type st_1 from statictext within w_puntoembarque
integer x = 64
integer y = 112
integer width = 462
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Punto De Embarque:"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_puntoembarque
integer x = 526
integer y = 108
integer width = 791
integer height = 72
integer taborder = 10
string dataobject = "d_arch_puntoembarque2"
boolean border = false
boolean livescroll = true
end type

type cb_cancelar from uo_cbcancelar within w_puntoembarque
integer x = 1125
integer y = 220
integer taborder = 30
end type

event clicked;
If IsValid( w_app_frame ) Then
	Close( w_app_frame ) 
End If

Close( Parent )


end event

type cb_aceptar from uo_cbaceptar within w_puntoembarque
integer x = 754
integer y = 220
integer taborder = 20
end type

event clicked;call super::clicked;//string ls_cod,ls_tipo
//ls_cod = f_trim(dw_1.Object.c_codigo_pte[1])
//
//If ls_cod = '' Then
//	MessageBox('Mensaje','Debe seleccionar un puerto de embarque para poder trabajar en el sistema',Exclamation!)
//	Return 1
//End If
//select c_tipopuntoembarque_pte
//into 	:ls_tipo
//from 	t_puntoembarque
//where c_codigo_pte=:ls_cod
//using sqlca;
//If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_puntoembarque 1.' ) < 0 Then 
//	RollBack Using SqlCa ;
//	Return 0
//End If
//gs_tipo=ls_tipo
//gs_punto=ls_cod
//gb_connect = True
CloseWithReturn( Parent, '1' )

end event

