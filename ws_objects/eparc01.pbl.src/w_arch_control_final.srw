$PBExportHeader$w_arch_control_final.srw
forward
global type w_arch_control_final from Window
end type
type p_ind from picture within w_arch_control_final
end type
type tab_1 from tab within w_arch_control_final
end type
type tabpage_1 from userobject within tab_1
end type
type dw_3 from datawindow within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_2 from datawindow within tabpage_1
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type cb_2 from commandbutton within tabpage_2
end type
type dw_6 from datawindow within tabpage_2
end type
type dw_5 from datawindow within tabpage_2
end type
type dw_4 from datawindow within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type cb_modificar from uo_cbother within tabpage_3
end type
type cb_manifiesto from uo_cbother within tabpage_3
end type
type cb_imprimir from uo_cbother within w_arch_control_final
end type
type dw_prn from datawindow within w_arch_control_final
end type
type cb_cerrar from uo_cbcancelar within w_arch_control_final
end type
type cb_aceptar from uo_cbaceptar within w_arch_control_final
end type
type tabpage_1 from userobject within tab_1
dw_3 dw_3
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
cb_2 cb_2
dw_6 dw_6
dw_5 dw_5
dw_4 dw_4
end type
type tabpage_3 from userobject within tab_1
cb_modificar cb_modificar
cb_manifiesto cb_manifiesto
end type
type tab_1 from tab within w_arch_control_final
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_arch_control_final from Window
int X=1056
int Y=484
int Width=3634
int Height=2548
boolean TitleBar=true
string Title="Control Final"
string MenuName="m_principal_arch_pallet"
long BackColor=33554431
boolean ControlMenu=true
boolean MinBox=true
event ue_print pbm_custom01
p_ind p_ind
tab_1 tab_1
cb_imprimir cb_imprimir
dw_prn dw_prn
cb_cerrar cb_cerrar
cb_aceptar cb_aceptar
end type
global w_arch_control_final w_arch_control_final

type variables
DataWindow idw_nor, idw_mix1, idw_mix2, idw_lis
Boolean ib_generar = True, ib_mostrarmsg = True, ib_color = False
Integer ii_pag = 1, ii_ceros = 0
String is_acc = 'I', is_pal = '', is_lot, is_staemp = '1'
DateTime id_emp
end variables

forward prototypes
public function long wf_print ()
public function boolean wf_setcolumn ()
public function datetime wf_getsysdate ()
end prototypes

event ue_print;wf_print( )
end event

public function long wf_print ();DataWindow	ldw_1
Long		ll_row, ll_rows
String	ls_sec, ls_mess, ls_cod, ls_act, ls_tem, ls_dwp, ls_copias, ls_pallet, ls_print


Choose Case ii_pag
	Case 1
		ldw_1 = idw_nor
	Case 2
		ldw_1 = idw_mix2
	Case 3
		ldw_1 = idw_lis
End Choose

If ldw_1.RowCount( ) <= 0 Then
	Beep(1)
	Return 0
End If

ll_row = ldw_1.GetRow( )

f_Preview( dw_prn )

//f_getPrinter('S', ls_print)
			
Return ll_rows
end function

public function boolean wf_setcolumn ();DataWindow	ldw_1
String		ls_col


If ii_pag = 1 Then
	ldw_1 = idw_nor
Else
	ldw_1 = idw_mix1
End If

ldw_1.AcceptText( )
//
//Choose Case ldw_1.GetColumnName( )
//	Case 'c_elemento' 
//		If ii_pag = 1 Then
//			ls_col = 'c_codigo_lot'
//		Else
//			ls_col = 'n_bulxpa_pal'
//		End If
//	Case 'n_bulxpa_pal' 
//		ls_col = 'c_codigo_lot'
//	Case 'c_codigo_lot' 
//		ls_col = 'c_codigo_pal'
//	Case 'c_codigo_pal' 
//		If ii_pag = 2 Then
//			tab_1.tabpage_2.cb_agregar.SetFocus( )
//			Return True
//		End If
//End Choose

If ls_col = '' Then
	Return False
