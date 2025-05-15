forward
global type w_qr from window
end type
type st_platform from statictext within w_qr
end type
type st_myversion from statictext within w_qr
end type
type st_qr_reader from statictext within w_qr
end type
type p_qr_reader from picture within w_qr
end type
type st_qr_generator from statictext within w_qr
end type
type st_copyright from statictext within w_qr
end type
type p_rsrsystem from picture within w_qr
end type
type p_qr_generator from picture within w_qr
end type
type dw_1 from datawindow within w_qr
end type
type p_qrcode from picture within w_qr
end type
type st_data from statictext within w_qr
end type
type sle_data from singlelineedit within w_qr
end type
type r_1 from rectangle within w_qr
end type
end forward

global type w_qr from window
integer width = 3378
integer height = 1868
boolean titlebar = true
string title = "Qr App"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_platform st_platform
st_myversion st_myversion
st_qr_reader st_qr_reader
p_qr_reader p_qr_reader
st_qr_generator st_qr_generator
st_copyright st_copyright
p_rsrsystem p_rsrsystem
p_qr_generator p_qr_generator
dw_1 dw_1
p_qrcode p_qrcode
st_data st_data
sle_data sle_data
r_1 r_1
end type
global w_qr w_qr

type variables
nvo_barcode io_qr
end variables

forward prototypes
public subroutine wf_version (statictext ast_version, statictext ast_patform)
public function long wf_retrieve (datawindow adw)
end prototypes

public subroutine wf_version (statictext ast_version, statictext ast_patform);String ls_version, ls_platform
environment env
integer rtn

rtn = GetEnvironment(env)

IF rtn <> 1 THEN 
	ls_version = string(year(today()))
	ls_platform="32"
ELSE
	ls_version = "20"+ string(env.pbmajorrevision)+ "." + string(env.pbbuildnumber)
	ls_platform=string(env.ProcessBitness)
END IF

ls_platform += " Bits"

ast_version.text=ls_version
ast_patform.text=ls_platform
end subroutine

public function long wf_retrieve (datawindow adw);Integer li_row, li_rowcount, li_Insert
Long ll_BusinessEntityID[25]
String ls_Title[25], ls_FirstName[25], ls_MiddleName[25]
String NullString

Setnull(NullString)

ll_BusinessEntityID[]={1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25}
ls_Title[] = {NullString, 	NullString, NullString, NullString, 'Ms.', 'Mr.', NullString, NullString, NullString, NullString, NullString, NullString, 'Ms.', NullString, NullString, NullString, NullString, NullString, NullString, NullString, NullString, NullString, NullString, 'Ms.', NullString} 
ls_FirstName[] = {'Ken', 'Terri', 'Roberto', 'Rob', 'Gail', 'Jossef', 'Dylan', 'Diane', 'Gigi', 'Michael', 'Ovidiu', 'Thierry', 'Janice', 'Michael', 'Sharon', 'David', 'Kevin', 'John', 'Mary', 'Wanida', 'Terry', 'Sariya', 'Mary', 'Jill', 'James'} 
ls_MiddleName[] = {'Smith', 'Lee', 'aaa', 'aaaaaaa', 'A', 'H', 'A', 'L', 'N', 'NullString', 'V', 'B', 'M', 'I', 'B', 'M', 'F', 'L', 'A', 'M', 'J', 'E', 'E', 'A', 'R'}


//Insertamos 25 Registros para la Demo

 li_rowcount = 25
 
FOR li_Row = 1 to  li_RowCount
	li_Insert = adw.InsertRow(0)
	adw.object.BusinessEntityID[li_Insert] = ll_BusinessEntityID[li_Row]
	adw.object.Title[li_Insert] = ls_Title[li_Row]
	adw.object.FirstName[li_Insert] =ls_FirstName[li_Row]
	adw.object.MiddleName[li_Insert] =ls_MiddleName[li_Row]
NEXT

return  li_rowcount
end function

on w_qr.create
this.st_platform=create st_platform
this.st_myversion=create st_myversion
this.st_qr_reader=create st_qr_reader
this.p_qr_reader=create p_qr_reader
this.st_qr_generator=create st_qr_generator
this.st_copyright=create st_copyright
this.p_rsrsystem=create p_rsrsystem
this.p_qr_generator=create p_qr_generator
this.dw_1=create dw_1
this.p_qrcode=create p_qrcode
this.st_data=create st_data
this.sle_data=create sle_data
this.r_1=create r_1
this.Control[]={this.st_platform,&
this.st_myversion,&
this.st_qr_reader,&
this.p_qr_reader,&
this.st_qr_generator,&
this.st_copyright,&
this.p_rsrsystem,&
this.p_qr_generator,&
this.dw_1,&
this.p_qrcode,&
this.st_data,&
this.sle_data,&
this.r_1}
end on

