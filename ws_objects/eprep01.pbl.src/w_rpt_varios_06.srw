$PBExportHeader$w_rpt_varios_06.srw
forward
global type w_rpt_varios_06 from wa_response
end type
type p_1 from picture within w_rpt_varios_06
end type
type st_mess from statictext within w_rpt_varios_06
end type
type em_ini from uo_editmask within w_rpt_varios_06
end type
type cb_ini from uo_cbdate within w_rpt_varios_06
end type
type st_2 from statictext within w_rpt_varios_06
end type
type em_fin from uo_editmask within w_rpt_varios_06
end type
type cb_fin from uo_cbdate within w_rpt_varios_06
end type
type st_1 from statictext within w_rpt_varios_06
end type
end forward

global type w_rpt_varios_06 from wa_response
int Width=1504
int Height=700
long BackColor=80269524
p_1 p_1
st_mess st_mess
em_ini em_ini
cb_ini cb_ini
st_2 st_2
em_fin em_fin
cb_fin cb_fin
st_1 st_1
end type
global w_rpt_varios_06 w_rpt_varios_06

type variables
String	is_rpt
end variables

event open;call super::open;DataWindowChild	ldwc_x

is_rpt = Message.StringParm

dw_1.InsertRow(0)

Choose Case is_rpt
	Case 'EXE' 
		Title = 'Empaques por Etiqueta'
		dw_list.DataObject = 'd_rpt_estadistica_empaque_etiqueta'
	Case 'ESP' /*  */
		Title = 'Estadística de Empaque por Producto'
		dw_list.DataObject = 'd_rpt_estadistica_empaque_prod'
	Case 'REN' /*  */
		Title = 'Rendimiento de lotes'
		dw_list.DataObject = 'd_rpt_rendimiento_x_lote'
		dw_1.GetChild( 'c_codigo_cul', ldwc_x)
		ldwc_x.InsertRow(1)
		ldwc_x.SetItem( 1, 'c_codigo_cul', '%' )
		ldwc_x.SetItem( 1, 'v_nombre_cul', 'Todos los cultivos' )
		ldwc_x.AcceptText( )
		dw_1.Object.c_codigo_cul[ 1] = '%'
	Case 'REE' /*  */
		Title = 'Resumen de Empaque por Producto'
		dw_list.DataObject = 'd_rpt_acumulado_diario_frame'
		em_ini.Enabled = False
		em_fin.Enabled = False
		cb_ini.Enabled = False
		cb_fin.Enabled = False
End Choose
dw_list.Visible = False

em_ini.Text = f_GetParmValue( '20' )
em_fin.Text = f_GetParmValue( '20' )

end event

on w_rpt_varios_06.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_mess=create st_mess
this.em_ini=create em_ini
this.cb_ini=create cb_ini
this.st_2=create st_2
this.em_fin=create em_fin
this.cb_fin=create cb_fin
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_mess
this.Control[iCurrent+3]=this.em_ini
this.Control[iCurrent+4]=this.cb_ini
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_fin
this.Control[iCurrent+7]=this.cb_fin
this.Control[iCurrent+8]=this.st_1
end on

on w_rpt_varios_06.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_mess)
destroy(this.em_ini)
destroy(this.cb_ini)
destroy(this.st_2)
destroy(this.em_fin)
destroy(this.cb_fin)
destroy(this.st_1)
end on

type dw_list from wa_response`dw_list within w_rpt_varios_06
int X=59
int Y=404
int Width=155
int Height=96
int TabOrder=0
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_varios_06
int X=219
int Y=184
int Width=1193
int Height=96
string DataObject="d_ext_cultivo"
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_varios_06
int X=1061
int Y=440
int TabOrder=50
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_varios_06
int X=681
int Y=440
int TabOrder=40
boolean Enabled=true
end type

event cb_aceptar::clicked;DataWindow	ldw_1
String		ls_cod, ls_nom

SetPointer( HourGlass! )

dw_1.AcceptText( )
ls_cod = f_Trim( dw_1.Object.c_codigo_cul[ 1] )

If ls_cod = '' Then 
	MessageBox( Title, 'Debe seleccionar un cultivo.', Exclamation! )
	dw_1.SetFocus( )
	Return
End If

Select	v_nombre_cul
Into		:ls_nom
From		t_cultivo
Where		c_codigo_cul = :ls_cod ;

ls_nom = f_Trim( ls_nom )

ldw_1 = f_PreviewXP( dw_list.DataObject )

If is_rpt = 'REE' Then
	ldw_1.Retrieve( ls_nom, f_StringToDate( em_ini.Text ) )
ElseIf is_rpt = 'REN' Then
	ldw_1.Retrieve( f_StringToDate( em_ini.Text ), f_StringToDate( em_fin.Text ), ls_cod, '%' )
Else
	ldw_1.Retrieve( gs_codtem, f_StringToDate( em_ini.Text ), f_StringToDate( em_fin.Text ), ls_cod, ls_nom )
End If

SetPointer( Arrow! )

end event

type p_1 from picture within w_rpt_varios_06
int X=37
int Y=32
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_mess from statictext within w_rpt_varios_06
int X=219
int Y=36
int Width=1198
int Height=120
boolean Enabled=false
boolean BringToTop=true
string Text="Para emitir el reporte, complete los datos solicitados y luego haga clic en el botón Aceptar"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_ini from uo_editmask within w_rpt_varios_06
int X=338
int Y=308
int TabOrder=20
end type

type cb_ini from uo_cbdate within w_rpt_varios_06
int X=681
int Y=312
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_2 from statictext within w_rpt_varios_06
int X=850
int Y=312
int Width=73
int Height=76
boolean Enabled=false
string Text="Al:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_fin from uo_editmask within w_rpt_varios_06
int X=983
int Y=308
int TabOrder=30
end type

type cb_fin from uo_cbdate within w_rpt_varios_06
int X=1326
int Y=312
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type st_1 from statictext within w_rpt_varios_06
int X=219
int Y=312
int Width=119
int Height=76
boolean Enabled=false
string Text="Del:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