End If
ldw_1.SetColumn( ls_col )
ldw_1.SetFocus( )
Return True
end function

public function datetime wf_getsysdate ();DateTime	ld_sys

ld_sys = f_GetSysDate( )

If is_staemp = '0' Then
	ld_sys = DateTime( RelativeDate( Date( ld_sys ), 1 ) )
End If

Return ld_sys
end function

on w_arch_control_final.create
if this.MenuName = "m_principal_arch_pallet" then this.MenuID = create m_principal_arch_pallet
this.p_ind=create p_ind
this.tab_1=create tab_1
this.cb_imprimir=create cb_imprimir
this.dw_prn=create dw_prn
this.cb_cerrar=create cb_cerrar
this.cb_aceptar=create cb_aceptar
this.Control[]={this.p_ind,&
this.tab_1,&
this.cb_imprimir,&
this.dw_prn,&
this.cb_cerrar,&
this.cb_aceptar}
end on

on w_arch_control_final.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_ind)
destroy(this.tab_1)
destroy(this.cb_imprimir)
destroy(this.dw_prn)
destroy(this.cb_cerrar)
destroy(this.cb_aceptar)
end on

event open;p_ind.Visible = False


end event

type p_ind from picture within w_arch_control_final
int X=2514
int Y=2200
int Width=27
int Height=44
boolean BringToTop=true
string PictureName="ind.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type tab_1 from tab within w_arch_control_final
event create ( )
event destroy ( )
int X=59
int Y=60
int Width=3520
int Height=2184
int TabOrder=10
boolean RaggedRight=true
int SelectedTab=1
long BackColor=33554431
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=100
int Width=3483
int Height=2068
string Text="Pendientes"
long TabBackColor=15780518
long TabTextColor=16711680
long PictureMaskColor=536870912
dw_3 dw_3
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type

on tabpage_1.create
this.dw_3=create dw_3
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.dw_3,&
this.cb_1,&
this.dw_2,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event constructor;DataWindowChild	ldwc_x

dw_2.SetTransObject( SqlCa )
dw_2.InsertRow(1)
dw_2.AcceptText( )


dw_2.GetChild( 'c_codigo_cul', ldwc_x )
//ldwc_x.InsertRow(1)
//ldwc_x.SetItem( 1, 'c_codigo_cul', '%' )
//
//dw_2.Object.c_codigo_cul[1]='%'



dw_3.SetTransObject( SqlCa )
dw_3.InsertRow(1)
dw_3.AcceptText( )

dw_3.SetRowFocusIndicator( p_ind )

end event

type dw_3 from datawindow within tabpage_1
int X=82
int Y=1344
int Width=3227
int Height=684
int TabOrder=10
string DataObject="d_arch_corteyacarreo_mostrar"
boolean LiveScroll=true
end type

type cb_1 from commandbutton within tabpage_1
int X=1289
int Y=36
int Width=343
int Height=84
int TabOrder=40
string Text="Aplicar"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_cul,ls_cot
dw_3.reset()
ls_cul=f_trim(dw_2.object.c_codigo_cul[1])
if ls_cul <>'' then 	
	dw_1.SetTransObject(SqlCa)
	dw_1.Retrieve(ls_cul)
end if
if dw_1.rowcount() >= 1 then
	ls_cot=f_trim(dw_1.object.c_codigo_cot[1])
	dw_3.SetTransObject(SqlCa)
	dw_3.retrieve(ls_cot)
end if
end event

type dw_2 from datawindow within tabpage_1
int X=96
int Y=40
int Width=1184
int Height=76
int TabOrder=20
string DataObject="d_cultivo_ddlb"
boolean Border=false
boolean LiveScroll=true
end type

