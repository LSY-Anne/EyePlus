$PBExportHeader$w_child_status_bar.srw
forward
global type w_child_status_bar from window
end type
type uo_block4 from uo_status_block within w_child_status_bar
end type
type uo_block3 from uo_status_block within w_child_status_bar
end type
type uo_block2 from uo_status_block within w_child_status_bar
end type
type uo_block1 from uo_status_block within w_child_status_bar
end type
end forward

global type w_child_status_bar from window
integer x = 1531
integer y = 1568
integer width = 2382
integer height = 136
boolean enabled = false
boolean border = false
windowtype windowtype = child!
long backcolor = 79741120
uo_block4 uo_block4
uo_block3 uo_block3
uo_block2 uo_block2
uo_block1 uo_block1
end type
global w_child_status_bar w_child_status_bar

forward prototypes
public function integer wf_setposition ()
end prototypes

public function integer wf_setposition ();environment    lenv_env                                // holds environment information

// Get the environment information
If ( GetEnvironment(lenv_env) <> 1 ) then
       MessageBox( "Application: Open", &
               "Unable to get environment information.~nHalting ..." )

       halt
End if
This.y = gw_frame.Height - (This.Height) - 105
This.x = gw_frame.Width - (This.Width) - 150

uo_block3.uf_SetText( gs_usuario )
Show()

Return 1
end function

on w_child_status_bar.create
this.uo_block4=create uo_block4
this.uo_block3=create uo_block3
this.uo_block2=create uo_block2
this.uo_block1=create uo_block1
this.Control[]={this.uo_block4,&
this.uo_block3,&
this.uo_block2,&
this.uo_block1}
end on

on w_child_status_bar.destroy
destroy(this.uo_block4)
destroy(this.uo_block3)
destroy(this.uo_block2)
destroy(this.uo_block1)
end on

event open;Timer(0.5)

Width = uo_block1.Width + uo_block2.Width + uo_block2.Width + uo_block2.Width 
Height = 136


wf_SetPosition()
end event

event activate;
wf_SetPosition( )

end event

event timer;Show()
end event

type uo_block4 from uo_status_block within w_child_status_bar
integer x = 1477
integer width = 704
integer height = 64
integer taborder = 20
end type

on uo_block4.destroy
call uo_status_block::destroy
end on

type uo_block3 from uo_status_block within w_child_status_bar
integer x = 1120
integer width = 361
integer height = 64
integer taborder = 30
end type

on uo_block3.destroy
call uo_status_block::destroy
end on

type uo_block2 from uo_status_block within w_child_status_bar
integer x = 635
integer width = 494
integer height = 64
integer taborder = 10
end type

on uo_block2.destroy
call uo_status_block::destroy
end on

type uo_block1 from uo_status_block within w_child_status_bar
integer width = 640
integer height = 64
integer taborder = 40
end type

on uo_block1.destroy
call uo_status_block::destroy
end on

