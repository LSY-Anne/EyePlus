$PBExportHeader$w_rpt_export.srw
forward
global type w_rpt_export from wa_response
end type
type st_1 from statictext within w_rpt_export
end type
type em_ini from uo_editmask within w_rpt_export
end type
type cb_5 from uo_cbdate within w_rpt_export
end type
type st_2 from statictext within w_rpt_export
end type
type em_fin from uo_editmask within w_rpt_export
end type
type cb_fin from uo_cbdate within w_rpt_export
end type
type st_3 from statictext within w_rpt_export
end type
type cbx_1 from checkbox within w_rpt_export
end type
type sle_man from singlelineedit within w_rpt_export
end type
type cb_buscam from commandbutton within w_rpt_export
end type
type sle_man2 from singlelineedit within w_rpt_export
end type
type cb_buscam2 from commandbutton within w_rpt_export
end type
type st_4 from statictext within w_rpt_export
end type
type st_6 from statictext within w_rpt_export
end type
type ddlb_1 from dropdownlistbox within w_rpt_export
end type
type st_5 from statictext within w_rpt_export
end type
end forward

global type w_rpt_export from wa_response
int Width=1385
int Height=928
boolean TitleBar=true
string Title="Exportación a TXT"
long BackColor=82042848
st_1 st_1
em_ini em_ini
cb_5 cb_5
st_2 st_2
em_fin em_fin
cb_fin cb_fin
st_3 st_3
cbx_1 cbx_1
sle_man sle_man
cb_buscam cb_buscam
sle_man2 sle_man2
cb_buscam2 cb_buscam2
st_4 st_4
st_6 st_6
ddlb_1 ddlb_1
st_5 st_5
end type
global w_rpt_export w_rpt_export

type variables
String	is_rpt, is_rptname
end variables

forward prototypes
public function integer wf_export_delourdes ()
public function integer wf_export_epsa ()
public function integer wf_export_campania ()
public function integer wf_buscaman (string as_cod)
public function integer wf_buscaman2 (string as_cod)
public function integer wf_solveproduce ()
public function integer wf_solveproduce2 ()
public function integer wf_export_stateresa ()
end prototypes

public function integer wf_export_delourdes ();Integer  i
Dec{4}   ldc_tc
String   ls_renglon,col10, ls_ruta, ls_name,ls_fecha
DateTime ld_ini,ld_fin,ld_hoy

SetPointer( HourGlass! )
Integer li_FileNum
ls_ruta  = f_getparmvalue('050')
ld_hoy   = datetime(today())

ld_ini=f_stringtodate( em_ini.Text )
ld_fin=f_stringtodate( em_fin.Text )

ls_fecha = string(ld_ini,'yymmdd') + '_' + string(ld_fin,'yymmdd')
ls_name = '\E_'+ ls_fecha+ '.txt' 
filedelete(ls_ruta + ls_name)

If CreateDirectoryA( ls_ruta, 0 ) Then
End If 
 
li_FileNum = FileOpen( ls_ruta + ls_name, LineMode!, Write!,LockReadWrite!, Append!)

dw_list.DataObject = 'd_rpt_embarque_export_delourdes2'
dw_list.SetTransObject( SqlCa )
dw_list.Retrieve( ld_ini,ld_fin )
For i = 1 To dw_list.RowCount()
	col10=dw_list.object.col10[i]
	ls_renglon = ''
	ls_renglon = f_espacios('',9) + f_espacios(col10,1) + dw_list.object.col11[i] + dw_list.object.col21[i]
	ls_renglon = ls_renglon + f_espacios(dw_list.object.col22[i],40)	+	f_espacios(dw_list.object.col62[i],12)+f_espacios(dw_list.object.col74[i],40)+f_espacios('',40)
	ls_renglon = ls_renglon + f_espacios('',5)	+	f_espacios(dw_list.object.col159[i],12)	+	f_espacios(dw_list.object.col171[i],12)	+	f_espacios('',12)
	ls_renglon = ls_renglon + f_espacios('',1)	+	f_espacios(dw_list.object.col196[i],12)	 + 	f_espacios('',40)+ f_espacios(dw_list.object.col248	[i],12)	
	ls_renglon = ls_renglon + f_espacios(dw_list.object.col260[i],10)	+	f_espacios('',16)		+	f_espacios(dw_list.object.col286[i],10)	+	f_espacios(dw_list.object.col296[i],10)
	ls_renglon = ls_renglon + f_espacios(dw_list.object.col306[i],10)	+	f_espacios(dw_list.object.col316[i],16)	+	f_espacios(dw_list.object.col332[i],16) +f_espacios('',16)	+	f_espacios(dw_list.object.col364[i],16)
	ls_renglon = ls_renglon +	f_espacios(dw_list.object.col380[i],16)	+	f_espacios('',16)+f_espacios('',16)
	ls_renglon = ls_renglon + f_espacios(dw_list.object.col428[i],1)	+	f_espaciosr(dw_list.object.col429[i],11) +	f_espacios('',11) +	f_espacios('',5) +f_espacios('',4)+f_espacios('',12)+f_espacios('',10)
	FileWrite(li_FileNum, ls_renglon)
