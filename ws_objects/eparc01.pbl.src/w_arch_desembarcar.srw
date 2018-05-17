$PBExportHeader$w_arch_desembarcar.srw
forward
global type w_arch_desembarcar from wa_response
end type
type p_ind from picture within w_arch_desembarcar
end type
type dw_prn from datawindow within w_arch_desembarcar
end type
type cb_imprimir from uo_cbother within w_arch_desembarcar
end type
type cb_guardar from commandbutton within w_arch_desembarcar
end type
type cb_1 from commandbutton within w_arch_desembarcar
end type
end forward

global type w_arch_desembarcar from wa_response
int X=5
int Y=4
int Width=3113
int Height=1040
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
cb_guardar cb_guardar
cb_1 cb_1
end type
global w_arch_desembarcar w_arch_desembarcar

type variables
Boolean ib_saved = True, ib_new = True

Integer ii_height = 72 /* Alto de cada registro */

String is_cursor= '0'
end variables

forward prototypes
public function boolean wf_save ()
public function boolean wf_aceptar ()
public function integer wf_eliminar ()
public function integer wf_new ()
public function integer wf_open ()
public function boolean wf_savechanges ()
public subroutine wf_enabled (boolean ab_enabled)
public subroutine wf_configurardoc ()
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

public function boolean wf_save ();String	ls_doc
integer li_opc
If ib_saved   Then 
	Beep(1)
	SetMicroHelp( 'Documento no modificado' )
	Return False
End If
//
//ib_saved = f_Arch_gasto(title, ib_new, dw_1)
//
//If Not ib_saved Then Return False
ls_doc = f_Trim( dw_1.Object.c_codigo_man[1] )
if ls_doc='' then
	MessageBox(title,'Favor de seleccionar un código de manifiesto.',Exclamation!)
	Return False
end if

li_opc = MessageBox( Title, '¿Esta seguro que desea desembarcar ' + &
								'el manifiesto ' + ls_doc + '?', Question!, YesNoCancel! )
	Choose Case	li_opc
		Case 1
			update t_manifiesto
			set c_origen_man=:ls_doc
			where c_codigo_man=:ls_doc
			using sqlca;
			If f_SqlError( SqlCa, 'No se pudo eliminar en la tabla pitcartamaterialdet.' ) < 0 Then 
				RollBack Using SqlCa ;
				Return False
			End If
			update t_palet
			set c_origen_man=:ls_doc,c_puntodes_pal=:gs_punto
			where c_codigo_man=:ls_doc
			using sqlca;
			If f_SqlError( SqlCa, 'No se pudo eliminar en la tabla pitcartamaterialdet.' ) < 0 Then 
				RollBack Using SqlCa ;
				Return False
			End If
			
			
			Commit Using SQlCa;
		Case 2
			Return false
		Case Else
			Return False
	End Choose

ib_new = False

MessageBox( Title, 'Manifiesto Desembarcado correctamente.' )
dw_1.setfocus()
dw_1.setcolumn('c_codigo_man')

wf_Enabled( False )
gw_frame.SetMicroHelp('Listo')


Return True
end function

public function boolean wf_aceptar ();// Va saltando de campo con el enter.
String	ls_col,ls_cod

dw_1.AcceptText( )
ls_col='c_codigo_man'

Choose Case dw_1.GetColumnName( )
   Case 'c_codigo_man'
		ls_cod = f_trim(dw_1.Object.c_codigo_man[1])
		wf_busca_mat(ls_cod)
		ls_col='n_gastoaduanal_man'
   Case 'n_gastoaduanal_man'
		  
	End Choose

dw_1.SetColumn(ls_col) 
dw_1.SetFocus( )

Return True
end function

public function integer wf_eliminar ();String	ls_cod

ib_saved = true
ls_cod = f_trim(dw_1.object.c_codigo_man[1])

update t_manifiesto
set n_gastoaduanal_man = 0
where c_codigo_man = :ls_cod
using sqlca;

If f_sqlerror( SqlCa, 'No se pudo obtener información de la tabla t_manifiesto' ) = -1 Then
	Return 0
End If

