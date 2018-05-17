$PBExportHeader$w_util_importar.srw
forward
global type w_util_importar from wa_response
end type
type cbx_1 from checkbox within w_util_importar
end type
type st_1 from statictext within w_util_importar
end type
type st_estado from statictext within w_util_importar
end type
type uo_bar from uo_progressbar within w_util_importar
end type
type cb_exportar from uo_cbother within w_util_importar
end type
type st_2 from statictext within w_util_importar
end type
type st_3 from statictext within w_util_importar
end type
type st_4 from statictext within w_util_importar
end type
type st_5 from statictext within w_util_importar
end type
end forward

global type w_util_importar from wa_response
integer width = 1870
integer height = 748
string title = "Importar Información"
long backcolor = 80269524
cbx_1 cbx_1
st_1 st_1
st_estado st_estado
uo_bar uo_bar
cb_exportar cb_exportar
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
end type
global w_util_importar w_util_importar

type variables
Integer ii_size = 1120
end variables

forward prototypes
public function long wf_setlotes (string as_opc)
end prototypes

public function long wf_setlotes (string as_opc);Long	i, j, ll_rows = 0
DateTime	ld_ini, ld_fin, ld_1er, ld_pla
Dec{2}	ldc_superficie, ldc_bhe, ldc_bhn
Integer	li_dip, li_dpc, li_dcc
String	ls_cod, ls_des, ls_tipo, ls_target, ls_cultivo, ls_var, ls_cam, ls_eta

If as_opc = 'I' Then
	dw_1.DataObject = 'd_mant_lote_edit'
	dw_1.SetTransObject( SqlCa )
Else
	dw_1.DataObject = 'd_util_exportar_lote_reg'
	dw_1.SetTransObject( SqlCa )
End If
For i = 1 To dw_list.RowCount( )
	
	ls_cod = dw_list.Object.c_codigo_lot[ i]
	ls_des = dw_list.Object.v_nombre_lot[ i]
	ls_tipo = dw_list.Object.c_tipo_lot[ i]
	ls_cultivo = dw_list.Object.c_codigo_cul[ i]
	ls_eta = dw_list.Object.c_codigo_eta[ i]
	ldc_superficie = dw_list.Object.n_superf_lot[ i]
	ls_var = dw_list.Object.c_codigo_var[ i]
	ls_cam = dw_list.Object.c_codigo_cam[ i]
	ld_ini = dw_list.Object.d_inicio_lot[ i] 
	ld_fin = dw_list.Object.d_cierre_lot[ i]
	ld_1er = dw_list.Object.d_1ercor_lot[ i]
	ldc_bhe = dw_list.Object.n_bulhae_lot[ i]
	ldc_bhn = dw_list.Object.n_bulhan_lot[ i]
	ls_target = dw_list.Object.v_target_lot[ i]
	ld_pla = dw_list.Object.d_planteo_lot[ i]
	li_dip = dw_list.Object.n_pladiasini_lot[ i]
	li_dpc = dw_list.Object.n_pladiascor_lot[ i]
	li_dcc = dw_list.Object.n_diascorcie_lot[ i]
	
	If as_opc = 'I' Then
		j = f_Zero( dw_1.Retrieve( gs_codtem + ls_cod ) )
	Else
		j = f_Zero( dw_1.Retrieve( ls_cod ) )
	End If
	If	j < 0 Then
		MessageBox( Title, 'Se produjo un error al intentar consultar el registro ' + &
									ls_cod + ' de la tabla t_lote.', StopSign! )
		Return -1
	End If
	
	If	j = 0 Then
		dw_1.InsertRow( 0 )
		If as_opc = 'I' Then
			dw_1.Object.c_codigo_tem[ 1] = gs_codtem
		End If
		dw_1.Object.c_codigo_lot[ 1] = ls_cod
		dw_1.Object.c_codigo_usu[ 1] = gs_usuario
		dw_1.Object.d_creacion[ 1] = DateTime(Today( ))
		dw_1.Object.c_activo[ 1] = '1'
		ll_rows ++
	End If
	
	If j = 0 Or cbx_1.Checked Then
		dw_1.Object.v_nombre_lot[ 1] = ls_des
		dw_1.Object.c_tipo_lot[ 1] = ls_tipo
		dw_1.Object.c_codigo_cul[ 1] = ls_cultivo
		dw_1.Object.c_codigo_eta[ 1] = ls_eta
		dw_1.Object.n_superf_lot[ 1] = ldc_superficie
		dw_1.Object.c_codigo_var[ 1] = ls_var
		dw_1.Object.c_codigo_cam[ 1] = ls_cam
		dw_1.Object.d_inicio_lot[ 1] = ld_ini
		dw_1.Object.d_cierre_lot[ 1] = ld_fin
		dw_1.Object.d_1ercor_lot[ 1] = ld_1er
		dw_1.Object.n_bulhae_lot[ 1] = ldc_bhe
		dw_1.Object.n_bulhan_lot[ 1] = ldc_bhn
		dw_1.Object.v_target_lot[ 1] = ls_target
		dw_1.Object.d_planteo_lot[ 1] = ld_pla
		dw_1.Object.n_pladiasini_lot[ 1] = li_dip
		dw_1.Object.n_pladiascor_lot[ 1] = li_dpc
		dw_1.Object.n_diascorcie_lot[ 1] = li_dcc
	End If
	
	If j > 0 And cbx_1.Checked Then
		dw_1.Object.c_usumod[ 1] = gs_usuario
		dw_1.Object.d_modifi[ 1] = Today( )
		ll_rows ++
	End If
	
	If j = 0 Or cbx_1.Checked Then
		dw_1.AcceptText( )
		If dw_1.Update( ) = -1 Then
			RollBack Using SqlCa ;
			MessageBox( Title, 'Se produjo un error al actualizar el registro ' + &
										ls_cod + ' de la tabla t_lote.', StopSign! )
			Return -1
		End If			
	End If
	uo_bar.uof_SetPercent( i, dw_list.RowCount( ) )
