$PBExportHeader$w_rpt_palet_entransito.srw
forward
global type w_rpt_palet_entransito from wa_response
end type
type p_1 from picture within w_rpt_palet_entransito
end type
type st_mess from statictext within w_rpt_palet_entransito
end type
type cbx_1 from checkbox within w_rpt_palet_entransito
end type
type cbx_2 from checkbox within w_rpt_palet_entransito
end type
type st_1 from statictext within w_rpt_palet_entransito
end type
type st_2 from statictext within w_rpt_palet_entransito
end type
type rb_1 from radiobutton within w_rpt_palet_entransito
end type
type dw_2 from datawindow within w_rpt_palet_entransito
end type
type rb_2 from radiobutton within w_rpt_palet_entransito
end type
type em_ini from uo_editmask within w_rpt_palet_entransito
end type
type st_3 from statictext within w_rpt_palet_entransito
end type
type st_4 from statictext within w_rpt_palet_entransito
end type
type em_fin from uo_editmask within w_rpt_palet_entransito
end type
type cb_5 from uo_cbdate within w_rpt_palet_entransito
end type
type cb_6 from uo_cbdate within w_rpt_palet_entransito
end type
end forward

global type w_rpt_palet_entransito from wa_response
int Width=1632
int Height=1160
long BackColor=80269524
p_1 p_1
st_mess st_mess
cbx_1 cbx_1
cbx_2 cbx_2
st_1 st_1
st_2 st_2
rb_1 rb_1
dw_2 dw_2
rb_2 rb_2
em_ini em_ini
st_3 st_3
st_4 st_4
em_fin em_fin
cb_5 cb_5
cb_6 cb_6
end type
global w_rpt_palet_entransito w_rpt_palet_entransito

type variables
String	is_rpt
end variables

forward prototypes
public function integer wf_buscapro (string as_cod)
public function integer wf_buscarpro2 (string as_cod)
end prototypes

public function integer wf_buscapro (string as_cod);//String ls_pro,ls_nompro,ls_parm,ls_act
//as_cod = f_Trim( as_cod )
//
//If as_cod = '' Then
//	 
//	 OpenWithParm( w_mant_buscar_x_nombre, 'PRO' )
//	 ls_parm = Message.StringParm 
//	 ls_parm = f_Trim( ls_parm )
//	 
//	 If Not ls_parm = '' Then
//	 	
//		 as_cod = ls_parm
//	 	 ls_pro = as_cod
//	 
//	 End If
//
//else
//	
//	 Select c_codigo_pro,c_activo_pro
//	 Into  :ls_pro,:ls_act
//	 From  t_producto
//	 Where  c_codigo_pro = :as_cod
//	 Using  SqlCa ;
//	
//	 If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_producto.' ) = -1 Then
//	 	Return 0
//	 end if
//	 if (f_trim(ls_act) <> '1') then
//	 	messagebox(title,'Producto no encontrado',exclamation!)
//		return 0
//
//	Else	 
//		If (f_trim(ls_pro) = '') then
//			messagebox(title, 'Producto no especificado', Exclamation!)
//			return 0
//		end if
//		
//	end if	
//End if
//
//sle_1.text=string(ls_pro)
//
//Select v_nombre_pro
//Into  :ls_nompro
//From  t_producto
//Where  c_codigo_pro = :ls_pro
//Using  SqlCa ;
//
//If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_producto.' ) = -1 Then
//Return 0
//End if
//
//sle_3.text = string(ls_nompro)
//
//
//
//
Return 1
end function

public function integer wf_buscarpro2 (string as_cod);//String ls_pro,ls_nompro,ls_parm,ls_act
//as_cod = f_Trim( as_cod )
//
//If as_cod = '' Then
//	 
//	 OpenWithParm( w_mant_buscar_x_nombre, 'PRO' )
//	 ls_parm = Message.StringParm 
//	 ls_parm = f_Trim( ls_parm )
//	 
//	 If Not ls_parm = '' Then
//	 	
//		 as_cod = ls_parm
//	 	 ls_pro = as_cod
//	 
//	 End If
//
//else
//	
//	 Select c_codigo_pro,c_activo_pro
//	 Into  :ls_pro,:ls_act
//	 From  t_producto
//	 Where  c_codigo_pro = :as_cod
//	 Using  SqlCa ;
//	
//	 If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_producto.' ) = -1 Then
//	 	Return 0
//	 end if
//	 if (f_trim(ls_act) <> '1') then
//	 	messagebox(title,'Producto no encontrado',exclamation!)
//		return 0
//
//	Else	 
//		If (f_trim(ls_pro) = '') then
//			messagebox(title, 'Producto no especificado', Exclamation!)
//			return 0
//		end if
//		
//	end if	
//End if
//
//sle_2.text=string(ls_pro)
//
//Select v_nombre_pro
//Into  :ls_nompro
//From  t_producto
//Where  c_codigo_pro = :ls_pro
//Using  SqlCa ;
//
//If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_producto.' ) = -1 Then
//Return 0
//End if
//
//sle_4.text = string(ls_nompro)
//
//

