$PBExportHeader$w_arch_opciones.srw
forward
global type w_arch_opciones from Window
end type
type dw_2 from datawindow within w_arch_opciones
end type
type dw_1 from datawindow within w_arch_opciones
end type
type dw_header from datawindow within w_arch_opciones
end type
type ln_1 from line within w_arch_opciones
end type
type ln_2 from line within w_arch_opciones
end type
type ln_h1 from line within w_arch_opciones
end type
type ln_h2 from line within w_arch_opciones
end type
end forward

global type w_arch_opciones from Window
int X=27
int Y=4
int Width=4059
int Height=2188
boolean TitleBar=true
boolean Resizable=true
WindowState WindowState=maximized!
dw_2 dw_2
dw_1 dw_1
dw_header dw_header
ln_1 ln_1
ln_2 ln_2
ln_h1 ln_h1
ln_h2 ln_h2
end type
global w_arch_opciones w_arch_opciones

on w_arch_opciones.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.dw_header=create dw_header
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_h1=create ln_h1
this.ln_h2=create ln_h2
this.Control[]={this.dw_2,&
this.dw_1,&
this.dw_header,&
this.ln_1,&
this.ln_2,&
this.ln_h1,&
this.ln_h2}
end on

on w_arch_opciones.destroy
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.dw_header)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_h1)
destroy(this.ln_h2)
end on

event open;dw_header.InsertRow(0)
dw_2.InsertRow(0)

end event

event resize;dw_header.width = newwidth
ln_1.BeginY = 1
ln_1.EndY = newheight

ln_h1.BeginX = 1
ln_h1.EndX = newwidth

ln_h2.BeginX = 1
ln_h2.EndX = newwidth

ln_2.BeginY = 1
ln_2.EndY = newheight

end event

event activate;This.WindowState = Maximized!
end event

type dw_2 from datawindow within w_arch_opciones
int X=1394
int Y=648
int Width=1760
int Height=924
int TabOrder=20
string DataObject="d_arch_palet_normal_web"
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_arch_opciones
int Y=472
int Width=759
int Height=828
int TabOrder=10
string DataObject="d_arch_opciones"
boolean Border=false
boolean LiveScroll=true
end type

type dw_header from datawindow within w_arch_opciones
int Width=3753
int Height=416
int TabOrder=30
string DataObject="d_arch_opciones_header"
boolean Border=false
boolean LiveScroll=true
end type

type ln_1 from line within w_arch_opciones
boolean Enabled=false
int BeginX=782
int BeginY=568
int EndX=782
int EndY=1396
int LineThickness=8
long LineColor=32238571
end type

type ln_2 from line within w_arch_opciones
boolean Enabled=false
int BeginX=773
int BeginY=556
int EndX=773
int EndY=1256
int LineThickness=4
long LineColor=276856960
end type

type ln_h1 from line within w_arch_opciones
boolean Enabled=false
int BeginX=-27
int BeginY=432
int EndX=1083
int EndY=436
int LineThickness=8
long LineColor=32238571
end type

type ln_h2 from line within w_arch_opciones
boolean Enabled=false
int BeginX=-110
int BeginY=428
int EndX=1001
int EndY=428
int LineThickness=4
long LineColor=276856960
end type

