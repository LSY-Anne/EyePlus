$PBExportHeader$w_rpt_manifiestos_fecha.srw
forward
global type w_rpt_manifiestos_fecha from wa_response
end type
type p_1 from picture within w_rpt_manifiestos_fecha
end type
type st_mess from statictext within w_rpt_manifiestos_fecha
end type
type em_ini from uo_editmask within w_rpt_manifiestos_fecha
end type
type cb_5 from uo_cbdate within w_rpt_manifiestos_fecha
end type
type st_2 from statictext within w_rpt_manifiestos_fecha
end type
type em_fin from uo_editmask within w_rpt_manifiestos_fecha
end type
type cb_fin from uo_cbdate within w_rpt_manifiestos_fecha
end type
type st_1 from statictext within w_rpt_manifiestos_fecha
end type
type sle_1 from singlelineedit within w_rpt_manifiestos_fecha
end type
type cb_dis from uo_cbdate within w_rpt_manifiestos_fecha
end type
type sle_6 from singlelineedit within w_rpt_manifiestos_fecha
end type
type st_3 from statictext within w_rpt_manifiestos_fecha
end type
type cbx_1 from checkbox within w_rpt_manifiestos_fecha
end type
end forward

global type w_rpt_manifiestos_fecha from wa_response
int Width=1710
int Height=728
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
cb_dis cb_dis
sle_6 sle_6
st_3 st_3
cbx_1 cbx_1
end type
global w_rpt_manifiestos_fecha w_rpt_manifiestos_fecha

type variables
String	is_rpt
end variables

forward prototypes
public function integer wf_buscar_dis (string as_cod)
end prototypes

public function integer wf_buscar_dis (string as_cod);String	ls_parm,ls_nomdis,ls_act,ls_dir,ls_ciudad,ls_tel,ls_rfc

as_cod = f_trim( as_cod )
If as_cod = ''   Then
	OpenWithParm( w_mant_buscar_x_nombre, 'DIS' )
	ls_parm = Message.StringParm	
	ls_parm = f_Trim( ls_parm )
	
	If Not ls_parm = '' Then
		as_cod = ls_parm
		sle_1.Text = ls_parm
		sle_6.Text = f_getdistribuidor( ls_parm )
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
		sle_6.Text=''
		sle_1.Text=''
		as_cod=''
		dw_1.SetColumn( 'c_codigo_dis' )
		return 0
	Else
		ls_nomdis = f_getdistribuidor( as_cod )
		If ls_nomdis = '' Then
			MessageBox( Title, 'Código de distribuidor no encontrado.', Exclamation! )
			sle_1.Text=''
			sle_6.Text=''
			dw_1.SetColumn( 'c_codigo_dis' )
			return 0
		End If
		sle_1.Text = as_cod
		sle_6.Text = ls_nomdis
   End If
End If



//dw_1.SetFocus()
//dw_1.SetColumn('liq')
Return 1
end function

event open;call super::open;
Title = 'Reporte de Manifiestos por Fecha'

		
dw_1.Visible = False
dw_list.Visible = False

em_ini.Text = f_GetParmValue( '20' )
em_fin.Text = f_GetParmValue( '20' )

end event

on w_rpt_manifiestos_fecha.create
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
this.cb_dis=create cb_dis
this.sle_6=create sle_6
this.st_3=create st_3
this.cbx_1=create cbx_1
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
this.Control[iCurrent+10]=this.cb_dis
this.Control[iCurrent+11]=this.sle_6
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.cbx_1
end on

on w_rpt_manifiestos_fecha.destroy
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
destroy(this.cb_dis)
destroy(this.sle_6)
destroy(this.st_3)
destroy(this.cbx_1)
end on

type dw_list from wa_response`dw_list within w_rpt_manifiestos_fecha
int X=14
int Y=664
int Width=73
int Height=52
int TabOrder=0
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_manifiestos_fecha
int X=0
int Y=712
int Width=155
int Height=124
int TabOrder=0
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_manifiestos_fecha
int X=1298
int Y=512
int TabOrder=50
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_manifiestos_fecha
int X=919
int Y=512
int TabOrder=40
boolean Enabled=true
end type

event cb_aceptar::clicked;DataWindow	ldw_1
Datetime ld_ini,ld_fin
String ls_dis

ld_ini= f_StringToDate( em_ini.Text )
ld_fin = f_StringToDate( em_fin.Text )
ls_dis = f_trim(sle_1.text)

If ls_dis = '' Then 
	ls_dis = '%' 
End If
If cbx_1.checked = true Then
	dw_list.DataObject = 'd_rpt_manifiesto_x_fechas_2'
Else
	dw_list.DataObject = 'd_rpt_manifiesto_x_fechas'
End If
ldw_1 = f_PreviewXP( dw_list.DataObject )
ldw_1.Retrieve( gs_codtem,ld_ini , ld_fin,ls_dis)


SetPointer( Arrow! )

end event

type p_1 from picture within w_rpt_manifiestos_fecha
int X=37
int Y=32
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_mess from statictext within w_rpt_manifiestos_fecha
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

type em_ini from uo_editmask within w_rpt_manifiestos_fecha
int X=325
int Y=232
end type

type cb_5 from uo_cbdate within w_rpt_manifiestos_fecha
int X=672
int Y=236
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_2 from statictext within w_rpt_manifiestos_fecha
int X=837
int Y=236
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

type em_fin from uo_editmask within w_rpt_manifiestos_fecha
int X=969
int Y=232
int TabOrder=20
end type

type cb_fin from uo_cbdate within w_rpt_manifiestos_fecha
int X=1312
int Y=236
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type st_1 from statictext within w_rpt_manifiestos_fecha
int X=206
int Y=236
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

type sle_1 from singlelineedit within w_rpt_manifiestos_fecha
int X=315
int Y=376
int Width=334
int Height=84
int TabOrder=30
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

event modified;string ls_cod

ls_cod = sle_1.text

if ls_cod = '' then
	sle_6.text = ''
end if

if ls_cod <> '' then
	wf_buscar_dis(ls_cod)
else
	wf_buscar_dis('')
end if 
end event

type cb_dis from uo_cbdate within w_rpt_manifiestos_fecha
int X=667
int Y=380
int TabOrder=0
end type

event clicked;wf_buscar_dis('')
end event

type sle_6 from singlelineedit within w_rpt_manifiestos_fecha
int X=763
int Y=376
int Width=882
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

type st_3 from statictext within w_rpt_manifiestos_fecha
int X=46
int Y=388
int Width=274
int Height=52
boolean Enabled=false
boolean BringToTop=true
string Text="Distribuidor:"
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

type cbx_1 from checkbox within w_rpt_manifiestos_fecha
int X=64
int Y=516
int Width=613
int Height=80
boolean BringToTop=true
string Text="Agrupado por Distribuidor"
BorderStyle BorderStyle=StyleLowered!
boolean RightToLeft=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