Next
FileClose(li_FileNum)
SetPointer( HourGlass! )
MessageBox('Exportacion Txt','Se exporto correctamente el archivo.txt ubicado en ' + ls_ruta, Information!)

Return 1
end function

public function integer wf_export_epsa ();Dec{4} ldc_tc
Integer i
String ls_renglon,col10, ls_ruta, ls_name,ls_fecha
DateTime ld_ini,ld_fin,ld_hoy

SetPointer( HourGlass! )
Integer li_FileNum
ls_ruta  = f_getparmvalue('050')
ld_hoy   = datetime(today())
ls_fecha = string(ld_hoy,'dd-mm-yyyy')

ls_name = '\e-'+ ls_fecha+ '.txt' 
filedelete(ls_ruta + ls_name)
li_FileNum = FileOpen( ls_ruta + ls_name, LineMode!, Write!, LockWrite!, Append!)

ld_ini=f_stringtodate(em_ini.Text)
ld_fin=f_stringtodate(em_fin.Text)
dw_list.DataObject= 'd_rpt_embarque_export_epsa'
dw_list.SetTransObject(SqlCa)
dw_list.Retrieve(ld_ini,ld_fin )
For i = 1 to dw_list.RowCount()
	col10=dw_list.object.col10[i]
	ls_renglon = ''
	ls_renglon =  f_espacios('',9)+f_espacios(col10,1)+dw_list.object.col11[i] +dw_list.object.col21[i]
	ls_renglon = ls_renglon + f_espacios(dw_list.object.col22[i],40)+f_espacios('',12)+f_espacios('',40)+f_espacios('',40)
	ls_renglon = ls_renglon + f_espacios('',5)+f_espacios(dw_list.object.col159[i],12)+f_espacios(dw_list.object.col171[i],12)+f_espacios('',12)
	ls_renglon = ls_renglon + f_espacios('',1)+f_espacios(dw_list.object.col196[i],12)+f_espacios('',40)+f_espacios('',12)
	ls_renglon = ls_renglon + f_espacios(dw_list.object.col260[i],10)+f_espacios('',16)+f_espacios(dw_list.object.col286[i],10)+f_espacios(dw_list.object.col296[i],10)
	ls_renglon = ls_renglon + f_espacios('',10)+f_espacios(dw_list.object.col316[i],16)+f_espacios(dw_list.object.col332[i],16)+f_espacios('',16)
	ls_renglon = ls_renglon + f_espacios('',16)+f_espacios(dw_list.object.col380[i],16)+f_espacios('',16)+f_espacios('',16)
	ls_renglon = ls_renglon + f_espacios(dw_list.object.col428[i],1)+f_espaciosr(dw_list.object.col429[i],11)+f_espacios('',11)
	ls_renglon = ls_renglon + f_espacios('',5)+f_espaciosr(dw_list.object.col456[i],4)+f_espacios('',12)+f_espacios('',10)
	FileWrite(li_FileNum, ls_renglon)
Next
FileClose(li_FileNum)
SetPointer( HourGlass! )
MessageBox('Exportacion Txt','Se exporto correctamente el archivo.txt ubicado en ' + ls_ruta, Information!)

Return 1
end function

public function integer wf_export_campania ();Dec{4}   ldc_tc
String   ls_renglon,col10, ls_ruta, ls_name,ls_fecha,ls_man,ls_man2,ls_men,ls_man1,ls_colf1,ls_colf3,ls_manp,ls_null,ls_packing,ls_e
DateTime ld_ini,ld_fin,ld_hoy,ld_null
long i,ll_row,j,i2,ll_len

setnull(ld_null)
setnull(ls_null)

SetPointer( HourGlass! )
Integer li_FileNum
ls_ruta  = f_getparmvalue('050')
ld_hoy   = datetime(today())
ls_fecha = string(ld_hoy,'dd-mm-yyyy')
ls_name = '\e-'+ ls_fecha+ '.txt' 
filedelete(ls_ruta + ls_name)
li_FileNum = FileOpen( ls_ruta + ls_name, LineMode!, Write!, LockWrite!, Append!)

ld_ini=f_stringtodate( em_ini.Text )
ld_fin=f_stringtodate( em_fin.Text )
dw_list.DataObject = 'd_rpt_embarque_export_campania'
dw_list.SetTransObject( SqlCa )

ls_man1 = f_trim(sle_man.text)
ls_manp = f_trim(sle_man2.text)
if cbx_1.checked then
	if ls_man1 > ls_manp then
		messagebox(title,'Rango de manifiestos incorrecto',exclamation!) //20080110
		return 0
	end if
	dw_list.Retrieve( 'L',ld_null,ld_null,ls_man1,ls_manp )