type dw_1 from datawindow within tabpage_1
int X=91
int Y=144
int Width=3296
int Height=1140
int TabOrder=30
string DataObject="d_arch_controlfinal_list"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event itemchanged;//dw_1.AcceptText()
datetime ld_hoy,ld_fecha,ld_null
string ls_hora,ls_cot,ls_ho,ls_cul,ls_enc
integer li_opc
setnull(ld_null)
ld_hoy=datetime(today())
ls_hora=string(today(),'hh:mm:ss')
Choose Case dwo.Name
	Case 'c_status_cot'		
		if data='O' then
			ls_cot=f_trim(dw_1.object.c_codigo_cot[row])
			ls_cul=f_trim(dw_1.object.c_codigo_cul[row])
						
			select 	isnull(c_codigo_cot,'')
			into		:ls_enc
			from 		t_corteyacarreo
			where  	c_status_cot='O'
			and 		c_codigo_cul=:ls_cul
			using  	sqlca;
			If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_corteyacarreo.' ) < 0 Then 
				RollBack Using SqlCa ;
				Return 0
			End If
			if ls_enc <> '' then
				MessageBox(title,'Ya se tiene un codigo de rastreo en proceso'+'~r~n'+&
							'del cultivo['+ls_cul+'] ',Exclamation!)
				dw_1.object.c_status_cot[row]=''	
				Return 0
			end if			
			if f_trim(string(dw_1.object.d_procempaque_cot[row]))= '' then
				dw_1.object.d_procempaque_cot[row]=ld_hoy
			end if
			ld_fecha=dw_1.object.d_procempaque_cot[row]
			if f_trim(dw_1.object.c_horaproc_cot[row])='' then
				dw_1.object.c_horaproc_cot[row]=ls_hora
			end if
			ls_ho=dw_1.object.c_horaproc_cot[row]			
			li_opc = MessageBox( Title, '¿Desea guardar los cambios efectuados en el ' + &
										'Rastreo ' + ls_cot+ '?', Question!, YesNoCancel! )
			Choose Case	li_opc
				Case 1
					update t_corteyacarreo
					set	 c_status_cot='O',d_procempaque_cot=:ld_fecha,c_horaproc_cot=:ls_ho
					where  c_codigo_cot=:ls_cot
					using  sqlca;
					If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_corteyacarreo.' ) < 0 Then 
							RollBack Using SqlCa ;
							Return 0
					End If
					
				Case 2
					dw_1.object.d_procempaque_cot[row]=ld_null
					dw_1.object.c_horaproc_cot[row]=''
					Return 0
				Case Else
					dw_1.object.d_procempaque_cot[row]=ld_null
					dw_1.object.c_horaproc_cot[row]=''
					Return 0
			End Choose
		
		end if
		if data='T' then
			ls_cot=f_trim(dw_1.object.c_codigo_cot[row])
			select 	isnull(c_status_cot,'')
			into		:ls_enc
			from 		t_corteyacarreo
			where  	c_codigo_cot=:ls_cot
			using  	sqlca;
			If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_corteyacarreo.' ) < 0 Then 
				RollBack Using SqlCa ;
				Return 0
			End If
			if ls_enc = 'P' then
				MessageBox(title,'Primero debe ser enviado a proceso'+'~r~n'+&
							'el rastreo ['+ls_cot+'] ',Exclamation!)
				dw_1.object.c_status_cot[row]=''	
				Return 0
			end if			
			if f_trim(string(dw_1.object.d_fin_cot[row]))= '' then
				dw_1.object.d_fin_cot[row]=ld_hoy
			end if
			ld_fecha=dw_1.object.d_fin_cot[row]
			if f_trim(dw_1.object.c_horafin_cot[row])='' then
				dw_1.object.c_horafin_cot[row]=ls_hora
			end if
			ls_ho=dw_1.object.c_horafin_cot[row]
	
			li_opc = MessageBox( Title, '¿Desea guardar los cambios efectuados en el ' + &
										'Rastreo ' + ls_cot+ '?', Question!, YesNoCancel! )
			Choose Case	li_opc
				Case 1
					update t_corteyacarreo
					set	 c_status_cot='T',d_fin_cot=:ld_fecha,c_horafin_cot=:ls_ho
					where  c_codigo_cot=:ls_cot
					using  sqlca;
					If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_corteyacarreo.' ) < 0 Then 
							RollBack Using SqlCa ;
							Return 0
					End If
					
				Case 2
					dw_1.object.d_fin_cot[row]=ld_null
					dw_1.object.c_horafin_cot[row]=''
					Return 0
				Case Else
					dw_1.object.d_fin_cot[row]=ld_null
					dw_1.object.c_horafin_cot[row]=''
					Return 0
			End Choose
		
		end if
