$PBExportHeader$w_dw_print_options.srw
$PBExportComments$Ventana de impresión
forward
global type w_dw_print_options from window
end type
type cb_file from commandbutton within w_dw_print_options
end type
type st_print_file from statictext within w_dw_print_options
end type
type st_pf from statictext within w_dw_print_options
end type
type ddlb_range from dropdownlistbox within w_dw_print_options
end type
type st_4 from statictext within w_dw_print_options
end type
type cb_printer from commandbutton within w_dw_print_options
end type
type cb_cancel from commandbutton within w_dw_print_options
end type
type cbx_collate from checkbox within w_dw_print_options
end type
type cbx_print_to_file from checkbox within w_dw_print_options
end type
type st_3 from statictext within w_dw_print_options
end type
type sle_page_range from singlelineedit within w_dw_print_options
end type
type rb_pages from radiobutton within w_dw_print_options
end type
type rb_current_page from radiobutton within w_dw_print_options
end type
type rb_all from radiobutton within w_dw_print_options
end type
type em_copies from editmask within w_dw_print_options
end type
type st_2 from statictext within w_dw_print_options
end type
type sle_printer from singlelineedit within w_dw_print_options
end type
type st_1 from statictext within w_dw_print_options
end type
type cb_ok from commandbutton within w_dw_print_options
end type
type gb_1 from groupbox within w_dw_print_options
end type
end forward

global type w_dw_print_options from window
integer x = 677
integer y = 268
integer width = 1856
integer height = 980
boolean titlebar = true
string title = "Opciones de Impresión"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79416533
cb_file cb_file
st_print_file st_print_file
st_pf st_pf
ddlb_range ddlb_range
st_4 st_4
cb_printer cb_printer
cb_cancel cb_cancel
cbx_collate cbx_collate
cbx_print_to_file cbx_print_to_file
st_3 st_3
sle_page_range sle_page_range
rb_pages rb_pages
rb_current_page rb_current_page
rb_all rb_all
em_copies em_copies
st_2 st_2
sle_printer sle_printer
st_1 st_1
cb_ok cb_ok
gb_1 gb_1
end type
global w_dw_print_options w_dw_print_options

type variables
string is_page_range
datawindow idw_dw
end variables

forward prototypes
private subroutine wf_page_range (radiobutton who)
public subroutine wf_enable_printfile ()
public subroutine wf_disable_printfile ()
end prototypes

private subroutine wf_page_range (radiobutton who);choose case who
	case rb_all
		sle_page_range.text = ''
		sle_page_range.enabled = false
		is_page_range = 'a'
	case rb_current_page
		sle_page_range.text = ''
		sle_page_range.enabled = false
		is_page_range = 'c'
	case rb_pages		
		sle_page_range.enabled = true
		is_page_range = 'p'
end choose
end subroutine

public subroutine wf_enable_printfile ();//show all items related to choosing a file
st_pf.visible = true
st_print_file.visible = true
cb_file.visible = true
end subroutine

public subroutine wf_disable_printfile ();//hide all items related to choosing a file
st_pf.visible = false
st_print_file.visible = false
cb_file.visible = false
st_print_file.text = ''
end subroutine

event open;// we assume that this window will be opened using openwitparm and that
// a datawindow control will be passed to it

String ls_rc, ls_modstring


idw_dw = message.powerobjectparm

f_CenterWindow( This )

sle_printer.text = idw_dw.describe('datawindow.printer')

//set the page print include (all,even,odd)

ls_rc = idw_dw.Describe('datawindow.print.page.rangeinclude')

choose case Left(ls_rc,1)  // determine rangeinclude (all,even,odd)
	case '0' // all
		ddlb_range.SelectItem(1) 
		is_page_range = 'a'
	case '1' // even
		ddlb_range.SelectItem(2) 
		is_page_range = 'e'
	case '2' //odd
		ddlb_range.SelectItem(3) 
		is_page_range = 'o'
end choose


//if cbx_collate.checked then // collate output

ls_rc = idw_dw.describe('datawindow.print.collate')

If ls_rc = "yes" Then
	cbx_collate.checked = True
ElseIf ls_rc = "no" Then
	cbx_collate.checked = False
End If


//page_range 
ls_rc = idw_dw.describe('datawindow.print.page.range')
If ls_rc = "" Then
	is_page_range = "a"
	rb_all.checked = true
Else
	is_page_range = "p"
	rb_pages.checked =true
	sle_page_range.text = ls_rc
End If

//// number of copies ?
ls_rc = idw_dw.describe('datawindow.print.copies')

//copies = 0 is actually 1 copy.....

If ls_rc = "0" Then ls_rc = "1"
em_copies.text = ls_rc

