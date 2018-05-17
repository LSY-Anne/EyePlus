$PBExportHeader$w_util_temporada_post_it.srw
forward
global type w_util_temporada_post_it from wa_response
end type
type st_1 from statictext within w_util_temporada_post_it
end type
type st_2 from statictext within w_util_temporada_post_it
end type
type st_3 from statictext within w_util_temporada_post_it
end type
type st_temporada from statictext within w_util_temporada_post_it
end type
type st_fecha from statictext within w_util_temporada_post_it
end type
type st_usuario from statictext within w_util_temporada_post_it
end type
type st_db from statictext within w_util_temporada_post_it
end type
end forward

global type w_util_temporada_post_it from wa_response
int Width=901
int Height=600
WindowType WindowType=main!
long BackColor=15793151
boolean MinBox=true
st_1 st_1
st_2 st_2
st_3 st_3
st_temporada st_temporada
st_fecha st_fecha
st_usuario st_usuario
st_db st_db
end type
global w_util_temporada_post_it w_util_temporada_post_it

on w_util_temporada_post_it.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_temporada=create st_temporada
this.st_fecha=create st_fecha
this.st_usuario=create st_usuario
this.st_db=create st_db
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_temporada
this.Control[iCurrent+5]=this.st_fecha
this.Control[iCurrent+6]=this.st_usuario
this.Control[iCurrent+7]=this.st_db
end on

on w_util_temporada_post_it.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_temporada)
destroy(this.st_fecha)
destroy(this.st_usuario)
destroy(this.st_db)
end on

event open;call super::open;Environment    lenv_env                                // holds environment information
Long	ll_x, ll_y

// Get the environment information
If ( GetEnvironment(lenv_env) <> 1 ) then
	MessageBox(	"System Information", &
					"Unable to get environment information.~nHalting ..." )
	Halt
End If

//Ubicar el post-it
ll_y = Long( ProfileString( gs_ini, gs_usuario, 'PostIt_Y', '0' ) )
ll_x = Long( ProfileString( gs_ini, gs_usuario, 'PostIt_X', '0' ) )

If ll_y = 0 Then
	ll_y = (PixelsToUnits(lenv_env.ScreenHeight, YPixelsToUnits!) - 1100)
End If

If ll_x = 0 Then
	ll_x = (PixelsToUnits(lenv_env.ScreenWidth, XPixelsToUnits!) -  1000)
End If

This.y = ll_y
This.x = ll_x

Title = gs_nomsis

st_db.Text = ProfileString( gs_ini, "DataBase", "ServerName", "") + ' - ' + &
				ProfileString( gs_ini, "DataBase", "database", "")

end event

event activate;String	ls_par, ls_fec


/* Definicion de temporada */
If gs_temporada = '' Then
	ls_par = '[No Definido]'
Else
	ls_par = gs_temporada
End If

f_GetSysDate( )

st_temporada.Text = ls_par
st_fecha.Text = String( gd_sys, 'dd/mm/yyyy' )
st_usuario.Text = gs_usuario


end event

event closequery;SetProfileString( gs_ini, gs_usuario, 'PostIt_Y', String(Y) ) 
SetProfileString( gs_ini, gs_usuario, 'PostIt_X', String(X) ) 

end event

type dw_list from wa_response`dw_list within w_util_temporada_post_it
int X=0
int Y=296
boolean Visible=false
boolean Enabled=false
boolean HScrollBar=false
boolean VScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_util_temporada_post_it
int X=197
int Y=316
int Width=123
int Height=88
boolean Visible=false
end type

event dw_1::itemchanged;call super::itemchanged;DateTime	ld_ini, ld_fin

AcceptText( )
ld_ini = Object.fechainiciosemana[row]
ld_fin = DateTime( RelativeDate( Date( ld_ini ), 6 ) )

Object.fechafinsemana[row] = ld_fin


end event

type cb_cancelar from wa_response`cb_cancelar within w_util_temporada_post_it
int X=1202
int Y=288
boolean Visible=false
end type

type cb_aceptar from wa_response`cb_aceptar within w_util_temporada_post_it
int X=823
int Y=288
boolean Visible=false
end type

event cb_aceptar::clicked;dw_1.AcceptText( )

If dw_1.Update( ) = 1 Then
	SetProfileString( gs_ini, 'System', 'Semana', dw_1.Object.idsemana[ 1] )
	SetProfileString( gs_ini, 'System', 'Inicio', String(dw_1.Object.fechainiciosemana[ 1], 'dd/mm/yyyy') )
	SetProfileString( gs_ini, 'System', 'Fin', String(dw_1.Object.fechafinsemana[ 1], 'dd/mm/yyyy') )
	Commit Using SqlCa ;
Else
	RollBack Using SqlCa ;
End If

Close( Parent )
	
end event

type st_1 from statictext within w_util_temporada_post_it
int X=32
int Y=16
int Width=832
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Temporada"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=15793151
int TextSize=-8
int Weight=400
string FaceName="Comic Sans MS"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Script!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_util_temporada_post_it
int X=32
int Y=176
int Width=832
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Fecha de Trabajo"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=15793151
int TextSize=-8
int Weight=400
string FaceName="Comic Sans MS"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Script!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_util_temporada_post_it
int X=32
int Y=304
int Width=832
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Usuario"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=15793151
int TextSize=-8
int Weight=400
string FaceName="Comic Sans MS"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Script!
FontPitch FontPitch=Variable!
end type

type st_temporada from statictext within w_util_temporada_post_it
int X=32
int Y=68
int Width=832
int Height=116
boolean Enabled=false
boolean BringToTop=true
string Text="Temporada"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=15793151
int TextSize=-8
int Weight=400
string FaceName="Comic Sans MS"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Script!
FontPitch FontPitch=Variable!
end type

type st_fecha from statictext within w_util_temporada_post_it
int X=32
int Y=228
int Width=832
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Fecha"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=15793151
int TextSize=-8
int Weight=400
string FaceName="Comic Sans MS"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Script!
FontPitch FontPitch=Variable!
end type

type st_usuario from statictext within w_util_temporada_post_it
int X=32
int Y=356
int Width=832
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Usuario"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=15793151
int TextSize=-8
int Weight=400
string FaceName="Comic Sans MS"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Script!
FontPitch FontPitch=Variable!
end type

type st_db from statictext within w_util_temporada_post_it
int X=32
int Y=404
int Width=832
int Height=80
boolean Enabled=false
boolean BringToTop=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=15793151
int TextSize=-8
int Weight=400
string FaceName="Comic Sans MS"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Script!
FontPitch FontPitch=Variable!
end type