Return 1
end function

event open;call super::open;string ls_hoy, ls_nombre
datetime ld_hoy
is_rpt = Message.StringParm
DataWindowChild ldwc_x

ls_hoy=string(today())
ld_hoy = datetime(today())
Title = 'Palet en Transito'
	
//dw_1.InsertRow(0)
//dw_2.InsertRow(0)
dw_list.Visible = False


		dw_1.SetTransObject(SqlCa)
		dw_1.InsertRow(0)

		dw_2.SetTransObject(SqlCa)
		dw_2.InsertRow(0)
		
		dw_2.GetChild('c_codigo_cze', ldwc_x)
		ldwc_x.InsertRow(1)
		ldwc_x.SetItem(1, 'c_codigo_cze', '%')
		ldwc_x.SetItem(1, 'v_desclarga_cze', 'Todos')
//		ldwc_x.InsertRow(1)
//		ldwc_x.SetItem(1, 'c_codigo_cze', 'N')
//		ldwc_x.SetItem(1, 'v_desclarga_cze', 'Ninguno en Especifico')
//		
//		
//		f_colEnabled (dw_1, 'v_nombre_pte', False)
//		f_colEnabled (dw_2, 'v_desclarga_cze', False)

em_ini.Text = String( gd_sys, 'dd/mm/yyyy' )
em_fin.Text = String( gd_sys, 'dd/mm/yyyy' )
end event

on w_rpt_palet_entransito.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_mess=create st_mess
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.st_1=create st_1
this.st_2=create st_2
this.rb_1=create rb_1
this.dw_2=create dw_2
this.rb_2=create rb_2
this.em_ini=create em_ini
this.st_3=create st_3
this.st_4=create st_4
this.em_fin=create em_fin
this.cb_5=create cb_5
this.cb_6=create cb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_mess
this.Control[iCurrent+3]=this.cbx_1
this.Control[iCurrent+4]=this.cbx_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.rb_1
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.rb_2
this.Control[iCurrent+10]=this.em_ini
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.em_fin
this.Control[iCurrent+14]=this.cb_5
this.Control[iCurrent+15]=this.cb_6
end on

on w_rpt_palet_entransito.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_mess)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.rb_1)
destroy(this.dw_2)
destroy(this.rb_2)
destroy(this.em_ini)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.em_fin)
destroy(this.cb_5)
destroy(this.cb_6)
end on