else
	dw_list.Retrieve('F', ld_ini,ld_fin,'','')
end if
ll_row = dw_list.RowCount()
ls_man2 = ''
For i = 1 To ll_row  //encabezado
	ls_man = f_trim(dw_list.object.c_codigo_man[i])
	ls_packing = left(f_trim(dw_list.object.colf3[i]) + f_espacios(' ',4),4)
	ls_e = left(f_trim(dw_list.object.colf1[i]) + f_espacios(' ',2),2)
	
	if ls_man = ls_man2 or i = 1 then
		ls_renglon = ''
		ls_renglon = dw_list.object.col1[i] 	+ dw_list.object.col3[i] + left(f_trim(dw_list.object.col65[i]) + f_espacios(' ',12),12) + f_espacios(' ',40) 
		ls_renglon = ls_renglon + left(f_trim(dw_list.object.col65[i]) + f_espacios(' ',12),12) + left(f_trim(dw_list.object.col77[i]) + f_espacios(' ',40),40) 
		ls_renglon = ls_renglon + left(f_trim(dw_list.object.col117[i])+f_espacios(' ',12),12) + left(f_trim(dw_list.object.col129[i]) + f_espacios(' ',40),40)
		ls_renglon = ls_renglon + left(f_trim(dw_list.object.col169[i]) + f_espacios(' ',12),12) + left(f_trim(dw_list.object.col181[i]) + f_espacios(' ',10),10)
		FileWrite(li_FileNum, ls_renglon)
	end if
	
	For j = I To ll_row //detalle
		ls_man2 = f_trim(dw_list.object.c_codigo_man[j])
		if ls_man = ls_man2 then
			ls_renglon = f_trim(dw_list.object.cold1[j]) + left(string(j) + f_espacios(' ',5),5)
			ls_renglon = ls_renglon + f_trim(dw_list.object.col117[j]) + left(f_trim(dw_list.object.cold12[j]) + f_espacios(' ',3),12)//
			ls_renglon = ls_renglon + left(f_trim(dw_list.object.cold20[j]) + f_espacios(' ',14),14) 
			ls_renglon = ls_renglon + left(f_trim(dw_list.object.cold34[j]) + f_espacios(' ',60),60) 
			ls_renglon = ls_renglon + left(f_trim(dw_list.object.cold94[j]) + f_espacios (' ',4),4)
			ls_renglon = ls_renglon + left(f_trim(dw_list.object.cold98[j]) + f_espacios(' ',4),4)
			ls_renglon = ls_renglon + dw_list.object.cold102[j] //dw_list.object.cold98[j]
			FileWrite(li_FileNum, ls_renglon)
		else
			i2 = i
			i = j - 1
			exit
		end if 
		i = j + 1
	next
	
	ls_renglon = ''
	ls_Renglon =  ls_e + ls_packing
	FileWrite(li_FileNum, ls_renglon)
	ls_renglon = ''
	
	FileWrite(li_FileNum, ls_renglon)
next
FileClose(li_FileNum)
SetPointer( HourGlass! )
MessageBox('Exportacion Txt','Se exporto correctamente el archivo.txt ubicado en ' + ls_ruta, Information!)

Return 1
end function

public function integer wf_buscaman (string as_cod);String ls_man, ls_parm,ls_act

as_cod = f_Trim( as_cod )

If as_cod = '' Then
	 OpenWithParm( w_mant_buscar_x_nombre, 'MAN' )
	 ls_parm = Message.StringParm 
	 ls_parm = f_Trim( ls_parm )
	 
	 If Not ls_parm = '' Then
	  as_cod = ls_parm
	  ls_man = as_cod
	 End If
else
	
	Select c_codigo_man,c_activo_man
	Into  :ls_man,:ls_act
	From  t_manifiesto
	Where  c_codigo_man = :as_cod
	and c_codigo_tem = (select c_codigo_tem from t_temporada where c_activo_tem = '1')
	Using  SqlCa ;
	If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_manifiesto.' ) = -1 Then
		Return 0
	end if
	if ls_act <> '1' then
		messagebox(title,'Manifiesto no encontrado',exclamation!)
		return 0
	end if
	
End If


sle_man.text=string(ls_man)

Return 1
end function

public function integer wf_buscaman2 (string as_cod);String ls_man, ls_parm,ls_act

as_cod = f_Trim( as_cod )

If as_cod = '' Then
	 OpenWithParm( w_mant_buscar_x_nombre, 'MAN' )
	 ls_parm = Message.StringParm 
	 ls_parm = f_Trim( ls_parm )
	 
	 If Not ls_parm = '' Then
	  as_cod = ls_parm
	  ls_man = as_cod
	 End If
