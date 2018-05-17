$PBExportHeader$w_rpt_documentos_manif.srw
forward
global type w_rpt_documentos_manif from wa_response
end type
type sle_1 from singlelineedit within w_rpt_documentos_manif
end type
type sle_2 from singlelineedit within w_rpt_documentos_manif
end type
type rb_1 from radiobutton within w_rpt_documentos_manif
end type
type rb_2 from radiobutton within w_rpt_documentos_manif
end type
type ddlb_1 from dropdownlistbox within w_rpt_documentos_manif
end type
type st_1 from statictext within w_rpt_documentos_manif
end type
type st_2 from statictext within w_rpt_documentos_manif
end type
type ddlb_mer from dropdownlistbox within w_rpt_documentos_manif
end type
type cb_1 from uo_cbother within w_rpt_documentos_manif
end type
end forward

global type w_rpt_documentos_manif from wa_response
int Width=1618
int Height=736
boolean TitleBar=true
string Title="Impresión de Documentos de Manifiesto"
long BackColor=80269524
sle_1 sle_1
sle_2 sle_2
rb_1 rb_1
rb_2 rb_2
ddlb_1 ddlb_1
st_1 st_1
st_2 st_2
ddlb_mer ddlb_mer
cb_1 cb_1
end type
global w_rpt_documentos_manif w_rpt_documentos_manif

type variables
String	is_rpt
end variables

event open;call super::open;
dw_1.Visible = False

dw_list.Visible = False


end event

on w_rpt_documentos_manif.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.sle_2=create sle_2
this.rb_1=create rb_1
this.rb_2=create rb_2
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.st_2=create st_2
this.ddlb_mer=create ddlb_mer
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.sle_2
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.ddlb_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.ddlb_mer
this.Control[iCurrent+9]=this.cb_1
end on

on w_rpt_documentos_manif.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.ddlb_mer)
destroy(this.cb_1)
end on