messagebox(title,'Importe de gasto aduanal del manifiesto: '+ls_cod+', ha sido eliminado correctamente',exclamation!)

close(this)
//cb_imprimir.enabled = false //boton eliminar
Return 1

end function

public function integer wf_new ();
If Not wf_SaveChanges( ) Then
	Return 0
End If

ib_new = True

dw_1.DataObject = 'd_arch_desembarcar'
dw_1.Reset( )
dw_1.SetTransObject( SqlCa )

//dw_list.Reset( )
//dw_list.SetTransObject( SqlCa )

dw_1.InsertRow(0)
wf_Enabled( True )

//dw_1.object.d_fecha_flt[1] =datetime(today())
dw_1.object.c_codigo_man[1] = ''
dw_1.SetColumn( 'c_codigo_man' )
dw_1.AcceptText( )


dw_1.SetFocus( )

dw_list.SetRowFocusIndicator( p_ind )
p_ind.Visible = False
cb_imprimir.enabled = false //boton eliminar

Return 1
end function

public function integer wf_open ();DateTime ld_fin, ld_null
Integer	li_opc
String	ls_doc
s_parm	lstr_parm
w_arch_desembarcar	lw_win

SetNull( Message.PowerObjectParm )
SetNull(ld_null)

OpenWithParm( w_arch_documento_abrir, 'DES' )

lstr_parm = Message.PowerObjectParm

If Not IsValid( lstr_parm ) Then Return 0

If IsNull( lstr_parm ) Then Return 0

If UpperBound( lstr_parm.s_cad[] ) = 0 Then Return 0

If f_trim(lstr_parm.s_cad[1])  = '' Then Return 0

	
	OpenSheet( lw_win, gw_frame, gi_poswin, Original! )
	
	lw_win.dw_1.Retrieve( lstr_parm.s_cad[1])
	lw_win.ib_new = False
	lw_win.wf_Enabled( true ) 
	lw_win.cb_guardar.enabled = false
	lw_win.cb_imprimir.enabled = true 
	

//End If

Return 1
end function

public function boolean wf_savechanges ();Integer	li_opc
String	ls_doc


If Not ib_saved Then 
	ls_doc = f_Trim( dw_1.Object.c_codigo_man[1] )
	If ls_doc <> '' Then
		//ls_doc = 'Nro ' + ls_doc
	End If
	li_opc = MessageBox( Title, '¿Desea guardar los cambios efectuados en el ' + &
								'importe del manifiesto ' + ls_doc + '?', Question!, YesNoCancel! )
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
	//dw_list.Object.DataWindow.ReadOnly = 'Yes'
Else
	dw_1.Object.DataWindow.ReadOnly = 'No'
	//dw_list.Object.DataWindow.ReadOnly = 'No'
End If

//cb_agregar.Enabled = ab_enabled
//cb_modificar.Enabled = ab_enabled
//cb_eliminar.Enabled = ab_enabled
cb_guardar.Enabled = ab_enabled
//cb_nuevo.Enabled = ab_enabled


If Not ab_enabled Then
	ib_new = False
	ib_saved = True
End If
end subroutine

public subroutine wf_configurardoc ();This.Title = 'Desembarcar'
This.WindowState = Maximized!

p_ind.Visible = False
dw_prn.Visible = False

cb_aceptar.Width = 0
cb_aceptar.Height = 0

dw_list.SetRowFocusIndicator( p_ind )
wf_New( )
Show( )
end subroutine

public function integer wf_busca_mat (string as_cod);/* Manifiesto */
String	ls_parm,ls_cod, ls_man, ls_mdo, ls_fac, ls_emb, ls_dis, ls_nomaga, ls_rfc, ls_dir, ls_cd, ls_cp, ls_tel, ls_nomemb, ls_nomdis
decimal {2} ldc_imp, ldc_bul
Datetime ld_fecman, ld_null

ls_cod = f_trim(as_cod)
setnull(ld_null)

