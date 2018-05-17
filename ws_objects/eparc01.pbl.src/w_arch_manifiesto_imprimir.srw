$PBExportHeader$w_arch_manifiesto_imprimir.srw
forward
global type w_arch_manifiesto_imprimir from wa_response
end type
type st_1 from statictext within w_arch_manifiesto_imprimir
end type
end forward

global type w_arch_manifiesto_imprimir from wa_response
int Width=1390
int Height=844
boolean TitleBar=true
string Title="Impresión de Documentos de Manifiesto/Guia"
boolean ControlMenu=false
st_1 st_1
end type
global w_arch_manifiesto_imprimir w_arch_manifiesto_imprimir

type variables
Integer ii_listado = 7
end variables

forward prototypes
public subroutine wf_setdocuments ()
public function integer wf_formatochiquita (string as_tem, string as_man)
public function integer wf_chiquita_beltran (string as_tem, string as_man)
public function integer wf_chiquita_sanemilio (string as_tem, string as_man)
public function integer wf_generastateresa (string as_tem, string as_man)
end prototypes

public subroutine wf_setdocuments ();/* wf_SetDocuments( ) */

dw_list.Object.v_documento[ 1] = 'Factura'
dw_list.Object.v_documento[ 2] = 'Formato AARC'
dw_list.Object.v_documento[ 3] = 'Control de Viajes x Lote Produc.'
dw_list.Object.v_documento[ 4] = 'Control de Viajes/Packing List'
dw_list.Object.v_documento[ 5] = 'Manifiesto General/Guía Mexicana'
dw_list.Object.v_documento[ 6] = 'Manifiesto del Chofer'
dw_list.Object.v_documento[ 8] = 'Certificado Fitosanitario'
dw_list.Object.v_documento[ 9] = 'Certificado de Origen'
dw_list.Object.v_documento[10] = 'Manifiesto SHANNON'
dw_list.Object.v_documento[11] = 'Reporte de Colores Por Manifiesto'
dw_list.Object.v_documento[12] = 'Reporte de Carta Promoción'
dw_list.Object.v_documento[13] = 'Manifiesto Premier'
dw_list.Object.v_documento[14] = 'Carta traslado'
dw_list.Object.v_documento[15] = 'CFI'
dw_list.Object.v_documento[16] = 'Sello de Seguridad'
dw_list.Object.v_documento[17] = 'Factura con Formato'
dw_list.Object.v_documento[18] = 'Formato Chiquita'
dw_list.Object.v_documento[19] = 'Factura Carta Material'
dw_list.Object.v_documento[20] = 'Remision'
dw_list.Object.v_documento[21] = 'Nota de Embarque'
dw_list.Object.v_documento[22] = 'Manifiesto Pacific Brokerage '

dw_list.AcceptText( )
end subroutine

public function integer wf_formatochiquita (string as_tem, string as_man);/* wf_formatochiquita() */
Datastore lds_manifiesto
String    ls_tem, ls_man, ls_docname, ls_named, ls_ruta, ls_codigo, ls_hoja, ls_var, ls_size
Integer   li_ok, li_hojas, li_hoja
Long      i, l, col, ren, ll_rens, ll_pallet, ll_cajas
OLEObject ole_Book, ole_Hoja, ole_excel

ls_ruta = f_getparmvalue('086')
ls_codigo = f_getparmvalue('087')
ls_docname = 'Chiquita.xls'

lds_manifiesto  = Create Datastore
lds_manifiesto.Dataobject = 'd_arch_chiquita'
lds_manifiesto.Settransobject(Sqlca)
lds_manifiesto.Retrieve(as_tem, as_man)
ll_rens = lds_manifiesto.Rowcount()

//Create an OLE Excel Object
ole_Excel = CREATE OLEObject
li_ok = ole_Excel.ConnectToNewObject( "Excel.Application")
//Create an OLE Excel Object
ole_Book = CREATE OLEObject
ole_Book = ole_Excel.Workbooks.Open( ls_ruta + ls_docname )

ole_Hoja = CREATE OLEObject
ole_Hoja = ole_Book.ActiveSheet

ole_Excel.Sheets(1).Select
ole_Excel.Visible = True

//Poner los Encabezados
ole_Excel.Range("D5").FormulaR1C1  = lds_manifiesto.Object.invoice[1]
ole_Excel.Range("D6").FormulaR1C1  = ls_codigo + Right('000' + lds_manifiesto.Object.Pool[1], 3)
ole_Excel.Range("D7").FormulaR1C1  = lds_manifiesto.Object.distribuidor[1]
ole_Excel.Range("D8").FormulaR1C1  = lds_manifiesto.Object.direccion[1]
ole_Excel.Range("D9").FormulaR1C1  = lds_manifiesto.Object.ciudad[1]
ole_Excel.Range("C13").FormulaR1C1 = lds_manifiesto.Object.FDA[1]
ole_Excel.Range("C14").FormulaR1C1 = lds_manifiesto.Object.Transporter[1]
ole_Excel.Range("C15").FormulaR1C1 = lds_manifiesto.Object.Truck_ID2[1]
ole_Excel.Range("C16").FormulaR1C1 = lds_manifiesto.Object.Plates2[1]
ole_Excel.Range("C17").FormulaR1C1 = lds_manifiesto.Object.Truck_ID[1]
ole_Excel.Range("C18").FormulaR1C1 = lds_manifiesto.Object.SCAC[1]
ole_Excel.Range("C19").FormulaR1C1 = lds_manifiesto.Object.Chofer[1]
ole_Excel.Range("F19").FormulaR1C1 = lds_manifiesto.Object.License[1]
ole_Excel.Range("C20").FormulaR1C1 = lds_manifiesto.Object.Origin[1]
ole_Excel.Range("C21").FormulaR1C1 = lds_manifiesto.Object.PackDate[1]
ole_Excel.Range("E21").FormulaR1C1 = lds_manifiesto.Object.Packtime[1]
ole_Excel.Range("C22").FormulaR1C1 = lds_manifiesto.Object.Crossing[1]
ole_Excel.Range("C23").FormulaR1C1 = lds_manifiesto.Object.DepartureDate[1]
ole_Excel.Range("D24").FormulaR1C1 = lds_manifiesto.Object.Total_Cases[1]
ole_Excel.Range("C25").FormulaR1C1 = lds_manifiesto.Object.Temperature[1]

