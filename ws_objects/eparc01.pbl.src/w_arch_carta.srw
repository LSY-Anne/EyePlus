$PBExportHeader$w_arch_carta.srw
forward
global type w_arch_carta from wa_response
end type
type p_ind from picture within w_arch_carta
end type
type dw_prn from datawindow within w_arch_carta
end type
type cb_imprimir from uo_cbother within w_arch_carta
end type
type cb_nuevo from uo_cbother within w_arch_carta
end type
type cb_guardar from uo_cbother within w_arch_carta
end type
type cb_eliminar from uo_cbother within w_arch_carta
end type
type cb_agregar from uo_cbother within w_arch_carta
end type
type cb_1 from commandbutton within w_arch_carta
end type
type cb_modificar from commandbutton within w_arch_carta
end type
type cb_cancel from commandbutton within w_arch_carta
end type
type st_1 from statictext within w_arch_carta
end type
type st_2 from statictext within w_arch_carta
end type
type st_3 from statictext within w_arch_carta
end type
end forward

global type w_arch_carta from wa_response
int X=5
int Y=4
int Width=2688
int Height=2048
WindowType WindowType=main!
boolean TitleBar=true
string Title="Entrada"
string MenuName="m_principal_arch_manifiesto"
long BackColor=1090519039
boolean MinBox=true
boolean MaxBox=true
boolean VScrollBar=true
boolean Resizable=true
WindowState WindowState=maximized!
event ue_save pbm_custom01
event ue_new pbm_custom02
event ue_open pbm_custom03
event vscroll pbm_vscroll
event ue_print pbm_custom04
p_ind p_ind
dw_prn dw_prn
cb_imprimir cb_imprimir
cb_nuevo cb_nuevo
cb_guardar cb_guardar
cb_eliminar cb_eliminar
cb_agregar cb_agregar
cb_1 cb_1
cb_modificar cb_modificar
cb_cancel cb_cancel
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_arch_carta w_arch_carta

type variables
Boolean ib_saved = True, ib_new = True

Integer ii_height = 72 /* Alto de cada registro */

String is_cursor= '0'
end variables

forward prototypes
public function boolean wf_save ()
public function boolean wf_aceptar ()
public function integer wf_agregar ()
public function integer wf_eliminar ()
public function integer wf_new ()
public function integer wf_open ()
public function long wf_print ()
public function boolean wf_savechanges ()
public subroutine wf_enabled (boolean ab_enabled)
public subroutine wf_configurardoc ()
public function string wf_modif ()
public function integer wf_busca_pro (string as_cod)
public function integer wf_busca_mat (string as_cod)
end prototypes

event ue_save;wf_Save( )

end event

event ue_new;wf_New( )
end event

event ue_open;
wf_Open( )
end event

event vscroll;gw_frame.SetMIcrohelp( String(scrollpos ))
end event

event ue_print;wf_Print( )
end event

public function boolean wf_save ();String	ls_doc

If ib_saved   Then 
	Beep(1)
	SetMicroHelp( 'Documento no modificado' )
	Return False
End If

ib_saved = f_Arch_Carta(  title, ib_new, dw_1, dw_list )

If Not ib_saved Then Return False

ib_new = False

MessageBox( Title, 'Carta Material  guardada correctamente.' )


wf_Enabled( False )
gw_frame.SetMicroHelp( 'Listo' )


Return True
end function

public function boolean wf_aceptar ();// Va saltando de campo con el enter.
String	ls_col,ls_cod, ls_pro, ls_eti
long ll_exis

dw_1.AcceptText( )
ls_col='d_fecini_car'

