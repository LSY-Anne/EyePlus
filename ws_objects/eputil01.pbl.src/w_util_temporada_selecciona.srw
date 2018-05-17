$PBExportHeader$w_util_temporada_selecciona.srw
forward
global type w_util_temporada_selecciona from wa_response
end type
end forward

global type w_util_temporada_selecciona from wa_response
int Width=1659
int Height=728
boolean TitleBar=true
string Title="Selección de Temporada"
long BackColor=80269524
end type
global w_util_temporada_selecciona w_util_temporada_selecciona

event open;call super::open;Integer i

If dw_list.Retrieve( ) <= 0  Then
	MessageBox( gs_aplicacion, 'No existen temporadas definidas en el sistema.')
	Close( This )
	Return
End If

For i = 1 To dw_list.RowCount( )
	If f_Trim( dw_list.Object.c_codigo_tem[i] ) = gs_codtem Then
		dw_list.Object.c_selecciona[i] = '1'
		dw_list.SetRow(i)
	End If
Next

dw_1.AcceptText( )
end event

on w_util_temporada_selecciona.create
call super::create
end on

on w_util_temporada_selecciona.destroy
call super::destroy
end on

type dw_list from wa_response`dw_list within w_util_temporada_selecciona
int X=37
int Y=28
int Width=1573
int Height=468
int TabOrder=10
string DataObject="d_util_temporada_selecciona"
end type

event dw_list::doubleclicked;cb_aceptar.TriggerEvent( Clicked! ) 
end event

type dw_1 from wa_response`dw_1 within w_util_temporada_selecciona
int X=27
int Y=472
int Width=206
int Height=128
int TabOrder=20
boolean Visible=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_util_temporada_selecciona
int X=1262
int Y=520
int TabOrder=40
end type

type cb_aceptar from wa_response`cb_aceptar within w_util_temporada_selecciona
int X=882
int Y=520
int TabOrder=30
boolean Enabled=true
end type

event cb_aceptar::clicked;If dw_list.RowCount( ) <= 0  Then Return

gs_codtem = dw_list.Object.c_codigo_tem[dw_list.GetRow( )]
gs_temporada = dw_list.Object.v_nombre_tem[dw_list.GetRow( )]

f_GetNombreTemporada( )
gw_frame.wf_ShowDefault( )

MessageBox( Title, 'Temporada seleccionada: ' +gs_codtem + ' ' + gs_temporada )

Close( Parent )
end event