//Llenar Los Datos
ll_Rens = 28
For i = 1 To lds_manifiesto.Rowcount()
 ole_Excel.Cells(ll_Rens, 1).Value = i
 ole_Excel.Cells(ll_Rens, 2).Value = 'MV' + lds_manifiesto.Object.Pallet[i]
 ole_Excel.Cells(ll_Rens, 3).Value = lds_manifiesto.Object.Field[i]
 ole_Excel.Cells(ll_Rens, 4).Value = lds_manifiesto.Object.Block[i]
 ole_Excel.Cells(ll_Rens, 5).Value = lds_manifiesto.Object.Variety[i]
 ole_Excel.Cells(ll_Rens, 6).Value = lds_manifiesto.Object.Pack[i]
 ole_Excel.Cells(ll_Rens, 7).Value = lds_manifiesto.Object.Label[i]
 ole_Excel.Cells(ll_Rens, 8).Value = lds_manifiesto.Object.Cize[i]
 ole_Excel.Cells(ll_Rens, 9).Value = lds_manifiesto.Object.Cases[i]
 ole_Excel.Cells(ll_Rens,10).Value = lds_manifiesto.Object.PackDate[i]
 ole_Excel.Cells(ll_Rens,11).Value = lds_manifiesto.Object.Farming[i]
 ll_Rens = ll_Rens + 1
Next
ole_Excel.Cells(ll_Rens + 1, 9).Value = lds_manifiesto.Object.Total_Cases[1]

For i = 1 To lds_manifiesto.Rowcount()
 ll_pallet = 0
 ll_cajas  = 0
 ls_var = f_trim(lds_manifiesto.Object.Variety[i])
 ls_size   = f_trim(lds_manifiesto.Object.Cize[i])
 Choose Case ls_var
  Case 'ROM'
   If ls_size = 'JB' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'ROM' and ls_size = 'JB' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("B54").FormulaR1C1 = ll_pallet
    ole_Excel.Range("D54").FormulaR1C1 = ll_cajas
   Elseif ls_size = 'XL' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'ROM' and ls_size = 'XL' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("B55").FormulaR1C1 = ll_pallet
    ole_Excel.Range("D55").FormulaR1C1 = ll_cajas
   Elseif ls_size = 'LG' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'ROM' and ls_size = 'LG' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("B56").FormulaR1C1 = ll_pallet
    ole_Excel.Range("D56").FormulaR1C1 = ll_cajas
   Elseif ls_size = 'MD' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'ROM' and ls_size = 'MD' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("B57").FormulaR1C1 = ll_pallet
    ole_Excel.Range("D57").FormulaR1C1 = ll_cajas
   Elseif ls_size = 'SM' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'ROM' and ls_size = 'SM' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("B58").FormulaR1C1 = ll_pallet
    ole_Excel.Range("D58").FormulaR1C1 = ll_cajas
   End If
  Case 'CUX'
   If ls_size = 'SS' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'CUX' and ls_size = 'SS' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("F54").FormulaR1C1 = ll_pallet
    ole_Excel.Range("H54").FormulaR1C1 = ll_cajas
   Elseif ls_size = 'SL' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'CUX' and ls_size = 'SL' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("F55").FormulaR1C1 = ll_pallet
    ole_Excel.Range("H55").FormulaR1C1 = ll_cajas
   Elseif ls_size = 'SM' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'CUX' and ls_size = 'SM' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("F56").FormulaR1C1 = ll_pallet
    ole_Excel.Range("H56").FormulaR1C1 = ll_cajas
   Elseif ls_size = 'LG' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'CUX' and ls_size = 'LG' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("F57").FormulaR1C1 = ll_pallet
    ole_Excel.Range("H57").FormulaR1C1 = ll_cajas
   Elseif ls_size = 'PL' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'CUX' and ls_size = 'PL' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("F58").FormulaR1C1 = ll_pallet
    ole_Excel.Range("H58").FormulaR1C1 = ll_cajas
   End If
  Case 'ECX'
   If ls_size = '12LG' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'ECX' and ls_size = '12LG' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("J54").FormulaR1C1 = ll_pallet
    ole_Excel.Range("L54").FormulaR1C1 = ll_cajas
   Elseif ls_size = '12MD' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'ECX' and ls_size = '12MD' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("J55").FormulaR1C1 = ll_pallet
    ole_Excel.Range("L55").FormulaR1C1 = ll_cajas
   Elseif ls_size = '12SM' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'ECX' and ls_size = '12SM' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("J56").FormulaR1C1 = ll_pallet
    ole_Excel.Range("L56").FormulaR1C1 = ll_cajas
   Elseif ls_size = 'PL' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'ECX' and ls_size = 'PL' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("J57").FormulaR1C1 = ll_pallet
    ole_Excel.Range("L57").FormulaR1C1 = ll_cajas
   End If
  Case 'GPR'
   If ls_size = 'JB' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'GPR' and ls_size = 'JB' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("B65").FormulaR1C1 = ll_pallet
    ole_Excel.Range("D65").FormulaR1C1 = ll_cajas
   Elseif ls_size = 'XL' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'GPR' and ls_size = 'XL' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("B66").FormulaR1C1 = ll_pallet
    ole_Excel.Range("D66").FormulaR1C1 = ll_cajas
   Elseif ls_size = 'LG' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'GPR' and ls_size = 'LG' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("B67").FormulaR1C1 = ll_pallet
    ole_Excel.Range("D67").FormulaR1C1 = ll_cajas
   Elseif ls_size = 'MD' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'GPR' and ls_size = 'MD' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("B68").FormulaR1C1 = ll_pallet
    ole_Excel.Range("D68").FormulaR1C1 = ll_cajas
   Elseif ls_size = 'SM' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'GPR' and ls_size = 'SM' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("B69").FormulaR1C1 = ll_pallet
    ole_Excel.Range("D69").FormulaR1C1 = ll_cajas
   Elseif ls_size = 'CHOIC' Then
    For l = 1 To  lds_manifiesto.Rowcount()
     ls_var = f_trim(lds_manifiesto.Object.Variety[l])
     ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
     If ls_var = 'GPR' and ls_size = 'CHOIC' Then 
      ll_pallet = ll_pallet + 1
      ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
     End If
    Next
    ole_Excel.Range("B70").FormulaR1C1 = ll_pallet
    ole_Excel.Range("D70").FormulaR1C1 = ll_cajas
   End If
 End Choose