Choose Case dw_1.GetColumnName( )
	Case 'd_fecini_car'
		ls_col = 'd_fecfin_car'
	Case 'd_fecfin_car'
		ls_col='c_codigo_pro'
   Case 'c_codigo_pro'
		ls_cod = f_trim(dw_1.Object.c_codigo_pro[1])
		If ls_cod ='' Then
			wf_busca_pro('')
		Else
			wf_busca_pro(ls_cod)
		End IF
		//***
		ls_pro = f_trim(dw_1.Object.c_codigo_pro[1])
		ls_eti = f_trim(dw_1.Object.c_codigo_eti[1])	
	
		if (ls_pro <> '') and (ls_eti <> '') then
	
		Select count (c_codigo_car)
		Into :ll_exis
		From t_cartamaterial
		Where c_codigo_pro = :ls_pro
		and   c_codigo_eti = :ls_eti
		Using SqlCa;
		//error sql
	
			If f_zero(ll_exis) >= 0 Then
				st_3.text= string(ll_exis)
			End If
		End if
		ls_col='c_codigo_eti'
	Case 'c_codigo_eti'
		ls_pro = dw_1.Object.c_codigo_pro[1]
		ls_eti = dw_1.Object.c_codigo_eti[1]	
	
		if (ls_pro <> '') and (ls_eti <> '') then
	
		Select count (c_codigo_car)
		Into :ll_exis
		From t_cartamaterial
		Where c_codigo_pro = :ls_pro
		and   c_codigo_eti = :ls_eti
		Using SqlCa;
		//error sql
	
			If f_zero(ll_exis) >= 0 Then
				st_3.text= string(ll_exis)
			End If
		End if		
		ls_col='c_codigo_mat'
	Case 'c_codigo_mat' 
		ls_cod = dw_1.Object.c_codigo_mat[1]
		If ls_cod='' Then
			wf_busca_mat('')
		Else
			wf_busca_mat(ls_cod)
		End If
		ls_col = 'n_cantidad_mat'
		
	Case 'n_cantidad_mat'
		ls_col='n_costops'
	Case 'n_costops'
		ls_col='n_costodll'
	Case 'n_costodll'
		ls_col = 'c_tipo_car'
	Case 'c_tipo_car'
		ib_saved = False
		wf_Agregar( )
		ls_col = 'c_codigo_mat'
//		ls_col = 'c_sustituye_mat'
//	Case 'c_sustituye_mat'
//		ib_saved = False
//		wf_Agregar( )
//		ls_col = 'c_codigo_mat'
End Choose

dw_1.SetColumn( ls_col )
dw_1.SetFocus( )

Return True
end function

public function integer wf_agregar ();//Agrega los productos a al list de detalle.
Date ld_fecha
Dec{4}    ldc_can
long    i
String	 ls_mat,ls_pro,ls_nompro,ls_tip
DataWindowChild ldwc_x
ib_saved = False

dw_1.AcceptText( )
dw_1.SetFocus( )

ls_tip = f_trim(dw_1.Object.c_tipo_car[1])
if ls_tip='' Then
	MessageBox( 'Carta de Materiales','Favor de escoger el Tipo.', Exclamation! )
	dw_1.SetColumn( 'c_tipo_car' )
	Return 0
End If


ls_mat = dw_1.Object.c_codigo_pro[1]
if ls_mat='' Then
	MessageBox( 'Mensaje...', 'Favor de escoger el material.', Exclamation! )
	dw_1.SetColumn( 'c_codigo_mat' )
	Return 0
End If	

ldc_can = f_Zero( dw_1.Object.n_cantidad_mat[ 1] )
if ldc_can =0 Then
	MessageBox( 'Mensaje...', 'Favor de teclear la cantidad.', Exclamation! )
	dw_1.SetColumn( 'n_cantidad_mat' )
	Return 0
End If	
		
i = dw_list.InsertRow(0)

dw_list.SetRow( i )
dw_list.ScrollToRow( i )

