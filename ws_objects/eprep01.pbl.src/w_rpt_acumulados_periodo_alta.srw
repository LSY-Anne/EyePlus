$PBExportHeader$w_rpt_acumulados_periodo_alta.srw
forward
global type w_rpt_acumulados_periodo_alta from wa_response
end type
type p_1 from picture within w_rpt_acumulados_periodo_alta
end type
type st_mess from statictext within w_rpt_acumulados_periodo_alta
end type
type em_ini from uo_editmask within w_rpt_acumulados_periodo_alta
end type
type cb_5 from uo_cbdate within w_rpt_acumulados_periodo_alta
end type
type st_2 from statictext within w_rpt_acumulados_periodo_alta
end type
type em_fin from uo_editmask within w_rpt_acumulados_periodo_alta
end type
type cb_fin from uo_cbdate within w_rpt_acumulados_periodo_alta
end type
type st_1 from statictext within w_rpt_acumulados_periodo_alta
end type
type sle_1 from singlelineedit within w_rpt_acumulados_periodo_alta
end type
type sle_2 from singlelineedit within w_rpt_acumulados_periodo_alta
end type
type sle_3 from singlelineedit within w_rpt_acumulados_periodo_alta
end type
type sle_4 from singlelineedit within w_rpt_acumulados_periodo_alta
end type
type cb_pro1 from commandbutton within w_rpt_acumulados_periodo_alta
end type
type cb_pro2 from commandbutton within w_rpt_acumulados_periodo_alta
end type
type sle_cul1 from singlelineedit within w_rpt_acumulados_periodo_alta
end type
type sle_cul2 from singlelineedit within w_rpt_acumulados_periodo_alta
end type
type st_cul from statictext within w_rpt_acumulados_periodo_alta
end type
type cb_procul1 from commandbutton within w_rpt_acumulados_periodo_alta
end type
type cb_procul2 from commandbutton within w_rpt_acumulados_periodo_alta
end type
type sle_nomcul1 from singlelineedit within w_rpt_acumulados_periodo_alta
end type
type sle_nomcul2 from singlelineedit within w_rpt_acumulados_periodo_alta
end type
type dw_2 from datawindow within w_rpt_acumulados_periodo_alta
end type
type st_3 from statictext within w_rpt_acumulados_periodo_alta
end type
type st_4 from statictext within w_rpt_acumulados_periodo_alta
end type
type st_5 from statictext within w_rpt_acumulados_periodo_alta
end type
type st_cul2 from statictext within w_rpt_acumulados_periodo_alta
end type
end forward

global type w_rpt_acumulados_periodo_alta from wa_response
int Width=1499
int Height=1188
long BackColor=80269524
p_1 p_1
st_mess st_mess
em_ini em_ini
cb_5 cb_5
st_2 st_2
em_fin em_fin
cb_fin cb_fin
st_1 st_1
sle_1 sle_1
sle_2 sle_2
sle_3 sle_3
sle_4 sle_4
cb_pro1 cb_pro1
cb_pro2 cb_pro2
sle_cul1 sle_cul1
sle_cul2 sle_cul2
st_cul st_cul
cb_procul1 cb_procul1
cb_procul2 cb_procul2
sle_nomcul1 sle_nomcul1
sle_nomcul2 sle_nomcul2
dw_2 dw_2
st_3 st_3
st_4 st_4
st_5 st_5
st_cul2 st_cul2
end type
global w_rpt_acumulados_periodo_alta w_rpt_acumulados_periodo_alta

type variables
String	is_rpt
end variables

forward prototypes
public function integer wf_buscapro (string as_cod)
public function integer wf_buscapro2 (string as_cod)
public function integer wf_buscacul (string as_cod)
public function integer wf_buscacul2 (string as_cod)
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

public function integer wf_buscapro2 (string as_cod);String ls_pro,ls_nompro,ls_parm,ls_act
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

public function integer wf_buscacul (string as_cod);String ls_cul,ls_nomcul,ls_parm,ls_act
as_cod = f_Trim( as_cod )