End Choose

end event

event rowfocuschanged;string ls_cot

This.SelectRow( 0, false )
This.SelectRow( currentrow, True )
if dw_1.rowcount() >= 1 then
	ls_cot=f_trim(dw_1.object.c_codigo_cot[getrow()])
	dw_3.retrieve(ls_cot)
end if

end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=100
int Width=3483
int Height=2068
long BackColor=33554431
string Text="Terminados"
long TabBackColor=15780518
long TabTextColor=16711680
long PictureMaskColor=536870912
cb_2 cb_2
dw_6 dw_6
dw_5 dw_5
dw_4 dw_4
end type

on tabpage_2.create
this.cb_2=create cb_2
this.dw_6=create dw_6
this.dw_5=create dw_5
this.dw_4=create dw_4
this.Control[]={this.cb_2,&
this.dw_6,&
this.dw_5,&
this.dw_4}
end on

on tabpage_2.destroy
destroy(this.cb_2)
destroy(this.dw_6)
destroy(this.dw_5)
destroy(this.dw_4)
end on

event constructor;DataWindowChild	ldwc_x
dw_6.SetTransObject( SqlCa )
dw_6.InsertRow(1)
dw_6.AcceptText( )


dw_6.GetChild( 'c_codigo_cul', ldwc_x )
end event

type cb_2 from commandbutton within tabpage_2
int X=1257
int Y=20
int Width=343
int Height=84
int TabOrder=30
string Text="Aplicar"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_cul,ls_cot
dw_5.reset()
ls_cul=f_trim(dw_6.object.c_codigo_cul[1])
if ls_cul <>'' then 	
	dw_4.SetTransObject(SqlCa)
	dw_4.Retrieve(ls_cul)
end if
if dw_4.rowcount() >= 1 then
	ls_cot=f_trim(dw_4.object.c_codigo_cot[1])
	dw_5.SetTransObject(SqlCa)
	dw_5.retrieve(ls_cot)
end if
end event

type dw_6 from datawindow within tabpage_2
int X=64
int Y=20
int Width=1353
int Height=80
int TabOrder=10
string DataObject="d_cultivo_ddlb"
boolean Border=false
boolean LiveScroll=true
end type

type dw_5 from datawindow within tabpage_2
int X=91
int Y=1312
int Width=3237
int Height=716
int TabOrder=30
string DataObject="d_arch_corteyacarreo_mostrar"
boolean LiveScroll=true
end type

type dw_4 from datawindow within tabpage_2
int X=338
int Y=120
int Width=2706
int Height=1140
int TabOrder=40
string DataObject="d_arch_controlfinal_term_list"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=100
int Width=3483
int Height=2068
boolean Visible=false
long BackColor=82899184
string Text="Listado"
long TabBackColor=82899184
long TabTextColor=33554432
long PictureMaskColor=553648127
cb_modificar cb_modificar
cb_manifiesto cb_manifiesto
end type

on tabpage_3.create
this.cb_modificar=create cb_modificar
this.cb_manifiesto=create cb_manifiesto
this.Control[]={this.cb_modificar,&
this.cb_manifiesto}
end on

on tabpage_3.destroy
destroy(this.cb_modificar)
destroy(this.cb_manifiesto)
end on

type cb_modificar from uo_cbother within tabpage_3
int X=1627
int Y=776
int TabOrder=20
boolean Visible=false
string Text="Modificar"
end type

event clicked;Long		ll_row
String	ls_tem, ls_man, ls_act, ls_cod, ls_sec

If idw_lis.RowCount( ) <= 0 Then
	Beep(1)
	Return
End If

ll_row = idw_lis.GetRow( )