If ls_cod = '' Then
	OpenWithParm( w_mant_buscar_x_nombre,'MAE')
	ls_parm = Message.StringParm
	
	ls_parm = f_Trim( ls_parm )
	
	If Not ls_parm = '' Then
		ls_cod = ls_parm
				
		SELECT man.c_merdes_man, man.c_numfac_man, man.c_codigo_emb, man.c_codigo_dis, man.n_importe_man, man.n_totbul_man, man.d_embarque_man, 
		       aga.v_nombre_aga, aga.c_rfc_aga, aga.v_direcc_aga, aga.v_ciudad_aga, aga.v_codpos_aga, aga.v_telef1_aga
		into	 :ls_mdo, :ls_fac, :ls_emb, :ls_dis, :ldc_imp, :ldc_bul, :ld_fecman,
		       :ls_nomaga, :ls_rfc, :ls_dir, :ls_cd, :ls_cp, :ls_tel
		FROM   t_manifiesto man (NOLOCK),
     			 t_agencia_aduanal aga (NOLOCK)
		where man.c_codigo_aga = aga.c_codigo_aga
		and   man.c_codigo_man = :ls_cod
		and	man.c_tipo_man='N'
		and	isnull(man.c_origen_man,'') = ''
		using sqlca;
		
		If f_sqlerror( SqlCa, 'No se pudo obtener información de la tabla t_manifiesto o t_agencia_aduanal' ) = -1 Then
			Return 0
		End If
		
		ls_mdo = f_trim(ls_mdo)
		if ls_mdo = 'N' then
		ls_mdo = 'Nacional'
		else
		ls_mdo = 'Extranjero'
		end if
		
		ls_emb = f_trim(ls_emb)
		Select v_nombre_emb
		Into  :ls_nomemb
		From	t_embarcador (Nolock)
		Where		c_codigo_emb = :ls_emb
		Using		SqlCa ;

		If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_embarcador' ) = -1 Then
			Return 0
		End If
				
		ls_dis = f_trim(ls_dis)
		Select v_nombre_dis
		Into  :ls_nomdis
		From	t_distribuidor (Nolock)
		Where		c_codigo_dis = :ls_dis
		Using		SqlCa ;

		If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_distribuidor' ) = -1 Then
			Return 0
		End If
		
		if isnull(ls_cod) or (ls_cod = '') then
			dw_1.Object.c_codigo_man[1] = 'S/d'
		else
			dw_1.Object.c_codigo_man[1] = ls_cod
		end if
		
		if isnull(ld_fecman) or (string(ld_fecman) = '') then
			dw_1.Object.d_embarque_man[1] = ld_null
		else
			dw_1.Object.d_embarque_man[1] = ld_fecman
		end if
		
		if isnull(ls_mdo) or (ls_mdo = '') then
			dw_1.Object.mercado[1] = 'S/d'
		else
			dw_1.Object.mercado[1] = ls_mdo
		end if

		if isnull(ls_fac) or (ls_fac = '') then
			dw_1.Object.c_numfac_man[1] = 'S/d'
		else
			dw_1.Object.c_numfac_man[1] = ls_fac
		end if
		
		if isnull(ls_nomemb) or (ls_nomemb = '') then
			dw_1.Object.embarcador[1] = 'S/d'
		else
			dw_1.Object.embarcador[1] = ls_nomemb
		end if
		
		if isnull(ldc_bul) or (ldc_bul < 0) then
			dw_1.Object.n_totbul_man[1] = 0
		else
			dw_1.Object.n_totbul_man[1] = ldc_bul
		end if
		
		if isnull(ls_nomdis) or (ls_nomdis = '') then
			dw_1.Object.distribuidor[1] = 'S/d'
		else
			dw_1.Object.distribuidor[1] = ls_nomdis
		end if
		
		if isnull(ldc_imp) or (ldc_imp < 0) then
			dw_1.Object.n_importe_man[1] = 0
		else
			dw_1.Object.n_importe_man[1] = ldc_imp
		end if
		
		if isnull(ls_nomaga) or (ls_nomaga = '') then
			dw_1.Object.v_nombre_aga[1] = 'S/d'
		else
			dw_1.Object.v_nombre_aga[1] = ls_nomaga
		end if
		
		if isnull(ls_cp) or (ls_cp = '') then
			dw_1.Object.v_codpos_aga[1] = 'S/d'
		else
			dw_1.Object.v_codpos_aga[1] = ls_cp
		end if
		
		if isnull(ls_dir) or (ls_dir = '') then
			dw_1.Object.v_direcc_aga[1] = 'S/d'
		else
			dw_1.Object.v_direcc_aga[1] = ls_dir
		end if
		
		if isnull(ls_tel) or (ls_tel = '') then
			dw_1.Object.v_telef1_aga[1] = 'S/d'
		else
			dw_1.Object.v_telef1_aga[1] = ls_tel
		end if
		
		if isnull(ls_cd) or (ls_cd = '') then
			dw_1.Object.v_ciudad_aga[1] = 'S/d'
		else
			dw_1.Object.v_ciudad_aga[1] = ls_cd
		end if
		
		if isnull(ls_rfc) or (ls_rfc = '') then
			dw_1.Object.c_rfc_aga[1] = 'S/d'
		else
			dw_1.Object.c_rfc_aga[1] = ls_rfc
		end if
		
	End If
