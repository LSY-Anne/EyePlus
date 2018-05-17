$PBExportHeader$w_util_reg_acu_emp.srw
forward
global type w_util_reg_acu_emp from wa_response
end type
type st_1 from statictext within w_util_reg_acu_emp
end type
type uo_bar from uo_progressbar within w_util_reg_acu_emp
end type
type dw_2 from datawindow within w_util_reg_acu_emp
end type
type p_1 from picture within w_util_reg_acu_emp
end type
type st_2 from statictext within w_util_reg_acu_emp
end type
type gb_1 from groupbox within w_util_reg_acu_emp
end type
end forward

global type w_util_reg_acu_emp from wa_response
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
global w_util_reg_acu_emp w_util_reg_acu_emp

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

event open;call super::open;

dw_1.Visible = False
dw_list.Visible = False

end event

on w_util_reg_acu_emp.create
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

on w_util_reg_acu_emp.destroy
call super::destroy
destroy(this.st_1)
destroy(this.uo_bar)
destroy(this.dw_2)
destroy(this.p_1)
destroy(this.st_2)
destroy(this.gb_1)
end on

type dw_list from wa_response`dw_list within w_util_reg_acu_emp
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

type dw_1 from wa_response`dw_1 within w_util_reg_acu_emp
int X=325
int Y=1224
int Width=155
int Height=124
int TabOrder=0
end type

type cb_cancelar from wa_response`cb_cancelar within w_util_reg_acu_emp
int X=759
int Y=228
int TabOrder=20
string Text="&Cancelar"
end type

type cb_aceptar from wa_response`cb_aceptar within w_util_reg_acu_emp
int X=325
int Y=228
int TabOrder=10
boolean Enabled=true
string Text="&Aceptar"
end type

event cb_aceptar::clicked;String     ls_tem, ls_pro, ls_eti, ls_merori, ls_merdes, ls_usu
Integer    li_count, li_count2, i
Decimal{2} ldc_emptot, ldc_embtot, ldc_sobant, ldc_sobhoy, ldc_meracu
Datetime   ld_fec
Datastore  lds_acu

ldc_emptot 	 = 0
ldc_embtot 	 = 0
ldc_sobant 	 = 0
ldc_sobhoy 	 = 0
ldc_meracu   = 0
li_count 	 = 0
li_count2    = 0

If MessageBox( Parent.Title, '¿Confirma la Regeneracion del Acumulado del Empaque?', Question!, YesNo!, 2 ) <> 1 Then
	cb_cancelar.SetFocus( )
	Return 0
End If

/*verifica que los productos en t_palet se encuentren en t_producto*/
If wf_verifica_pro() = 1 Then
	Return 0
End if

ld_fec = f_stringtodate(f_trim(f_getparmvalue('020')))
ls_usu = f_usuario()

/*se crea un datastore con la informacion de la tabla t_palet y t_otro_movimiento*/
lds_acu = create datastore
lds_acu.dataobject = ('d_util_acumulado_update')
lds_acu.SetTransObject(SqlCa)
lds_acu.Retrieve( ld_fec, gs_codtem )
li_count = lds_acu.Rowcount( )

/*inicio del ciclo para actualizar t_acumulado*/
For i = 1 To li_count
	uo_bar.uof_SetPercent(i, li_count)
	
	/*se actualizan las variables necesarias para actualizar en t_acumulado*/
	ls_pro     = f_Trim( lds_acu.object.c_codigo_pro[ i] )
	ls_eti     = f_Trim( lds_acu.object.c_codigo_eti[ i] )
	ls_merori  = f_Trim( lds_acu.object.c_merori_pro[ i] )
	ls_merdes  = f_Trim( lds_acu.object.c_merdes_pro[ i] )
	ldc_emptot = f_zero( lds_acu.object.empaque[ i] )
	ldc_sobant = f_zero( lds_acu.object.sobanterior[ i] )
	ldc_sobhoy = f_zero( lds_acu.object.sobhoy[ i] )
	ldc_meracu = f_zero( lds_acu.object.meracu[ i] )

