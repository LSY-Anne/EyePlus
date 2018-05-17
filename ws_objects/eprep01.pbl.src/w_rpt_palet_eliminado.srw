$PBExportHeader$w_rpt_palet_eliminado.srw
forward
global type w_rpt_palet_eliminado from wa_response
end type
type p_1 from picture within w_rpt_palet_eliminado
end type
type st_mess from statictext within w_rpt_palet_eliminado
end type
type em_ini from uo_editmask within w_rpt_palet_eliminado
end type
type cb_5 from uo_cbdate within w_rpt_palet_eliminado
end type
type st_2 from statictext within w_rpt_palet_eliminado
end type
type em_fin from uo_editmask within w_rpt_palet_eliminado
end type
type cb_fin from uo_cbdate within w_rpt_palet_eliminado
end type
type st_1 from statictext within w_rpt_palet_eliminado
end type
type st_3 from statictext within w_rpt_palet_eliminado
end type
type st_4 from statictext within w_rpt_palet_eliminado
end type
type st_5 from statictext within w_rpt_palet_eliminado
end type
type st_6 from statictext within w_rpt_palet_eliminado
end type
type st_7 from statictext within w_rpt_palet_eliminado
end type
type st_8 from statictext within w_rpt_palet_eliminado
end type
type st_9 from statictext within w_rpt_palet_eliminado
end type
type em_inipa from uo_editmask within w_rpt_palet_eliminado
end type
type em_finpa from uo_editmask within w_rpt_palet_eliminado
end type
type cb_inipa from uo_cbdate within w_rpt_palet_eliminado
end type
type cb_finpa from uo_cbdate within w_rpt_palet_eliminado
end type
type cb_pro1 from uo_cbdate within w_rpt_palet_eliminado
end type
type cb_pro2 from uo_cbdate within w_rpt_palet_eliminado
end type
type sle_1 from singlelineedit within w_rpt_palet_eliminado
end type
type sle_2 from singlelineedit within w_rpt_palet_eliminado
end type
type sle_3 from singlelineedit within w_rpt_palet_eliminado
end type
type sle_4 from singlelineedit within w_rpt_palet_eliminado
end type
end forward

global type w_rpt_palet_eliminado from wa_response
int Width=1824
int Height=1080
long BackColor=80269524
p_1 p_1
st_mess st_mess
em_ini em_ini
cb_5 cb_5
st_2 st_2
em_fin em_fin
cb_fin cb_fin
st_1 st_1
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
st_9 st_9
em_inipa em_inipa
em_finpa em_finpa
cb_inipa cb_inipa
cb_finpa cb_finpa
cb_pro1 cb_pro1
cb_pro2 cb_pro2
sle_1 sle_1
sle_2 sle_2
sle_3 sle_3
sle_4 sle_4
end type
global w_rpt_palet_eliminado w_rpt_palet_eliminado

type variables
String	is_rpt
end variables

forward prototypes
public function integer wf_buscapro (string as_cod)
public function integer wf_buscarpro2 (string as_cod)
end prototypes

public function integer wf_buscapro (string as_cod);String ls_pro,ls_nompro,ls_parm,ls_act
as_cod = f_Trim( as_cod )

If as_cod = '' Then
	 
	 OpenWithParm( w_mant_buscar_x_nombre, 'PRO' )
	 ls_parm = Message.StringParm 
	 ls_parm = f_Trim( ls_parm )
	 
	 If Not ls_parm = '' Then
	 	
		 as_cod = ls_parm
	 	 ls_pro = as_cod
	 
	 End If

else
	
	 Select c_codigo_pro,c_activo_pro
	 Into  :ls_pro,:ls_act
	 From  t_producto
	 Where  c_codigo_pro = :as_cod
	 Using  SqlCa ;
	
	 If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_producto.' ) = -1 Then
	 	Return 0
	 end if
	 if (f_trim(ls_act) <> '1') then
	 	messagebox(title,'Producto no encontrado',exclamation!)
		return 0

	Else	 
		If (f_trim(ls_pro) = '') then
			messagebox(title, 'Producto no especificado', Exclamation!)
			return 0
		end if
		
	end if	
End if

sle_1.text=string(ls_pro)

Select v_nombre_pro
Into  :ls_nompro
From  t_producto
Where  c_codigo_pro = :ls_pro
Using  SqlCa ;

If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_producto.' ) = -1 Then
Return 0
End if

sle_3.text = string(ls_nompro)




Return 1
end function

public function integer wf_buscarpro2 (string as_cod);String ls_pro,ls_nompro,ls_parm,ls_act
as_cod = f_Trim( as_cod )

