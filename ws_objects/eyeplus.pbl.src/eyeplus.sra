$PBExportHeader$eyeplus.sra
$PBExportComments$Generated Application Object
forward
global type eyeplus from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
Transaction ms_sqlca
DateTime gd_sys /* Fecha de sistema (interna) de operaciones */

String gs_aplicacion = 'EyE Plus'
String gs_usuario
String gs_cia = ''
String gs_mercado = ''
String gs_temporada, gs_codtem = ''
String gs_ini = 'eyeplus.ini'
String gs_version = 'v3.5.090J'
string gs_dprinter
string gs_tipo='N'
string gs_punto=''
String gs_codsis = '02'
String gs_nomsis = 'EyePlus'
String gs_hini /* Hora de Inicio */

Integer gi_cia, gi_poswin = 6, gi_popopc = 0

w_app_frame gw_frame

Boolean gb_connect = False
end variables

global type eyeplus from application
string appname = "eyeplus"
end type
global eyeplus eyeplus

type prototypes
Function boolean CopyFileA (String source, String target, boolean failexists) Library "Kernel32.DLL"
Function Boolean MoveFileA (String source, String target) Library "Kernel32.DLL"
Function Boolean CreateDirectoryA( Ref string ls_newdir, ulong lnull )  Library "Kernel32.DLL"
Function long GetComputerNameA (REF string lpBuffer, ref long nSize) Library "Kernel32.DLL"
Function long GetComputerNameW (REF string lpBuffer, ref long nSize) Library "Kernel32.DLL"
Function ulong GetCurrentDirectoryA (ulong textlen, ref string dirtext) library "KERNEL32.DLL"

//playsound
Function boolean sndPlaySoundA (string SoundName, uint Flags) Library "WINMM.DLL"
Function uint waveOutGetNumDevs () Library "WINMM.DLL"

end prototypes

type variables

end variables

on eyeplus.create
appname="eyeplus"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on eyeplus.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;Open(w_logo)
//uysaff
end event