else
	
	Select c_codigo_man,c_activo_man
	Into  :ls_man,:ls_act
	From  t_manifiesto
	Where  c_codigo_man = :as_cod
	and c_codigo_tem = (select c_codigo_tem from t_temporada where c_activo_tem = '1')
	Using  SqlCa ;
	If f_SqlError( SqlCa, 'No se puede obtener informacion de la tabla t_manifiesto.' ) = -1 Then
		Return 0
	end if
	if ls_act <> '1' then
		messagebox(title,'Manifiesto no encontrado',exclamation!)
		return 0
	end if
	
End If


sle_man2.text=string(ls_man)

Return 1
end function

public function integer wf_solveproduce ();//DEL CAMPO
long  	ll_count,j,i
String   ls_renglon, ls_ruta, ls_name,ls_fecha,ls_sep,col1,col2,col3,col4,col5,col6,col7,col8,col9,col10,col11,col12,col13,col14,col15,col16,col17,&
			col18,col19, ls_tag, ls_tip, ls_part
DateTime ld_ini,ld_fin,ld_hoy

ld_ini=f_stringtodate( em_ini.Text )
ld_fin=f_stringtodate( em_fin.Text )

ls_tag = f_getparmvalue('081')
ls_tag = f_trim(ls_tag)
if ls_tag = '' then
	messagebox(title,'Agregue el valor del parametro 081',exclamation!)
	return 0
elseif (len(ls_tag))<> 3 then
	messagebox(title,'Longitud incorrecta del valor en el parametro 081',exclamation!)
	return 0	
end if

ls_tip = f_getparmvalue('082')
ls_tip = f_trim(ls_tip)
if ls_tip = '' then
	messagebox(title,'Agregue el valor del parametro 082',exclamation!)
	return 0
end if

ls_part = f_getparmvalue('083')
ls_part = f_trim(ls_part)
if ls_part = '' then
	messagebox(title,'Agregue el valor del parametro 083',exclamation!)
	return 0
end if

SetPointer( HourGlass! )
Integer li_FileNum
ls_ruta  = f_getparmvalue('050')
ld_hoy   = datetime(today())
ls_fecha = string(ld_hoy,'dd-mm-yyyy')
ls_fecha = string(ld_ini,'yyyy-mm-dd') + ' - ' + string(ld_fin,'yyyy-mm-dd')
ls_name = '\e-'+ ls_fecha+ '.txt' 
ls_sep = '*'
filedelete(ls_ruta + ls_name)
li_FileNum = FileOpen( ls_ruta + ls_name, LineMode!, Write!, LockWrite!, Append!)



dw_list.DataObject = 'd_rpt_embarque_export_solveproduce'
dw_list.SetTransObject( SqlCa )
dw_list.Retrieve( ld_ini,ld_fin )
ll_count = dw_list.RowCount()

if ll_count = 0 then
	messagebox(title,'No hay datos para exportar con ese rango de fechas',exclamation!)
	return 0
end if

ls_renglon = ''
For j = 1 To 2
	If j=1 Then
		ls_renglon = '///+'+'CONTENT+'+'LIT+'+'VERSION+'+'2.00+'+'PARTNERID+'+f_trim(f_getparmvalue('083'))+'+///'
	Else
		ls_renglon = '///+'+'TOTREC+'+string(ll_count)+'+'+'TOTQTY+'+string(dw_list.object.total[1])+'+OPTYPE+'+f_trim(f_getparmvalue('082'))+'+'+'TAGUID+'+f_trim(f_getparmvalue('081'))+'+'+'FLDDEL+'+ls_sep+'+///'
	End If
FileWrite(li_FileNum, ls_renglon)
Next

For i = 1 To ll_count
	col1 = f_trim(dw_list.object.col1[i])
	col2 = f_trim(dw_list.object.col2[i])
	col3 = f_trim(dw_list.object.col3[i])
	col4 = f_trim(dw_list.object.col4[i])
	col5 = f_trim(string(dw_list.object.col5[i],'yyyymmdd'))
	col6 = f_trim(dw_list.object.col6[i])
	col7 = f_trim(dw_list.object.col7[i])
	col8 = f_trim(dw_list.object.col8[i])
	col9 = f_trim(dw_list.object.col9[i])
	col10 = f_trim(dw_list.object.col10[i])
	col11 = f_trim(dw_list.object.col11[i])
	col12 = f_trim(dw_list.object.col12[i])
	col13 = f_trim(dw_list.object.col13[i])
	col14 = f_trim(string(Round(dw_list.object.col14[i],0)))
	col15 = f_trim(dw_list.object.col15[i])
	col16 = f_trim(string(Round(dw_list.object.col16[i],0)))
	col17 = f_trim(dw_list.object.col17[i])
	col18 = f_trim(dw_list.object.col18[i])
	col19 = f_trim(dw_list.object.col19[i])

	ls_renglon = ''

	ls_renglon = ls_renglon + 'REC=' + col1 + ls_sep + col2 + ls_sep + col3 + ls_sep + col4 + ls_sep + col5 + ls_sep + col6 
	ls_renglon = ls_renglon + ls_sep + col7 + ls_sep + col8 + ls_sep + col9 + ls_sep + col10 + ls_sep + col11 + ls_sep + col12 + ls_sep + col13 + ls_sep + col14
	ls_renglon = ls_renglon + ls_sep + col15 + ls_sep + col16 + ls_sep + col17 + ls_sep + col18 + ls_sep + col19 +'<<<'


	FileWrite(li_FileNum, ls_renglon)