dw_list.Object.c_codigo_mat[ i] = dw_1.Object.c_codigo_mat[ 1]
dw_list.Object.v_nombre_pro[ i] = f_getmaterial(dw_1.Object.c_codigo_mat[ 1])
dw_list.Object.n_cantidad_cet[ i] = f_zero(dw_1.Object.n_cantidad_mat[ 1])
dw_list.Object.c_sustituye_mat[ i] =  dw_1.Object.c_sustituye_mat[ 1]
dw_list.Object.v_abrevia_uni[ i] =  f_getuniabrevia(dw_1.Object.c_codigo_uni[ 1])
dw_list.Object.n_costops_cet[ i] = f_zero(dw_1.Object.n_costops[ 1])
dw_list.Object.n_costodll_cet[ i] = f_zero(dw_1.Object.n_costodll[ 1])
dw_list.Object.c_tipo_car[ i] = f_trim(dw_1.Object.c_tipo_car[ 1])

dw_1.Object.c_tipo_car[ 1] = ''
dw_1.Object.c_codigo_mat[ 1] = ''
dw_1.Object.v_nombre_mat[ 1] = ''
dw_1.Object.c_sustituye_mat[ 1] = ''
dw_1.Object.c_codigo_uni[ 1] = ''
dw_1.Object.n_cantidad_mat[ 1] = 0
dw_1.Object.n_costops[ 1] = 0
dw_1.Object.n_costodll[ 1] = 0

dw_1.GetChild( 'c_sustituye_mat', ldwc_x )
ldwc_x.Reset()
For i = 1 to dw_list.RowCount()
	
	
	ls_pro = dw_list.Object.c_codigo_mat[ i] 
	ls_nompro = dw_list.Object.v_nombre_pro[ i] 
	
	ldwc_x.InsertRow(1)
	ldwc_x.SetItem( 1, 'c_codigo_mat',ls_pro )
	ldwc_x.SetItem( 1, 'v_nombre_mat', ls_nompro)
Next


Return 1
end function

public function integer wf_eliminar ();String	ls_cod

dw_1.accepttext()

ls_cod = f_trim(dw_1.object.c_codigo_car[1])

delete from t_cartamaterialdet
where c_codigo_car = :ls_cod
using sqlca;
		
If f_SqlError( SqlCa, 'No se pudo accesar a la tabla t_cartamaterialdet . (delete)' ) < 0 Then 
Return 0
End If

delete from t_cartamaterial
where c_codigo_car = :ls_cod
using sqlca;

if f_SqlError( SqlCa, 'No se pudo accesar a la tabla t_cartamaterial . (delete)' ) < 0 Then 
Return 0
End If

Return 1
end function

public function integer wf_new ();datetime ld_ini, ld_fin

If Not wf_SaveChanges( ) Then
	Return 0
End If

ib_new = True

dw_1.DataObject = 'd_arch_carta'
dw_1.Reset( )
dw_1.SetTransObject( SqlCa )

dw_list.Reset( )
dw_list.SetTransObject( SqlCa )

dw_1.InsertRow(0)
wf_Enabled( True )

dw_1.SetColumn( 'd_fecini_car' )
dw_1.AcceptText( )

Select d_inicio_tem, d_fin_tem
Into :ld_ini, :ld_fin
from t_temporada
where c_activo_tem = '1'
using sqlca;
If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_temporada' ) = -1 Then
	Return 0
End If

dw_1.object.d_fecini_car[1]= ld_ini
dw_1.object.d_fecfin_car[1]= ld_fin
	f_colenabled(dw_1,'c_sustituye_mat',false)
dw_1.SetFocus( )

dw_list.SetRowFocusIndicator( p_ind )
p_ind.Visible = False

Return 1
end function

public function integer wf_open ();DateTime ld_fin
Integer	li_opc
String	ls_doc
s_parm	lstr_parm
w_arch_carta	lw_win

SetNull( Message.PowerObjectParm )

OpenWithParm( w_arch_documento_abrir, 'CAR' )
lstr_parm = Message.PowerObjectParm

If Not IsValid( lstr_parm ) Then Return 0

If IsNull( lstr_parm ) Then Return 0

If UpperBound( lstr_parm.s_cad[] ) = 0 Then Return 0
If f_trim(lstr_parm.s_cad[2])  = '' Then Return 0