Else
	
	Select c_codigo_man
	Into :ls_man
	From	t_manifiesto (Nolock)
	Where	c_codigo_man = :ls_cod
	Using	SqlCa ;

	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_manifiesto' ) = -1 Then
		Return 0
	End If
	ls_man = f_trim(ls_man)
	
	If ls_man = '' Then
		MessageBox( Title, 'Código de Manifiesto NO encontrado.', Exclamation! )
		return 0
	End If
	
	SELECT man.c_merdes_man, man.c_numfac_man, man.c_codigo_emb, man.c_codigo_dis, man.n_importe_man, man.n_totbul_man, man.d_embarque_man, 
		       aga.v_nombre_aga, aga.c_rfc_aga, aga.v_direcc_aga, aga.v_ciudad_aga, aga.v_codpos_aga, aga.v_telef1_aga
		into	 :ls_mdo, :ls_fac, :ls_emb, :ls_dis, :ldc_imp, :ldc_bul, :ld_fecman,
		       :ls_nomaga, :ls_rfc, :ls_dir, :ls_cd, :ls_cp, :ls_tel
		FROM   t_manifiesto man (nolock),
     			 t_agencia_aduanal aga (nolock)
		where man.c_codigo_aga = aga.c_codigo_aga
		and   man.c_codigo_man = :ls_cod
		and	man.c_tipo_man='N'
		and	isnull(man.c_origen_man,'') = ''
		using sqlca;
		
		If f_sqlerror( SqlCa, 'No se pudo obtener información de la tabla t_manifiesto o t_agencia_aduanal' ) = -1 Then
			Return 0
		End If
		
		ls_mdo = f_trim(ls_mdo)
		if ls_mdo = 'N' then
		ls_mdo = 'Nacional'
		else
		ls_mdo = 'Extranjero'
		end if
		
		ls_emb = f_trim(ls_emb)
		Select v_nombre_emb
		Into  :ls_nomemb
		From	t_embarcador (Nolock)
		Where		c_codigo_emb = :ls_emb
		Using		SqlCa ;

		If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_embarcador' ) = -1 Then
			Return 0
		End If
				
		ls_dis = f_trim(ls_dis)
		Select v_nombre_dis
		Into  :ls_nomdis
		From	t_distribuidor (Nolock)
		Where		c_codigo_dis = :ls_dis
		Using		SqlCa ;

		If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_distribuidor' ) = -1 Then
			Return 0
		End If
				
		if isnull(ls_cod) or (ls_cod = '') then
			dw_1.Object.c_codigo_man[1] = 'S/d'
		else
			dw_1.Object.c_codigo_man[1] = ls_cod
		end if
		
		if isnull(ld_fecman) or (string(ld_fecman) = '') then
			dw_1.Object.d_embarque_man[1] = ld_null
		else
			dw_1.Object.d_embarque_man[1] = ld_fecman
		end if
		
		if isnull(ls_mdo) or (ls_mdo = '') then
			dw_1.Object.mercado[1] = 'S/d'
		else
			dw_1.Object.mercado[1] = ls_mdo
		end if

		if isnull(ls_fac) or (ls_fac = '') then
			dw_1.Object.c_numfac_man[1] = 'S/d'
		else
			dw_1.Object.c_numfac_man[1] = ls_fac
		end if
		
		if isnull(ls_nomemb) or (ls_nomemb = '') then
			dw_1.Object.embarcador[1] = 'S/d'
		else
			dw_1.Object.embarcador[1] = ls_nomemb
		end if
		
		if isnull(ldc_bul) or (ldc_bul < 0) then
			dw_1.Object.n_totbul_man[1] = 0
		else
			dw_1.Object.n_totbul_man[1] = ldc_bul
		end if
		
		if isnull(ls_nomdis) or (ls_nomdis = '') then
			dw_1.Object.distribuidor[1] = 'S/d'
		else
			dw_1.Object.distribuidor[1] = ls_nomdis
		end if
		
		if isnull(ldc_imp) or (ldc_imp < 0) then
			dw_1.Object.n_importe_man[1] = 0
		else
			dw_1.Object.n_importe_man[1] = ldc_imp
		end if
		
		if isnull(ls_nomaga) or (ls_nomaga = '') then
			dw_1.Object.v_nombre_aga[1] = 'S/d'
		else
			dw_1.Object.v_nombre_aga[1] = ls_nomaga
		end if
		
		if isnull(ls_cp) or (ls_cp = '') then
			dw_1.Object.v_codpos_aga[1] = 'S/d'
		else
			dw_1.Object.v_codpos_aga[1] = ls_cp
		end if
		
		if isnull(ls_dir) or (ls_dir = '') then
			dw_1.Object.v_direcc_aga[1] = 'S/d'
		else
			dw_1.Object.v_direcc_aga[1] = ls_dir
		end if
		
		if isnull(ls_tel) or (ls_tel = '') then
			dw_1.Object.v_telef1_aga[1] = 'S/d'
		else
			dw_1.Object.v_telef1_aga[1] = ls_tel
		end if
		
		if isnull(ls_cd) or (ls_cd = '') then
			dw_1.Object.v_ciudad_aga[1] = 'S/d'
		else
			dw_1.Object.v_ciudad_aga[1] = ls_cd
		end if
		
		if isnull(ls_rfc) or (ls_rfc = '') then
			dw_1.Object.c_rfc_aga[1] = 'S/d'
		else
			dw_1.Object.c_rfc_aga[1] = ls_rfc
		end if
		