Next
ole_Excel.DisConnectObject()
Destroy ole_Excel

Return 1
end function

public function integer wf_chiquita_beltran (string as_tem, string as_man);/* wf_formatochiquita() */
Datastore lds_manifiesto
String    ls_tem, ls_man, ls_docname,ls_named,ls_ruta, ls_codigo, ls_hoja
Integer   li_ok, li_hojas, li_hoja
Long      i,col,ren,ll_rens
OLEObject ole_Book, ole_Hoja, ole_excel

ls_ruta = f_getparmvalue('086')
ls_codigo = f_getparmvalue('087')
ls_docname = 'Chiquita.xls'

lds_manifiesto  = Create Datastore
lds_manifiesto.Dataobject = 'd_arch_chiquita'
lds_manifiesto.Settransobject(Sqlca)
lds_manifiesto.Retrieve(as_tem, as_man)

//Create an OLE Excel Object
ole_Excel = CREATE OLEObject
li_ok = ole_Excel.ConnectToNewObject( "Excel.Application")
//Create an OLE Excel Object
ole_Book = CREATE OLEObject
ole_Book = ole_Excel.Workbooks.Open( ls_ruta + ls_docname ) // Abrir un documento existente

ole_Hoja = CREATE OLEObject
ole_Hoja = ole_Book.ActiveSheet

ole_Excel.Sheets(1).Select
ole_Excel.Visible = True

//Poner los Encabezados
ole_Excel.Range("D6").FormulaR1C1  = ls_codigo + Right('000' + lds_manifiesto.Object.Pool[1], 3)
ole_Excel.Range("C13").FormulaR1C1 = lds_manifiesto.Object.FDA[1]
ole_Excel.Range("C14").FormulaR1C1 = lds_manifiesto.Object.Transporter[1]
ole_Excel.Range("C15").FormulaR1C1 = lds_manifiesto.Object.Truck_ID[1]
ole_Excel.Range("C16").FormulaR1C1 = lds_manifiesto.Object.Plates[1]
ole_Excel.Range("C17").FormulaR1C1 = lds_manifiesto.Object.SCAC[1]
ole_Excel.Range("C18").FormulaR1C1 = lds_manifiesto.Object.Chofer[1]
ole_Excel.Range("C19").FormulaR1C1 = lds_manifiesto.Object.Origin[1]
ole_Excel.Range("C20").FormulaR1C1 = lds_manifiesto.Object.PackDate[1]
ole_Excel.Range("C21").FormulaR1C1 = lds_manifiesto.Object.Crossing[1]
ole_Excel.Range("C22").FormulaR1C1 = lds_manifiesto.Object.PackDate[1]
ole_Excel.Range("D23").FormulaR1C1 = lds_manifiesto.Object.Total_Cases[1]
ole_Excel.Range("C24").FormulaR1C1 = lds_manifiesto.Object.Temperature[1]

//Llenar Los Datos
ll_Rens = 28
For i = 1 To lds_manifiesto.Rowcount()
	ole_Excel.Cells(ll_Rens, 1).Value = i
	ole_Excel.Cells(ll_Rens, 2).Value = 'MV' + lds_manifiesto.Object.Pallet[i]
	ole_Excel.Cells(ll_Rens, 3).Value = lds_manifiesto.Object.Field[i]
	ole_Excel.Cells(ll_Rens, 4).Value = lds_manifiesto.Object.Block[i]
	ole_Excel.Cells(ll_Rens, 5).Value = lds_manifiesto.Object.Variety[i]
	ole_Excel.Cells(ll_Rens, 6).Value = lds_manifiesto.Object.Pack[i]
	ole_Excel.Cells(ll_Rens, 7).Value = lds_manifiesto.Object.Grade[i]
	ole_Excel.Cells(ll_Rens, 8).Value = lds_manifiesto.Object.Label[i]
	ole_Excel.Cells(ll_Rens, 9).Value = lds_manifiesto.Object.Cize[i]
	ole_Excel.Cells(ll_Rens,10).Value = lds_manifiesto.Object.Cases[i]
	ole_Excel.Cells(ll_Rens,11).Value = lds_manifiesto.Object.PackDate[i]
	ole_Excel.Cells(ll_Rens,12).Value = lds_manifiesto.Object.Farming[i]
	ll_Rens = ll_Rens + 1
Next
//ole_Excel.Range(ole_Excel.Cells(2, 3), ole_Excel.Cells(ll_Rens+1,6)).NumberFormat = "#,#0.00;-#,#0.00;-"
//ole_Excel.Range(ole_Excel.Cells(2, 8), ole_Excel.Cells(ll_Rens+1,8)).NumberFormat = "dd/mm/aaaa"
//ole_Excel.Range(ole_Excel.Cells(2, 8), ole_Excel.Cells(ll_Rens+1,8)).NumberFormat = "dd/mm/aaaa"
ole_Excel.DisConnectObject()
Destroy ole_Excel

Return 1
end function

public function integer wf_chiquita_sanemilio (string as_tem, string as_man);/* wf_formatochiquita() */
Datastore lds_manifiesto
String    ls_tem, ls_man, ls_docname, ls_named, ls_ruta, ls_codigo, ls_hoja, ls_var, ls_size
Integer   li_ok, li_hojas, li_hoja
Long      i, l, col, ren, ll_rens, ll_pallet, ll_cajas
OLEObject ole_Book, ole_Hoja, ole_excel

