$PBExportHeader$w_rpt_embarques_cultivo.srw
forward
global type w_rpt_embarques_cultivo from wa_response
end type
type p_1 from picture within w_rpt_embarques_cultivo
end type
type st_mess from statictext within w_rpt_embarques_cultivo
end type
type em_ini from uo_editmask within w_rpt_embarques_cultivo
end type
type cb_5 from uo_cbdate within w_rpt_embarques_cultivo
end type
type st_2 from statictext within w_rpt_embarques_cultivo
end type
type em_fin from uo_editmask within w_rpt_embarques_cultivo
end type
type cb_fin from uo_cbdate within w_rpt_embarques_cultivo
end type
type st_1 from statictext within w_rpt_embarques_cultivo
end type
type st_3 from statictext within w_rpt_embarques_cultivo
end type
type st_5 from statictext within w_rpt_embarques_cultivo
end type
type sle_1 from singlelineedit within w_rpt_embarques_cultivo
end type
type sle_2 from singlelineedit within w_rpt_embarques_cultivo
end type
type cb_6 from uo_cbdate within w_rpt_embarques_cultivo
end type
type cb_7 from uo_cbdate within w_rpt_embarques_cultivo
end type
type cb_8 from uo_cbdate within w_rpt_embarques_cultivo
end type
type st_10 from statictext within w_rpt_embarques_cultivo
end type
type st_11 from statictext within w_rpt_embarques_cultivo
end type
type sle_3 from singlelineedit within w_rpt_embarques_cultivo
end type
type sle_4 from singlelineedit within w_rpt_embarques_cultivo
end type
type cb_9 from uo_cbdate within w_rpt_embarques_cultivo
end type
type sle_5 from singlelineedit within w_rpt_embarques_cultivo
end type
type sle_6 from singlelineedit within w_rpt_embarques_cultivo
end type
type sle_7 from singlelineedit within w_rpt_embarques_cultivo
end type
type sle_8 from singlelineedit within w_rpt_embarques_cultivo
end type
type rb_1 from radiobutton within w_rpt_embarques_cultivo
end type
type rb_2 from radiobutton within w_rpt_embarques_cultivo
end type
end forward

global type w_rpt_embarques_cultivo from wa_response
int Width=2231
int Height=964
boolean TitleBar=true
string Title="Reportes por Bulto"
long BackColor=82899184
p_1 p_1
st_mess st_mess
em_ini em_ini
cb_5 cb_5
st_2 st_2
em_fin em_fin
cb_fin cb_fin
st_1 st_1
st_3 st_3
st_5 st_5
sle_1 sle_1
sle_2 sle_2
cb_6 cb_6
cb_7 cb_7
cb_8 cb_8
st_10 st_10
st_11 st_11
sle_3 sle_3
sle_4 sle_4
cb_9 cb_9
sle_5 sle_5
sle_6 sle_6
sle_7 sle_7
sle_8 sle_8
rb_1 rb_1
rb_2 rb_2
end type
global w_rpt_embarques_cultivo w_rpt_embarques_cultivo

type variables
String	is_rpt
end variables

forward prototypes
public function integer wf_buscar_cul1 (string as_cod)
public function integer wf_buscar_cul2 (string as_cod)
public function integer wf_buscar_dis1 (string as_cod)
public function integer wf_buscar_dis2 (string as_cod)
end prototypes

public function integer wf_buscar_cul1 (string as_cod);String ls_cul,ls_nomcul,ls_parm,ls_act
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
		sle_1.text=''
		sle_5.text=''
		return 0
	Else	 
		If (f_trim(ls_cul) = '') then
			messagebox(title, 'Cultivo no especificado', Exclamation!)
			sle_1.text=''
			sle_5.text=''
			return 0
		end if		
	end if	
End if

sle_1.text=string(ls_cul)

Select v_nombre_cul
Into  :ls_nomcul
From  t_cultivo
Where  c_codigo_cul = :ls_cul
Using  SqlCa ;
If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_cultivo.' ) = -1 Then
Return 0
End if
sle_5.text = string(ls_nomcul)

Return 1
end function

