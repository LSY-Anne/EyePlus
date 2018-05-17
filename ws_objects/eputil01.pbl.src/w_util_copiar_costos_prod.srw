$PBExportHeader$w_util_copiar_costos_prod.srw
forward
global type w_util_copiar_costos_prod from wa_response
end type
type dw_2 from datawindow within w_util_copiar_costos_prod
end type
type st_2 from statictext within w_util_copiar_costos_prod
end type
type ln_1 from line within w_util_copiar_costos_prod
end type
type ln_2 from line within w_util_copiar_costos_prod
end type
type p_1 from picture within w_util_copiar_costos_prod
end type
type cb_aplicar from uo_cbother within w_util_copiar_costos_prod
end type
end forward

global type w_util_copiar_costos_prod from wa_response
int Width=1787
int Height=1604
boolean TitleBar=true
string Title="Copiar Costos de Productos"
long BackColor=80269524
dw_2 dw_2
st_2 st_2
ln_1 ln_1
ln_2 ln_2
p_1 p_1
cb_aplicar cb_aplicar
end type
global w_util_copiar_costos_prod w_util_copiar_costos_prod

type variables
String is_cod
end variables

forward prototypes
public function boolean wf_setcosto ()
public function integer wf_aplicar ()
end prototypes

public function boolean wf_setcosto ();/* wf_SetCosto( ) */
uo_DataStore	lds_1
Integer			i, j
String			ls_cod, ls_cos, ls_nom, ls_mer, ls_fil
Destroy	lds_1

lds_1 = Create uo_DataStore
lds_1.DataObject = 'd_dddw_costo'
lds_1.SetTransObject( SqlCa )
lds_1.Retrieve( )

dw_1.AcceptText( )
ls_cod = dw_1.Object.c_codigo_pro[ 1]

/* Se filtra el listado para el mercado del costo o para mercado "Ambos" -> 'A'

				Ya no aplica 

ls_fil = 'c_mercado_cos In ("A", "' + ls_mer + '")' 
lds_1.SetFilter( ls_fil )
lds_1.Filter( )
*/
For i = 1 To lds_1.RowCount( )
	ls_cos = lds_1.Object.c_codigo_cos[i]
	ls_nom = lds_1.Object.v_nombre_cos[i]
	If dw_list.Find( 'c_codigo_cos = "' + ls_cos + '"', 1, dw_list.RowCount( ) ) > 0 Then Continue
	j = dw_list.InsertRow(0)
	dw_list.Object.c_codigo_pro[ j] = ls_cod
	dw_list.Object.c_codigo_cos[ j] = ls_cos
	dw_list.Object.v_nombre_cos[ j] = ls_nom
	dw_list.Object.c_codigo_usu[ j] = gs_usuario
	dw_list.Object.d_creacion[ j] = Today( )
	dw_list.Object.c_activo[ j] = '1'
Next
dw_1.AcceptText( )

Destroy lds_1
Return True
end function

public function integer wf_aplicar ();Dec{5}	ldc_imp
DateTime	ld_hoy
Integer	i
Long		ll_count
String	ls_pro, ls_cod, ls_cos

ld_hoy = DateTime( Today() )

dw_2.AcceptText( )
dw_list.AcceptText( )

ls_cod = f_Trim( dw_2.Object.c_codigo_pro[ 1] )
If ls_cod = '' Then
	MessageBox( Title, 'Para poder continuar debe seleccinar el producto destino de la copia.', Exclamation! )
	Return 0
End If


