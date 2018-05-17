$PBExportHeader$w_app_frame.srw
forward
global type w_app_frame from window
end type
type mdi_1 from mdiclient within w_app_frame
end type
end forward

global type w_app_frame from window
integer x = 1056
integer y = 484
integer width = 2569
integer height = 1516
boolean titlebar = true
string menuname = "m_principal"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 276856960
event ue_postopen pbm_custom01
mdi_1 mdi_1
end type
global w_app_frame w_app_frame

forward prototypes
public subroutine wf_getdefault ()
public subroutine wf_showdefault ()
end prototypes

event ue_postopen;s_parm	lstr_parm

//f_GetSysDate( )

//wf_GetDefault( )
//wf_ShowDefault( )

//If f_GetTipoCambio( gd_sys ) = -100 Then
//	/* Si no hay tipo de cambio para la fecha del sistema, se solicita al inicio */
//	lstr_parm.s_cad[1] = 'I'
//	lstr_parm.s_cad[2] = ''
//	lstr_parm.n_num[1] = 1
//	OpenSheetWithParm( w_mant_tipo_cambio_edit, lstr_parm, gw_frame, 0, Original! )
//End If

//OpenSheet( w_util_temporada_post_it, This, gi_poswin, Original! )

end event

public subroutine wf_getdefault ();Long	ll_cnt

gs_mercado = f_GetParmValue( '2' )
gs_codtem = f_GetParmValue( '1' )

f_GetNombreTemporada( )

//Select	Count(*)
//Into		:ll_cnt
//From		t_temporada ;
//If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_temporada.(Count)' ) = -1 Then
//	gs_codtem = ''
//	gs_temporada = ''
//End If

If f_Zero(ll_cnt) = 0 Then
	Beep( 1)
	MessageBox( Title, 'Bienvenido al Sistema de Empaque y Embarques~r~n' + &
							'~r~nDeberá Crear una Temporada y Reiniciar el Sistema.' )
	Open( w_util_temporada_inicia )
	If Message.StringParm = '0' Then
		MessageBox( Title, 'Si no se tiene una Temporada creada no se puede continuar con el Sistema.', Exclamation!)
		Halt Close
	End If
End If
end subroutine

public subroutine wf_showdefault ();String	ls_par, ls_fec
If AppeonGetClientType() <>"WEB" Then
	Open(w_child_status_bar, This)
	If IsValid(w_child_status_bar) Then
		Show(w_child_status_bar) 
	End If
End If

/* Definicion de mercado default */
If gs_mercado = 'E' Then
	ls_par = 'Extranjero'
ElseIf gs_mercado = 'N' Then
	ls_par = 'Nacional'
Else
	ls_par = '[No Definido]'
End If

f_SetMHStatus( 1, 'Mdo. ' + ls_par )

/* Definicion de temporada */
If gs_temporada = '' Then
	ls_par = '[No Definido]'
Else
	ls_par = gs_codtem + ' ' + gs_temporada
End If

ls_fec = String( gd_sys, 'dd/mm/yyyy' )
f_SetMHStatus( 4, 'F. Trabajo: ' + ls_fec )


f_SetMHStatus( 2, gs_temporada )

end subroutine

on w_app_frame.create
if this.MenuName = "m_principal" then this.MenuID = create m_principal
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_app_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event activate;wf_ShowDefault( )

end event

event open;String ls_cia
debugbreak()
//Select v_valor_par
//Into :ls_cia
//from t_parametro
//Where c_codigo_par='004'
//Using SqlCa;
//If f_SqlError( SqlCa, 'No se pudo leer la tabla t_parametro . (select)' ) < 0 Then 
//	 RollBack Using SqlCa ;
//	 Return 0
//End If	
//if f_getparmvalue('106')='S' then
//	This.Title = gs_aplicacion + ' - ' + ls_cia  + ' -Punto de Emb: ' + gs_punto + '[' + gs_tipo + ']'
//else
//	This.Title = gs_aplicacion + ' - ' + ls_cia 
//end if


gw_frame = This

//f_GetSysDate( )
//f_setopciones()
TriggerEvent( 'ue_postopen' )


end event

event resize;If IsValid(w_child_status_bar) Then
	w_child_status_bar.wf_SetPosition( ) 
End If
end event

event close;DateTime	ld_hoy
String	ls_hfin

ld_hoy = DateTime( Today( ) )
ls_hfin = String( Now( ), 'hhmm' )

/* Actualiza la hora de salida al sistema */

Update	assusuariosesion
Set		c_horfin_use = :ls_hfin
Where		c_codigo_usu = :gs_usuario  
And		c_codigo_sis = :gs_codsis
And		d_acceso_use = :ld_hoy
And		c_horini_use = :gs_hini ;
If f_SqlError( SqlCa, 'No se pudo actualizar la tabla assusuariosesion (c_horfin_usu = ' + ls_hfin + ')' ) = -1 Then
	RollBack Using SqlCa ;
Else
	Commit Using SqlCa ;
End If
end event

type mdi_1 from mdiclient within w_app_frame
long BackColor=276856960
end type