Next
FileClose(li_FileNum)
SetPointer( HourGlass! )

REturn 1
end function

public function integer wf_solveproduce2 ();long  	ll_count,j,i
String   ls_renglon, ls_ruta, ls_name,ls_fecha,ls_sep,col1,col2,col3,col4,col5,col6,col7,col8,col9,col10,col11,col12,col13,col14,col15,col16,col17,&
			col18,col19, ls_tag, ls_tip, ls_part
DateTime ld_ini,ld_fin,ld_hoy

ld_ini=f_stringtodate( em_ini.Text )
ld_fin=f_stringtodate( em_fin.Text )

ls_tag = f_getparmvalue('091')
ls_tag = f_trim(ls_tag)
if ls_tag = '' then
	messagebox(title,'Agregue el valor del parametro 091',exclamation!)
	return 0
elseif (len(ls_tag))<> 3 then
	messagebox(title,'Longitud incorrecta del valor en el parametro 091',exclamation!)
	return 0	
end if

ls_tip = f_getparmvalue('092')
ls_tip = f_trim(ls_tip)
if ls_tip = '' then
	messagebox(title,'Agregue el valor del parametro 092',exclamation!)
	return 0
end if

ls_part = f_getparmvalue('093')
ls_part = f_trim(ls_part)
if ls_part = '' then
	messagebox(title,'Agregue el valor del parametro 093',exclamation!)
	return 0
end if

SetPointer( HourGlass! )
Integer li_FileNum
ls_ruta  = f_getparmvalue('050')
ld_hoy   = datetime(today())
ls_fecha = string(ld_hoy,'dd-mm-yyyy')
ls_fecha = string(ld_ini,'yyyy-mm-dd') + ' - ' + string(ld_fin,'yyyy-mm-dd')
ls_name = '\e-'+ ls_fecha+ '.txt' // mismo nombre?

ls_sep = '*'
filedelete(ls_ruta + ls_name)
li_FileNum = FileOpen( ls_ruta + ls_name, LineMode!, Write!, LockWrite!, Append!)

dw_list.DataObject = 'd_rpt_embarque_export_solveproduce2'
dw_list.SetTransObject( SqlCa )
dw_list.Retrieve( ld_ini,ld_fin )
ll_count = dw_list.RowCount()

if ll_count = 0 then
	messagebox(title,'No hay datos para exportar con ese rango de fechas',exclamation!)
	return 0
end if

ls_renglon = ''
For j = 1 To 2
	If j=1 Then
		ls_renglon = '///+'+'CONTENT+'+'LIT+'+'VERSION+'+'2.00+'+'PARTNERID+'+f_trim(f_getparmvalue('093'))+'+///'
	Else
		ls_renglon = '///+'+'TOTREC+'+string(ll_count)+'+'+'TOTQTY+'+string(dw_list.Object.total[1])+'+OPTYPE+'+f_trim(f_getparmvalue('092'))+'+'+'TAGUID+'+f_trim(f_getparmvalue('091'))+'+'+'FLDDEL+'+ls_sep+'+///'
	End If
FileWrite(li_FileNum, ls_renglon)
Next

For i = 1 To ll_count
	col1 = f_trim(dw_list.object.col1[i])
	col2 = f_trim(dw_list.object.col2[i])
	col3 = f_trim(dw_list.object.col3[i])
	col4 = f_trim(dw_list.object.col4[i])
	col5 = f_trim(string(dw_list.object.col5[i],'yyyymmdd'))
	col6 = f_trim(dw_list.object.col6[i])
	col7 = f_trim(dw_list.object.col7[i])
	col8 = f_trim(dw_list.object.col8[i])
	col9 = f_trim(dw_list.object.col9[i])
	col10 = f_trim(dw_list.object.col10[i])
	col11 = f_trim(dw_list.object.col11[i])
	if len(col11)< 18 then
		col11 = Left (col11 + '000000000000000000',18)
	end if	
	col12 = f_trim(dw_list.object.col12[i])
	col13 = f_trim(dw_list.object.col13[i])
	col14 = f_trim(string(Round(dw_list.object.col14[i],0)))
	col15 = f_trim(dw_list.object.col15[i])
	col16 = f_trim(string(Round(dw_list.object.col16[i],0)))
	col17 = f_trim(dw_list.object.col17[i])
	col18 = f_trim(dw_list.object.col18[i])
	col19 = f_trim(dw_list.object.col19[i])

	ls_renglon = ''

	ls_renglon = ls_renglon + 'REC=' + col1 + ls_sep + col2 + ls_sep + col3 + ls_sep + col4 + ls_sep + col5 + ls_sep + col6 
	ls_renglon = ls_renglon + ls_sep + col7 + ls_sep + col8 + ls_sep + col9 + ls_sep + col10 + ls_sep + col11 + ls_sep + col12 + ls_sep + col13 + ls_sep + col14
	ls_renglon = ls_renglon + ls_sep + col15 + ls_sep + col16 + ls_sep + col17 + ls_sep + col18 + ls_sep + col19 +'<<<'


	FileWrite(li_FileNum, ls_renglon)