ls_ruta = f_getparmvalue('086')
ls_codigo = f_getparmvalue('087')
ls_docname = 'Chiquita.xls'

lds_manifiesto  = Create Datastore
lds_manifiesto.Dataobject = 'd_arch_chiquita'
lds_manifiesto.Settransobject(Sqlca)
lds_manifiesto.Retrieve(as_tem, as_man)
ll_rens = lds_manifiesto.Rowcount()

//Create an OLE Excel Object
ole_Excel = CREATE OLEObject
li_ok = ole_Excel.ConnectToNewObject( "Excel.Application")
//Create an OLE Excel Object
ole_Book = CREATE OLEObject
ole_Book = ole_Excel.Workbooks.Open( ls_ruta + ls_docname )

ole_Hoja = CREATE OLEObject
ole_Hoja = ole_Book.ActiveSheet

ole_Excel.Sheets(1).Select
ole_Excel.Visible = True

//Poner los Encabezados
ole_Excel.Range("D5").FormulaR1C1  = lds_manifiesto.Object.invoice[1]
ole_Excel.Range("D6").FormulaR1C1  = ls_codigo + Right('000' + lds_manifiesto.Object.Pool[1], 3)
ole_Excel.Range("D7").FormulaR1C1  = lds_manifiesto.Object.distribuidor[1]
ole_Excel.Range("D8").FormulaR1C1  = lds_manifiesto.Object.direccion[1]
ole_Excel.Range("D9").FormulaR1C1  = lds_manifiesto.Object.ciudad[1]
ole_Excel.Range("C13").FormulaR1C1 = lds_manifiesto.Object.FDA[1]
ole_Excel.Range("C14").FormulaR1C1 = lds_manifiesto.Object.Transporter[1]
ole_Excel.Range("C15").FormulaR1C1 = lds_manifiesto.Object.Truck_ID2[1]
ole_Excel.Range("C16").FormulaR1C1 = lds_manifiesto.Object.Plates2[1]
ole_Excel.Range("C17").FormulaR1C1 = lds_manifiesto.Object.Truck_ID[1]
ole_Excel.Range("C18").FormulaR1C1 = lds_manifiesto.Object.SCAC[1]
ole_Excel.Range("C19").FormulaR1C1 = lds_manifiesto.Object.Chofer[1]
// numero de licencia
ole_Excel.Range("F19").NumberFormat = "@"
ole_Excel.Range("F19").FormulaR1C1 = lds_manifiesto.Object.License[1]
ole_Excel.Range("C20").FormulaR1C1 = lds_manifiesto.Object.Origin[1]
ole_Excel.Range("C21").FormulaR1C1 = lds_manifiesto.Object.PackDate[1]
// hora de salida
ole_Excel.Range("D21").FormulaR1C1 = mid(lds_manifiesto.Object.Packtime[1],1,2) +':'+ mid(lds_manifiesto.Object.Packtime[1],3,2)
ole_Excel.Range("C22").FormulaR1C1 = lds_manifiesto.Object.Crossing[1]
ole_Excel.Range("C23").FormulaR1C1 = lds_manifiesto.Object.DepartureDate[1]
ole_Excel.Range("D24").FormulaR1C1 = lds_manifiesto.Object.Total_Cases[1]
ole_Excel.Range("C25").FormulaR1C1 = lds_manifiesto.Object.Temperature[1]

//Llenar Los Datos
ll_Rens = 28
For i = 1 To lds_manifiesto.Rowcount()
 ole_Excel.Cells(ll_Rens, 1).Value = i
 ole_Excel.Cells(ll_Rens, 2).Value = 'MV' + lds_manifiesto.Object.Pallet[i]
 ole_Excel.Cells(ll_Rens, 3).Value = lds_manifiesto.Object.Field[i]
 ole_Excel.Cells(ll_Rens, 4).Value = lds_manifiesto.Object.Block[i]
 ole_Excel.Cells(ll_Rens, 5).Value = lds_manifiesto.Object.Variety[i]
 ole_Excel.Cells(ll_Rens, 6).Value = lds_manifiesto.Object.Pack[i]
 ole_Excel.Cells(ll_Rens, 7).Value = lds_manifiesto.Object.Label[i]
 ole_Excel.Cells(ll_Rens, 8).Value = lds_manifiesto.Object.Cize[i]
 ole_Excel.Cells(ll_Rens, 9).Value = lds_manifiesto.Object.Cases[i]
 ole_Excel.Cells(ll_Rens,10).Value = lds_manifiesto.Object.PackDate[i]
 ole_Excel.Cells(ll_Rens,11).Value = lds_manifiesto.Object.Farming[i]
 ll_Rens = ll_Rens + 1