//	Select n_embtot_acu
//	Into   :ldc_embtot
//	From   t_acumulado
//	Where  c_codigo_pro = :ls_pro
//	And 	 c_codigo_eti = :ls_eti
//	And  	 c_merori_acu = :ls_merori
//	And 	 c_merdes_acu = :ls_merdes
//	Using  Sqlca;
//			 ldc_embtot = f_zero(ldc_embtot)
	Select c_codigo_tem
	Into   :ls_tem
	From 	 t_temporada
	Where  c_activo_tem = 1
	Using  sqlca;
	
	/*checa si el producto esta en t_acumulado*/
	Select count(*)
	Into   :li_count2
	from   t_acumulado
	where  c_codigo_pro = :ls_pro
	And 	 c_codigo_eti = :ls_eti
	And 	 c_merori_acu = :ls_merori
	And 	 c_merdes_acu = :ls_merdes
	Using  Sqlca;
	
	/*si el producto ya esta dado de alta en t_acumulado lo actualiza, si no lo inserta*/
	If li_count2 = 0 Then
		Insert Into  t_acumulado
						(c_codigo_tem, c_codigo_pro, c_codigo_eti, c_merori_acu, c_merdes_acu, 
						 n_emphoy_acu, n_emptot_acu, n_embhoy_acu, n_embtot_acu, n_sobant_acu,
						 n_sobhoy_acu, n_sobtot_acu, n_reehoy_acu, n_reetot_acu, n_merhoy_acu,
						 n_mertot_acu, n_acchoy_acu, n_acctot_acu, c_codigo_usu, d_creacion_acu,
						 c_usumod_acu, d_modifi_acu, c_activo_acu)
		Values		(:ls_tem, :ls_pro, :ls_eti, :ls_merori, :ls_merdes,
						 '0', :ldc_emptot, '0', '0', :ldc_sobant,
						 '0', :ldc_emptot, '0', '0', '0',
						 '0', '0', '0', :ls_usu, :ld_fec,
						 Null, Null, '1')
		Using Sqlca;
	Else
		Update t_acumulado
		Set 	 n_emptot_acu = :ldc_emptot + :ldc_sobant, 
			 	 n_sobant_acu = :ldc_sobant,
			 	 n_sobhoy_acu = :ldc_sobhoy,
			 	 n_sobtot_acu = :ldc_emptot + :ldc_sobant - n_embtot_acu - :ldc_meracu
		Where	 c_codigo_pro = :ls_pro
		And 	 c_codigo_eti = :ls_eti
		And 	 c_merori_acu = :ls_merori
		And 	 c_merdes_acu = :ls_merdes
		Using  Sqlca;
	End if
Next
/*termina el ciclo*/

Destroy lds_acu
cb_aceptar.Enabled = False

Commit Using Sqlca;
Messagebox (Title, 'La Regeneracion Del Acumulado del Empaque se Realizo Correctamente')
cb_cancelar.SetFocus( )

Return 0
end event

type st_1 from statictext within w_util_reg_acu_emp
int X=101
int Y=40
int Width=1019
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="REGENERANDO ACUMULADO"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_bar from uo_progressbar within w_util_reg_acu_emp
int X=101
int Y=128
int Width=1019
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
end type

on uo_bar.destroy
call uo_progressbar::destroy
end on

type dw_2 from datawindow within w_util_reg_acu_emp
int X=1522
int Y=1084
int Width=183
int Height=152
boolean BringToTop=true
string DataObject="d_arch_nomrecibo_recalculo_lleno"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type p_1 from picture within w_util_reg_acu_emp
int X=50
int Y=376
int Width=73
int Height=56
boolean BringToTop=true
string PictureName="Nota.bmp"
boolean FocusRectangle=false
end type

type st_2 from statictext within w_util_reg_acu_emp
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

type gb_1 from groupbox within w_util_reg_acu_emp
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