End If

ib_saved = False

Return 1
end function

on w_arch_desembarcar.create
int iCurrent
call super::create
if this.MenuName = "m_principal_arch_manifiesto" then this.MenuID = create m_principal_arch_manifiesto
this.p_ind=create p_ind
this.dw_prn=create dw_prn
this.cb_imprimir=create cb_imprimir
this.cb_guardar=create cb_guardar
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_ind
this.Control[iCurrent+2]=this.dw_prn
this.Control[iCurrent+3]=this.cb_imprimir
this.Control[iCurrent+4]=this.cb_guardar
this.Control[iCurrent+5]=this.cb_1
end on

on w_arch_desembarcar.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_ind)
destroy(this.dw_prn)
destroy(this.cb_imprimir)
destroy(this.cb_guardar)
destroy(this.cb_1)
end on

event open;call super::open;String ls_protect


is_cursor='0'
cb_guardar.visible= true
cb_cancelar.visible = true

wf_New( )
wf_ConfigurarDoc( )

dw_1.SetFocus( )

// ls_protect = ProfileString ( gs_ini, "System", "protect_det", 	"0") 
// dw_1.Modify( 'v_nombre_pro.Protect = "' + ls_protect + '"' )

end event

event resize;

dw_1.X = (newwidth - dw_1.Width ) / 2

cb_guardar.x = dw_1.x + 500
cb_1.x =cb_guardar.x  + 700
cb_cancelar.x =cb_1.x + 700

end event

event closequery;
If wf_SaveChanges( ) Then
	Return 0
Else
	Return 1
End If
end event

type dw_list from wa_response`dw_list within w_arch_desembarcar
int X=224
int Y=676
int Width=78
int Height=104
int TabOrder=20
boolean Visible=false
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

type dw_1 from wa_response`dw_1 within w_arch_desembarcar
event key pbm_dwnkey
int X=14
int Y=4
int Width=3182
int Height=672
string DataObject="d_arch_desembarcar"
end type