Next
ole_Excel.Cells(ll_Rens + 1, 9).Value = lds_manifiesto.Object.Total_Cases[1]
//
//For i = 1 To lds_manifiesto.Rowcount()
//	ll_pallet = 0
//	ll_cajas  = 0
//	ls_var = f_trim(lds_manifiesto.Object.Variety[i])
//	ls_size   = f_trim(lds_manifiesto.Object.Cize[i])
//	Choose Case ls_var
//		Case 'ROM'
//			If ls_size = 'JB' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'ROM' and ls_size = 'JB' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("B54").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("D54").FormulaR1C1 = ll_cajas
//			Elseif ls_size = 'XL' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'ROM' and ls_size = 'XL' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("B55").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("D55").FormulaR1C1 = ll_cajas
//			Elseif ls_size = 'LG' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'ROM' and ls_size = 'LG' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("B56").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("D56").FormulaR1C1 = ll_cajas
//			Elseif ls_size = 'MD' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'ROM' and ls_size = 'MD' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("B57").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("D57").FormulaR1C1 = ll_cajas
//			Elseif ls_size = 'SM' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'ROM' and ls_size = 'SM' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("B58").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("D58").FormulaR1C1 = ll_cajas
//			End If
//		Case 'CUX'
//			If ls_size = 'SS' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'CUX' and ls_size = 'SS' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("F54").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("H54").FormulaR1C1 = ll_cajas
//			Elseif ls_size = 'SL' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'CUX' and ls_size = 'SL' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("F55").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("H55").FormulaR1C1 = ll_cajas
//			Elseif ls_size = 'SM' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'CUX' and ls_size = 'SM' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("F56").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("H56").FormulaR1C1 = ll_cajas
//			Elseif ls_size = 'LG' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'CUX' and ls_size = 'LG' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("F57").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("H57").FormulaR1C1 = ll_cajas
//			Elseif ls_size = 'PL' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'CUX' and ls_size = 'PL' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("F58").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("H58").FormulaR1C1 = ll_cajas
//			End If
//		Case 'ECX'
//			If ls_size = '12LG' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'ECX' and ls_size = '12LG' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("J54").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("L54").FormulaR1C1 = ll_cajas
//			Elseif ls_size = '12MD' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'ECX' and ls_size = '12MD' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("J55").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("L55").FormulaR1C1 = ll_cajas
//			Elseif ls_size = '12SM' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'ECX' and ls_size = '12SM' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("J56").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("L56").FormulaR1C1 = ll_cajas
//			Elseif ls_size = 'PL' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'ECX' and ls_size = 'PL' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("J57").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("L57").FormulaR1C1 = ll_cajas
//			End If
//		Case 'GPR'
//			If ls_size = 'JB' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'GPR' and ls_size = 'JB' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("B65").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("D65").FormulaR1C1 = ll_cajas
//			Elseif ls_size = 'XL' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'GPR' and ls_size = 'XL' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("B66").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("D66").FormulaR1C1 = ll_cajas
//			Elseif ls_size = 'LG' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'GPR' and ls_size = 'LG' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("B67").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("D67").FormulaR1C1 = ll_cajas
//			Elseif ls_size = 'MD' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'GPR' and ls_size = 'MD' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("B68").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("D68").FormulaR1C1 = ll_cajas
//			Elseif ls_size = 'SM' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'GPR' and ls_size = 'SM' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("B69").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("D69").FormulaR1C1 = ll_cajas
//			Elseif ls_size = 'CHOIC' Then
//				For l = 1 To  lds_manifiesto.Rowcount()
//					ls_var = f_trim(lds_manifiesto.Object.Variety[l])
//					ls_size   = f_trim(lds_manifiesto.Object.Cize[l])
//					If ls_var = 'GPR' and ls_size = 'CHOIC' Then	
//						ll_pallet = ll_pallet + 1
//						ll_cajas  = ll_cajas + Long(lds_manifiesto.Object.Cases[l])
//					End If
//				Next
//				ole_Excel.Range("B70").FormulaR1C1 = ll_pallet
//				ole_Excel.Range("D70").FormulaR1C1 = ll_cajas
//			End If
//	End Choose
//Next
ole_Excel.DisConnectObject()
Destroy ole_Excel

Return 1

end function

public function integer wf_generastateresa (string as_tem, string as_man);/* wf_formatochiquita() */
Datastore lds_manifiesto,lds_resu
String    ls_tem, ls_man, ls_docname, ls_named, ls_ruta, ls_codigo, ls_hoja, ls_var, ls_size,ls_prueba
Integer   li_ok, li_hojas, li_hoja
Long      i, l, col, ren, ll_rens, ll_pallet, ll_cajas,ll_resu,m
OLEObject ole_Book, ole_Hoja, ole_excel

ls_ruta = f_getparmvalue('086')
ls_codigo = f_getparmvalue('087')
ls_docname = 'Chiquita.xls'

lds_manifiesto  = Create Datastore
lds_manifiesto.Dataobject = 'd_arch_chiquita'
lds_manifiesto.Settransobject(SqlCa)
lds_manifiesto.Retrieve(as_tem, as_man)
ll_rens = lds_manifiesto.Rowcount()

//Create an OLE Excel Object
ole_Excel = CREATE OLEObject
li_ok = ole_Excel.ConnectToNewObject( "Excel.Application")
//Create an OLE Excel Object
ole_Book = CREATE OLEObject
ole_Book = ole_Excel.Workbooks.Open( ls_ruta + ls_docname )

ole_Hoja = CREATE OLEObject
ole_Hoja = ole_Book.ActiveSheet

ole_Excel.Sheets(1).Select
ole_Excel.Visible = True

//Poner los Encabezados
ole_Excel.Range("D5").FormulaR1C1  = lds_manifiesto.Object.invoice[1]
ole_Excel.Range("D6").FormulaR1C1  = ls_codigo + Right('000000' + lds_manifiesto.Object.Pool[1], 6)
ole_Excel.Range("D7").FormulaR1C1  = lds_manifiesto.Object.distribuidor[1]
ole_Excel.Range("D8").FormulaR1C1  = lds_manifiesto.Object.direccion[1]
ole_Excel.Range("D9").FormulaR1C1  = lds_manifiesto.Object.ciudad[1]
ole_Excel.Range("C13").FormulaR1C1 = lds_manifiesto.Object.FDA[1]
ole_Excel.Range("C14").FormulaR1C1 = lds_manifiesto.Object.Transporter[1]
ole_Excel.Range("C15").FormulaR1C1 = lds_manifiesto.Object.Truck_ID2[1]
ole_Excel.Range("C16").FormulaR1C1 = lds_manifiesto.Object.Plates2[1]
ole_Excel.Range("C17").FormulaR1C1 = lds_manifiesto.Object.Truck_ID[1]
ole_Excel.Range("C18").FormulaR1C1 = lds_manifiesto.Object.SCAC[1]
ole_Excel.Range("C19").FormulaR1C1 = lds_manifiesto.Object.Chofer[1]
// numero de licencia
ole_Excel.Range("F19").NumberFormat = "@"
ole_Excel.Range("F19").FormulaR1C1 = lds_manifiesto.Object.License[1]
ole_Excel.Range("C20").FormulaR1C1 = lds_manifiesto.Object.Origin[1]
ole_Excel.Range("C21").FormulaR1C1 = lds_manifiesto.Object.PackDate[1]
// hora de salida
ole_Excel.Range("D21").FormulaR1C1 = mid(lds_manifiesto.Object.Packtime[1],1,2) +':'+ mid(lds_manifiesto.Object.Packtime[1],3,2)
ole_Excel.Range("C22").FormulaR1C1 = lds_manifiesto.Object.Crossing[1]
ole_Excel.Range("C23").FormulaR1C1 = lds_manifiesto.Object.DepartureDate[1]
ole_Excel.Range("D24").FormulaR1C1 = lds_manifiesto.Object.Total_Cases[1]
ole_Excel.Range("C25").FormulaR1C1 = lds_manifiesto.Object.Temperature[1]

