$PBExportHeader$w_util_asignar_opciones.srw
forward
global type w_util_asignar_opciones from wa_mant_edit
end type
type dw_mnu from uo_dw_list within w_util_asignar_opciones
end type
type dw_usu from datawindow within w_util_asignar_opciones
end type
type st_1 from statictext within w_util_asignar_opciones
end type
type cb_addall from uo_cbother within w_util_asignar_opciones
end type
type cb_add from uo_cbother within w_util_asignar_opciones
end type
type cb_del from uo_cbother within w_util_asignar_opciones
end type
type cb_delall from uo_cbother within w_util_asignar_opciones
end type
type dw_usm from uo_dw_list within w_util_asignar_opciones
end type
type cb_aplicar from uo_cbother within w_util_asignar_opciones
end type
end forward

global type w_util_asignar_opciones from wa_mant_edit
int Width=2222
int Height=1360
boolean TitleBar=true
string Title="Asignar Opciones de Menu"
long BackColor=79741120
dw_mnu dw_mnu
dw_usu dw_usu
st_1 st_1
cb_addall cb_addall
cb_add cb_add
cb_del cb_del
cb_delall cb_delall
dw_usm dw_usm
cb_aplicar cb_aplicar
end type
global w_util_asignar_opciones w_util_asignar_opciones

forward prototypes
public function boolean wf_aplicar ()
public function integer wf_aceptar ()
end prototypes

public function boolean wf_aplicar ();Integer	i

For i = 1 To dw_usm.RowCount( )
	dw_usm.Object.c_codigo_usu[i] = dw_usu.Object.c_codigo_usu[1]
	dw_usm.Object.c_usucre_usm[i] = gs_usuario
	dw_usm.Object.d_creacion_usm[i] = DateTime(Today( ))
	dw_usm.Object.c_activo_usm[i] = '1'
Next

dw_usm.AcceptText( )
If dw_usm.Update( ) = 1 Then
	Commit Using SqlCa ;
Else
	RollBack Using SqlCa ;
	MessageBox( Title, 'Los cambios no han sido guardados.', StopSign! )
	Return False
End If

cb_aplicar.Enabled = False

Return True
end function

public function integer wf_aceptar ();If wf_Aplicar( ) Then
	Close( This )
	Return 1
Else
	Return -1
End If
end function

on w_util_asignar_opciones.create
int iCurrent
call super::create
this.dw_mnu=create dw_mnu
this.dw_usu=create dw_usu
this.st_1=create st_1
this.cb_addall=create cb_addall
this.cb_add=create cb_add
this.cb_del=create cb_del
this.cb_delall=create cb_delall
this.dw_usm=create dw_usm
this.cb_aplicar=create cb_aplicar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mnu
this.Control[iCurrent+2]=this.dw_usu
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_addall
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.cb_del
this.Control[iCurrent+7]=this.cb_delall
this.Control[iCurrent+8]=this.dw_usm
this.Control[iCurrent+9]=this.cb_aplicar
end on

on w_util_asignar_opciones.destroy
call super::destroy
destroy(this.dw_mnu)
destroy(this.dw_usu)
destroy(this.st_1)
destroy(this.cb_addall)
destroy(this.cb_add)
destroy(this.cb_del)
destroy(this.cb_delall)
destroy(this.dw_usm)
destroy(this.cb_aplicar)
end on

event open;istr_parm.w_win[1] = gw_frame

f_CenterWindow( This )

dw_usu.SetTransObject( SqlCa )
dw_usu.InsertRow( 0 )

dw_mnu.SetTransObject( SqlCa )

dw_usm.SetTransObject( SqlCa )

dw_1.Visible = False


end event

type dw_1 from wa_mant_edit`dw_1 within w_util_asignar_opciones
int X=37
int Y=1132
int Width=155
int Height=88
int TabOrder=0
end type

type cb_cancelar from wa_mant_edit`cb_cancelar within w_util_asignar_opciones
int X=1810
int Y=1136
int TabOrder=90
end type