event dw_1::itemchanged;call super::itemchanged;String ls_cod
ib_saved = False

If dwo.name='c_codigo_man' Then
	ls_cod = f_trim(data)
	wf_busca_mat(ls_cod)
End If



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

event dw_1::buttonclicked;If dwo.Name = 'cb_man' Then
  wf_Busca_mat('')// cambiar para que busque manifiestos
End If


dw_1.AcceptText( )
dw_1.SetRedraw( True )

end event

event dw_1::getfocus;cb_aceptar.Default = True

end event

event dw_1::constructor;call super::constructor;wf_aceptar()
end event

type cb_cancelar from wa_response`cb_cancelar within w_arch_desembarcar
int X=1856
int Y=728
int Width=549
int Height=80
int TabOrder=50
string Text="&Cerrar"
boolean Cancel=false
end type

type cb_aceptar from wa_response`cb_aceptar within w_arch_desembarcar
int X=155
int Y=676
int Width=50
int Height=100
int TabOrder=0
boolean Enabled=true
string Text=""
end type

event cb_aceptar::clicked;wf_Aceptar( )
end event

type p_ind from picture within w_arch_desembarcar
int X=50
int Y=160
int Width=27
int Height=44
boolean Visible=false
boolean BringToTop=true
string PictureName="ind.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type dw_prn from datawindow within w_arch_desembarcar
int X=18
int Y=2136
int Width=224
int Height=132
boolean Border=false
boolean LiveScroll=true
end type

event constructor;SetTransObject( SqlCa )
end event

type cb_imprimir from uo_cbother within w_arch_desembarcar
int X=1266
int Y=728
int Width=549
int Height=80
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
string Text="&Eliminar"
end type

event clicked;wf_eliminar( )
end event

type cb_guardar from commandbutton within w_arch_desembarcar
int X=690
int Y=728
int Width=549
int Height=80
int TabOrder=30
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

type cb_1 from commandbutton within w_arch_desembarcar
int X=1280
int Y=732
int Width=549
int Height=80
int TabOrder=30
boolean BringToTop=true
string Text="Cancelación de Carga "
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_doc,ls_enc
integer li_opc

ls_doc = f_Trim( dw_1.Object.c_codigo_man[1] )

li_opc = MessageBox( Title, '¿Esta seguro que desea cancelar el desembarque ' + &
								'del manifiesto ' + ls_doc + '?', Question!, YesNoCancel! )
	Choose Case	li_opc
		Case 1
			select c_codigo_man
			into 	:ls_enc
			from 	t_manifiesto
			where c_codigo_man=:ls_doc
			and 	isnull(c_origen_man,'') <> ''
			AND 	c_tipo_man='F'
			using sqlca;
			If f_SqlError( SqlCa, 'No se pudo eliminar en la tabla t_manifiesto.' ) < 0 Then 
				RollBack Using SqlCa ;
				Return 0
			End If
			If ls_enc ='' Then
				MessageBox(title,'El Manifiesto no se puede cancelar, ya que se Reembarco.',Exclamation!)
				Return 0
			End If
			
			update t_manifiesto
			set c_origen_man=''
			where c_codigo_man=:ls_doc
			using sqlca;
			If f_SqlError( SqlCa, 'No se pudo eliminar en la tabla pitcartamaterialdet.' ) < 0 Then 
				RollBack Using SqlCa ;
				Return 0
			End If
			update t_palet
			set c_origen_man='',c_puntodes_pal=''
			where c_codigo_man=:ls_doc
			using sqlca;
			If f_SqlError( SqlCa, 'No se pudo eliminar en la tabla pitcartamaterialdet.' ) < 0 Then 
				RollBack Using SqlCa ;
				Return 0
			End If
			
			
			Commit Using SQlCa;
		Case 2
			Return 0
		Case Else
			Return 0
	End Choose

ib_new = False

MessageBox( Title, 'Desembarcado Cancelado correctamente.' )
dw_1.setfocus()
dw_1.setcolumn('c_codigo_man')

wf_Enabled( False )
gw_frame.SetMicroHelp('Listo')


Return 1
end event