//print to file ?
ls_rc = idw_dw.describe('datawindow.print.filename')
If ls_rc <> "" and ls_rc <>"!"Then 
	cbx_print_to_file.checked = True
	wf_enable_printfile()
	//strip the ~'s out of the file name to display properly
	ls_rc = f_GlobalReplace(ls_rc,"~~","")
	st_print_file.text = ls_rc
Else
	cbx_print_to_file.checked = False
	wf_disable_printfile()
End If


//fecha y hora
ls_modstring = "string(today(),'dd-mm-yyyy') + '   ' + string(now(),'hh:mm')"
ls_modstring = 'fechahora.Expression = "'+ls_modstring+ '"'
ls_modstring = idw_dw.Modify(ls_modstring)

/*If ls_modstring <> "" Then
	Messagebox("",ls_modstring)
End If*/

end event

on w_dw_print_options.create
this.cb_file=create cb_file
this.st_print_file=create st_print_file
this.st_pf=create st_pf
this.ddlb_range=create ddlb_range
this.st_4=create st_4
this.cb_printer=create cb_printer
this.cb_cancel=create cb_cancel
this.cbx_collate=create cbx_collate
this.cbx_print_to_file=create cbx_print_to_file
this.st_3=create st_3
this.sle_page_range=create sle_page_range
this.rb_pages=create rb_pages
this.rb_current_page=create rb_current_page
this.rb_all=create rb_all
this.em_copies=create em_copies
this.st_2=create st_2
this.sle_printer=create sle_printer
this.st_1=create st_1
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.Control[]={this.cb_file,&
this.st_print_file,&
this.st_pf,&
this.ddlb_range,&
this.st_4,&
this.cb_printer,&
this.cb_cancel,&
this.cbx_collate,&
this.cbx_print_to_file,&
this.st_3,&
this.sle_page_range,&
this.rb_pages,&
this.rb_current_page,&
this.rb_all,&
this.em_copies,&
this.st_2,&
this.sle_printer,&
this.st_1,&
this.cb_ok,&
this.gb_1}
end on

on w_dw_print_options.destroy
destroy(this.cb_file)
destroy(this.st_print_file)
destroy(this.st_pf)
destroy(this.ddlb_range)
destroy(this.st_4)
destroy(this.cb_printer)
destroy(this.cb_cancel)
destroy(this.cbx_collate)
destroy(this.cbx_print_to_file)
destroy(this.st_3)
destroy(this.sle_page_range)
destroy(this.rb_pages)
destroy(this.rb_current_page)
destroy(this.rb_all)
destroy(this.em_copies)
destroy(this.st_2)
destroy(this.sle_printer)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.gb_1)
end on

event activate;SetMicrohelp("Opciones de Impresión")
end event

type cb_file from commandbutton within w_dw_print_options
integer x = 1426
integer y = 936
integer width = 370
integer height = 100
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Archivos..."
end type

event clicked;string ls_temp 
string ls_file
int li_rc
li_rc = GetFileSaveName("Imprimir a archivo", ls_file, ls_temp, "PRN", "Print (*.PRN),*.PRN")

If li_rc = 1 Then	st_print_file.text = ls_file
end event

type st_print_file from statictext within w_dw_print_options
integer x = 375
integer y = 932
integer width = 965
integer height = 96
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_pf from statictext within w_dw_print_options
integer x = 78
integer y = 952
integer width = 251
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Print File:"
boolean focusrectangle = false
end type

type ddlb_range from dropdownlistbox within w_dw_print_options
integer x = 274
integer y = 768
integer width = 1070
integer height = 288
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Rango de páginas"
boolean sorted = false
string item[] = {"Rango de páginas","Pares","Impares"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_dw_print_options
integer x = 41
integer y = 776
integer width = 183
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
boolean enabled = false
string text = "Im&primir:"
boolean focusrectangle = false
end type

type cb_printer from commandbutton within w_dw_print_options
integer x = 1426
integer y = 408
integer width = 347
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Impresora"
end type

event clicked;String		ls_setting
PrintSetup()

sle_printer.text = idw_dw.Object.DataWindow.Printer

idw_dw.SetRedraw( False )
ls_setting = sle_printer.text 
idw_dw.Modify("DataWindow.print.preview=No")
idw_dw.Modify("DataWindow.print.preview=YES")
idw_dw.SetRedraw( True )

//openwithparm(w_printer,idw_dw)
sle_printer.text = idw_dw.Object.DataWindow.Printer

end event

type cb_cancel from commandbutton within w_dw_print_options
integer x = 1426
integer y = 276
integer width = 347
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, -1)
end event

