$PBExportHeader$w_arch_documento_abrir.srw
forward
global type w_arch_documento_abrir from wa_response
end type
type st_1 from statictext within w_arch_documento_abrir
end type
type em_ini from uo_editmask within w_arch_documento_abrir
end type
type cb_5 from uo_cbdate within w_arch_documento_abrir
end type
type st_2 from statictext within w_arch_documento_abrir
end type
type em_fin from uo_editmask within w_arch_documento_abrir
end type
type cb_fin from uo_cbdate within w_arch_documento_abrir
end type
type cb_buscar from uo_cbother within w_arch_documento_abrir
end type
type cb_pornumero from uo_cbother within w_arch_documento_abrir
end type
end forward

global type w_arch_documento_abrir from wa_response
int Width=2725
int Height=1180
boolean TitleBar=true
string Title="Abrir Documento"
long BackColor=81324524
st_1 st_1
em_ini em_ini
cb_5 cb_5
st_2 st_2
em_fin em_fin
cb_fin cb_fin
cb_buscar cb_buscar
cb_pornumero cb_pornumero
end type
global w_arch_documento_abrir w_arch_documento_abrir

type variables
String is_doc
end variables

forward prototypes
public subroutine wf_activo ()
end prototypes

public subroutine wf_activo ();String ls_c1, ls_c2, ls_fmt

ls_c1 = String( f_Color( 'rojo' ) )
ls_c2 = String( f_Color( 'verde' ) )

ls_fmt = "c_activo.Color = '0~tIf ( c_activo = ~~'0~~', " + ls_c1 + ', '+ ls_c2 +")'" 
dw_list.Modify( ls_fmt )

ls_fmt = "c_activo.format = '[general]~tIf( c_activo = ~~'0~~', ~~'û~~', ~~'ü~~' )'" 
dw_list.Modify( ls_fmt )

end subroutine

on w_arch_documento_abrir.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_ini=create em_ini
this.cb_5=create cb_5
this.st_2=create st_2
this.em_fin=create em_fin
this.cb_fin=create cb_fin
this.cb_buscar=create cb_buscar
this.cb_pornumero=create cb_pornumero
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_ini
this.Control[iCurrent+3]=this.cb_5
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.em_fin
this.Control[iCurrent+6]=this.cb_fin
this.Control[iCurrent+7]=this.cb_buscar
this.Control[iCurrent+8]=this.cb_pornumero
end on

on w_arch_documento_abrir.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_ini)
destroy(this.cb_5)
destroy(this.st_2)
destroy(this.em_fin)
destroy(this.cb_fin)
destroy(this.cb_buscar)
destroy(this.cb_pornumero)
end on

event open;call super::open;String ls_fecha
is_doc = Message.StringParm

em_ini.Text = String(Datetime(today()),'dd/mm/yyyy')
em_fin.Text = String(Datetime(today()),'dd/mm/yyyy')

dw_1.Visible = False
cb_aceptar.visible=true

Choose Case is_doc
	Case 'CAR'
		dw_list.DataObject = 'd_arch_carta_abrir'
	Case 'FLT'
		dw_list.DataObject = 'd_arch_factura_flete_abrir'
	Case 'MAN'
		dw_list.DataObject = 'd_arch_gasto_aduanal_abrir'
	Case 'COR'
		dw_list.DataObject = 'd_arch_corteacarreo_abrir'	
	Case 'DES'
		dw_list.DataObject = 'd_arch_desembarcar_abrir'	
End Choose

dw_list.SetTransObject( SqlCa )
wf_activo( )
end event

type dw_list from wa_response`dw_list within w_arch_documento_abrir
int X=14
int Y=132
int Width=2629
int Height=780
int TabOrder=50
string DataObject="d_arch_abrir_polcosto"
end type

event dw_list::retrieveend;call super::retrieveend;String	ls_cod

If rowcount > 0  Then 
	cb_aceptar.Enabled = True
	ls_cod = dw_list.Object.c_codigo[ dw_list.GetRow()]
End If


end event

event dw_list::getfocus;cb_aceptar.Default = True

end event

event dw_list::rowfocuschanged;call super::rowfocuschanged;String	ls_cod

If currentrow > 0 Then
	ls_cod = dw_list.Object.c_codigo[ currentrow]
End If
end event

event dw_list::doubleclicked;// Aqui estoy utilizando un comportamiento especifico de otro objeto
// Para este caso el evento es clicked del objeto cb_aceptar

cb_aceptar.TriggerEvent(Clicked!)

end event

type dw_1 from wa_response`dw_1 within w_arch_documento_abrir
int X=46
int Y=936
int Width=306
int Height=136
int TabOrder=0
string DataObject="d_rpt_manifiesto_x_fechas"
end type

type cb_cancelar from wa_response`cb_cancelar within w_arch_documento_abrir
int X=2318
int Y=960
int TabOrder=70
end type

event cb_cancelar::clicked;s_parm	lstr_parm

lstr_parm.s_cad[1] = ''	
lstr_parm.s_cad[2] = ''

CloseWithReturn( Parent, lstr_parm )
end event

type cb_aceptar from wa_response`cb_aceptar within w_arch_documento_abrir
int X=1957
int Y=960
int TabOrder=60
end type