Next
FileClose(li_FileNum)
SetPointer( HourGlass! )

REturn 1
end function

public function integer wf_export_stateresa ();Long i, li_filenum
String ls_ruta, ls_name, ls_fecha, ls_renglon, ls_llegada, ls_salida, ls_cajas
DateTime ld_ini, ld_fin, ld_hoy, ld_fec

ls_ruta  = f_getparmvalue('050')
ld_hoy   = Datetime(Today())
ld_ini = f_stringtodate(em_ini.Text)
ld_fin = f_stringtodate(em_fin.Text)
ls_renglon= f_trim(ddlb_1.text)
If ls_renglon = 'Pacific' Then
	dw_list.DataObject= 'd_rpt_embarque_export_excel_teresa'
	dw_list.SetTransObject(SqlCa)
	dw_list.Retrieve(ld_ini, ld_fin)
	ls_fecha = String(ld_ini,'ddmmyyyy')
	ls_name = 'Embarque_' + ls_fecha+ '.xls'
	Filedelete(ls_ruta + ls_name)
	dw_list.SaveAs(ls_ruta + ls_name, Excel!, True)
	f_abrir_doc(ls_ruta + ls_name)
Elseif ls_renglon = 'Guimarra' Then
	dw_list.DataObject = 'd_rpt_embarque_export_txt_teresa'
	dw_list.SetTransObject(SqlCa)
	dw_list.Retrieve(ld_ini,ld_fin)
	ls_fecha = String(ld_ini,'yymmdd')
	ls_name = 'HFF'+ ls_fecha+ '.txt'
	filedelete(ls_ruta + ls_name)
	li_FileNum = FileOpen( ls_ruta + ls_name, LineMode!, Write!, LockWrite!, Append!)
	For i = 1 To dw_list.RowCount()
		ld_fec = dw_list.object.CrossDate[i]
		ls_salida = String(ld_fec,'yymmdd')
		ls_llegada = String(Relativedate(Date(ld_fec), 1), 'yymmdd')
		ls_cajas = String(dw_list.object.Cases[i], '####')
		ls_renglon = ''
		ls_renglon = 'ST'+Right('000000'+dw_list.object.ShipperRef[i],6) + Left(dw_list.object.TrailerID[i]+Space(15), 15) + Right('0000'+ls_cajas, 4)
		ls_renglon = ls_renglon + Right('000'+String(dw_list.object.Pallets[i]), 3) + ls_llegada + ls_salida
		FileWrite(li_FileNum, ls_renglon)
	Next
	FileClose(li_FileNum)
	f_abrir_doc(ls_ruta + ls_name)
	
	dw_list.DataObject = 'd_rpt_embarque_export_txtdet_teresa'
	dw_list.SetTransObject(SqlCa)
	dw_list.Retrieve(ld_ini,ld_fin)
	ls_name = 'DFF'+ ls_fecha+ '.txt'
	filedelete(ls_ruta + ls_name)
	li_FileNum = FileOpen( ls_ruta + ls_name, LineMode!, Write!, LockWrite!, Append!)
	For i = 1 To dw_list.RowCount()
		ld_fec = dw_list.object.PackDate[i]
		ls_salida = String(ld_fec,'yymmdd')
		ls_cajas = String(dw_list.object.Cases[i], '####')
		ls_renglon = ''
		ls_renglon = 'ST'+Right('000000'+dw_list.object.Manifiesto[i],6)+Left(dw_list.object.pallet[i]+Space(10),10)+Left(dw_list.object.label[i]+Space(4),4)
		ls_renglon = ls_renglon + Left(dw_list.object.Producto[i]+Space(4),4) + Left(dw_list.object.Tamanio[i]+Space(3),3) + Right('000'+ls_cajas,3)
		ls_renglon = ls_renglon + Left(dw_list.object.Lote[i]+Space(6),6) + ls_salida + '8 00000'
		FileWrite(li_FileNum, ls_renglon)
	Next
	FileClose(li_FileNum)
	f_abrir_doc(ls_ruta + ls_name)
	MessageBox(Title,'Se exporto correctamente el archivo ubicado en ' + ls_ruta, Information!)