If as_cod = '' Then
	 
	 OpenWithParm( w_mant_buscar_x_nombre, 'CUL' )
	 ls_parm = Message.StringParm 
	 ls_parm = f_Trim( ls_parm )
	 
	 If Not ls_parm = '' Then
	 	
		 as_cod = ls_parm
	 	 ls_cul = as_cod
	 
	 End If

else
	
	 Select c_codigo_cul,c_activo_cul
	 Into  :ls_cul,:ls_act
	 From  t_cultivo
	 Where  c_codigo_cul = :as_cod
	 Using  SqlCa ;
	
	 If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_cultivo.' ) = -1 Then
	 	Return 0
	 end if
	 if (f_trim(ls_act) <> '1') then
	 	messagebox(title,'Cultivo no encontrado',exclamation!)
		return 0

	Else	 
		If (f_trim(ls_cul) = '') then
			messagebox(title, 'Cultivo no especificado', Exclamation!)
			return 0
		end if
		
	end if	
End if

sle_cul1.text=string(ls_cul)

Select v_nombre_cul
Into  :ls_nomcul
From  t_cultivo
Where  c_codigo_cul = :ls_cul
Using  SqlCa ;

If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_cultivo.' ) = -1 Then
Return 0
End if

sle_nomcul1.text = string(ls_nomcul)




Return 1
end function

public function integer wf_buscacul2 (string as_cod);String ls_cul,ls_nomcul,ls_parm,ls_act
as_cod = f_Trim( as_cod )

If as_cod = '' Then
	 
	 OpenWithParm( w_mant_buscar_x_nombre, 'CUL' )
	 ls_parm = Message.StringParm 
	 ls_parm = f_Trim( ls_parm )
	 
	 If Not ls_parm = '' Then
	 	
		 as_cod = ls_parm
	 	 ls_cul = as_cod
	 
	 End If

else
	
	 Select c_codigo_cul,c_activo_cul
	 Into  :ls_cul,:ls_act
	 From  t_cultivo
	 Where  c_codigo_cul = :as_cod
	 Using  SqlCa ;
	
	 If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_cultivo.' ) = -1 Then
	 	Return 0
	 end if
	 if (f_trim(ls_act) <> '1') then
	 	messagebox(title,'Cultivo no encontrado',exclamation!)
		return 0

	Else	 
		If (f_trim(ls_cul) = '') then
			messagebox(title, 'Cultivo no especificado', Exclamation!)
			return 0
		end if
		
	end if	
End if

sle_cul2.text=string(ls_cul)

Select v_nombre_cul
Into  :ls_nomcul
From  t_cultivo
Where  c_codigo_cul = :ls_cul
Using  SqlCa ;

If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_cultivo.' ) = -1 Then
Return 0
End if

sle_nomcul2.text = string(ls_nomcul)




Return 1
end function

event open;call super::open;Datetime ld_hoy
DataWindowChild ldwc_x
Long ll_row

dw_list.Visible = False
dw_1.visible = False
dw_2.visible = true

//Choose Case is_rpt
	//Case 'ACT'
		Title = 'Acumulado General por Periodo'	
	//End Choose
	
em_ini.Text = String( gd_sys, 'dd/mm/yyyy' )
em_fin.Text = String( gd_sys, 'dd/mm/yyyy' )

dw_2.settransobject(sqlca)
dw_2.insertrow(0)
dw_2.GetChild('v_nombre_lit', ldwc_x)
ll_row=ldwc_x.InsertRow(0)
ldwc_x.SetItem(ll_row, 'c_codigo_lit', '%')
ldwc_x.SetItem(ll_row, 'v_nombre_lit', 'TODOS')
dw_2.object.v_nombre_lit[1]='TODOS'

is_rpt = Message.StringParm
end event