event cb_aceptar::clicked;Long		ll_row
String	ls_opc
s_parm	lstr_parm

If dw_list.RowCount ( ) <= 0  Then 
	Beep( 1)
	Return
End If

is_doc = Message.StringParm
ll_row = dw_list.GetRow( )

If dw_list.Object.c_activo[ ll_row] = '0' Then
	MessageBox( Title, 'El registro se encuentra eliminado/cancelado.' )
	dw_list.SetFocus( )
	Return
End If

If is_doc='POL' then
   lstr_parm.d_fecha[1] = dw_list.Object.d_fecha_pol[ ll_row]
End If

Choose Case is_doc
	Case 'CAR'
		lstr_parm.s_cad[1] = ''	
		lstr_parm.s_cad[2] = dw_list.Object.c_codigo[ ll_row]
	Case 'FLT' //cambiar por los datos de lt y faclt
		lstr_parm.s_cad[1] = dw_list.Object.c_codigo1[ll_row]	
		lstr_parm.s_cad[2] = dw_list.Object.c_codigo2[ll_row]
	Case 'MAN'
		lstr_parm.s_cad[1] = dw_list.Object.c_codigo[ ll_row]
	Case 'COR'
		lstr_parm.s_cad[1] = dw_list.Object.c_codigo[ ll_row]
	Case 'DES'
		lstr_parm.s_cad[1] = dw_list.Object.c_codigo[ ll_row]	
End Choose

CloseWithReturn( Parent, lstr_parm )




end event

type st_1 from statictext within w_arch_documento_abrir
int X=46
int Y=40
int Width=123
int Height=76
boolean Enabled=false
string Text="&Del:"
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

type em_ini from uo_editmask within w_arch_documento_abrir
int X=178
int Y=36
int Accelerator=100
end type

event getfocus;cb_buscar.Default = True
end event

type cb_5 from uo_cbdate within w_arch_documento_abrir
int X=521
int Y=40
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_2 from statictext within w_arch_documento_abrir
int X=690
int Y=40
int Width=91
int Height=76
boolean Enabled=false
string Text="&Al:"
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

type em_fin from uo_editmask within w_arch_documento_abrir
int X=823
int Y=36
int TabOrder=20
int Accelerator=97
end type

event getfocus;cb_buscar.Default = True
end event

type cb_fin from uo_cbdate within w_arch_documento_abrir
int X=1166
int Y=40
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type cb_buscar from uo_cbother within w_arch_documento_abrir
int X=1321
int Y=32
int TabOrder=40
string Text="&Buscar"
boolean Default=true
end type

event clicked;String	ls_null,ls_numdoc
Datetime ld_fecini, ld_fecfin

SetNull( ls_null )

is_doc = Message.StringParm
ld_fecini = f_StringToDate( em_ini.Text )
ld_fecfin = f_StringToDate( em_fin.Text )
ls_numdoc = f_Trim( Message.StringParm )
Choose Case is_doc
	Case 'CAR'
		dw_list.Retrieve(ld_fecini,ld_fecfin,'')
	Case 'FLT'
		dw_list.Retrieve(ld_fecini,ld_fecfin,'','')
	Case 'MAN'
		dw_list.Retrieve(ld_fecini,ld_fecfin,'')
	Case 'COR'
		dw_list.Retrieve('%')
	Case 'DES'
		dw_list.Retrieve('%')
End Choose

dw_list.SetFocus( )
end event

type cb_pornumero from uo_cbother within w_arch_documento_abrir
int X=1701
int Y=32
int Width=357
int TabOrder=30
string Text="&Por Codigo"
end type

event clicked;String	ls_numdoc, ls_lit, ls_fac
Datetime ld_null,ld_fecini, ld_fecfin
long ll_long

Open( w_arch_ingresar_numero_doc )
ls_numdoc = f_Trim( Message.StringParm )

If ls_numdoc = '' Then Return

ls_numdoc= '%' + ls_numdoc + '%'
SetNull( ld_null )


is_doc = Message.StringParm
ld_fecini = f_StringToDate( em_ini.Text )
ld_fecfin = f_StringToDate( em_fin.Text )

Choose Case is_doc
	Case 'CAR'
		dw_list.Retrieve(ld_fecini,ld_fecfin,ls_numdoc)
	Case 'FLT'
		ll_long = len(ls_numdoc) - 2	
		ls_lit = f_trim(mid(ls_numdoc,1,2))
		ls_fac = f_trim(mid(ls_numdoc,3, ll_long))
		dw_list.Retrieve(ld_fecini,ld_fecfin,ls_lit,ls_fac)
	Case 'MAN'
		dw_list.Retrieve(ld_fecini,ld_fecfin,ls_numdoc)
	Case 'COR'
		dw_list.Retrieve(ls_numdoc)
		Case 'MAN'
		dw_list.Retrieve(LS_NUMDOC)
End Choose

dw_list.SetFocus( )







end event