If lstr_parm.s_cad[ 1] = 'NEW' Then
	OpenSheet( lw_win, gw_frame, gi_poswin, Original! )
	lw_win.dw_1.Object.c_mensaje[1] = 'POLIZA NUEVA'
Else
	OpenSheet( lw_win, gw_frame, gi_poswin, Original! )
	lw_win.dw_1.Retrieve( lstr_parm.s_cad[ 2] )

	lw_win.dw_list.Retrieve( lstr_parm.s_cad[ 2])
	
	lw_win.ib_new = False

		lw_win.wf_Enabled( True ) 

End If

Return 1
end function

public function long wf_print ();Long	ll_rows
String ls_car

ls_car = f_trim(dw_1.Object.c_codigo_car[1])

If ls_car= '' Then
	MessageBox( Title, 'La carta Material no ha sido guardada' + &
								'~r~nPara poder imprimir, revise/complete' + &
								' el documento y haga clic en guardar y reintente.', Exclamation! )
	Return -1
End If

dw_prn.DataObject = 'd_rpt_cartamaterial'
dw_prn.SetTransObject( SqlCa )
ll_rows = dw_prn.Retrieve(ls_Car)
f_Preview( dw_prn )


Return ll_rows
end function

public function boolean wf_savechanges ();Integer	li_opc
String	ls_pro, ls_eti


If Not ib_saved Then 
	ls_pro = f_Trim( dw_1.Object.c_codigo_pro[1] )
	ls_eti = f_Trim( dw_1.Object.c_codigo_eti[1] )
//	If ls_pro <> '' Then
//		ls_doc = 'Nro ' + ls_doc
//	End If
	li_opc = MessageBox( Title, '¿Desea guardar los cambios efectuados en la ~r~ Carta Material, producto:'+ls_pro+',con ~r~ etiqueta: '+ls_eti+'?', Question!, YesNoCancel! )
	Choose Case	li_opc
		Case 1
			If wf_Save( ) Then
				Return True
			Else
				Return False
			End If
		Case 2
			Return True
		Case Else
			Return False
	End Choose
End If

Return True
end function

public subroutine wf_enabled (boolean ab_enabled);If Not ab_enabled Then
	dw_1.Object.DataWindow.ReadOnly = 'Yes'
	dw_1.object.cb_busca_pro.visible = false
	dw_1.object.cb_busca_mat.visible = false
	dw_list.Object.DataWindow.ReadOnly = 'Yes'

Else
	dw_1.Object.DataWindow.ReadOnly = 'No'
	dw_list.Object.DataWindow.ReadOnly = 'No'
End If

cb_agregar.Enabled = ab_enabled
cb_modificar.Enabled = ab_enabled
cb_eliminar.Enabled = ab_enabled

If Not ab_enabled Then
	ib_new = False
	ib_saved = True
End If
end subroutine

public subroutine wf_configurardoc ();This.Title = 'Carta Materiales'
This.WindowState = Maximized!

p_ind.Visible = False
dw_prn.Visible = False

cb_aceptar.Width = 0
cb_aceptar.Height = 0

dw_list.SetRowFocusIndicator( p_ind )
wf_New( )
Show( )
end subroutine

public function string wf_modif ();string ls_cod, ls_cod2,ls_res
//ls_cod=dw_1.object.c_codigo[1]
//select c_activo_pol
//into :ls_cod2
//from conpoliza
//where c_codigo_pol= :ls_cod
//using sqlca;
//
//
//if ls_cod <> '' then
//	ls_res= 'S'
//else
//	ls_res='N'
//end if
return ls_res

end function

public function integer wf_busca_pro (string as_cod);/* wf_BuscarProducto( as_cod ) */
String	ls_nompro, ls_parm

as_cod = f_Trim( as_cod )

If as_cod = '' Then
	OpenWithParm( w_mant_buscar_x_nombre, 'PRO' )
	ls_parm = Message.StringParm
	
	ls_parm = f_Trim( ls_parm )
	
	If Not ls_parm = '' Then
		as_cod = ls_parm
		dw_1.Object.c_codigo_pro[ 1] = ls_parm
		ls_nompro=f_GetProducto( ls_parm )
		dw_1.Object.v_nombre_pro[ 1] = ls_nompro
		
	End If