If as_cod = '' Then
	 
	 OpenWithParm( w_mant_buscar_x_nombre, 'PRO' )
	 ls_parm = Message.StringParm 
	 ls_parm = f_Trim( ls_parm )
	 
	 If Not ls_parm = '' Then
	 	
		 as_cod = ls_parm
	 	 ls_pro = as_cod
	 
	 End If

else
	
	 Select c_codigo_pro,c_activo_pro
	 Into  :ls_pro,:ls_act
	 From  t_producto
	 Where  c_codigo_pro = :as_cod
	 Using  SqlCa ;
	
	 If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_producto.' ) = -1 Then
	 	Return 0
	 end if
	 if (f_trim(ls_act) <> '1') then
	 	messagebox(title,'Producto no encontrado',exclamation!)
		return 0

	Else	 
		If (f_trim(ls_pro) = '') then
			messagebox(title, 'Producto no especificado', Exclamation!)
			return 0
		end if
		
	end if	
End if

sle_2.text=string(ls_pro)

Select v_nombre_pro
Into  :ls_nompro
From  t_producto
Where  c_codigo_pro = :ls_pro
Using  SqlCa ;

If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_producto.' ) = -1 Then
Return 0
End if

sle_4.text = string(ls_nompro)




Return 1
end function

event open;call super::open;string ls_hoy
is_rpt = Message.StringParm

ls_hoy=string(today())
Title = 'Palet Eliminados'
		
dw_1.InsertRow(0)
dw_list.Visible = False

em_ini.Text = f_GetParmValue( '20' )
em_fin.Text = ls_hoy

em_inipa.Text = f_GetParmValue( '20' )
em_finpa.Text = ls_hoy


end event

on w_rpt_palet_eliminado.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_mess=create st_mess
this.em_ini=create em_ini
this.cb_5=create cb_5
this.st_2=create st_2
this.em_fin=create em_fin
this.cb_fin=create cb_fin
this.st_1=create st_1
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.em_inipa=create em_inipa
this.em_finpa=create em_finpa
this.cb_inipa=create cb_inipa
this.cb_finpa=create cb_finpa
this.cb_pro1=create cb_pro1
this.cb_pro2=create cb_pro2
this.sle_1=create sle_1
this.sle_2=create sle_2
this.sle_3=create sle_3
this.sle_4=create sle_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_mess
this.Control[iCurrent+3]=this.em_ini
this.Control[iCurrent+4]=this.cb_5
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_fin
this.Control[iCurrent+7]=this.cb_fin
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.st_6
this.Control[iCurrent+13]=this.st_7
this.Control[iCurrent+14]=this.st_8
this.Control[iCurrent+15]=this.st_9
this.Control[iCurrent+16]=this.em_inipa
this.Control[iCurrent+17]=this.em_finpa
this.Control[iCurrent+18]=this.cb_inipa
this.Control[iCurrent+19]=this.cb_finpa
this.Control[iCurrent+20]=this.cb_pro1
this.Control[iCurrent+21]=this.cb_pro2
this.Control[iCurrent+22]=this.sle_1
this.Control[iCurrent+23]=this.sle_2
this.Control[iCurrent+24]=this.sle_3
this.Control[iCurrent+25]=this.sle_4
end on

on w_rpt_palet_eliminado.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_mess)
destroy(this.em_ini)
destroy(this.cb_5)
destroy(this.st_2)
destroy(this.em_fin)
destroy(this.cb_fin)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.em_inipa)
destroy(this.em_finpa)
destroy(this.cb_inipa)
destroy(this.cb_finpa)
destroy(this.cb_pro1)
destroy(this.cb_pro2)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.sle_3)
destroy(this.sle_4)
end on

type dw_list from wa_response`dw_list within w_rpt_palet_eliminado
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

type dw_1 from wa_response`dw_1 within w_rpt_palet_eliminado
int Y=184
int Width=1673
int Height=96
string DataObject="d_rpt_palet_eliminado"
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_palet_eliminado
int X=887
int Y=860
int TabOrder=140
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_palet_eliminado
int X=507
int Y=860
int TabOrder=130
boolean Enabled=true
end type

event cb_aceptar::clicked;String ls_cul1, ls_cul2, ls_pro1, ls_pro2, ls_dt, ls_lt, ls_ini, ls_fin, ls_dis, ls_lit, ls_rep, ls_mot, ls_inipa, ls_finpa
Long ll_rows
Datetime ld_ini, ld_fin, ld_inipa, ld_finpa

SetPointer( HourGlass! )

// Validar el motivo de eliminación
ls_mot = f_trim(dw_1.object.c_motivo_pal[1])
If f_trim(ls_mot) = '' Then
			ls_mot = '%'
End If

//Validar las fechas de eliminación
ls_ini = f_trim(em_ini.text)
ls_fin = f_trim(em_fin.text)
		
