$PBExportHeader$w_arch_produccion_campo_edit.srw
forward
global type w_arch_produccion_campo_edit from wa_mant_edit
end type
type p_1 from picture within w_arch_produccion_campo_edit
end type
type st_1 from statictext within w_arch_produccion_campo_edit
end type
end forward

global type w_arch_produccion_campo_edit from wa_mant_edit
int Width=1819
int Height=1028
boolean TitleBar=true
string Title="Producción de Campo - "
long BackColor=79741120
p_1 p_1
st_1 st_1
end type
global w_arch_produccion_campo_edit w_arch_produccion_campo_edit

forward prototypes
public function boolean wf_validareg ()
public function boolean wf_checkactionm ()
public function boolean wf_checkactione ()
public function boolean wf_checkactionr ()
public function boolean wf_checkactioni ()
public function long wf_retrievelist ()
end prototypes

public function boolean wf_validareg ();Long		ll_cnt
String	ls_lot, ls_new

dw_1.AcceptText( )

ls_lot = f_trim( dw_1.Object.c_codigo_lot[ 1])
If ls_lot = '' Then
	MessageBox( Title, 'Debe ingresar seleccionar el lote para continuar.', Exclamation!)
	Return False
End If
f_GetSysDate( )

If istr_parm.s_cad[ 1] = 'I' Then	/* insertar */
	/* validamos que el registro ingresado no exista */
	dw_1.Object.c_codigo_tem[ 1] = gs_codtem
	Select	Count( * )
	Into 		:ll_cnt
	From		t_produccion_campo
	Where		c_codigo_tem = :gs_codtem
	And		c_codigo_lot = :ls_lot
	And		d_trabajo_prc = :gd_sys ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_produccion_campo (Count)' ) =-1 Then
		Return False
	End If
	If f_Zero( ll_cnt ) > 0 Then
		MessageBox( Title, 'Este registro de producción de campo ya existe.~n~r' + &
							'~r~nSi desea actualizarlo, seleccionelo y haga clic en Modificar.', Exclamation!)
		Return False
	End If
	/* Genera código */
	Select	Max( c_codigo_prc )
	Into 		:ls_new
	From		t_produccion_campo ;
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_produccion_campo (Max)' ) =-1 Then
		Return False
	End If
	ls_new = f_Trim( ls_new )
	ls_new = Right( '000000' + f_Trim( String( Integer( ls_new ) + 1 )), 6 )
	dw_1.Object.c_codigo_prc[ 1] = ls_new 
End If

/* Validamos que campos mandatorios esten ingresados */
/* Fechas */
If Date( dw_1.Object.d_1erpla_prc[ 1] ) = Date( '1900/01/01' ) Or &
	IsNull( dw_1.Object.d_1erpla_prc[ 1] ) Then
	MessageBox( Title, 'Debe ingresar fecha de primer planteo.', Exclamation!)
	Return False