type dw_list from wa_response`dw_list within w_rpt_palet_entransito
int X=293
int Y=1324
int Width=718
int Height=216
int TabOrder=0
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_palet_entransito
int X=635
int Y=656
int Width=955
int Height=80
string DataObject="d_arch_puntoembarque3"
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_palet_entransito
int X=754
int Y=944
int TabOrder=70
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_palet_entransito
int X=366
int Y=948
int TabOrder=60
boolean Enabled=true
end type

event cb_aceptar::clicked;String  ls_punto, ls_nombre, ls_exc, ls_cruce, ls_puntoe, ls_marca
Long ll_rows
Datetime ld_ini,ld_fin

ld_ini=  f_StringToDate( em_ini.Text )
ld_fin= f_StringToDate( em_fin.Text )

SetPointer( HourGlass! )

if em_ini.text = '00/00/0000' then
	 Messagebox(title,'La fecha inicial no debe permanecer en ceros',exclamation!)
	 em_ini.setfocus()
	 return 0
End if

if em_fin.text = '00/00/0000' then
	 Messagebox(title,'La fecha final no debe permanecer en ceros',exclamation!)
	 em_fin.setfocus()
	 return 0
End if

if ld_ini > ld_fin then
	 Messagebox(title,'La fecha inicial no debe ser mayor que la fecha final', exclamation!)
	 em_ini.setfocus()
	 return 0
End if


If cbx_1.checked=true then
	If f_trim(dw_2.object.c_codigo_cze [1] )= '' Then
		MessageBox( Title, 'Si elegiste palet en transito, debes elegir lugar de cruce.', Exclamation! )
 		Return 0
	End If
End If
		
If cbx_2.checked=true then
	If f_trim(dw_1.object.v_nombre_pte [1] )= '' Then
		MessageBox( Title, 'Si elegiste existencia en frontera, debes elegir punto de embarque.', Exclamation! )
 		Return 0
	End If
End If
	
If cbx_1.checked=false and cbx_2.checked=false Then
	MessageBox( Title, 'Debes marcar palet en transito ó existencia en frontera para mostrar reporte.', Exclamation! )
	Return 0
End If
	
If rb_1.checked = true then
	ls_exc = '1'
	ls_marca = 'e'
elseif rb_2.checked = true then
	ls_exc = '0'
	ls_marca = 't'
elseif rb_1.checked = false and rb_2.checked = false then
	ls_marca = 't'
End IF


If cbx_1.checked = true then
	ls_cruce = f_trim(dw_2.object.c_codigo_cze [1] )
End IF

If cbx_2.checked = true then
	ls_puntoe = f_trim(dw_1.object.v_nombre_pte [1])
End If

if cbx_1.checked=true then
	dw_list.DataObject = 'd_rpt_palet_entransito1'	
elseif cbx_2.checked = true then
	dw_list.DataObject = 'd_rpt_palet_entransito2'	
end if

select c_codigo_pte
into :ls_punto
from t_puntoembarque (nolock)
where v_nombre_pte = :ls_puntoe
Using	SqlCa;
	If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_puntoembarque. (select)' ) < 0 Then
		RollBack Using SqlCa;
		Return 0
	End If
	
////Mandar al reporte
//	dw_list.DataObject = 'd_rpt_pallet_eliminados'	
		dw_list.settransobject(sqlca)
		if cbx_1.checked=true then
			ll_rows = dw_list.Retrieve(gs_codtem, ls_cruce, ls_exc, ls_marca, ld_ini, ld_fin)	
		elseif cbx_2.checked = true then
			ll_rows = dw_list.Retrieve(gs_codtem, ls_punto, ls_exc, ls_marca, ld_ini, ld_fin)	
		end if 
		
		f_Preview(dw_list)
		
		Return ll_rows

end event

type p_1 from picture within w_rpt_palet_entransito
int X=37
int Y=32
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_mess from statictext within w_rpt_palet_entransito
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

type cbx_1 from checkbox within w_rpt_palet_entransito
int X=114
int Y=340
int Width=763
int Height=80
boolean BringToTop=true
string Text="Mostrar Palets en Transito"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//if cbx_1.checked=true then
//	f_colEnabled (dw_1, 'v_nombre_pte', False)
//	dw_1.object.v_nombre_pte [1] = ''
//	cbx_2.checked = false
//else
//	f_colEnabled (dw_1, 'v_nombre_pte', true)
//	
//end if

If cbx_1.checked=true then
	cbx_2.checked = false
	dw_1.object.v_nombre_pte [1] = ''
End If
end event

type cbx_2 from checkbox within w_rpt_palet_entransito
int X=114
int Y=564
int Width=585
int Height=80
boolean BringToTop=true
string Text="Existencia en Frontera"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//if cbx_2.checked=true then
//	f_colEnabled (dw_2, 'v_desclarga_cze', False)
//	dw_2.object.v_desclarga_cze[1] = ''
//	cbx_1.checked = false
//else
////	f_colEnabled (dw_2, 'v_desclarga_cze', true)
//	f_colEnabled (dw_1, 'v_nombre_pte', true)
//end if

If cbx_2.checked=true then
	cbx_1.checked = false
	dw_2.object.c_codigo_cze [1] = ''
End IF
end event

type st_1 from statictext within w_rpt_palet_entransito
int X=183
int Y=664
int Width=453
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Punto de Embarque:"
Alignment Alignment=Right!
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

type st_2 from statictext within w_rpt_palet_entransito
int X=183
int Y=456
int Width=357
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Lugar de Cruce"
Alignment Alignment=Right!
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

type rb_1 from radiobutton within w_rpt_palet_entransito
int X=114
int Y=764
int Width=814
int Height=80
boolean BringToTop=true
string Text="Mostrar solo palet excedentes"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_rpt_palet_entransito
int X=631
int Y=440
int Width=599
int Height=80
int TabOrder=50
boolean BringToTop=true
string DataObject="d_arch_crucex"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event itemchanged;//If cbx_1 = true Then
//	dw_1.object.
end event

type rb_2 from radiobutton within w_rpt_palet_entransito
int X=114
int Y=852
int Width=608
int Height=80
boolean BringToTop=true
string Text="Mostrar todos los palets"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_ini from uo_editmask within w_rpt_palet_entransito
int X=329
int Y=220
int TabOrder=40
end type

event getfocus;//rb_2.Checked = True
//cb_buscar.Default = True
//cb_aceptar.Default = False
end event

type st_3 from statictext within w_rpt_palet_entransito
int X=210
int Y=220
int Width=123
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Del:"
Alignment Alignment=Center!
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

type st_4 from statictext within w_rpt_palet_entransito
int X=786
int Y=228
int Width=78
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Al:"
Alignment Alignment=Center!
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

type em_fin from uo_editmask within w_rpt_palet_entransito
int X=864
int Y=220
int TabOrder=20
end type

event getfocus;//rb_2.Checked = True
//cb_buscar.Default = True
//cb_aceptar.Default = False
end event

type cb_5 from uo_cbdate within w_rpt_palet_entransito
int X=677
int Y=220
int TabOrder=30
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type cb_6 from uo_cbdate within w_rpt_palet_entransito
int X=1202
int Y=220
int TabOrder=40
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