End If

Return 1
end function

event open;call super::open;string ls_par

dw_1.Visible = False
dw_list.Visible = False
em_ini.Text=string(gd_sys,'dd/mm/yyyy')
em_fin.Text=string(gd_sys,'dd/mm/yyyy')

ls_par = UPPER(f_getparmvalue('068'))
if ls_par = 'C' then
	st_5.visible = false
	ddlb_1.visible = false
	st_6.visible = false
	sle_man.enabled = false
	cb_buscam.enabled = false
	st_4.visible = false
	sle_man2.enabled = false
	cb_buscam2.enabled = false
	cbx_1.enabled = true
	cbx_1.checked = false
elseif ls_par = 'V' Or ls_par = 'S' then
	st_5.visible = true
	ddlb_1.visible = true
	sle_man.visible = false
	sle_man2.visible = false
	cbx_1.visible = false
	cbx_1.checked = false
	cb_buscam.visible = false
	cb_buscam2.visible = false
	st_4.visible = false
	st_6.visible = false
else
	st_5.visible = false
	ddlb_1.visible = false
	sle_man.visible = false
	sle_man2.visible = false
	cbx_1.visible = false
	cbx_1.checked = false
	cb_buscam.visible = false
	cb_buscam2.visible = false
	st_4.visible = false
	st_6.visible = false
end if
end event

on w_rpt_export.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_ini=create em_ini
this.cb_5=create cb_5
this.st_2=create st_2
this.em_fin=create em_fin
this.cb_fin=create cb_fin
this.st_3=create st_3
this.cbx_1=create cbx_1
this.sle_man=create sle_man
this.cb_buscam=create cb_buscam
this.sle_man2=create sle_man2
this.cb_buscam2=create cb_buscam2
this.st_4=create st_4
this.st_6=create st_6
this.ddlb_1=create ddlb_1
this.st_5=create st_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_ini
this.Control[iCurrent+3]=this.cb_5
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.em_fin
this.Control[iCurrent+6]=this.cb_fin
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.cbx_1
this.Control[iCurrent+9]=this.sle_man
this.Control[iCurrent+10]=this.cb_buscam
this.Control[iCurrent+11]=this.sle_man2
this.Control[iCurrent+12]=this.cb_buscam2
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.ddlb_1
this.Control[iCurrent+16]=this.st_5
end on

on w_rpt_export.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_ini)
destroy(this.cb_5)
destroy(this.st_2)
destroy(this.em_fin)
destroy(this.cb_fin)
destroy(this.st_3)
destroy(this.cbx_1)
destroy(this.sle_man)
destroy(this.cb_buscam)
destroy(this.sle_man2)
destroy(this.cb_buscam2)
destroy(this.st_4)
destroy(this.st_6)
destroy(this.ddlb_1)
destroy(this.st_5)
end on

type dw_list from wa_response`dw_list within w_rpt_export
int X=9
int Y=912
int Width=137
int Height=112
int TabOrder=0
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=false
boolean VScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type dw_1 from wa_response`dw_1 within w_rpt_export
int X=178
int Y=912
int Width=155
int Height=124
int TabOrder=0
end type

type cb_cancelar from wa_response`cb_cancelar within w_rpt_export
int X=942
int Y=700
int TabOrder=60
end type

type cb_aceptar from wa_response`cb_aceptar within w_rpt_export
int X=562
int Y=700
int TabOrder=50
boolean Enabled=true
end type

event cb_aceptar::clicked;String ls_opc,ls_ruta, ls_tip, ls_ini, ls_fin
Datetime ld_ini, ld_fin

ls_ruta  = f_getparmvalue('050')
if ls_ruta = '' then
messagebox(title,'Agregue la ruta de exportación (parametro 050)',exclamation!)
return 0
end if

ls_opc = UPPER(f_getparmvalue('068'))
if ls_opc = '' then
messagebox(title,'Agregue el valor correcto al parametro 068',exclamation!)
return 0
end if

ls_ini = f_trim(em_ini.text)
ls_fin = f_trim(em_fin.text)
if (ls_ini = '') or (ls_ini = '00/00/00') then
	messagebox(title,'Debe capturar la fecha inicial',exclamation!)
	return 0
end if

if (ls_fin = '') or (ls_fin = '00/00/00') then
	messagebox(title,'Debe capturar la fecha final',exclamation!)
	return 0
end if

ld_ini = datetime(date(ls_ini))
ld_fin = datetime(date(ls_fin))
if ld_ini > ld_fin then
	messagebox(title,'La fecha inicial No debe ser mayor que la fecha final',exclamation!)
	return 0
end if