If (ls_ini = '00/00/0000') or (ls_ini = '') Then
	MessageBox(title,' La fecha inicial no debe permanecer sin datos ',Exclamation!)
	return 2
End If

If (ls_fin = '00/00/0000') or (ls_fin = '') Then
	MessageBox(title,' La fecha final no debe permanecer sin datos ',Exclamation!)
	return 2
End if	
		
ld_ini = f_StringToDate(em_ini.Text)
ld_fin = f_StringToDate(em_fin.Text)

If ld_ini>ld_fin then
	Messagebox(title,' La fecha final debe ser mayor  o igual que la fecha inicial',exclamation!)
	return 2
End If

//Validar las fechas de elaboración de palet
ls_inipa = f_trim(em_inipa.text)
ls_finpa = f_trim(em_finpa.text)
		
If (ls_inipa = '00/00/0000') or (ls_inipa = '') Then
	MessageBox(title,' La fecha inicial no debe permanecer sin datos ',Exclamation!)
	return 2
End If

If (ls_finpa = '00/00/0000') or (ls_finpa = '') Then
	MessageBox(title,' La fecha final no debe permanecer sin datos ',Exclamation!)
	return 2
End if	
		
ld_inipa = f_StringToDate(em_inipa.Text)
ld_finpa = f_StringToDate(em_finpa.Text)

If ld_inipa>ld_finpa then
	Messagebox(title,' La fecha final debe ser mayor  o igual que la fecha inicial',exclamation!)
	return 2
End If

// Validar los productos
ls_pro1 = f_trim(sle_1.text)
ls_pro2 = f_trim(sle_2.text)
	
If (f_trim(ls_pro1)='') and (f_trim(ls_pro2)='')  Then
	select min(c_codigo_pro)
	into  :ls_pro1
	from   t_producto (nolock)
	Using  Sqlca;

	If f_sqlerror(sqlca,'No se pudo obtener informacion de la tabla t_producto')= -1 Then
		Rollback Using SqlCa;
		return 2		
	End if
	
	select max(c_codigo_pro)
	into  :ls_pro2
	from   t_producto (nolock)
	Using  Sqlca;

	If f_sqlerror(sqlca,'Nose pudo obtener informacion de la tabla t_producto')= -1 Then
		Rollback Using SqlCa;
   	return 2		
	End if
End If

If (f_trim(ls_pro1)='') or (f_trim(ls_pro2)='')  Then
Messagebox(title,' Determine el otro valor para el rango de productos',exclamation!)
	return 2
End If

if long(ls_pro1) > long(ls_pro2) then
	Messagebox(title, 'El producto inicial no debe ser mayor que el producto final',Exclamation!)
	return 0	
End if


//Mandar al reporte
	dw_list.DataObject = 'd_rpt_pallet_eliminados'	
		dw_list.settransobject(sqlca)
		ll_rows = dw_list.Retrieve(gs_codtem, ld_ini, ld_fin, ld_inipa, ld_finpa, ls_pro1, ls_pro2, ls_mot)
		f_Preview(dw_list)
		Return ll_rows

end event

type p_1 from picture within w_rpt_palet_eliminado
int X=37
int Y=32
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_mess from statictext within w_rpt_palet_eliminado
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

type em_ini from uo_editmask within w_rpt_palet_eliminado
int X=741
int Y=328
int TabOrder=20
end type

type cb_5 from uo_cbdate within w_rpt_palet_eliminado
int X=1088
int Y=328
int TabOrder=0
int Weight=700
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_2 from statictext within w_rpt_palet_eliminado
int X=1230
int Y=328
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

type em_fin from uo_editmask within w_rpt_palet_eliminado
int X=1303
int Y=328
int TabOrder=30
end type

type cb_fin from uo_cbdate within w_rpt_palet_eliminado
int X=1637
int Y=328
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type st_1 from statictext within w_rpt_palet_eliminado
int X=622
int Y=328
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

type st_3 from statictext within w_rpt_palet_eliminado
int X=64
int Y=328
int Width=485
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Fecha de eliminación:"
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

type st_4 from statictext within w_rpt_palet_eliminado
int X=64
int Y=456
int Width=439
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Fecha de Palet:"
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

type st_5 from statictext within w_rpt_palet_eliminado
int X=622
int Y=456
int Width=105
int Height=80
boolean Enabled=false
boolean BringToTop=true
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

type st_6 from statictext within w_rpt_palet_eliminado
int X=1230
int Y=456
int Width=73
int Height=80
boolean Enabled=false
boolean BringToTop=true
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

type st_7 from statictext within w_rpt_palet_eliminado
int X=64
int Y=584
int Width=439
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Producto:"
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

type st_8 from statictext within w_rpt_palet_eliminado
int X=622
int Y=584
int Width=128
int Height=80
boolean Enabled=false
boolean BringToTop=true
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

