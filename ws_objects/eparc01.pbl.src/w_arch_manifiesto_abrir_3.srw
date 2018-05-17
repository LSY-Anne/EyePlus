$PBExportHeader$w_arch_manifiesto_abrir_3.srw
forward
global type w_arch_manifiesto_abrir_3 from wa_response
end type
type cb_buscar from uo_cbother within w_arch_manifiesto_abrir_3
end type
end forward

global type w_arch_manifiesto_abrir_3 from wa_response
int Width=1961
int Height=1148
boolean TitleBar=true
string Title="Abrir Manifiesto"
cb_buscar cb_buscar
end type
global w_arch_manifiesto_abrir_3 w_arch_manifiesto_abrir_3

forward prototypes
public function boolean wf_actualizaacumulados (string as_acc)
end prototypes

public function boolean wf_actualizaacumulados (string as_acc);uo_DataStore	lds_1, lds_acu
DateTime	ld_emp, ld_emb
Dec{2}	ldc_bul
String	ls_tem, ls_cod, ls_mer, ls_pro, ls_eti, ls_des, ls_codori
Long		ll_row, i, ll_ret


Destroy lds_acu
Destroy lds_1

ls_cod = dw_list.Object.c_codigo_man[ dw_list.GetRow()]
ls_des = dw_list.Object.c_merdes_man[ dw_list.GetRow()]
ls_tem = dw_list.Object.c_codigo_tem[ dw_list.GetRow()]
ld_emb = dw_list.Object.d_embarque_man[ dw_list.GetRow()]


lds_1 = Create uo_DataStore
lds_1.DataObject = 'd_arch_manifiesto_det'
lds_1.SetTransObject( SqlCa )
ll_ret = lds_1.Retrieve( ls_tem, ls_cod )


lds_acu = Create uo_DataStore
lds_acu.DataObject = 'd_arch_acumulado_edit'
lds_acu.SetTransObject( SqlCa ) 

For i = 1 To lds_1.RowCount( )
	ls_mer = ''
	ls_pro = f_Trim( lds_1.Object.c_codigo_pro[ i] )
	
	Select	c_merdes_pro
	Into		:ls_mer
	From		t_producto
	Where		c_codigo_pro = :ls_pro ;
	
	ls_eti = f_Trim( lds_1.Object.c_codigo_eti[ i] )
	ldc_bul = f_Zero( lds_1.Object.n_bulxpa_pal[ i] )
	ld_emp = lds_1.Object.d_empaque_pal[ i]
	ls_codori = gs_codtem + ls_pro + ls_eti + ls_mer
	ll_row = lds_acu.Retrieve( gs_codtem + ls_pro + ls_eti + ls_mer + ls_des )
	If ll_row > 0 Then
		lds_acu.Object.c_usumod[ll_row] = gs_usuario
		lds_acu.Object.d_modifi[ll_row] = DateTime( Today( ) )
		lds_acu.Object.c_activo[ll_row] = '1'
		If as_acc = 'I' Then
			lds_acu.Object.n_embhoy_acu[ll_row] = f_Zero(lds_acu.Object.n_embhoy_acu[ll_row]) + ldc_bul
		Else
			lds_acu.Object.n_embhoy_acu[ll_row] = f_Zero(lds_acu.Object.n_embhoy_acu[ll_row]) - ldc_bul
			If Not ls_mer = ls_des Then
				If ld_emp = ld_emb Then
					lds_acu.Object.n_emphoy_acu[ll_row] = f_Zero(lds_acu.Object.n_emphoy_acu[ll_row]) - ldc_bul
				Else
					lds_acu.Object.n_emptot_acu[ll_row] = f_Zero(lds_acu.Object.n_emptot_acu[ll_row]) - ldc_bul
				End If
			End If
		End If
		lds_acu.AcceptText( )
		If lds_acu.Update( ) <> 1 Then
			RollBack Using SqlCa ;
			MessageBox( Title, 'El registro no ha sido actualizado.', StopSign! )
			Destroy lds_acu
			Destroy lds_1
			Return False
		Else
			If ( as_acc = 'E' ) And ( Not ls_mer = ls_des ) Then
				/* Se debe efectuar el descuento por cambio de mercado */
				If ld_emp = ld_emb Then
					/* Si la fecha de empaque es = a la de embarque se vuelve acumular el empaque de hoy */
					Update	t_acumulado
					Set		n_emphoy_acu = IsNull( n_emphoy_acu, 0 ) + :ldc_bul
					Where		c_codigo_tem + c_codigo_pro + c_codigo_eti + c_merori_acu = :ls_codori
         		And		c_merdes_acu <> :ls_des
					Using		SqlCa ;
				Else
					/* Si la fecha de empaque NO es = a la de embarque se vuelve acumular el empaque acumulado total anterior */
					Update	t_acumulado
					Set		n_emptot_acu = IsNull( n_emptot_acu, 0 ) + :ldc_bul
					Where		c_codigo_tem + c_codigo_pro + c_codigo_eti + c_merori_acu = :ls_codori
         		And		c_merdes_acu <> :ls_des
					Using		SqlCa ;
				End If
				If f_SqlError( SqlCa, 'No se pudo actualizar la tabla t_acumulado (empaque)' ) = -1 Then
					Return False
				End If
			End If

		End If
	End If
Next


Destroy lds_acu
Destroy lds_1
		
Return True
end function

on w_arch_manifiesto_abrir_3.create
int iCurrent
call super::create
this.cb_buscar=create cb_buscar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_buscar
end on

on w_arch_manifiesto_abrir_3.destroy
call super::destroy
destroy(this.cb_buscar)
end on

event open;call super::open;
dw_1.Visible = False

String	ls_null

SetNull( ls_null )

dw_list.Retrieve( gs_codtem, '%')
dw_list.SetFocus( )
end event

type dw_list from wa_response`dw_list within w_arch_manifiesto_abrir_3
int X=37
int Y=132
int Width=1888
int Height=768
int TabOrder=20
string DataObject="d_arch_manifiesto_abrir_3"
end type

event dw_list::retrieveend;call super::retrieveend;If rowcount > 0  Then cb_aceptar.Enabled = True
end event

event dw_list::doubleclicked;cb_aceptar.TriggerEvent( Clicked! )
end event

event dw_list::getfocus;cb_aceptar.Default = True
end event

type dw_1 from wa_response`dw_1 within w_arch_manifiesto_abrir_3
int X=46
int Y=904
int Width=306
int Height=136
int TabOrder=0
string DataObject="d_rpt_manifiesto_x_fechas"
end type

type cb_cancelar from wa_response`cb_cancelar within w_arch_manifiesto_abrir_3
int X=1225
int Y=924
int TabOrder=40
end type

event cb_cancelar::clicked;s_parm	lstr_parm


CloseWithReturn( Parent, lstr_parm )
end event

type cb_aceptar from wa_response`cb_aceptar within w_arch_manifiesto_abrir_3
int X=855
int Y=924
int TabOrder=30
end type

event cb_aceptar::clicked;//s_parm	lstr_parm
string ls_cod
If dw_list.RowCount ( ) <= 0  Then 
	Beep( 1)
	Return
End If

ls_cod = dw_list.Object.c_codigo_man[dw_list.GetRow( )]

CloseWithReturn( Parent, ls_cod )

end event

type cb_buscar from uo_cbother within w_arch_manifiesto_abrir_3
int X=1504
int Y=32
string Text="&Buscar"
end type

event clicked;String	ls_null

SetNull( ls_null )

dw_list.Retrieve( gs_codtem, ls_null )
dw_list.SetFocus( )
end event