public function integer wf_buscar_cul2 (string as_cod);String ls_cul,ls_nomcul,ls_parm,ls_act
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
		 sle_2.text=''
		 sle_6.text=''
		return 0
	Else	 
		If (f_trim(ls_cul) = '') then
			messagebox(title, 'Cultivo no especificado', Exclamation!)
			sle_2.text=''
			sle_6.text=''
			return 0
		end if		
	end if	
End if

sle_2.text=string(ls_cul)

Select v_nombre_cul
Into  :ls_nomcul
From  t_cultivo
Where  c_codigo_cul = :ls_cul
Using  SqlCa ;
If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_cultivo.' ) = -1 Then
Return 0
End if
sle_6.text = string(ls_nomcul)

Return 1
end function

public function integer wf_buscar_dis1 (string as_cod);String	ls_parm,ls_nomdis,ls_act,ls_dir,ls_ciudad,ls_tel,ls_rfc

as_cod = f_trim( as_cod )
If as_cod = ''   Then
	OpenWithParm( w_mant_buscar_x_nombre, 'DIS' )
	ls_parm = Message.StringParm	
	ls_parm = f_Trim( ls_parm )
	
	If Not ls_parm = '' Then
		as_cod = ls_parm
		sle_3.Text = ls_parm
		sle_7.Text = f_getdistribuidor( ls_parm )
	End If
Else
	as_cod=Trim(Right( '000000' + Trim(as_cod),6))
	Select	c_activo_dis
	Into     :ls_act
	From		t_distribuidor(nolock)
	Where		c_codigo_dis = :as_cod
	Using SqlCa;
	If f_SqlError( SqlCa, 'No se pudo leer la tabla t_distribuidor . (select)' ) < 0 Then 
			 RollBack Using SqlCa ;
			 Return 0
	End If

	If ls_act = '0' Then
		MessageBox( Title, 'Código de distribuidor esta eliminado.', Exclamation! )
		sle_7.Text=''
		sle_3.Text=''
		as_cod=''
//		dw_1.SetColumn( 'c_codigo_dis' )
		return 0
	Else
		ls_nomdis = f_getdistribuidor( as_cod )
		If ls_nomdis = '' Then
			MessageBox( Title, 'Código de distribuidor no encontrado.', Exclamation! )
			sle_7.Text=''
			sle_3.Text=''
//			dw_1.SetColumn( 'c_codigo_dis' )
			return 0
		End If
		sle_3.Text = as_cod
		sle_7.Text = ls_nomdis
   End If
End If
Return 1
end function

public function integer wf_buscar_dis2 (string as_cod);String	ls_parm,ls_nomdis,ls_act,ls_dir,ls_ciudad,ls_tel,ls_rfc
as_cod = f_trim( as_cod )
If as_cod = ''   Then
	OpenWithParm( w_mant_buscar_x_nombre, 'DIS' )
	ls_parm = Message.StringParm	
	ls_parm = f_Trim( ls_parm )	
	If Not ls_parm = '' Then
		as_cod = ls_parm
		sle_4.Text = ls_parm
		sle_8.Text = f_getdistribuidor( ls_parm )
	End If
Else
	as_cod=Trim(Right( '000000' + Trim(as_cod),6))
	Select	c_activo_dis
	Into     :ls_act
	From		t_distribuidor(nolock)
	Where		c_codigo_dis = :as_cod
	Using SqlCa;
	If f_SqlError( SqlCa, 'No se pudo leer la tabla t_distribuidor . (select)' ) < 0 Then 
			 RollBack Using SqlCa ;
			 Return 0
	End If
	If ls_act = '0' Then
		MessageBox( Title, 'Código de distribuidor esta eliminado.', Exclamation! )
		sle_4.Text=''
		sle_8.Text=''
		as_cod=''
//		dw_1.SetColumn( 'c_codigo_dis' )
		return 0
	Else
		ls_nomdis = f_getdistribuidor( as_cod )
		If ls_nomdis = '' Then
			MessageBox( Title, 'Código de distribuidor no encontrado.', Exclamation! )
			sle_4.Text=''
			sle_8.Text=''
//			dw_1.SetColumn( 'c_codigo_dis' )
			return 0
		End If
		sle_4.Text = as_cod
		sle_8.Text = ls_nomdis
   End If
End If
Return 1
end function

event open;call super::open;is_rpt = Message.StringParm