type dw_list from wa_response`dw_list within w_rpt_documentos_manif
int X=1330
int Y=20
int Width=110
int Height=88
int TabOrder=0
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean VScrollBar=false
boolean HSplitScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_documentos_manif
int X=1010
int Y=16
int Width=155
int Height=112
int TabOrder=0
string DataObject="d_rpt_pallet_std_list_no_codebar"
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_documentos_manif
int X=1193
int Y=484
int TabOrder=60
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_documentos_manif
int X=827
int Y=484
int TabOrder=50
boolean Enabled=true
end type

event cb_aceptar::clicked;Integer	li_man, li_fac
String	ls_man, ls_fac, ls_cia, ls_mer, ls_chr, ls_pa1, ls_pa2, ls_dwf 
uo_DataStore	lds_1 

ls_mer = Left( ddlb_mer.Text, 1 )
ls_man = f_Trim( sle_2.Text )
ls_chr = Left( ls_man, 1 )
If Not f_Trim( ls_man ) = '' Then
	If Not IsNumber( ls_chr ) Then // Si no es un digito verificar si tiene la letra de mer_des
		If Not ls_chr = 'E' And Not ls_chr = 'N' Then
			ls_man = ls_mer + ls_man
		End If
		If Not ls_mer = ls_chr Then
			ddlb_mer.SetFocus( )
			MessageBox( Title, 'El Documento de Manifiesto no corresponde al tipo de mercado.', Exclamation! )
			Return 
		End If
	Else		
		ls_man = ls_mer + ls_man
	End If
End If

If ls_mer = 'N' Then
	ls_pa1 = '33' ; ls_pa2 = '35' // <---- Actualizar los parametros segun mercado /Nacional
Else
	ls_pa1 = '13' ; ls_pa2 = '15' // <---- Extranjero
End If

li_man = f_Zero( Integer( f_GetParmValue( ls_pa1 ) ) )
ls_fac = f_Trim( sle_1.Text )
li_fac = f_Zero( Integer( f_GetParmValue( ls_pa2 ) ) )

If li_man > 0 Then
	ls_man = Mid( ls_man, 2 )
	ls_man = Right( Fill( '0', li_man ) + ls_man, li_man )
	ls_man = ls_mer + ls_man
End If

/* Asigna el numero de factura con la cantidad de digitos ke este en parametros */
If li_fac > 0 Then 
	ls_fac = Right( Fill( '0', li_fac ) + ls_fac, li_fac )
End If

ls_cia = f_GetParmValue('3')

If rb_1.Checked Then
	ls_man = ''
	If f_Trim( sle_1.Text ) = '' Then
		MessageBox( Parent.Title, 'Debe ingresar el número de factura.', Exclamation! )
		Return
	End If
	Select	c_codigo_man
	Into		:ls_man
	From		t_manifiesto
	Where		c_codigo_tem = :gs_codtem
	And		c_numfac_man = :ls_fac
	And		c_merdes_man = :ls_mer
	And		c_activo_man = '1' ;
	
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_manifiesto. (c_numfac_man)' ) < 0 Then 
		RollBack Using SqlCa ;
		Return 
	End If

	ls_man = f_Trim(ls_man)
	If ls_man = '' Then
		MessageBox( Parent.Title, 'El número de factura no existe o el manifiesto está eliminado o cancelado.', Exclamation! )
		Return
	End If
	ls_dwf = ProfileString( gs_ini, 'System', 'dwFactura', 'd_rpt_factura_gral' )
	dw_1.DataObject = ls_dwf
Else
	If f_Trim( sle_2.Text ) = '' Then
		MessageBox( Parent.Title, 'Debe ingresar el número de manifiesto.', Exclamation! )
		Return
	End If
	ls_mer = ''
	Select	c_merdes_man
	Into		:ls_mer
	From		t_manifiesto
	Where		c_codigo_tem = :gs_codtem
	And		c_codigo_man = :ls_man
	And		c_activo_man = '1' ;
	
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_manifiesto. (c_merdes_man)' ) < 0 Then 
		RollBack Using SqlCa ;
		Return 
	End If
	
	If ls_mer = '' Then
		MessageBox( Parent.Title, 'El número de manifiesto no existe o está eliminado o cancelado.', Exclamation! )
		Return
	End If
	
	Choose Case Lower( Left( ddlb_1.Text, 3 ) )
		Case 'for'
			ls_dwf = ProfileString( gs_ini, 'System', 'dwFormato', 'd_rpt_formato_aarc_gral' )
			dw_1.DataObject = ls_dwf
		Case 'con'
			ls_dwf = ProfileString( gs_ini, 'System', 'dwControl', 'd_rpt_control_viajes' )
			dw_1.DataObject = ls_dwf
		Case 'man'
			If ls_mer = 'N' Then
				ls_dwf = ProfileString( gs_ini, 'System', 'dwmanifiesto', 'd_rpt_guia_mexicana' )
				dw_1.dataobject = ls_dwf
			Else
				ls_dwf = ProfileString( gs_ini, 'System', 'dwmanifiestoex', 'd_rpt_manifiesto_gral' )
				dw_1.dataobject = ls_dwf
			End If
	End Choose
End If

dw_1.SetTransObject( SqlCa )
dw_1.Retrieve( gs_codtem, ls_man) 

f_Preview( dw_1 )


end event

type sle_1 from singlelineedit within w_rpt_documentos_manif
int X=475
int Y=164
int Width=425
int Height=84
int TabOrder=20
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

event modified;ddlb_1.Enabled = False
rb_2.Checked = False

end event

type sle_2 from singlelineedit within w_rpt_documentos_manif
int X=475
int Y=268
int Width=425
int Height=84
int TabOrder=30
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;ddlb_1.Enabled = True
rb_2.Checked = True

end event

type rb_1 from radiobutton within w_rpt_documentos_manif
int X=69
int Y=168
int Width=347
int Height=76
boolean BringToTop=true
string Text="&Factura Nº:"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If Checked Then ddlb_1.Enabled = False
sle_1.SetFocus()

end event

type rb_2 from radiobutton within w_rpt_documentos_manif
int X=69
int Y=272
int Width=407
int Height=76
boolean BringToTop=true
string Text="&Manifiesto Nº:"
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

event clicked;If Checked Then ddlb_1.Enabled = True
sle_2.SetFocus()
end event

type ddlb_1 from dropdownlistbox within w_rpt_documentos_manif
int X=475
int Y=376
int Width=1065
int Height=308
int TabOrder=40
boolean Enabled=false
boolean BringToTop=true
string Text="Manifiesto General/Guía Mexicana"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
int Accelerator=100
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Formato AARC",&
"Control de Viajes/Packing List",&
"Manifiesto General/Guía Mexicana"}
end type

type st_1 from statictext within w_rpt_documentos_manif
int X=146
int Y=380
int Width=274
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Documento:"
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

type st_2 from statictext within w_rpt_documentos_manif
int X=73
int Y=72
int Width=247
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Mercado:"
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

type ddlb_mer from dropdownlistbox within w_rpt_documentos_manif
int X=475
int Y=60
int Width=425
int Height=228
int TabOrder=10
boolean BringToTop=true
string Text="Extranjero"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Extranjero",&
"Nacional"}
end type

type cb_1 from uo_cbother within w_rpt_documentos_manif
int X=942
int Y=164
int Width=599
int TabOrder=20
boolean BringToTop=true
string Text="&Generar Doc. en HTML"
end type

event clicked;Integer	li_man, li_fac
String	ls_man, ls_fac, ls_cia, ls_mer, ls_chr, ls_pa1, ls_pa2, ls_dwf 
uo_DataStore	lds_1 

ls_mer = Left( ddlb_mer.Text, 1 )
ls_man = f_Trim( sle_2.Text )
ls_chr = Left( ls_man, 1 )
If Not f_Trim( ls_man ) = '' Then
	If Not IsNumber( ls_chr ) Then // Si no es un digito verificar si tiene la letra de mer_des
		If Not ls_chr = 'E' And Not ls_chr = 'N' Then
			ls_man = ls_mer + ls_man
		End If
		If Not ls_mer = ls_chr Then
			ddlb_mer.SetFocus( )
			MessageBox( Title, 'El Documento de Manifiesto no corresponde al tipo de mercado.', Exclamation! )
			Return 
		End If
	Else		
		ls_man = ls_mer + ls_man
	End If
End If

If ls_mer = 'N' Then
	ls_pa1 = '33' ; ls_pa2 = '35' // <---- Actualizar los parametros segun mercado /Nacional
Else
	ls_pa1 = '13' ; ls_pa2 = '15' // <---- Extranjero
End If

li_man = f_Zero( Integer( f_GetParmValue( ls_pa1 ) ) )
ls_fac = f_Trim( sle_1.Text )
li_fac = f_Zero( Integer( f_GetParmValue( ls_pa2 ) ) )

If li_man > 0 Then
	ls_man = Mid( ls_man, 2 )
	ls_man = Right( Fill( '0', li_man ) + ls_man, li_man )
	ls_man = ls_mer + ls_man
End If

/* Asigna el numero de factura con la cantidad de digitos ke este en parametros */
If li_fac > 0 Then 
	ls_fac = Right( Fill( '0', li_fac ) + ls_fac, li_fac )
End If

ls_cia = f_GetParmValue('3')

If rb_1.Checked Then
	ls_man = ''
	If f_Trim( sle_1.Text ) = '' Then
		MessageBox( Parent.Title, 'Debe ingresar el número de factura.', Exclamation! )
		Return
	End If
	Select	c_codigo_man
	Into		:ls_man
	From		t_manifiesto
	Where		c_codigo_tem = :gs_codtem
	And		c_numfac_man = :ls_fac
	And		c_merdes_man = :ls_mer
	And		c_activo_man = '1' ;
	
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_manifiesto. (c_numfac_man)' ) < 0 Then 
		RollBack Using SqlCa ;
		Return 
	End If

	ls_man = f_Trim(ls_man)
	If ls_man = '' Then
		MessageBox( Parent.Title, 'El número de factura no existe o el manifiesto está eliminado o cancelado.', Exclamation! )
		Return
	End If
Else
	If f_Trim( sle_2.Text ) = '' Then
		MessageBox( Parent.Title, 'Debe ingresar el número de manifiesto.', Exclamation! )
		Return
	End If
	ls_mer = ''
	Select	c_merdes_man
	Into		:ls_mer
	From		t_manifiesto
	Where		c_codigo_tem = :gs_codtem
	And		c_codigo_man = :ls_man
	And		c_activo_man = '1' ;
	
	If f_SqlError( SqlCa, 'No se pudo obtener información de la tabla t_manifiesto. (c_merdes_man)' ) < 0 Then 
		RollBack Using SqlCa ;
		Return 
	End If
	
	If ls_mer = '' Then
		MessageBox( Parent.Title, 'El número de manifiesto no existe o está eliminado o cancelado.', Exclamation! )
		Return
	End If
	
End If

f_RptFacHTML( ls_man ) 
end event