ls_tem	= f_Trim( idw_lis.Object.c_codigo_tem[ll_row] )
ls_cod	= f_Trim( idw_lis.Object.c_codigo_pal[ll_row] )
ls_sec	= f_Trim( idw_lis.Object.c_codsec_pal[ll_row] )
ls_man	= f_Trim( idw_lis.Object.c_codigo_man[ll_row] )
ls_act	= f_Trim( idw_lis.Object.c_activo_pal[ll_row] )
id_emp	= idw_lis.Object.d_empaque_pal[ll_row]
If ls_sec = '00' Then
	MessageBox( Title, 'El palet normal no puede ser actualizado, debe eliminarlo y volver a ingresar.' )
	idw_lis.SetFocus( )
	Return
End If
If ls_man <> '' Then
	MessageBox( Title, 'El palet ya se encuentra en un manifiesto, no puede ser actualizado.' )
	idw_lis.SetFocus( )
	Return
End If
If ls_act = '0' Then
	MessageBox( Title, 'El registro se encuentra eliminado/cancelado.' )
	idw_lis.SetFocus( )
	Return
End If

tab_1.tabpage_1.Enabled = False
is_acc = 'M'
is_pal = ls_cod
idw_mix2.Retrieve( ls_tem + ls_cod )
f_ColEnabled( idw_mix1, 'c_codigo_pal', False )
f_ColEnabled( idw_mix1, 'd_empaque_pal', False )
idw_mix1.Object.c_codigo_pal[1] = is_pal
idw_mix1.Object.d_empaque_pal[1] = id_emp
tab_1.SelectedTab = 2
end event

type cb_manifiesto from uo_cbother within tabpage_3
int X=2368
int Y=776
int TabOrder=20
boolean Visible=false
string Text="Manifiesto"
end type

event clicked;Long		ll_row
String	ls_tem, ls_man, ls_act, ls_cod, ls_sec

If idw_lis.RowCount( ) <= 0 Then
	Beep(1)
	Return
End If

ll_row = idw_lis.GetRow( )


ls_tem	= f_Trim( idw_lis.Object.c_codigo_tem[ll_row] )
ls_cod	= f_Trim( idw_lis.Object.c_codigo_pal[ll_row] )
ls_sec	= f_Trim( idw_lis.Object.c_codsec_pal[ll_row] )
ls_man	= f_Trim( idw_lis.Object.c_codigo_man[ll_row] )
ls_act	= f_Trim( idw_lis.Object.c_activo_pal[ll_row] )
id_emp	= idw_lis.Object.d_empaque_pal[ll_row]
If ls_sec = '00' Then
	MessageBox( Title, 'El palet normal no puede ser actualizado, debe eliminarlo y volver a ingresar.' )
	idw_lis.SetFocus( )
	Return
End If
If ls_man = '' Then
	MessageBox( Title, 'El palet no se encuentra en un manifiesto, no se puede continuar.' )
	idw_lis.SetFocus( )
	Return
End If
If ls_act = '0' Then
	MessageBox( Title, 'El registro se encuentra eliminado/cancelado.' )
	idw_lis.SetFocus( )
	Return
End If

/*If dw_list.Object.c_activo_man[dw_list.GetRow( )] = '0' Then
	MessageBox( Title, 'El registro se encuentra eliminado/cancelado.' )
	dw_list.SetFocus( )
	Return
End If
*/
//lstr_parm.s_cad[1] = ls_tem
//lstr_parm.s_cad[2] = ls_man
//CloseWithReturn( Parent, lstr_parm )
end event

type cb_imprimir from uo_cbother within w_arch_control_final
int X=2875
int Y=2140
int TabOrder=30
boolean Visible=false
string Text="Imprimir"
end type

event clicked;wf_Print( )
end event

type dw_prn from datawindow within w_arch_control_final
int X=1211
int Y=1060
int Width=137
int Height=92
boolean Border=false
boolean LiveScroll=true
end type

type cb_cerrar from uo_cbcancelar within w_arch_control_final
int X=3241
int Y=2272
int TabOrder=40
string Text="Cerrar"
end type

type cb_aceptar from uo_cbaceptar within w_arch_control_final
int X=1751
int Y=1624
int TabOrder=20
boolean Visible=false
boolean Enabled=false
end type