End If
If Date( dw_1.Object.d_1ercor_prc[ 1] ) = Date( '1900/01/01' ) Or &
	IsNull( dw_1.Object.d_1ercor_prc[ 1] ) Then
	MessageBox( Title, 'Debe ingresar fecha de primer corte.', Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_checkactionm ();String	ls_acol[]

ls_acol[] = { 'c_codigo_aga' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactione ();
String	ls_acol[]

ls_acol[] = { 'c_codigo_lot', 'c_codigo_cul', 'd_trabajo_prc', 'd_1erpla_prc', &
				'd_1ercor_prc', 'n_hectar_prc', 'n_surcos_prc', 'n_trabaj_prc', &
				'n_baldes_prc', 'n_manobr_prc', 'n_cosxba_prc', 'n_balxtr_prc', 'n_promed_prc' }

wf_ColEnabled( ls_acol[] , False )

Return True

end function

public function boolean wf_checkactionr ();Return wf_CheckActionE( )

end function

public function boolean wf_checkactioni ();f_GetSysDate( )
dw_1.Object.d_trabajo_prc[1] = gd_sys

Return True

end function

public function long wf_retrievelist ();If UpperBound( istr_parm.dw_dat[ ] ) > 0 Then
	Return istr_parm.dw_dat[ 1].Retrieve( gs_codtem, gd_sys, gd_sys)
End If

Return 0

end function

on w_arch_produccion_campo_edit.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_1
end on

on w_arch_produccion_campo_edit.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_1)
end on

type dw_1 from wa_mant_edit`dw_1 within w_arch_produccion_campo_edit
int X=0
int Y=0
int Width=1797
int Height=804
string DataObject="d_arch_produccion_campo_edit"
end type

event dw_1::itemchanged;call super::itemchanged;String	ls_cul
DateTime	ld_1erpla, ld_1ercor
Dec{2}	ldc_hectar, ldc_trabaj, ldc_baldes, ldc_manobr, ldc_cosxba, ldc_balxtr, ldc_promed


If dwo.Name = 'n_hectar_prc' Or dwo.Name = 'n_trabaj_prc' Or &
	dwo.Name = 'n_baldes_prc' Or dwo.Name = 'n_manobr_prc' Then
	ldc_hectar = f_Zero( Object.n_hectar_prc[1] )
	ldc_trabaj = f_Zero( Object.n_trabaj_prc[1] )
	ldc_baldes = f_Zero( Object.n_baldes_prc[1] )
	ldc_manobr = f_Zero( Object.n_manobr_prc[1] )
End If

//messagebox( '', String( Object.d_1ercor_prc[1] , 'dd/mm/yyyy'))

Choose Case dwo.Name
	Case 'c_codigo_lot'
		Select	c_codigo_cul
		Into		:ls_cul
		From		t_lote
		Where		c_codigo_tem = :gs_codtem
		And		c_codigo_lot = :data ;
		If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_lote' ) = -1 Then
			Return 2
		End If
		
		/* Asigna el Cultivo */
		Object.c_codigo_cul[1] = ls_cul
		
		Select	Max( d_1erpla_prc ), Max( d_1ercor_prc )
		Into 		:ld_1erpla, :ld_1ercor
		From		t_produccion_campo
		Where		c_codigo_tem = :gs_codtem
		And		c_codigo_lot = :data 
		And		c_activo_prc = '1' ;
		If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_produccion_campo (Max)' ) =-1 Then
			Return 2
		End If
		dw_1.Object.d_1erpla_prc[ 1] = ld_1erpla
		dw_1.Object.d_1ercor_prc[ 1] = ld_1ercor

	Case 'n_hectar_prc'
		/* Obtiene las hectareas */
		ldc_hectar = Dec( Data )
	Case 'n_trabaj_prc'
		ldc_trabaj = Dec( Data )
	Case 'n_baldes_prc'
		ldc_baldes = Dec( Data )
	Case 'n_manobr_prc'
		ldc_manobr = Dec( Data )
End Choose

If f_Zero( ldc_hectar ) <> 0 Then ldc_promed = ldc_baldes / ldc_hectar
If f_Zero( ldc_trabaj ) <> 0 Then ldc_balxtr = ldc_baldes / ldc_trabaj
If f_Zero( ldc_baldes ) <> 0 Then ldc_cosxba = ldc_manobr / ldc_baldes

Object.n_cosxba_prc[1] = ldc_cosxba
Object.n_balxtr_prc[1] = ldc_balxtr
Object.n_promed_prc[1] = ldc_promed

end event

type cb_cancelar from wa_mant_edit`cb_cancelar within w_arch_produccion_campo_edit
int X=1403
int Y=812
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_arch_produccion_campo_edit
int X=1029
int Y=812
end type

type p_1 from picture within w_arch_produccion_campo_edit
int X=14
int Y=828
int Width=73
int Height=56
boolean BringToTop=true
string PictureName="nota.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_1 from statictext within w_arch_produccion_campo_edit
int X=105
int Y=832
int Width=334
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Cajas = Baldes"
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