if ls_opc = 'V' then
	ls_tip = f_trim(ddlb_1.text)
	if ls_tip = '' then
		messagebox(title,'Debe seleccionar un tipo de archivo',exclamation!)
		return 0
	else
		if ls_tip = 'Del Campo' then
			ls_tip = '1'
		else
			ls_tip = '3'
		end if
	end if
end if

Choose Case ls_opc
	Case 'E'
		wf_export_epsa()
	Case 'L'
		wf_export_delourdes()
	Case 'C'
		if cbx_1.checked then
			if f_trim(sle_man.text) = '' then
				messagebox(title,'No ha elegido el manifiesto para generar',exclamation!)
				return 0
			end if
		end if
			wf_export_campania()	
	Case 'V'//Alta / Prima / Pozo
		if ls_tip = '1' then
			IF wf_solveproduce() = 1 Then
				MessageBox('Archivo Importación','Se exporto correctamente el archivo (1) ' + ls_ruta,Exclamation!)
			Else
				MessageBox('Archivo Importación','No se pudo exportar el archivo (1)',Exclamation!)
			End IF
		else
			IF wf_solveproduce2() = 1 Then
				MessageBox('Archivo Importación','Se exporto correctamente el archivo (3) ' + ls_ruta,Exclamation!)
			Else
				MessageBox('Archivo Importación','No se pudo exportar el archivo (3)',Exclamation!)
			End IF
		end if
	Case 'S'
		wf_export_stateresa()
	Case Else
		Messagebox(title, 'Elija en opciones(068) el tipo de archivo que desea generar', Exclamation!)
End Choose

Return 1
end event

type st_1 from statictext within w_rpt_export
int X=91
int Y=32
int Width=1179
int Height=116
boolean Enabled=false
boolean BringToTop=true
string Text="El archivo se exporta en C:\export.txt al dar click en el boton aceptar."
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

type em_ini from uo_editmask within w_rpt_export
int X=219
int Y=172
end type

type cb_5 from uo_cbdate within w_rpt_export
int X=567
int Y=176
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_ini )
end event

type st_2 from statictext within w_rpt_export
int X=718
int Y=176
int Width=73
int Height=76
boolean Enabled=false
string Text="Al:"
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

type em_fin from uo_editmask within w_rpt_export
int X=850
int Y=172
int TabOrder=20
end type

type cb_fin from uo_cbdate within w_rpt_export
int X=1198
int Y=176
int TabOrder=0
end type

event clicked;uof_Calendar( Parent, em_fin )
end event

type st_3 from statictext within w_rpt_export
int X=105
int Y=172
int Width=114
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Del "
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

type cbx_1 from checkbox within w_rpt_export
int X=91
int Y=400
int Width=384
int Height=80
boolean BringToTop=true
string Text="Por Manifiesto"
BorderStyle BorderStyle=StyleLowered!
boolean RightToLeft=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if cbx_1.checked then
	sle_man.enabled = true
	cb_buscam.enabled = true
	sle_man2.enabled = true
	cb_buscam2.enabled = true
else
	sle_man.enabled = false
	cb_buscam.enabled = false
	sle_man2.enabled = false
	cb_buscam2.enabled = false
	sle_man.text = ''
	sle_man2.text = ''
end if
	
end event

type sle_man from singlelineedit within w_rpt_export
int X=238
int Y=508
int Width=334
int Height=84
int TabOrder=30
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

event modified;string ls_man

ls_man = sle_man.text

if ls_man <> '' then
		wf_buscaman(ls_man)
else
	wf_buscaman('')
end if
return 1
end event

type cb_buscam from commandbutton within w_rpt_export
int X=585
int Y=508
int Width=82
int Height=76
boolean BringToTop=true
string Text="..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_buscaman('')
end event

type sle_man2 from singlelineedit within w_rpt_export
int X=869
int Y=508
int Width=334
int Height=84
int TabOrder=40
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

event modified;string ls_man

ls_man = sle_man2.text

if ls_man <> '' then
		wf_buscaman2(ls_man)
else
	wf_buscaman2('')
end if
return 1
end event

type cb_buscam2 from commandbutton within w_rpt_export
int X=1216
int Y=508
int Width=87
int Height=76
boolean BringToTop=true
string Text="..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_buscaman2('')
end event

type st_4 from statictext within w_rpt_export
int X=736
int Y=508
int Width=73
int Height=76
boolean Enabled=false
string Text="Al:"
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

type st_6 from statictext within w_rpt_export
int X=123
int Y=508
int Width=114
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Del "
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

type ddlb_1 from dropdownlistbox within w_rpt_export
int X=485
int Y=296
int Width=791
int Height=396
int TabOrder=20
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Del Campo",&
"Divine Flavor",&
"Pacific",&
"Guimarra"}
end type

type st_5 from statictext within w_rpt_export
int X=105
int Y=300
int Width=379
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Tipo de Archivo: "
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