on w_rpt_acumulados_periodo_alta.create
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
this.sle_1=create sle_1
this.sle_2=create sle_2
this.sle_3=create sle_3
this.sle_4=create sle_4
this.cb_pro1=create cb_pro1
this.cb_pro2=create cb_pro2
this.sle_cul1=create sle_cul1
this.sle_cul2=create sle_cul2
this.st_cul=create st_cul
this.cb_procul1=create cb_procul1
this.cb_procul2=create cb_procul2
this.sle_nomcul1=create sle_nomcul1
this.sle_nomcul2=create sle_nomcul2
this.dw_2=create dw_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_cul2=create st_cul2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_mess
this.Control[iCurrent+3]=this.em_ini
this.Control[iCurrent+4]=this.cb_5
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_fin
this.Control[iCurrent+7]=this.cb_fin
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.sle_1
this.Control[iCurrent+10]=this.sle_2
this.Control[iCurrent+11]=this.sle_3
this.Control[iCurrent+12]=this.sle_4
this.Control[iCurrent+13]=this.cb_pro1
this.Control[iCurrent+14]=this.cb_pro2
this.Control[iCurrent+15]=this.sle_cul1
this.Control[iCurrent+16]=this.sle_cul2
this.Control[iCurrent+17]=this.st_cul
this.Control[iCurrent+18]=this.cb_procul1
this.Control[iCurrent+19]=this.cb_procul2
this.Control[iCurrent+20]=this.sle_nomcul1
this.Control[iCurrent+21]=this.sle_nomcul2
this.Control[iCurrent+22]=this.dw_2
this.Control[iCurrent+23]=this.st_3
this.Control[iCurrent+24]=this.st_4
this.Control[iCurrent+25]=this.st_5
this.Control[iCurrent+26]=this.st_cul2
end on

on w_rpt_acumulados_periodo_alta.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_mess)
destroy(this.em_ini)
destroy(this.cb_5)
destroy(this.st_2)
destroy(this.em_fin)
destroy(this.cb_fin)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.sle_3)
destroy(this.sle_4)
destroy(this.cb_pro1)
destroy(this.cb_pro2)
destroy(this.sle_cul1)
destroy(this.sle_cul2)
destroy(this.st_cul)
destroy(this.cb_procul1)
destroy(this.cb_procul2)
destroy(this.sle_nomcul1)
destroy(this.sle_nomcul2)
destroy(this.dw_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_cul2)
end on

