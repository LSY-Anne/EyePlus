$PBExportHeader$w_util_temporada_actualiza.srw
forward
global type w_util_temporada_actualiza from wa_response
end type
type cb_aplicar from uo_cbother within w_util_temporada_actualiza
end type
end forward

global type w_util_temporada_actualiza from wa_response
int Width=2121
boolean TitleBar=true
string Title="Consultar/Actualizar Temporada"
cb_aplicar cb_aplicar
end type
global w_util_temporada_actualiza w_util_temporada_actualiza

forward prototypes
public function boolean wf_aplicar ()
end prototypes

public function boolean wf_aplicar ();
dw_1.AcceptText( )

If cb_aplicar.Enabled Then
	If dw_list.Update( ) = 1 Then
		Commit Using SqlCa ;
	Else
		RollBack Using SqlCa ;
		MessageBox( Title, 'Los cambios no han sido guardados.', StopSign! )
		Return False
	End If
End If

cb_aplicar.Enabled = False

f_GetNombreTemporada( )

Return True
end function

on w_util_temporada_actualiza.create
int iCurrent
call super::create
this.cb_aplicar=create cb_aplicar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aplicar
end on

on w_util_temporada_actualiza.destroy
call super::destroy
destroy(this.cb_aplicar)
end on

event open;call super::open;dw_1.Visible = False

dw_list.Retrieve( )

dw_list.ScrollToRow( dw_list.RowCount() )
end event

type dw_list from wa_response`dw_list within w_util_temporada_actualiza
int X=37
int Y=36
int Width=2021
int Height=532
string DataObject="d_util_temporada_actualiza"
end type

event dw_list::itemchanged;cb_aceptar.Enabled = True


/* Asigna el usuario activo */
If f_Trim( This.Object.c_codigo_usu[row] ) = '' Then
	This.Object.c_codigo_usu[row] = gs_usuario
	This.Object.d_creacion_tem[row] = Today( )
Else
	This.Object.c_usumod_tem[row] = gs_usuario
	This.Object.d_modifi_tem[row] = Today( )
End If


end event

event dw_list::editchanged;If Not cb_aceptar.Enabled Then cb_aceptar.Enabled = True
If Not cb_aplicar.Enabled Then cb_aplicar.Enabled = True
end event

type dw_1 from wa_response`dw_1 within w_util_temporada_actualiza
int X=50
int Y=584
int Width=224
int Height=112
end type

type cb_cancelar from wa_response`cb_cancelar within w_util_temporada_actualiza
int X=1705
int Y=600
end type

type cb_aceptar from wa_response`cb_aceptar within w_util_temporada_actualiza
int X=974
int Y=600
end type

event cb_aceptar::clicked;If wf_Aplicar( ) Then
	Close( Parent )
End If
end event

type cb_aplicar from uo_cbother within w_util_temporada_actualiza
int X=1339
int Y=600
int TabOrder=20
boolean Enabled=false
boolean BringToTop=true
string Text="&Aplicar"
end type

event clicked;wf_Aplicar( )
end event