on w_qr.destroy
destroy(this.st_platform)
destroy(this.st_myversion)
destroy(this.st_qr_reader)
destroy(this.p_qr_reader)
destroy(this.st_qr_generator)
destroy(this.st_copyright)
destroy(this.p_rsrsystem)
destroy(this.p_qr_generator)
destroy(this.dw_1)
destroy(this.p_qrcode)
destroy(this.st_data)
destroy(this.sle_data)
destroy(this.r_1)
end on

event open;wf_version(st_myversion, st_platform)

wf_retrieve(dw_1)

io_qr = CREATE nvo_barcode

end event

event closequery;if not isPOwerClientApp() then
	Disconnect USING SQLCA;
end if	
destroy io_qr 
end event

type st_platform from statictext within w_qr
integer x = 2839
integer y = 140
integer width = 457
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33521664
string text = "Bits"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_myversion from statictext within w_qr
integer x = 2839
integer y = 52
integer width = 457
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33521664
string text = "Versión"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_qr_reader from statictext within w_qr
integer x = 910
integer y = 1520
integer width = 695
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217857
long backcolor = 67108864
string text = "<-- Click Lectura QR"
boolean focusrectangle = false
end type

type p_qr_reader from picture within w_qr
integer x = 183
integer y = 1408
integer width = 690
integer height = 236
string pointer = "HyperLink!"
string picturename = "qrreader.png"
boolean focusrectangle = false
end type

event clicked;String ls_lectura, ls_ruta

//Quito el QR para poder generar el siguiente
IF p_qrcode.PictureName = "" THEN
	messagebox("Atención", "¡No hay ningun QR Cargado!", exclamation!)
	return
END IF	

ls_Ruta = p_qrcode.PictureName

ls_lectura = io_qr.of_leer_qr(ls_ruta)

messagebox("Lectura QR", ls_lectura)

 
end event

type st_qr_generator from statictext within w_qr
integer x = 2770
integer y = 400
integer width = 695
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217857
long backcolor = 67108864
string text = "<-- Click Genera QR"
boolean focusrectangle = false
end type

type st_copyright from statictext within w_qr
integer x = 1778
integer y = 1684
integer width = 1531
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 67108864
string text = "Copyright © Ramón San Félix Ramón  rsrsystem.soft@gmail.com"
boolean focusrectangle = false
end type

type p_rsrsystem from picture within w_qr
integer x = 5
integer y = 4
integer width = 1253
integer height = 248
boolean originalsize = true
string picturename = "logo.jpg"
boolean focusrectangle = false
string powertiptext = "Click Para Registrar Librerias"
end type

type p_qr_generator from picture within w_qr
integer x = 2043
integer y = 288
integer width = 690
integer height = 236
string pointer = "HyperLink!"
string picturename = "qrgenerator.png"
boolean focusrectangle = false
end type

event clicked;String ls_data, ls_ruta

ls_data = sle_data.Text

//Quito el QR para poder generar el siguiente
p_qrcode.PictureName = ""

ls_Ruta = io_qr.of_genera_qr(ls_data)

p_qrcode.PictureName = ls_Ruta
end event

type dw_1 from datawindow within w_qr
integer x = 969
integer y = 624
integer width = 2213
integer height = 724
integer taborder = 20
string title = "none"
string dataobject = "dw_persondemo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_data
Integer li_businessentityid
String ls_firstname, ls_middlename

debugbreak()

IF row < 1 THEN RETURN

li_businessentityid = dw_1.object.BusinessEntityid[row]
ls_firstname  = dw_1.object.firstname[row]
ls_middlename = dw_1.object.middlename[row]

IF isnull(ls_firstname) OR TRIM(ls_firstname)="" THEN
	ls_firstname = ""
ELSE
	ls_firstname = " , "+ls_firstname
END IF	
IF isnull(ls_middlename) OR TRIM(ls_middlename)="" THEN
	ls_middlename = ""  
ELSE
	ls_middlename = " , " +ls_middlename
END IF	

ls_data =  string(li_businessentityid)+ls_firstname+ ls_middlename
sle_data.text = ls_data
p_qrcode.PictureName = ""
end event

type p_qrcode from picture within w_qr
integer x = 96
integer y = 628
integer width = 809
integer height = 728
boolean focusrectangle = false
end type

type st_data from statictext within w_qr
integer x = 78
integer y = 320
integer width = 745
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Datos para Generar QR:"
boolean focusrectangle = false
end type

type sle_data from singlelineedit within w_qr
integer x = 78
integer y = 424
integer width = 1765
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type r_1 from rectangle within w_qr
long linecolor = 33521664
integer linethickness = 4
long fillcolor = 33521664
integer y = -8
integer width = 3314
integer height = 260
end type