Next

Return 1
end function

on w_util_importar.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.st_1=create st_1
this.st_estado=create st_estado
this.uo_bar=create uo_bar
this.cb_exportar=create cb_exportar
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_estado
this.Control[iCurrent+4]=this.uo_bar
this.Control[iCurrent+5]=this.cb_exportar
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_5
end on

on w_util_importar.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.st_estado)
destroy(this.uo_bar)
destroy(this.cb_exportar)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
end on

event open;call super::open;//Transaction ms_sqlca 
If f_conecta_new(ms_SqlCa, '0', 'MSDatabase', '', '', '', '', 'S')<>1 Then
	Close(This)
	Return -1
End If

If f_GetParmValue( '22' ) = 'S' Then 
	cbx_1.Checked = True
End If

Return 1
end event

type dw_list from wa_response`dw_list within w_util_importar
integer x = 558
integer y = 784
end type

type dw_1 from wa_response`dw_1 within w_util_importar
integer x = 23
integer y = 752
integer width = 366
integer height = 252
end type

type cb_cancelar from wa_response`cb_cancelar within w_util_importar
integer x = 1458
integer y = 288
end type

type cb_aceptar from wa_response`cb_aceptar within w_util_importar
integer x = 1458
integer y = 56
boolean enabled = true
string text = "&Importar"
boolean default = false
end type

event cb_aceptar::clicked;Integer	j, li_tablas, li_error
String	ls_tablas[ 3]


If MessageBox( Parent.Title, '¿Confirma que desea importar información del Servidor?', Question!, YesNo! ) <> 1 Then
	Return
End If

ls_tablas[ 1] = 'Lote'