destroy lds_resu
ll_Rens =26
lds_resu  = Create Datastore
lds_resu.Dataobject = 'd_arch_chiquita_res'
lds_resu.Settransobject(SqlCa)
lds_resu.Retrieve(as_tem, as_man)
ll_resu = lds_resu.Rowcount()
//resumido
For m = 1 To lds_resu.Rowcount()
 ole_Excel.Cells(ll_Rens + m, 2).Value = lds_resu.Object.tot[m]
 ole_Excel.Cells(ll_Rens + m, 3).Value = lds_resu.Object.Grade[m]
 ole_Excel.Cells(ll_Rens + m, 4).Value = lds_resu.Object.cize[m]
 ole_Excel.Cells(ll_Rens + m, 5).Value = lds_resu.Object.embarcador[m]

next
//encabezados
ll_Rens =26 + m
 ole_Excel.Cells(ll_Rens , 2).Value = 'Pallet'
 ole_Excel.Cells(ll_Rens , 3).Value = 'Field'
 ole_Excel.Cells(ll_Rens , 4).Value = 'Block'
 ole_Excel.Cells(ll_Rens , 5).Value = 'Variety'
 ole_Excel.Cells(ll_Rens , 6).Value = 'Pack'
 ole_Excel.Cells(ll_Rens , 7).Value = 'Label'
 ole_Excel.Cells(ll_Rens , 8).Value = 'Size'
 ole_Excel.Cells(ll_Rens , 9).Value = 'Cases /Pallet'
 ole_Excel.Cells(ll_Rens , 10).Value = 'PacketDate'
 ole_Excel.Cells(ll_Rens , 11).Value = 'Farming'
 
ll_Rens =27+ m

//Llenar Los Datos
//ll_Rens = 28
For i = 1 To lds_manifiesto.Rowcount()
	ls_prueba=Right('00' + left(lds_manifiesto.Object.Block[i],2) ,2)
 ole_Excel.Cells(ll_Rens, 1).Value = i
 ole_Excel.Cells(ll_Rens, 2).Value = lds_manifiesto.Object.Pallet[i]
 ole_Excel.Cells(ll_Rens, 3).Value = lds_manifiesto.Object.Field[i]
 ole_Excel.Cells(ll_Rens, 4).Value = Right('00' + left(lds_manifiesto.Object.Block[i],2) ,2)
 ole_Excel.Cells(ll_Rens, 5).Value = lds_manifiesto.Object.Variety[i]
 ole_Excel.Cells(ll_Rens, 6).Value = lds_manifiesto.Object.Pack[i]
 ole_Excel.Cells(ll_Rens, 7).Value = lds_manifiesto.Object.Label[i]
 ole_Excel.Cells(ll_Rens, 8).Value = lds_manifiesto.Object.Cize[i]
 ole_Excel.Cells(ll_Rens, 9).Value = lds_manifiesto.Object.Cases[i]
 ole_Excel.Cells(ll_Rens,10).Value = lds_manifiesto.Object.PackDate[i]
 ole_Excel.Cells(ll_Rens,11).Value = lds_manifiesto.Object.Farming[i]
 ll_Rens = ll_Rens + 1
Next
ole_Excel.Cells(ll_Rens + 1, 9).Value = lds_manifiesto.Object.Total[1]
ole_Excel.DisConnectObject()
Destroy ole_Excel

Return 1

end function

event open;call super::open;dw_1.Visible = False
wf_SetDocuments( )
istr_parm = Message.PowerObjectParm
If istr_parm.s_cad[1] <> 'L' Then //L = Listado M = Manifiesto
	dw_list.Object.c_visible[ii_listado] = '1'
	dw_list.Object.c_checked[ 1] = ProfileString( gs_ini, 'DocumentosEmbarques', 'Factura', '0' )
	dw_list.Object.c_checked[ 2] = ProfileString( gs_ini, 'DocumentosEmbarques', 'FormatoAARC', '0' )
	dw_list.Object.c_checked[ 3] = ProfileString( gs_ini, 'DocumentosEmbarques', 'ControlXLot-Prod', '0' )
	dw_list.Object.c_checked[ 4] = ProfileString( gs_ini, 'DocumentosEmbarques', 'ControldeViajes', '0' )
	dw_list.Object.c_checked[ 5] = ProfileString( gs_ini, 'DocumentosEmbarques', 'Manifiesto', '0' )
	dw_list.Object.c_checked[ 6] = ProfileString( gs_ini, 'DocumentosEmbarques', 'ManifiestoChofer', '0' )
	dw_list.Object.c_checked[ 7] = ProfileString( gs_ini, 'DocumentosEmbarques', 'xxx', '0' )
   dw_list.Object.c_checked[ 8] = ProfileString( gs_ini, 'DocumentosEmbarques', 'Certificado_Fitosanitario', '0' )
	dw_list.Object.c_checked[ 9] = ProfileString( gs_ini, 'DocumentosEmbarques', 'Certificado_Origen', '0' )
	dw_list.Object.c_checked[10] = ProfileString( gs_ini, 'DocumentosEmbarques', 'ManifiestoSHANNON', '0' )
	dw_list.Object.c_checked[11] = ProfileString( gs_ini, 'DocumentosEmbarques', 'ReporteColores', '0' )
	dw_list.Object.c_checked[12] = ProfileString( gs_ini, 'DocumentosEmbarques', 'CartaPromocion', '0' )
	dw_list.Object.c_checked[13] = ProfileString( gs_ini, 'DocumentosEmbarques', 'ManifiestoPremier', '0' )
	dw_list.Object.c_checked[14] = ProfileString( gs_ini, 'DocumentosEmbarques', 'CartaTraslado', '0' )
	dw_list.Object.c_checked[15] = ProfileString( gs_ini, 'DocumentosEmbarques', 'CFI', '0' )
	dw_list.Object.c_checked[16] = ProfileString( gs_ini, 'DocumentosEmbarques', 'SelloSeg', '0' )
	dw_list.Object.c_checked[17] = ProfileString( gs_ini, 'DocumentosEmbarques', 'Factura con Formato', '0' )
	dw_list.Object.c_checked[18] = ProfileString( gs_ini, 'DocumentosEmbarques', 'Formato Chiquita', '0' )
	dw_list.Object.c_checked[19] = ProfileString( gs_ini, 'DocumentosEmbarques', 'Factura Carta', '0' )
	dw_list.Object.c_checked[20] = ProfileString( gs_ini, 'DocumentosEmbarques', 'Remision', '0' )
	dw_list.Object.c_checked[21] = ProfileString( gs_ini, 'DocumentosEmbarques', 'Nota de Embarque', '0' )
	dw_list.Object.c_checked[22] = ProfileString( gs_ini, 'DocumentosEmbarques', 'Manifiesto Pacific Brokerage', '0' )
