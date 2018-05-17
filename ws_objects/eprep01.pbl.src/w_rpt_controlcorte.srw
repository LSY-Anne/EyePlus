$PBExportHeader$w_rpt_controlcorte.srw
forward
global type w_rpt_controlcorte from wa_response
end type
type p_1 from picture within w_rpt_controlcorte
end type
type st_mess from statictext within w_rpt_controlcorte
end type
type em_ini from uo_editmask within w_rpt_controlcorte
end type
type st_1 from statictext within w_rpt_controlcorte
end type
type cb_1 from commandbutton within w_rpt_controlcorte
end type
end forward

global type w_rpt_controlcorte from wa_response
int Width=1477
int Height=568
long BackColor=80269524
p_1 p_1
st_mess st_mess
em_ini em_ini
st_1 st_1
cb_1 cb_1
end type
global w_rpt_controlcorte w_rpt_controlcorte

type variables
String	is_rpt
end variables

event open;call super::open;is_rpt = Message.StringParm


Choose Case is_rpt
	Case 'COR'
		Title = 'Reporte de Control de corte y acarreo'
		dw_list.DataObject = 'd_rpt_corteyacarreo'

End Choose
dw_1.Visible = False
dw_list.Visible = False


end event

on w_rpt_controlcorte.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_mess=create st_mess
this.em_ini=create em_ini
this.st_1=create st_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_mess
this.Control[iCurrent+3]=this.em_ini
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_1
end on

on w_rpt_controlcorte.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_mess)
destroy(this.em_ini)
destroy(this.st_1)
destroy(this.cb_1)
end on

event close;call super::close;
delete t_controlcorte
using sqlca;

commit using sqlca;	
end event

type dw_list from wa_response`dw_list within w_rpt_controlcorte
int X=0
int Y=600
int Width=2423
int Height=1148
int TabOrder=0
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_controlcorte
int X=0
int Y=712
int Width=155
int Height=124
int TabOrder=0
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_controlcorte
int X=1093
int Y=344
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_controlcorte
int X=270
int Y=344
boolean Enabled=true
end type

event cb_aceptar::clicked;DataWindow	ldw_1
string ls_max
long ll_num,i

SetPointer( HourGlass! )
ll_num=dec(em_ini.Text)
for i=1 to ll_num
	ls_max=f_getparmvalue('107')
	ls_max=Trim(Right( '0000000000' + Trim(ls_max),10))
	ls_max=string(dec(ls_max )+( i))
	insert into t_controlcorte
					(c_folio_ras)
	values      (:ls_max)
	using       sqlca;
	If f_SqlError( SqlCa, 'No se pudo actualizar la tabla nomprecredencial. (Insert)' ) < 0 Then 
			RollBack Using SqlCa ;
			Return 0
	End If
next

commit using sqlca;	

dw_list.DataObject = 'd_rpt_corteyacarreo'
ldw_1 = f_PreviewXP( dw_list.DataObject )
ldw_1.Retrieve(  )



SetPointer( Arrow! )
end event

type p_1 from picture within w_rpt_controlcorte
int X=37
int Y=32
int Width=146
int Height=116
boolean BringToTop=true
string PictureName="printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_mess from statictext within w_rpt_controlcorte
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

type em_ini from uo_editmask within w_rpt_controlcorte
int X=759
int Y=196
Alignment Alignment=Right!
string Mask="#####"
MaskDataType MaskDataType=StringMask!
end type

type st_1 from statictext within w_rpt_controlcorte
int X=379
int Y=212
int Width=361
int Height=76
boolean Enabled=false
string Text="Folios a Imprimir:"
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

type cb_1 from commandbutton within w_rpt_controlcorte
int X=681
int Y=344
int Width=347
int Height=92
int TabOrder=40
boolean BringToTop=true
string Text="Confirmar"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_fin
long ll_num

ll_num= long(em_ini.text)
ll_num=ll_Num
ls_fin= Trim(Right( '000000000' + Trim(string(ll_num)),10)) 
 
update t_parametro
set v_valor_par=:ls_fin
where c_codigo_par='107'
using sqlca;
If f_SqlError( SqlCa, 'No se pudo consultar la tabla t_parametro.' ) < 0 Then 
	RollBack Using SqlCa ;
	Return 0
End If
commit using sqlca;
end event