li_tablas = UpperBound( ls_tablas[])
For j = 1 To li_tablas
	st_estado.Text = 'Preparando paso ' +  Trim( String(j) ) + ' de ' + Trim( String(li_tablas) )
	st_estado.Text = st_estado.Text + ' (' + ls_tablas[ j] + 's)'
	dw_list.DataObject = 'd_util_importar_' + ls_tablas[ j]
	dw_list.SetTransObject(ms_sqlca)
	dw_list.Retrieve( )
	st_estado.Text = 'Importando ' + ls_tablas[ j] + 's'
	uo_bar.uof_InitBar( )
	Choose Case j
		Case 1
			li_error = wf_SetLotes( 'I' )
	End Choose			
	If li_error = -1 Then
		MessageBox( Parent.Title, 'El proceso se canceló por un error en la importación.', StopSign!)
		Exit
	End If
Next

If li_error <> -1 Then
	Commit Using SqlCa ;
	MessageBox( Parent.Title, 'El proceso de actualización terminó correctamente.' )
End If
end event

type cbx_1 from checkbox within w_util_importar
integer x = 41
integer y = 340
integer width = 1006
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Actualizar al Importar registros existentes."
end type

type st_1 from statictext within w_util_importar
integer x = 50
integer y = 36
integer width = 1184
integer height = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Las tablas pueden actualizarce solo con registros nuevos y/o con existentes"
boolean focusrectangle = false
end type

type st_estado from statictext within w_util_importar
integer x = 41
integer y = 472
integer width = 1742
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "En Espera"
boolean focusrectangle = false
end type

type uo_bar from uo_progressbar within w_util_importar
integer x = 41
integer y = 532
integer width = 1760
integer taborder = 50
boolean bringtotop = true
boolean border = true
end type

on uo_bar.destroy
call uo_progressbar::destroy
end on

type cb_exportar from uo_cbother within w_util_importar
integer x = 1458
integer y = 172
integer taborder = 20
boolean bringtotop = true
string text = "&Exportar"
end type

event clicked;Integer	j, li_tablas, li_error
String	ls_tablas[ 3]


If MessageBox( Parent.Title, '¿Confirma que desea exportar información al Servidor?', Question!, YesNo! ) <> 1 Then
	Return
End If

ls_tablas[ 1] = 'Lote'

li_tablas = UpperBound( ls_tablas[])
For j = 1 To li_tablas
	st_estado.Text = 'Preparando paso ' +  Trim( String(j) ) + ' de ' + Trim( String(li_tablas) )
	st_estado.Text = st_estado.Text + ' (' + ls_tablas[ j] + 's)'
	dw_list.DataObject = 'd_util_exportar_' + ls_tablas[ j]
	dw_list.SetTransObject(ms_sqlca)
	dw_list.Retrieve( )
	st_estado.Text = 'Exportando ' + ls_tablas[ j] + 's'
	uo_bar.uof_InitBar( )
	Choose Case j
		Case 1
			li_error = wf_SetLotes( 'E' )
	End Choose			
	If li_error = -1 Then
		MessageBox( Parent.Title, 'El proceso se canceló por un error en la exportación.', StopSign!)
		Exit
	End If
Next

If li_error <> -1 Then
	Commit Using SqlCa ;
	MessageBox( Parent.Title, 'El proceso de actualización terminó correctamente.' )
End If
end event

type st_2 from statictext within w_util_importar
integer x = 123
integer y = 176
integer width = 1275
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Importar - Recupera la información  del Servidor a Eye Plus"
boolean focusrectangle = false
end type

type st_3 from statictext within w_util_importar
integer x = 123
integer y = 244
integer width = 1184
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Exportar - Envía la información de Eye Plus al Servidor"
boolean focusrectangle = false
end type

type st_4 from statictext within w_util_importar
integer x = 78
integer y = 176
integer width = 41
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "°"
boolean focusrectangle = false
end type

type st_5 from statictext within w_util_importar
integer x = 78
integer y = 244
integer width = 41
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "°"
boolean focusrectangle = false
end type

