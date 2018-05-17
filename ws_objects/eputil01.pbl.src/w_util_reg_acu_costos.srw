$PBExportHeader$w_util_reg_acu_costos.srw
forward
global type w_util_reg_acu_costos from wa_response
end type
type st_1 from statictext within w_util_reg_acu_costos
end type
type uo_bar from uo_progressbar within w_util_reg_acu_costos
end type
type dw_2 from datawindow within w_util_reg_acu_costos
end type
type p_1 from picture within w_util_reg_acu_costos
end type
type st_2 from statictext within w_util_reg_acu_costos
end type
type gb_1 from groupbox within w_util_reg_acu_costos
end type
end forward

global type w_util_reg_acu_costos from wa_response
int Width=1243
int Height=632
boolean TitleBar=true
string Title="Regenerar Acumulado de Empaque"
long BackColor=81324524
st_1 st_1
uo_bar uo_bar
dw_2 dw_2
p_1 p_1
st_2 st_2
gb_1 gb_1
end type
global w_util_reg_acu_costos w_util_reg_acu_costos

type variables
String	is_rpt, is_rptname
end variables

forward prototypes
public function integer wf_verifica_pro ()
end prototypes

public function integer wf_verifica_pro ();/*verifica si los productos en t_palet existen en t_producto*/
String ls_pro
Int li_count = 0, i
datetime ld_fec
Datastore lds_acu

ld_fec = f_stringtodate(f_getparmvalue('020'))

lds_acu = create datastore
lds_acu.dataobject = ('d_util_acumulado_update')
lds_acu.SetTransObject(SqlCa)
lds_acu.Retrieve( ld_fec )
li_count = lds_acu.Rowcount( )

For i = 1 To li_count
	ls_pro = f_Trim( lds_acu.object.c_codigo_pro[ i] )

	Select	count(*)
	Into		:li_count
	From		t_producto
	Where		c_codigo_pro = :ls_pro 
	Using Sqlca;
	If li_count = 0 Then
		MessageBox(title,'Regeneracion Fallida, Un Producto Empacado, No Esta Dado de Alta.', StopSign! )
		Return 1
	End If
next
	
Return 0
end function

event open;call super::open;uo_bar.visible= False
dw_1.Visible = False
dw_list.Visible = False

end event

on w_util_reg_acu_costos.create
int iCurrent
call super::create
this.st_1=create st_1
this.uo_bar=create uo_bar
this.dw_2=create dw_2
this.p_1=create p_1
this.st_2=create st_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.uo_bar
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.gb_1
end on

on w_util_reg_acu_costos.destroy
call super::destroy
destroy(this.st_1)
destroy(this.uo_bar)
destroy(this.dw_2)
destroy(this.p_1)
destroy(this.st_2)
destroy(this.gb_1)
end on

type dw_list from wa_response`dw_list within w_util_reg_acu_costos
int X=155
int Y=1224
int Width=137
int Height=112
int TabOrder=0
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean VScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_util_reg_acu_costos
int X=325
int Y=1224
int Width=155
int Height=124
int TabOrder=0
end type

type cb_cancelar from wa_response`cb_cancelar within w_util_reg_acu_costos
int X=626
int Y=228
int TabOrder=20
string Text="&Cancelar"
end type

type cb_aceptar from wa_response`cb_aceptar within w_util_reg_acu_costos
int X=192
int Y=228
int TabOrder=10
boolean Enabled=true
string Text="&Aceptar"
end type

event cb_aceptar::clicked;SetPointer( HourGlass! )

If MessageBox( 'CONFIRMACION:', '¿Confirma la Regeneracion del Acumulado de Costos?', Question!, YesNo!, 2 ) <> 1 Then
	Return 1
End If

//CAMBIO: 20100125 AaronS - Cambio Funcion Para Procesar Costos (Puede Procesar el dia y todo Historico, Saca Costo Por Kilo y Corrige errorres varios
If f_util_procesa_costos('S', gd_sys) = 1 Then
	cb_aceptar.Enabled = False
	Commit Using Sqlca;
	MessageBox( 'RECALCULO COSTOS:', 'Proceso terminado con éxito. Gracias!', Information!)
	Return -1
Else
	cb_aceptar.Enabled = False
	RollBack Using SqlCa;
	MessageBox( 'RECALCULO COSTOS:', 'NO se pudo realizar el proceso de recalculo de costos, Favor de revisar los mensajes de error, corregirlos y reintentar. Gracias!', Exclamation!)
	Return -1
End If
Return 1
end event

type st_1 from statictext within w_util_reg_acu_costos
int X=32
int Y=16
int Width=1161
int Height=196
boolean Enabled=false
boolean BringToTop=true
string Text="REGENERAR ACUMULADO DE COSTOS"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_bar from uo_progressbar within w_util_reg_acu_costos
int X=101
int Y=516
int Width=1019
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
end type

on uo_bar.destroy
call uo_progressbar::destroy
end on

type dw_2 from datawindow within w_util_reg_acu_costos
int X=1522
int Y=1084
int Width=183
int Height=152
boolean BringToTop=true
string DataObject="d_arch_nomrecibo_recalculo_lleno"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type p_1 from picture within w_util_reg_acu_costos
int X=50
int Y=376
int Width=73
int Height=56
boolean BringToTop=true
string PictureName="Nota.bmp"
boolean FocusRectangle=false
end type

type st_2 from statictext within w_util_reg_acu_costos
int X=142
int Y=376
int Width=1015
int Height=116
boolean Enabled=false
boolean BringToTop=true
string Text="Este proceso puede tardar, las demás sesiones de EyePlus deberán cerrarse."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=81324524
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_util_reg_acu_costos
int X=18
int Y=328
int Width=1184
int Height=184
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