Else
	dw_list.Object.c_checked[ii_listado] = '1'
End If
dw_list.AcceptText( )
end event

on w_arch_manifiesto_imprimir.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_arch_manifiesto_imprimir.destroy
call super::destroy
destroy(this.st_1)
end on

type dw_list from wa_response`dw_list within w_arch_manifiesto_imprimir
int X=32
int Y=80
int Width=1317
int Height=496
int TabOrder=0
string DataObject="d_arch_manifiesto_imprimir"
boolean HScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

event dw_list::clicked;call super::clicked;Integer	i

If row <> ii_listado Then
	Object.c_checked[ii_listado] = '0'
Else
	For i = 1 To RowCount( )
		If i <> ii_listado Then 
			Object.c_checked[i] = '0'
		End If
	Next
End If

AcceptText( )
end event

type dw_1 from wa_response`dw_1 within w_arch_manifiesto_imprimir
int X=27
int Y=612
int Width=133
int Height=80
int TabOrder=0
end type

type cb_cancelar from wa_response`cb_cancelar within w_arch_manifiesto_imprimir
int X=1006
int Y=612
int TabOrder=20
end type

event cb_cancelar::clicked;s_parm	lstr_parm

lstr_parm.s_cad[ 1] = '0'
lstr_parm.s_cad[ 2] = '0'
lstr_parm.s_cad[ 3] = '0'
lstr_parm.s_cad[ 4] = '0'
lstr_parm.s_cad[ 5] = '0'

CloseWithReturn( Parent, lstr_parm )
end event

type cb_aceptar from wa_response`cb_aceptar within w_arch_manifiesto_imprimir
int X=640
int Y=612
int TabOrder=10
boolean Enabled=true
end type

event cb_aceptar::clicked;Long	  i, J, ll_renglon, ll_len
DataWindow ldw_1
DateTime	  ld_ini, ld_fin
s_parm	  lstr_parm
String	  ls_tem, ls_man, ls_mer, ls_cia, ls_dwf, ls_tipo, ls_rem, ls_par, ls_cul
Datastore  lds_listado
ls_cul = ''

ls_rem = upper(f_trim(f_getparmvalue('071')))
dw_list.AcceptText( )
cb_cancelar.Text = 'Cerrar'
ldw_1 = istr_parm.dw_dat[1]
ls_tem = ldw_1.Object.c_codigo_tem[ldw_1.GetRow( )]
ls_man = ldw_1.Object.c_codigo_man[ldw_1.GetRow( )]
ls_mer = ldw_1.Object.c_merdes_man[ldw_1.GetRow( )]

ls_cia = f_GetParmValue('003')