dw_1.InsertRow( 0 )
dw_1.Object.c_codigo_emb.Width = 1050
if rb_1.checked=true then
	dw_list.dataobject='d_rpt_emb_cul_detmol'
else
	dw_list.dataobject='d_rpt_emb_cul_conmol'
end if
em_ini.Text = f_GetParmValue( '20' )
em_fin.Text = f_GetParmValue( '20' )

end event

on w_rpt_embarques_cultivo.create
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
this.st_5=create st_5
this.sle_1=create sle_1
this.sle_2=create sle_2
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_8=create cb_8
this.st_10=create st_10
this.st_11=create st_11
this.sle_3=create sle_3
this.sle_4=create sle_4
this.cb_9=create cb_9
this.sle_5=create sle_5
this.sle_6=create sle_6
this.sle_7=create sle_7
this.sle_8=create sle_8
this.rb_1=create rb_1
this.rb_2=create rb_2
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
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.sle_1
this.Control[iCurrent+12]=this.sle_2
this.Control[iCurrent+13]=this.cb_6
this.Control[iCurrent+14]=this.cb_7
this.Control[iCurrent+15]=this.cb_8
this.Control[iCurrent+16]=this.st_10
this.Control[iCurrent+17]=this.st_11
this.Control[iCurrent+18]=this.sle_3
this.Control[iCurrent+19]=this.sle_4
this.Control[iCurrent+20]=this.cb_9
this.Control[iCurrent+21]=this.sle_5
this.Control[iCurrent+22]=this.sle_6
this.Control[iCurrent+23]=this.sle_7
this.Control[iCurrent+24]=this.sle_8
this.Control[iCurrent+25]=this.rb_1
this.Control[iCurrent+26]=this.rb_2
end on

on w_rpt_embarques_cultivo.destroy
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
destroy(this.st_5)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.sle_3)
destroy(this.sle_4)
destroy(this.cb_9)
destroy(this.sle_5)
destroy(this.sle_6)
destroy(this.sle_7)
destroy(this.sle_8)
destroy(this.rb_1)
destroy(this.rb_2)
end on