For i = 1 to dw_list.RowCount( )
	
	If Not f_Trim( dw_list.Object.c_check[ i] ) = '1' Then Continue
	
	ls_cos = dw_list.Object.c_codigo_cos[ i]
	ldc_imp = dw_list.Object.n_importe_prc[ i]
	ll_count = 0
	/* Si ya tiene el costo actualiza */
	Select	Count(*)
	Into		:ll_count
	From		t_producto_costo
	Where		c_codigo_pro = :ls_cod
	And		c_codigo_cos = :ls_cos ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_producto_costo.') = -1 Then
		Return -1
	End If
		
	If ll_count = 0 Then
		Insert Into t_producto_costo
			(	c_codigo_pro, c_codigo_cos, n_importe_prc, c_codigo_usu, d_creacion_prc, c_activo_prc )
		Values
			(	:ls_cod, :ls_cos, :ldc_imp, :gs_usuario, :ld_hoy, '1' ) ;
	Else
		Update	t_producto_costo
		Set		n_importe_prc = :ldc_imp,
					c_usumod_prc = :gs_usuario,
					d_modifi_prc = :ld_hoy,
					c_activo_prc = '1' 
		Where		c_codigo_pro = :ls_cod
		And		c_codigo_cos = :ls_cos ;	
	End If
	If f_SqlError( SqlCa, 'No se pudo insertar/actualizar la tabla t_producto_costo.') = -1 Then
		Return -1
	End If
Next

Commit Using SqlCa ;

Return 1
end function

on w_util_copiar_costos_prod.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.st_2=create st_2
this.ln_1=create ln_1
this.ln_2=create ln_2
this.p_1=create p_1
this.cb_aplicar=create cb_aplicar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.ln_1
this.Control[iCurrent+4]=this.ln_2
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.cb_aplicar
end on

on w_util_copiar_costos_prod.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.p_1)
destroy(this.cb_aplicar)
end on

event open;call super::open;is_cod = Message.StringParm

dw_1.InsertRow(0)
dw_1.Object.v_etiqueta[ 1] = 'Del Producto:'

is_cod = f_Trim( is_cod )
If not is_cod = '' Then 
	dw_1.Object.c_codigo_pro[ 1] = is_cod
	dw_list.Retrieve( is_cod )
End If

dw_2.SetTransObject( SqlCa )
dw_2.InsertRow(0)
dw_2.Object.v_etiqueta[ 1] = 'Hacia:'
end event

type dw_list from wa_response`dw_list within w_util_copiar_costos_prod
int X=41
int Y=156
int Width=1691
int Height=996
int TabOrder=50
string DataObject="d_util_producto_costo_copia"
end type

type dw_1 from wa_response`dw_1 within w_util_copiar_costos_prod
int X=41
int Y=36
int Width=1691
int Height=88
string DataObject="d_ext_producto_copiar"
end type

event dw_1::itemchanged;call super::itemchanged;If Not cb_aplicar.Enabled Then cb_aplicar.Enabled = True 

dw_list.Retrieve( data )
wf_SetCosto( )
end event

type cb_cancelar from wa_response`cb_cancelar within w_util_copiar_costos_prod
int X=1376
int Y=1292
int TabOrder=40
end type

type cb_aceptar from wa_response`cb_aceptar within w_util_copiar_costos_prod
int X=645
int Y=1292
end type

event cb_aceptar::clicked;If wf_Aplicar( ) = 1 Then Close( Parent )
	
end event

type dw_2 from datawindow within w_util_copiar_costos_prod
int X=41
int Y=1184
int Width=1691
int Height=88
int TabOrder=30
string DataObject="d_ext_producto_copiar"
boolean Border=false
boolean LiveScroll=true
end type

type st_2 from statictext within w_util_copiar_costos_prod
int X=133
int Y=1440
int Width=1605
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="Nota: Los Costos deben especificarse en Dólares Americanos"
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

type ln_1 from line within w_util_copiar_costos_prod
boolean Enabled=false
int BeginX=41
int BeginY=1416
int EndX=1728
int EndY=1416
int LineThickness=4
long LineColor=276856960
end type

type ln_2 from line within w_util_copiar_costos_prod
boolean Enabled=false
int BeginX=41
int BeginY=1420
int EndX=1728
int EndY=1420
int LineThickness=4
long LineColor=1090519039
end type

type p_1 from picture within w_util_copiar_costos_prod
int X=27
int Y=1440
int Width=73
int Height=56
boolean BringToTop=true
string PictureName="nota.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type cb_aplicar from uo_cbother within w_util_copiar_costos_prod
int X=1010
int Y=1292
int TabOrder=20
boolean Enabled=false
boolean BringToTop=true
string Text="&Aplicar"
end type

event clicked;wf_Aplicar( )
end event