Else
	ls_nompro = f_GetProducto( as_cod )
	If ls_nompro = '' Then
		MessageBox( Title, 'Código de Producto no encontrado.', Exclamation! )
	End If
	dw_1.Object.v_nombre_pro[ 1] = ls_nompro
End If

ib_saved = False

Return 1
end function

public function integer wf_busca_mat (string as_cod);/* wf_BuscarMateriales( as_cod ) */
String	ls_nompro, ls_parm,ls_uni

as_cod = f_Trim( as_cod )

If as_cod = '' Then
	OpenWithParm( w_mant_buscar_x_nombre, 'MAT' )
	ls_parm = Message.StringParm
	
	ls_parm = f_Trim( ls_parm )
	
	If Not ls_parm = '' Then
		as_cod = ls_parm
		dw_1.Object.c_codigo_mat[ 1] = ls_parm
		ls_nompro = f_GetMaterial( ls_parm )
		dw_1.Object.v_nombre_mat[ 1] = ls_nompro
	End If
Else
	ls_nompro = f_GetMaterial( as_cod )
	If ls_nompro = '' Then
		MessageBox( Title, 'Código de Material no encontrado.', Exclamation! )
	End If
	dw_1.Object.v_nombre_mat[ 1] = ls_nompro
End If

If ls_nompro <> '' Then
		Select	 c_codigo_uni
		Into		:ls_uni
		From		invproducto (Nolock)
		Where		c_codigo_pro = :as_cod
		Using		SqlCa ;
		
		If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla invproducto' ) = -1 Then
			Return 0
		End If
		dw_1.Object.c_codigo_uni[1] = ls_uni
End If
ib_saved = False

Return 1
end function

on w_arch_carta.create
int iCurrent
call super::create
if this.MenuName = "m_principal_arch_manifiesto" then this.MenuID = create m_principal_arch_manifiesto
this.p_ind=create p_ind
this.dw_prn=create dw_prn
this.cb_imprimir=create cb_imprimir
this.cb_nuevo=create cb_nuevo
this.cb_guardar=create cb_guardar
this.cb_eliminar=create cb_eliminar
this.cb_agregar=create cb_agregar
this.cb_1=create cb_1
this.cb_modificar=create cb_modificar
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_ind
this.Control[iCurrent+2]=this.dw_prn
this.Control[iCurrent+3]=this.cb_imprimir
this.Control[iCurrent+4]=this.cb_nuevo
this.Control[iCurrent+5]=this.cb_guardar
this.Control[iCurrent+6]=this.cb_eliminar
this.Control[iCurrent+7]=this.cb_agregar
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cb_modificar
this.Control[iCurrent+10]=this.cb_cancel
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.st_3
end on

on w_arch_carta.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_ind)
destroy(this.dw_prn)
destroy(this.cb_imprimir)
destroy(this.cb_nuevo)
destroy(this.cb_guardar)
destroy(this.cb_eliminar)
destroy(this.cb_agregar)
destroy(this.cb_1)
destroy(this.cb_modificar)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;call super::open;String ls_protect


is_cursor='0'
//cb_guardar.visible=False

wf_New( )
wf_ConfigurarDoc( )

dw_1.SetFocus( )

// ls_protect = ProfileString ( gs_ini, "System", "protect_det", 	"0") 
// dw_1.Modify( 'v_nombre_pro.Protect = "' + ls_protect + '"' )

end event

event resize;

dw_1.X = (newwidth - dw_1.Width ) / 2
dw_list.X = (newwidth - dw_list.Width ) / 2



cb_eliminar.x = dw_1.x + dw_1.Width - cb_eliminar.Width
cb_agregar.y = cb_eliminar.y
cb_agregar.x = cb_eliminar.x - cb_agregar.Width





cb_cancel.x = dw_1.x + dw_1.Width - cb_cancel.Width