type dw_list from wa_response`dw_list within w_rpt_embarques_cultivo
int X=69
int Y=612
int Width=1755
int Height=152
int TabOrder=0
boolean Visible=false
string DataObject="d_rpt_emb_cul_detmol"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_embarques_cultivo
int X=430
int Y=188
int Width=1065
int Height=92
int TabOrder=130
boolean Visible=false
string DataObject="d_ext_embarcador"
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_embarques_cultivo
int X=1778
int Y=760
int TabOrder=150
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_embarques_cultivo
int X=1390
int Y=760
int TabOrder=140
boolean Enabled=true
end type

event cb_aceptar::clicked;String	ls_cul1,ls_cul2,ls_dis1,ls_dis2
//
ls_cul1= f_Trim( sle_1.text )
ls_cul2= f_Trim( sle_2.text )
ls_dis1= f_Trim( sle_3.text )
ls_dis2= f_Trim( sle_4.text )

If ls_cul1 = '' Then
	ls_cul1='0000'
end if
If ls_cul2 = '' Then
	ls_cul2='9999'
end if

If ls_dis1 = '' Then
	ls_dis1='0000'
end if
If ls_dis2 = '' Then
	ls_dis2='9999'
end if

if rb_1.checked=true then
	dw_list.dataobject='d_rpt_emb_cul_detmol'
else
	dw_list.dataobject='d_rpt_emb_cul_conmol'
end if
SetPointer( HourGlass! )
dw_list.SetTransObject( SqlCa )
dw_list.Retrieve( gs_codtem, f_StringToDate( em_ini.Text ), f_StringToDate( em_fin.Text ),ls_cul1,ls_cul2,ls_dis1,ls_dis2 )
SetPointer( Arrow! )

f_Preview( dw_list )


end event

type p_1 from picture within w_rpt_embarques_cultivo
int X=37
int Y=32
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_mess from statictext within w_rpt_embarques_cultivo
int X=219
int Y=36
int Width=1289
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

type em_ini from uo_editmask within w_rpt_embarques_cultivo
int X=430
int Y=264
end type

type cb_5 from uo_cbdate within w_rpt_embarques_cultivo
int X=617
int Y=464
int TabOrder=80
end type

event clicked;wf_buscar_cul2('')
end event

type st_2 from statictext within w_rpt_embarques_cultivo
int X=942
int Y=276
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

type em_fin from uo_editmask within w_rpt_embarques_cultivo
int X=1074
int Y=264
int TabOrder=30
end type

type cb_fin from uo_cbdate within w_rpt_embarques_cultivo
int X=1417
int Y=268
int TabOrder=40
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type st_1 from statictext within w_rpt_embarques_cultivo
int X=73
int Y=276
int Width=352
int Height=76
boolean Enabled=false
string Text="Embarques Del:"
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

type st_3 from statictext within w_rpt_embarques_cultivo
int X=78
int Y=472
int Width=224
int Height=76
boolean Enabled=false
string Text="Al Cultivo:"
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

type st_5 from statictext within w_rpt_embarques_cultivo
int X=73
int Y=384
int Width=256
int Height=76
boolean Enabled=false
string Text="Del Cultivo:"
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

type sle_1 from singlelineedit within w_rpt_embarques_cultivo
int X=347
int Y=372
int Width=251
int Height=84
int TabOrder=50
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

event modified;string ls_dis2

ls_dis2= right('00'+ f_trim(sle_1.Text),2)

sle_1.Text=ls_dis2
wf_buscar_cul1(ls_dis2)
end event

type sle_2 from singlelineedit within w_rpt_embarques_cultivo
int X=347
int Y=464
int Width=251
int Height=84
int TabOrder=70
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

event modified;string ls_dis2

ls_dis2= right('00'+ f_trim(sle_2.Text),2)

sle_2.Text=ls_dis2
wf_buscar_cul2(ls_dis2)
end event

type cb_6 from uo_cbdate within w_rpt_embarques_cultivo
int X=777
int Y=268
int TabOrder=20
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type cb_7 from uo_cbdate within w_rpt_embarques_cultivo
int X=617
int Y=372
int TabOrder=60
end type

event clicked;wf_buscar_cul1('')
end event

type cb_8 from uo_cbdate within w_rpt_embarques_cultivo
int X=617
int Y=564
int TabOrder=100
end type

event clicked;wf_buscar_dis1('')
end event

type st_10 from statictext within w_rpt_embarques_cultivo
int X=78
int Y=660
int Width=224
int Height=76
boolean Enabled=false
string Text="Al Cliente:"
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

type st_11 from statictext within w_rpt_embarques_cultivo
int X=73
int Y=572
int Width=256
int Height=76
boolean Enabled=false
string Text="Del Cliente:"
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

type sle_3 from singlelineedit within w_rpt_embarques_cultivo
int X=347
int Y=560
int Width=251
int Height=84
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

event modified;string ls_dis2

ls_dis2= right('000000'+ f_trim(sle_3.Text),6)

sle_3.Text=ls_dis2
wf_buscar_dis1(ls_dis2)
end event

type sle_4 from singlelineedit within w_rpt_embarques_cultivo
int X=347
int Y=652
int Width=251
int Height=84
int TabOrder=110
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

event modified;string ls_dis2

ls_dis2= right('000000'+ f_trim(sle_4.Text),6)

sle_4.Text=ls_dis2
wf_buscar_dis2(ls_dis2)
end event

type cb_9 from uo_cbdate within w_rpt_embarques_cultivo
int X=617
int Y=656
int TabOrder=120
end type

event clicked;wf_buscar_dis2('')
end event

type sle_5 from singlelineedit within w_rpt_embarques_cultivo
int X=722
int Y=372
int Width=1376
int Height=84
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

type sle_6 from singlelineedit within w_rpt_embarques_cultivo
int X=722
int Y=464
int Width=1376
int Height=84
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

type sle_7 from singlelineedit within w_rpt_embarques_cultivo
int X=722
int Y=560
int Width=1376
int Height=84
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

type sle_8 from singlelineedit within w_rpt_embarques_cultivo
int X=727
int Y=656
int Width=1376
int Height=84
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

type rb_1 from radiobutton within w_rpt_embarques_cultivo
int X=224
int Y=164
int Width=320
int Height=80
boolean BringToTop=true
string Text="Detallado"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_rpt_embarques_cultivo
int X=741
int Y=164
int Width=421
int Height=80
boolean BringToTop=true
string Text="Concentrado"
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