type dw_list from wa_response`dw_list within w_rpt_acumulados_periodo_alta
int X=5
int Y=124
int Width=73
int Height=76
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean VScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_acumulados_periodo_alta
int X=5
int Y=208
int Width=73
int Height=80
int TabOrder=30
boolean LiveScroll=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_acumulados_periodo_alta
int X=727
int Y=960
int TabOrder=110
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_acumulados_periodo_alta
int X=357
int Y=960
int TabOrder=100
boolean Enabled=true
end type

event cb_aceptar::clicked;String ls_cul1, ls_cul2, ls_pro1, ls_pro2, ls_dt, ls_lt, ls_ini, ls_fin, ls_dis, ls_lit, ls_rep
Long ll_rows
Datetime ld_ini, ld_fin

SetPointer( HourGlass! )

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

ls_cul1= f_trim(sle_cul1.text)
ls_cul2= f_trim(sle_cul2.text)

If (f_trim(ls_cul1)='') and (f_trim(ls_cul2)='')  Then
	select min(c_codigo_cul)
	into  :ls_cul1
	from   t_cultivo (nolock)
	Using  Sqlca;
	If f_sqlerror(sqlca,'No se pudo obtener informacion de la tabla t_distribuidor')= -1 Then
		Rollback Using SqlCa;
		return 2		
	End if
	
	select max(c_codigo_cul)
	into  :ls_cul2
	from   t_cultivo (nolock)
	Using  Sqlca;
	If f_sqlerror(sqlca,'Nose pudo obtener informacion de la tabla t_distribuidor')= -1 Then
		Rollback Using SqlCa;
		return 2		
	End if
End If

If (f_trim(ls_cul1)='') or (f_trim(ls_cul2)='')  Then
	Messagebox(title,' determine el otro valor para el rango de cultivos',exclamation!)
	return 2
End If

if long(ls_cul1) > long(ls_cul2) then
	Messagebox(title, 'El cultivo inicial no debe ser mayor que el cultivo final',Exclamation!)
	return 2	
End if

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

ls_lt = f_trim(dw_2.object.v_nombre_lit[1])
		
If Len(ls_lt) = 2 Then
	Select  Isnull(v_nombre_lit, ' sin especificar ')
	Into    :ls_lit
	From   t_linea_transporte (NOLOCK)
	Where c_codigo_lit = :ls_lt
	Using  SqlCa;
			
	If f_sqlerror(sqlca,'No se pudo obtener informacion de la tabla t_linea_transporte')= -1 Then
		Rollback Using Sqlca;
		return 2		
	End if
			
Else
			
	Select  Isnull(c_codigo_lit, ' sin especificar ')
	Into    :ls_lit
	From   t_linea_transporte (NOLOCK)
	Where v_nombre_lit = :ls_lt
	Using  SqlCa;
			
	If f_sqlerror(sqlca,'Nose pudo obtener informacion de la tabla t_linea_transporte')= -1 Then
		Rollback Using Sqlca;
		return 2		
	End if
	
End if

		If f_trim(ls_lit) = '' Then
			ls_lt = '%'
		End If
		
		dw_list.DataObject = 'd_rpt_acumulado_gral_x_periodo_lt_alta'	
		dw_list.settransobject(sqlca)
		ll_rows = dw_list.Retrieve(gs_codtem, ld_ini, ld_fin, ls_cul1, ls_cul2, ls_pro1, ls_pro2, ls_lt)
		f_Preview(dw_list)
		Return ll_rows
		
SetPointer( Arrow! )
end event

type p_1 from picture within w_rpt_acumulados_periodo_alta
int X=5
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_mess from statictext within w_rpt_acumulados_periodo_alta
int X=155
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

type em_ini from uo_editmask within w_rpt_acumulados_periodo_alta
int X=174
int Y=280
int Height=80
int TabOrder=60
end type

type cb_5 from uo_cbdate within w_rpt_acumulados_periodo_alta
int X=521
int Y=284
int Width=96
int Height=68
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_2 from statictext within w_rpt_acumulados_periodo_alta
int X=869
int Y=284
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

type em_fin from uo_editmask within w_rpt_acumulados_periodo_alta
int X=946
int Y=280
int Height=80
int TabOrder=70
end type

type cb_fin from uo_cbdate within w_rpt_acumulados_periodo_alta
int X=1289
int Y=284
int Width=96
int Height=68
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type st_1 from statictext within w_rpt_acumulados_periodo_alta
int X=78
int Y=280
int Width=96
int Height=60
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

type sle_1 from singlelineedit within w_rpt_acumulados_periodo_alta
int X=82
int Y=716
int Width=192
int Height=76
int TabOrder=10
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

type sle_2 from singlelineedit within w_rpt_acumulados_periodo_alta
int X=82
int Y=856
int Width=192
int Height=76
int TabOrder=20
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

ls_cod= f_trim(sle_2.text)

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
		sle_2.text = ''
		sle_4.text = ''
		
	Else
		sle_2.text = ls_cod
		sle_4.text = ls_pro
				
	End If

else

 	wf_buscapro2('%')

end if
end event

type sle_3 from singlelineedit within w_rpt_acumulados_periodo_alta
int X=421
int Y=720
int Width=965
int Height=76
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

type sle_4 from singlelineedit within w_rpt_acumulados_periodo_alta
int X=421
int Y=856
int Width=965
int Height=76
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

type cb_pro1 from commandbutton within w_rpt_acumulados_periodo_alta
int X=302
int Y=716
int Width=91
int Height=68
boolean BringToTop=true
string Text="..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_buscapro('')
end event

type cb_pro2 from commandbutton within w_rpt_acumulados_periodo_alta
int X=302
int Y=856
int Width=91
int Height=68
boolean BringToTop=true
string Text="..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_buscapro2('')
end event

type sle_cul1 from singlelineedit within w_rpt_acumulados_periodo_alta
int X=82
int Y=424
int Width=192
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

event modified;string ls_cod, ls_cul

ls_cod= f_trim(sle_cul1.text)

if ls_cod <> '' then
	
	select v_nombre_cul
	into :ls_cul
	From t_cultivo
	where c_codigo_cul = :ls_cod
	and c_activo_cul = '1'
	Using sqlca;
	
	if f_sqlerror(sqlca,'No se pudo obtener informacion de la tabla t_cultivo')= -1 Then
		return 2
	End if
 
 	If f_trim(ls_cul) = '' then
		
		MessageBox(title,'Codigo invalido',Exclamation!)
		sle_cul1.text = ''
		sle_nomcul1.text = ''
		
	Else
		sle_cul1.text = ls_cod
		sle_nomcul1.text = ls_cul
				
	End If

else

 	wf_buscacul('%')

end if
end event

type sle_cul2 from singlelineedit within w_rpt_acumulados_periodo_alta
int X=82
int Y=572
int Width=192
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

event modified;string ls_cod, ls_cul

ls_cod= f_trim(sle_cul2.text)

if ls_cod <> '' then
	
	select v_nombre_cul
	into :ls_cul
	From t_cultivo
	where c_codigo_cul = :ls_cod
	and c_activo_cul = '1'
	Using sqlca;
	
	if f_sqlerror(sqlca,'No se pudo obtener informacion de la tabla t_cultivo')= -1 Then
		return 2
	End if
 
 	If f_trim(ls_cul) = '' then
		
		MessageBox(title,'Codigo invalido',Exclamation!)
		sle_cul2.text = ''
		sle_nomcul2.text = ''
		
	Else
		sle_cul2.text = ls_cod
		sle_nomcul2.text = ls_cul
				
	End If

else

 	wf_buscacul2('%')

end if
end event

type st_cul from statictext within w_rpt_acumulados_periodo_alta
int X=78
int Y=364
int Width=293
int Height=64
boolean Enabled=false
string Text="Cultivo Inicial"
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

type cb_procul1 from commandbutton within w_rpt_acumulados_periodo_alta
int X=302
int Y=428
int Width=96
int Height=68
boolean BringToTop=true
string Text="..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_buscacul('')
end event

type cb_procul2 from commandbutton within w_rpt_acumulados_periodo_alta
int X=302
int Y=576
int Width=96
int Height=68
boolean BringToTop=true
string Text="..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_buscacul2('')
end event

type sle_nomcul1 from singlelineedit within w_rpt_acumulados_periodo_alta
int X=421
int Y=424
int Width=965
int Height=76
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

type sle_nomcul2 from singlelineedit within w_rpt_acumulados_periodo_alta
int X=421
int Y=572
int Width=965
int Height=76
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

type dw_2 from datawindow within w_rpt_acumulados_periodo_alta
int X=82
int Y=192
int Width=1303
int Height=72
int TabOrder=50
boolean BringToTop=true
string DataObject="d_rpt_linea_trans"
boolean Border=false
boolean LiveScroll=true
end type

type st_3 from statictext within w_rpt_acumulados_periodo_alta
int X=78
int Y=120
int Width=471
int Height=56
boolean Enabled=false
boolean BringToTop=true
string Text=" Linea de Transporte "
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

type st_4 from statictext within w_rpt_acumulados_periodo_alta
int X=78
int Y=652
int Width=361
int Height=56
boolean Enabled=false
boolean BringToTop=true
string Text="Producto Inicial"
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

type st_5 from statictext within w_rpt_acumulados_periodo_alta
int X=78
int Y=796
int Width=334
int Height=52
boolean Enabled=false
boolean BringToTop=true
string Text="Producto Final"
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

type st_cul2 from statictext within w_rpt_acumulados_periodo_alta
int X=78
int Y=504
int Width=293
int Height=64
boolean Enabled=false
string Text="Cultivo Final"
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