cb_guardar.x = dw_1.x + dw_1.Width - cb_guardar.Width - cb_cancel.Width - 40

cb_imprimir.x = dw_1.x + dw_1.Width - cb_imprimir.Width - cb_guardar.Width -40 - cb_cancel.Width - 40

cb_nuevo.x = dw_1.x + dw_1.Width - cb_nuevo.Width - cb_guardar.Width -40 - cb_cancel.Width - 40 - cb_imprimir.Width - 40

cb_modificar.x = dw_1.x + dw_1.Width - cb_modificar.Width - cb_guardar.Width - 40 - cb_cancel.Width - 40 - cb_imprimir.Width - 40 - cb_nuevo.Width - 40




end event

event closequery;
If wf_SaveChanges( ) Then
	Return 0
Else
	Return 1
End If
end event

type dw_list from wa_response`dw_list within w_arch_carta
int X=78
int Y=832
int Width=2427
int Height=732
string DataObject="d_arch_cartadet"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event dw_list::rowfocuschanged;call super::rowfocuschanged;This.SelectRow( 0, False )
end event

event dw_list::clicked;If row > 0 Then 
	This.SetRow( row )
	gw_frame.SetMicroHelp( "Fila: " + String(row) + "/" + String(RowCount()))
End If
end event

event dw_list::retrieveend;call super::retrieveend;This.SelectRow( 0, False )
end event

event dw_list::getfocus;cb_aceptar.Default = False
end event

event dw_list::editchanged;ib_saved = False

end event

type dw_1 from wa_response`dw_1 within w_arch_carta
event key pbm_dwnkey
int X=78
int Y=0
int Width=2414
int Height=788
string DataObject="d_arch_carta"
end type

event dw_1::itemchanged;call super::itemchanged;String ls_pro,ls_car,ls_exis, ls_eti
long ll_exis
ib_saved = False
If dwo.name='c_codigo_pro' Then
	
	ls_pro = f_trim(dw_1.Object.c_codigo_pro[1])
	ls_eti = f_trim(dw_1.Object.c_codigo_eti[1])	
	
	if (ls_pro <> '') and (ls_eti <> '') then
	
		Select count (c_codigo_car)
		Into :ll_exis
		From t_cartamaterial
		Where c_codigo_pro = :ls_pro
		and   c_codigo_eti = :ls_eti
		Using SqlCa;
		//error sql
	
		If f_zero(ll_exis) >= 0 Then
			st_3.text= string(ll_exis)
		End If
	End if
End IF


If dwo.name='c_codigo_eti' Then
	ls_pro = dw_1.Object.c_codigo_pro[1]
	ls_eti = dw_1.Object.c_codigo_eti[1]	
	
	if (ls_pro <> '') and (ls_eti <> '') then
	
		Select count (c_codigo_car)
		Into :ll_exis
		From t_cartamaterial
		Where c_codigo_pro = :ls_pro
		and   c_codigo_eti = :ls_eti
		Using SqlCa;
		//error sql
	
		If f_zero(ll_exis) >= 0 Then
      	st_3.text= string(ll_exis)
		End If
	End if
End IF

end event

event dw_1::dberror;//Row changed between retrieve and update

s_parm	lstr_parm


lstr_parm.s_cad[1] = SqlCa.DataBase
lstr_parm.s_cad[2] = DataObject
lstr_parm.s_cad[3] = String( SqlDBCode )
lstr_parm.s_cad[4] = SqlErrText + '~r~n~r~nSQL Syntax: ' + sqlsyntax

RollBack ;
OpenWithParm( w_sqlerror, lstr_parm )

Return 1
end event

event dw_1::buttonclicked;String	ls_parm, ls_nompro

If dwo.Name = 'cb_busca_pro' Then
  wf_Busca_pro( '' )
End If

If dwo.Name = 'cb_busca_mat' Then
  wf_Busca_mat( '' )
End If


dw_1.AcceptText( )
dw_1.SetRedraw( True )

end event