type st_9 from statictext within w_rpt_palet_eliminado
int X=626
int Y=672
int Width=105
int Height=80
boolean Enabled=false
boolean BringToTop=true
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

type em_inipa from uo_editmask within w_rpt_palet_eliminado
int X=741
int Y=444
int TabOrder=120
end type

type em_finpa from uo_editmask within w_rpt_palet_eliminado
int X=1303
int Y=440
int TabOrder=110
end type

type cb_inipa from uo_cbdate within w_rpt_palet_eliminado
int X=1088
int Y=452
int TabOrder=40
int Weight=700
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type cb_finpa from uo_cbdate within w_rpt_palet_eliminado
int X=1637
int Y=440
int TabOrder=50
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type cb_pro1 from uo_cbdate within w_rpt_palet_eliminado
int X=997
int Y=568
int TabOrder=60
int Weight=700
end type

event clicked;wf_buscapro('')
end event

type cb_pro2 from uo_cbdate within w_rpt_palet_eliminado
int X=997
int Y=672
int TabOrder=70
int Weight=700
end type

event clicked;wf_buscarpro2('')
end event

type sle_1 from singlelineedit within w_rpt_palet_eliminado
int X=736
int Y=568
int Width=247
int Height=76
int TabOrder=100
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;string ls_cod, ls_pro

ls_cod= f_trim(sle_1.text)

if ls_cod <> '' then
	
	select v_nombre_pro
	into :ls_pro
	From t_producto
	where c_codigo_pro = :ls_cod
	and c_activo_pro = '1'
	Using sqlca;
	
	if f_sqlerror(sqlca,'No se pudo obtener informacion de la tabla t_producto')= -1 Then
		return 2
	End if
 
 	If f_trim(ls_pro) = '' then
		
		MessageBox(title,'Codigo invalido',Exclamation!)
		sle_1.text = ''
		sle_3.text = ''
		
	Else
		sle_1.text = ls_cod
		sle_3.text = ls_pro
				
	End If

else

 	wf_buscapro('%')

end if
end event

type sle_2 from singlelineedit within w_rpt_palet_eliminado
int X=736
int Y=676
int Width=247
int Height=76
int TabOrder=90
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;string ls_cod, ls_pro

ls_cod= f_trim(sle_1.text)

if ls_cod <> '' then
	
	select v_nombre_pro
	into :ls_pro
	From t_producto
	where c_codigo_pro = :ls_cod
	and c_activo_pro = '1'
	Using sqlca;
	
	if f_sqlerror(sqlca,'No se pudo obtener informacion de la tabla t_producto')= -1 Then
		return 2
	End if
 
 	If f_trim(ls_pro) = '' then
		
		MessageBox(title,'Codigo invalido',Exclamation!)
		sle_1.text = ''
		sle_3.text = ''
		
	Else
		sle_1.text = ls_cod
		sle_3.text = ls_pro
				
	End If

else

 	wf_buscapro('%')

end if
end event

type sle_3 from singlelineedit within w_rpt_palet_eliminado
int X=1106
int Y=568
int Width=617
int Height=76
int TabOrder=80
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;string ls_cod, ls_pro

ls_cod= f_trim(sle_1.text)

if ls_cod <> '' then
	
	select v_nombre_pro
	into :ls_pro
	From t_producto
	where c_codigo_pro = :ls_cod
	and c_activo_pro = '1'
	Using sqlca;
	
	if f_sqlerror(sqlca,'No se pudo obtener informacion de la tabla t_producto')= -1 Then
		return 2
	End if
 
 	If f_trim(ls_pro) = '' then
		
		MessageBox(title,'Codigo invalido',Exclamation!)
		sle_1.text = ''
		sle_3.text = ''
		
	Else
		sle_1.text = ls_cod
		sle_3.text = ls_pro
				
	End If

else

 	wf_buscapro('%')

end if
end event

type sle_4 from singlelineedit within w_rpt_palet_eliminado
int X=1106
int Y=676
int Width=617
int Height=76
int TabOrder=90
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;string ls_cod, ls_pro

ls_cod= f_trim(sle_1.text)

if ls_cod <> '' then
	
	select v_nombre_pro
	into :ls_pro
	From t_producto
	where c_codigo_pro = :ls_cod
	and c_activo_pro = '1'
	Using sqlca;
	
	if f_sqlerror(sqlca,'No se pudo obtener informacion de la tabla t_producto')= -1 Then
		return 2
	End if
 
 	If f_trim(ls_pro) = '' then
		
		MessageBox(title,'Codigo invalido',Exclamation!)
		sle_1.text = ''
		sle_3.text = ''
		
	Else
		sle_1.text = ls_cod
		sle_3.text = ls_pro
				
	End If

else

 	wf_buscapro('%')

end if
end event