type cbx_collate from checkbox within w_dw_print_options
integer x = 1367
integer y = 692
integer width = 494
integer height = 72
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "Collate Cop&ies"
end type

type cbx_print_to_file from checkbox within w_dw_print_options
integer x = 1367
integer y = 604
integer width = 494
integer height = 72
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "Impr. a Archivo"
end type

on clicked;If this.checked Then
	wf_enable_printfile()
Else
	wf_disable_printfile()
End If
end on

type st_3 from statictext within w_dw_print_options
integer x = 69
integer y = 576
integer width = 1239
integer height = 128
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
boolean enabled = false
string text = "Entre Número de Páginas y/o rangos de página separados por comas. Por ejemplo, 2,5,8-10"
boolean focusrectangle = false
end type

type sle_page_range from singlelineedit within w_dw_print_options
integer x = 443
integer y = 464
integer width = 864
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type rb_pages from radiobutton within w_dw_print_options
integer x = 87
integer y = 468
integer width = 347
integer height = 72
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "Pá&ginas:"
end type

on clicked;wf_page_range(this)
end on

type rb_current_page from radiobutton within w_dw_print_options
integer x = 87
integer y = 388
integer width = 480
integer height = 72
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "Página A&ctual"
end type

on clicked;wf_page_range(this)
end on

type rb_all from radiobutton within w_dw_print_options
integer x = 87
integer y = 308
integer width = 270
integer height = 72
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "&Todo"
end type

on clicked;wf_page_range(this)
end on

type em_copies from editmask within w_dw_print_options
integer x = 274
integer y = 128
integer width = 183
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "1"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_2 from statictext within w_dw_print_options
integer x = 41
integer y = 144
integer width = 215
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
boolean enabled = false
string text = "Copias:"
boolean focusrectangle = false
end type

type sle_printer from singlelineedit within w_dw_print_options
integer x = 274
integer y = 36
integer width = 1408
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33638660
long backcolor = 79416533
boolean border = false
boolean autohscroll = false
boolean hideselection = false
end type

type st_1 from statictext within w_dw_print_options
integer x = 41
integer y = 36
integer width = 329
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
boolean enabled = false
string text = "Impresora:"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_dw_print_options
integer x = 1426
integer y = 144
integer width = 347
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
boolean default = true
end type

event clicked;string tmp, command
long row 
string	docname, named, ls_modstring
int	value

ls_modstring = 'fecha.text = "'+string(today(),"dd-mm-yyyy")+'" hora.text = "' +string(now(),"hh:mm")+'"'
idw_dw.Modify(ls_modstring)

choose case lower(left(ddlb_range.text,1)) // determine rangeinclude (all,even,odd)
	case 'r' // all  - rango
		tmp = '0'
	case 'p' // even - pares
		tmp = '1'
	case 'i' //odd  - impares
		tmp = '2'
end choose
command = 'datawindow.print.page.rangeinclude = '+tmp

if cbx_collate.checked then // collate output ?
	command = command +  " datawindow.print.collate = yes"
else
	command = command +  " datawindow.print.collate = no"
end if
choose case is_page_range // did they pick a page range?
	case 'a'  // all
		tmp = ''
	case 'c' // current page?
		row = idw_dw.getrow()
		tmp = idw_dw.describe("evaluate('page()',"+string(row)+")")
	case 'p' // a range?
		tmp = sle_page_range.text
end choose		
command = command +  " datawindow.print.page.range = '"+tmp+"'"

// number of copies ?
if len(em_copies.text) > 0 then command = command +  " datawindow.print.copies = "+em_copies.text

If cbx_print_to_file.checked  and st_print_file.text = "" Then // print to file and no file seleted yet?
	value = GetFileSaveName("Print To File", docname, named, "PRN", "Print (*.PRN),*.PRN")
	if value = 1 then 
		st_print_file.text= docname
	else // they canceled out of the dialog so quit completely
		return
	end if
end if

If cbx_print_to_file.checked Then
	command = command + " datawindow.print.filename = '"+st_print_file.text+"'"
Else
	command = command + " datawindow.print.filename = '' "
End If

// now alter the datawindow
tmp = idw_dw.modify(command)
If len(tmp) > 0 then // if error the display the 
	messagebox('Opciones de Impresión','Error message = ' + tmp + '~r~nCommand = ' + command)
	return
End if
ls_modstring = 'fecha.text = " " hora.text = " "'
idw_dw.Modify(ls_modstring)

CloseWithReturn(parent,1)

end event

type gb_1 from groupbox within w_dw_print_options
integer x = 41
integer y = 232
integer width = 1303
integer height = 492
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "Rango de Páginas "
end type

