$PBExportHeader$w_arch_acumulado_costos_prod_desglo_list.srw
forward
global type w_arch_acumulado_costos_prod_desglo_list from wa_response
end type
type st_1 from statictext within w_arch_acumulado_costos_prod_desglo_list
end type
type st_tc from statictext within w_arch_acumulado_costos_prod_desglo_list
end type
type em_peso from editmask within w_arch_acumulado_costos_prod_desglo_list
end type
type em_bultos from editmask within w_arch_acumulado_costos_prod_desglo_list
end type
type st_peso from statictext within w_arch_acumulado_costos_prod_desglo_list
end type
type st_bultos from statictext within w_arch_acumulado_costos_prod_desglo_list
end type
end forward

global type w_arch_acumulado_costos_prod_desglo_list from wa_response
int Width=2139
int Height=1652
boolean TitleBar=true
string Title="Desglose de Costo de Materiales y Gastos Operativos"
long BackColor=80269524
st_1 st_1
st_tc st_tc
em_peso em_peso
em_bultos em_bultos
st_peso st_peso
st_bultos st_bultos
end type
global w_arch_acumulado_costos_prod_desglo_list w_arch_acumulado_costos_prod_desglo_list

on w_arch_acumulado_costos_prod_desglo_list.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_tc=create st_tc
this.em_peso=create em_peso
this.em_bultos=create em_bultos
this.st_peso=create st_peso
this.st_bultos=create st_bultos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_tc
this.Control[iCurrent+3]=this.em_peso
this.Control[iCurrent+4]=this.em_bultos
this.Control[iCurrent+5]=this.st_peso
this.Control[iCurrent+6]=this.st_bultos
end on

on w_arch_acumulado_costos_prod_desglo_list.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_tc)
destroy(this.em_peso)
destroy(this.em_bultos)
destroy(this.st_peso)
destroy(this.st_bultos)
end on

event open;call super::open;Dec{2}	ldc_peso, ldc_bultos
String	ls_cod

ls_cod = Message.StringParm

dw_list.Retrieve( gs_codtem, ls_cod )
st_tc.Text = String( w_arch_acumulado_costos_list.idc_tc, '#,###.####' )


Select	n_pesbul_pro,
			n_bulxpa_pro
Into		:ldc_peso,
			:ldc_bultos
From		t_producto
Where		c_codigo_pro = :ls_cod ;

em_bultos.Text = f_Trim( String( ldc_bultos ) )
em_peso.Text = f_Trim( String( ldc_peso ) )

end event

type dw_list from wa_response`dw_list within w_arch_acumulado_costos_prod_desglo_list
int X=37
int Y=32
int Width=2048
int Height=1256
int TabOrder=50
string DataObject="d_arch_acumulado_costos_prod_desglo_list"
end type

type dw_1 from wa_response`dw_1 within w_arch_acumulado_costos_prod_desglo_list
int X=462
int Y=1316
int Width=215
int Height=108
boolean Visible=false
end type

type cb_cancelar from wa_response`cb_cancelar within w_arch_acumulado_costos_prod_desglo_list
int X=1737
int Y=1424
int TabOrder=40
end type

type cb_aceptar from wa_response`cb_aceptar within w_arch_acumulado_costos_prod_desglo_list
int X=1358
int Y=1424
end type

type st_1 from statictext within w_arch_acumulado_costos_prod_desglo_list
int X=37
int Y=1336
int Width=375
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Tipo de Cambio: "
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

type st_tc from statictext within w_arch_acumulado_costos_prod_desglo_list
int X=443
int Y=1336
int Width=315
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="0.0000"
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

type em_peso from editmask within w_arch_acumulado_costos_prod_desglo_list
int X=1120
int Y=1336
int Width=265
int Height=76
int TabOrder=30
boolean BringToTop=true
Alignment Alignment=Right!
boolean Border=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=80269524
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_bultos from editmask within w_arch_acumulado_costos_prod_desglo_list
int X=1824
int Y=1336
int Width=265
int Height=76
int TabOrder=30
boolean BringToTop=true
Alignment Alignment=Right!
boolean Border=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=80269524
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_peso from statictext within w_arch_acumulado_costos_prod_desglo_list
int X=809
int Y=1336
int Width=306
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Peso x Bulto: "
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

type st_bultos from statictext within w_arch_acumulado_costos_prod_desglo_list
int X=1477
int Y=1336
int Width=334
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Bultos x Pallet: "
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

