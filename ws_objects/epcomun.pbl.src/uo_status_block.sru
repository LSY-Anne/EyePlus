$PBExportHeader$uo_status_block.sru
forward
global type uo_status_block from UserObject
end type
type ln_s2 from line within uo_status_block
end type
type st_status from statictext within uo_status_block
end type
type ln_s1 from line within uo_status_block
end type
type ln_3 from line within uo_status_block
end type
type ln_4 from line within uo_status_block
end type
end forward

global type uo_status_block from UserObject
int Width=667
int Height=92
long BackColor=79741120
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
ln_s2 ln_s2
st_status st_status
ln_s1 ln_s1
ln_3 ln_3
ln_4 ln_4
end type
global uo_status_block uo_status_block

forward prototypes
public function string uf_gettext ()
public function string uf_settext (string as_status)
end prototypes

public function string uf_gettext ();Return st_status.Text
end function

public function string uf_settext (string as_status);String	ls_text

ls_text = st_status.Text
st_status.Text = as_status

Return ls_text

end function

on uo_status_block.create
this.ln_s2=create ln_s2
this.st_status=create st_status
this.ln_s1=create ln_s1
this.ln_3=create ln_3
this.ln_4=create ln_4
this.Control[]={this.ln_s2,&
this.st_status,&
this.ln_s1,&
this.ln_3,&
this.ln_4}
end on

on uo_status_block.destroy
destroy(this.ln_s2)
destroy(this.st_status)
destroy(this.ln_s1)
destroy(this.ln_3)
destroy(this.ln_4)
end on

event constructor;st_status.width = width 
end event

type ln_s2 from line within uo_status_block
boolean Enabled=false
int BeginX=5
int EndX=5
int EndY=60
int LineThickness=4
long LineColor=276856960
end type

type st_status from statictext within uo_status_block
int X=9
int Width=1125
int Height=48
boolean Enabled=false
Alignment Alignment=Center!
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

type ln_s1 from line within uo_status_block
boolean Enabled=false
int EndY=60
int LineThickness=4
long LineColor=1090519039
end type

type ln_3 from line within uo_status_block
boolean Enabled=false
int BeginY=56
int EndX=2117
int EndY=56
int LineThickness=4
long LineColor=276856960
end type

type ln_4 from line within uo_status_block
boolean Enabled=false
int BeginX=5
int BeginY=52
int EndX=2121
int EndY=52
int LineThickness=4
long LineColor=1090519039
end type