type cb_aceptar from wa_mant_edit`cb_aceptar within w_util_asignar_opciones
int X=1065
int Y=1136
int TabOrder=80
end type

type dw_mnu from uo_dw_list within w_util_asignar_opciones
int X=46
int Y=152
int Width=978
int Height=952
int TabOrder=20
boolean BringToTop=true
string DataObject="d_util_asignar_opciones_part1"
end type

event doubleclicked;cb_add.TriggerEvent( Clicked! )
end event

type dw_usu from datawindow within w_util_asignar_opciones
int X=265
int Y=44
int Width=782
int Height=88
int TabOrder=10
boolean BringToTop=true
string DataObject="d_ext_usuario"
boolean Border=false
boolean LiveScroll=true
end type

event itemchanged;dw_mnu.Retrieve( data )
dw_usm.Retrieve( data )

cb_add.Enabled = True
cb_addall.Enabled = True
cb_del.Enabled = True
cb_delall.Enabled = True

end event

type st_1 from statictext within w_util_asignar_opciones
int X=46
int Y=48
int Width=197
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Usuario:"
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

type cb_addall from uo_cbother within w_util_asignar_opciones
int X=1042
int Y=316
int Width=119
int TabOrder=30
boolean Enabled=false
boolean BringToTop=true
string Text=">>"
end type

event clicked;Integer	i, j

If dw_mnu.RowCount( ) <= 0 Then 
	Beep(1)
	Return
End If

For i = 1 To dw_mnu.RowCount( )
	j = dw_usm.InsertRow(0)
	dw_usm.Object.c_codigo_mnu[j] = dw_mnu.Object.c_codigo_mnu[i] 
	dw_usm.Object.v_nombre_mnu[j] = dw_mnu.Object.v_nombre_mnu[i] 
Next

dw_mnu.Reset( )
dw_usm.AcceptText( )

cb_aplicar.Enabled = True
cb_aceptar.Enabled = True

end event

type cb_add from uo_cbother within w_util_asignar_opciones
int X=1042
int Y=424
int Width=119
int TabOrder=40
boolean Enabled=false
boolean BringToTop=true
string Text=">"
end type

event clicked;Integer	i, j


If dw_mnu.RowCount( ) <= 0 Then 
	Beep(1)
	Return
End If

i = dw_mnu.GetRow( )
j = dw_usm.InsertRow(0)

dw_usm.Object.c_codigo_mnu[j] = dw_mnu.Object.c_codigo_mnu[i] 
dw_usm.Object.v_nombre_mnu[j] = dw_mnu.Object.v_nombre_mnu[i] 

dw_usm.AcceptText( )

dw_mnu.DeleteRow( i )

cb_aplicar.Enabled = True
cb_aceptar.Enabled = True

end event

type cb_del from uo_cbother within w_util_asignar_opciones
int X=1042
int Y=532
int Width=119
int TabOrder=50
boolean Enabled=false
boolean BringToTop=true
string Text="<"
end type

event clicked;Integer	i, j


If dw_usm.RowCount( ) <= 0 Then 
	Beep(1)
	Return
End If

i = dw_usm.GetRow( )
j = dw_mnu.InsertRow(0)

dw_mnu.Object.c_codigo_mnu[j] = dw_usm.Object.c_codigo_mnu[i] 
dw_mnu.Object.v_nombre_mnu[j] = dw_usm.Object.v_nombre_mnu[i] 

dw_mnu.AcceptText( )

dw_usm.DeleteRow( i )

cb_aplicar.Enabled = True
cb_aceptar.Enabled = True

end event

type cb_delall from uo_cbother within w_util_asignar_opciones
int X=1042
int Y=640
int Width=119
int TabOrder=70
boolean Enabled=false
boolean BringToTop=true
string Text="<<"
end type

event clicked;Integer	i, j


If dw_usm.RowCount( ) <= 0 Then 
	Beep(1)
	Return
End If

For i = 1 To dw_usm.RowCount( )
	j = dw_mnu.InsertRow(0)
	dw_mnu.Object.c_codigo_mnu[j] = dw_usm.Object.c_codigo_mnu[i] 
	dw_mnu.Object.v_nombre_mnu[j] = dw_usm.Object.v_nombre_mnu[i] 
Next

dw_mnu.AcceptText( )

Do While dw_usm.RowCount( ) > 0
	dw_usm.DeleteRow( 0 )
Loop

cb_aplicar.Enabled = True
cb_aceptar.Enabled = True

end event

type dw_usm from uo_dw_list within w_util_asignar_opciones
int X=1179
int Y=152
int Width=978
int Height=952
int TabOrder=60
boolean BringToTop=true
string DataObject="d_util_asignar_opciones_part2"
end type

event doubleclicked;cb_del.TriggerEvent( Clicked! )
end event

type cb_aplicar from uo_cbother within w_util_asignar_opciones
int X=1435
int Y=1136
int TabOrder=90
boolean Enabled=false
boolean BringToTop=true
string Text="&Aplicar"
end type

event clicked;wf_Aplicar( )
end event