For i = 1 To dw_list.RowCount( )
	dw_list.SelectRow( 0, False )
	dw_list.SetRow( i )
	If dw_list.Object.c_checked[ i] = '0' Then Continue
	If dw_list.Object.c_impreso[ i] = '1' Then Continue
	Choose Case i
		Case 1
			If ls_mer = 'N' Then
				if ls_rem <> 'S' then
					ls_dwf = f_Trim( ProfileString( gs_ini, 'System', 'dwFacturaNacional', '' ) )
				else			
					ls_tipo =  istr_parm.s_cad[4]
					if ls_tipo <> 'N' then
						ls_dwf = ProfileString( gs_ini, 'System', 'dwFactura', 'd_rpt_factura_gral' )
					else
						ls_dwf = f_Trim( ProfileString( gs_ini, 'System', 'dwFacturaNacional', '' ) )
					end if
				end if
			End If
			
			If ls_dwf = '' Then
				ls_dwf = ProfileString( gs_ini, 'System', 'dwFactura', 'd_rpt_factura_gral' )
			End If
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man, gs_hini )
		Case 2
			ls_dwf = ProfileString( gs_ini, 'System', 'dwFormato', 'd_rpt_formato_aarc_gral' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man, gs_hini)
		Case 3
			ls_dwf = ProfileString( gs_ini, 'System', 'dwControlxloteprod', 'd_rpt_control_viajes_x_lote_producto' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )	
		Case 4
			ls_dwf = ProfileString( gs_ini, 'System', 'dwControl', 'd_rpt_control_viajes' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
		Case 5
			If ls_mer = 'N' Then
				ls_dwf = ProfileString( gs_ini, 'System', 'dwmanifiesto', 'd_rpt_guia_mexicana' )
				dw_1.dataobject = ls_dwf
			Else
				ls_dwf = ProfileString( gs_ini, 'System', 'dwmanifiestoex', 'd_rpt_manifiesto_gral' )
				dw_1.dataobject = ls_dwf
			End If
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
			cb_cancelar.SetFocus( )
		Case 6
			ls_dwf = ProfileString( gs_ini, 'System', 'dwMChofer', 'd_rpt_manifiesto_chofer_gral' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
		Case 8
			ls_dwf = ProfileString( gs_ini, 'System', 'dwfitosanitario', 'd_rpt_fitosanitario' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
		Case 9
			ls_dwf = ProfileString( gs_ini, 'System', 'dworigen', 'd_rpt_certificadoorigen_batiz' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			if ls_dwf <> 'd_rpt_certificadoorigen_ema' then
				dw_1.Retrieve( ls_tem, ls_man)
			else //20100120
				lds_listado = create datastore
				lds_listado.dataobject = 'd_util_nombre_cultivo'
				lds_listado.settransobject(sqlca)
				lds_listado.retrieve(ls_tem, ls_man)
				ll_renglon =lds_listado.rowcount()
				for j = 1 to ll_renglon
					ls_cul = ls_cul + f_trim(lds_listado.object.v_nombre_cul[j]) + ', '
				next
				ll_len = len(ls_cul) 
				ls_cul = mid(ls_cul, 1, ll_len - 2)
				dw_1.Retrieve( ls_tem, ls_man, ls_cul)
			end if
		Case 10
			ls_dwf = ProfileString( gs_ini, 'System', 'dwMSHANON', 'd_rpt_manifiesto_gral_beltran' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
		Case 11
			ls_dwf = ProfileString( gs_ini, 'System', 'dwMColor', 'd_rpt_embarcado_x_color_manifiesto_imp' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
		Case 12
			ls_dwf = ProfileString( gs_ini, 'System', 'dwcartapromocion', 'd_rpt_carta_promocion' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
			
		Case 13 //20081005
			ls_dwf = ProfileString( gs_ini, 'System', 'dwpremier', 'd_rpt_manifiesto_premier_valta' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
			
		Case 14 //20081005
			ls_dwf = ProfileString( gs_ini, 'System', 'dwtraslado', 'd_rpt_carta_traslado' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
			
		Case 15 //20081005
			ls_dwf = ProfileString( gs_ini, 'System', 'dw_cfi', 'd_rpt_certificado_cfi' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
			
		Case 16 //20081006
			ls_dwf = ProfileString( gs_ini, 'System', 'dwsello', 'd_rpt_sello_adicional' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
		Case 17 //20081031
			ls_dwf = ProfileString( gs_ini, 'System', 'dwFacturaconformato', 'd_rpt_factura_exp_gpe2' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
		Case 18 //20081204
			ls_par = f_getparmvalue('105')
			If ls_par = '1' Then
				wf_chiquita_beltran(ls_tem, ls_man)
			Elseif ls_par = '2' Then
				wf_chiquita_sanemilio(ls_tem, ls_man)
			Elseif ls_par = '3' Then
				wf_generastateresa(ls_tem, ls_man)
			Else
				wf_chiquita_beltran(ls_tem, ls_man)
			End If
		Case 19 //20081204
			ls_dwf = ProfileString( gs_ini, 'System', 'dwFormatocarta', 'd_rpt_factura_manifiesto' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
		Case ii_listado
			dw_1.DataObject = 'd_rpt_manifiesto_x_fechas'
			dw_1.SetTransObject( SqlCa )
			ld_ini = f_StringToDate( istr_parm.s_cad[2] )
			ld_fin = f_StringToDate( istr_parm.s_cad[3] )
			dw_1.Retrieve( ls_tem, ld_ini, ld_fin )
		Case 20 //20090224
			ls_dwf = ProfileString( gs_ini, 'System', 'dwremision', 'd_rpt_remision_asmoles' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
		Case 21 //20090529
			ls_dwf = ProfileString( gs_ini, 'System', 'dwnotaemb', 'd_rpt_notaemb2_hort' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
			
		Case 22  //20091027 teresa
			ls_dwf = ProfileString( gs_ini, 'System', 'dwnotaemb', 'd_rpt_factura_teresa_pacific' )
			dw_1.DataObject = ls_dwf
			dw_1.SetTransObject( SqlCa )
			dw_1.Retrieve( ls_tem, ls_man )
			
	End Choose
	If i <> 18 Then
	  f_Preview( dw_1 )
	End If
	dw_list.Object.c_impreso[ i] = '1'
	Exit
Next

dw_list.AcceptText( )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'Factura', f_Trim(dw_list.Object.c_checked[ 1]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'FormatoAARC', f_Trim(dw_list.Object.c_checked[ 2]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'ControlXLot-Prod', f_Trim(dw_list.Object.c_checked[ 3]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'ControldeViajes', f_Trim(dw_list.Object.c_checked[ 4]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'Manifiesto', f_Trim(dw_list.Object.c_checked[ 5]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'ManifiestoChofer', f_Trim(dw_list.Object.c_checked[ 6]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'Certificado_Fitosanitario', f_Trim(dw_list.Object.c_checked[ 8]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'Certificado_Origen', f_Trim(dw_list.Object.c_checked[ 9]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'ManifiestoSHANNON', f_Trim(dw_list.Object.c_checked[10]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'ReporteColores', f_Trim(dw_list.Object.c_checked[11]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'CartaPromocion', f_Trim(dw_list.Object.c_checked[12]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'ManifiestoPremier', f_Trim(dw_list.Object.c_checked[13]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'CartaTraslado', f_Trim(dw_list.Object.c_checked[14]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'CFI', f_Trim(dw_list.Object.c_checked[15]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'SelloSeg', f_Trim(dw_list.Object.c_checked[16]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'Factura con Formato', f_Trim(dw_list.Object.c_checked[17]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'Formato Chiquita', f_Trim(dw_list.Object.c_checked[18]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'Formato Carta', f_Trim(dw_list.Object.c_checked[19]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'Remision', f_Trim(dw_list.Object.c_checked[20]) )
SetProfileString( gs_ini, 'DocumentosEmbarques', 'Manifiesto Pacific Brokerage', f_Trim(dw_list.Object.c_checked[22]) )


end event

type st_1 from statictext within w_arch_manifiesto_imprimir
int X=41
int Y=16
int Width=1157
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="Marque los documentos que desea imprimir. "
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