event dw_1::getfocus;cb_aceptar.Default = True
end event

event dw_1::constructor;call super::constructor;wf_aceptar()
end event

type cb_cancelar from wa_response`cb_cancelar within w_arch_carta
int X=9
int Y=116
int TabOrder=120
boolean Visible=false
boolean Enabled=false
boolean Cancel=false
end type

type cb_aceptar from wa_response`cb_aceptar within w_arch_carta
int X=27
int Y=324
int Width=50
int Height=100
int TabOrder=80
boolean Enabled=true
string Text=""
end type

event cb_aceptar::clicked;wf_Aceptar( )
end event

type p_ind from picture within w_arch_carta
int X=50
int Y=160
int Width=27
int Height=44
boolean BringToTop=true
string PictureName="ind.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type dw_prn from datawindow within w_arch_carta
int X=18
int Y=2136
int Width=224
int Height=132
boolean Border=false
boolean LiveScroll=true
end type

event constructor;SetTransObject( SqlCa )
end event

type cb_imprimir from uo_cbother within w_arch_carta
int X=1669
int Y=1588
int Height=84
int TabOrder=70
boolean BringToTop=true
string Text="&Imprimir"
end type

event clicked;wf_Print( )
end event

type cb_nuevo from uo_cbother within w_arch_carta
int X=1152
int Y=1588
int Height=84
int TabOrder=60
boolean BringToTop=true
string Text="&Nuevo"
end type

event clicked;wf_New( )
end event

type cb_guardar from uo_cbother within w_arch_carta
int X=142
int Y=1588
int Height=84
int TabOrder=50
boolean BringToTop=true
string Text="&Eliminar"
end type

event clicked;call super::clicked;String ls_cod
integer li_opc



dw_1.accepttext()

ls_cod = f_trim(dw_1.object.c_codigo_car[1])

if ls_cod <> '' then
	li_opc = messagebox(title,'Esta seguro de eliminar esta carta material',Question!,YesNo!,2)		
	Choose Case	li_opc
		Case 1
			if wf_eliminar() = 1 then
				messagebox(title,'Carta Material:'+ls_cod+' eliminada exitosamente',exclamation!)
				commit using sqlca;
				wf_new()
				close(parent)
				return 1
			end if	
		Case 2
			Return 0
		Case Else
			Return 0
	End Choose
end if
 
Return 1
end event

type cb_eliminar from uo_cbother within w_arch_carta
int X=1870
int Y=724
int Width=549
int Height=80
int TabOrder=30
boolean BringToTop=true
string Text="&Eliminar Seleccionado"
end type

event clicked;ib_saved = False
wf_Eliminar( )

end event

type cb_agregar from uo_cbother within w_arch_carta
int X=1294
int Y=724
int Width=549
int Height=80
int TabOrder=20
boolean BringToTop=true
string Text="&Agregar a lista"
end type

event clicked;ib_saved = False
wf_Agregar( )

end event

type cb_1 from commandbutton within w_arch_carta
int X=1778
int Y=1336
int Width=283
int Height=52
int TabOrder=110
boolean Visible=false
string Text="&Salir"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
Close(Parent)

end event

type cb_modificar from commandbutton within w_arch_carta
int X=681
int Y=1588
int Width=347
int Height=84
int TabOrder=100
boolean BringToTop=true
string Text="&Guardar"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_Save( )
end event

type cb_cancel from commandbutton within w_arch_carta
int X=2153
int Y=1588
int Width=347
int Height=84
int TabOrder=90
boolean BringToTop=true
string Text="&Cancelar"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(parent)
end event

type st_1 from statictext within w_arch_carta
int X=4151
int Y=120
int Width=320
int Height=52
boolean Enabled=false
boolean BringToTop=true
string Text="Cartas"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_arch_carta
int X=4151
int Y=180
int Width=320
int Height=52
boolean BringToTop=true
string Text="Existentes:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_arch_carta
int X=4151
int Y=244
int Width=320
int Height=52
boolean BringToTop=true
string Text="0"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

