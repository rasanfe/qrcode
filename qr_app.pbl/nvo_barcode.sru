forward
global type nvo_barcode from nonvisualobject
end type
end forward

global type nvo_barcode from nonvisualobject
end type
global nvo_barcode nvo_barcode

type variables
nvo_zxingnet8 io_zxing

CONSTANT Integer AZTEC = 1
        //
        // Resumen:
        //     CODABAR 1D format.
CONSTANT Integer CODABAR = 2
        //
        // Resumen:
        //     Code 39 1D format.
CONSTANT Integer  CODE_39 =3
        //
        // Resumen:
        //     Code 93 1D format.
CONSTANT Integer CODE_93 =4
        //
        // Resumen:
        //     Code 128 1D format.
CONSTANT Integer CODE_128 =5
        //
        // Resumen:
        //     Data Matrix 2D barcode format.
CONSTANT Integer  DATA_MATRIX = 6
        //
        // Resumen:
        //     EAN-8 1D format.
CONSTANT Integer  EAN_8 = 7
        //
        // Resumen:
        //     EAN-13 1D format.
CONSTANT Integer EAN_13 = 8
        //
        // Resumen:
        //     ITF (Interleaved Two of Five) 1D format.
CONSTANT Integer ITF = 9
        //
        // Resumen:
        //     MaxiCode 2D barcode format.
CONSTANT Integer  MAXICODE =10
        //
        // Resumen:
        //     PDF417 format.
CONSTANT Integer  PDF_417 =11
        //
        // Resumen:
        //     QR Code 2D barcode format.
CONSTANT Integer  QR_CODE = 12
        //
        // Resumen:
        //     RSS 14
CONSTANT Integer RSS_14 = 13
        //
        // Resumen:
        //     RSS EXPANDED
CONSTANT Integer  RSS_EXPANDED =14
        //
        // Resumen:
        //     UPC-A 1D format.
CONSTANT Integer UPC_A =15
        //
        // Resumen:
        //     UPC-E 1D format.
CONSTANT Integer  UPC_E =16
        //
        // Resumen:
        //     UPC/EAN extension format. Not a stand-alone format.
CONSTANT Integer  UPC_EAN_EXTENSION =17
        //
        // Resumen:
        //     MSI
CONSTANT Integer  MSI = 18
        //
        // Resumen:
        //     Plessey
CONSTANT Integer  PLESSEY =19
        //
        // Resumen:
        //     Intelligent Mail barcode
CONSTANT Integer  IMB = 20
        //
        // Resumen:
        //     Pharmacode format.
CONSTANT Integer PHARMA_CODE = 21
        //
        // Resumen:
        //     UPC_A | UPC_E | EAN_13 | EAN_8 | CODABAR | CODE_39 | CODE_93 | CODE_128 | ITF
        //     | RSS_14 | RSS_EXPANDED without MSI (to many false-positives) and IMB (not enough
        //     tested, and it looks more like a 2D)  -->ONLY FOR DECODE
CONSTANT Integer   All_1D = 22
end variables

forward prototypes
public function string of_genera_qr (string as_data)
public function string of_leer_qr (string as_qrfilepath)
public function boolean of_controles_previos ()
end prototypes

public function string of_genera_qr (string as_data);String ls_path
String ls_qr, ls_qr_blanco
Integer li_width, li_height, li_margin, li_format
Boolean lb_PureBarcode
String ls_result

if not of_controles_previos() then
	Return ls_qr_blanco
end if	

if isnull(as_data) OR as_data = "" then
	messagebox("Atención!", "¡ No hay Información para generar QR !", exclamation!)
	Return ls_qr_blanco
end if

ls_path = gs_appdir + "QR_IMAGEN"
CreateDirectory(ls_path)

ls_qr = ls_path + "\qr.png" // Fichero donde se genera el código de barras

FileDelete(ls_qr) //Si existe lo borro

ls_qr_blanco =  ls_path +"\qrblanco.png"   // Fichero todo blanco

//Podriamos Genera Cualquier otro tipo de codigo de barras. Ver constantes de Instancia con todos los Formatos disponibles.
//Configuración del Código QR
li_width=230
li_height=230
li_margin=2
lb_PureBarcode=true
li_format = QR_CODE

ls_result = io_zxing.of_barcodegenerate(as_data, ls_qr, li_format, li_height, li_width, lb_PureBarcode, li_margin)
                         

IF isnull(ls_result) or ls_result="" THEN ls_result = io_zxing.is_ErrorText
	
IF ls_result <> ls_qr THEN
		messagebox("Error", ls_result, Stopsign!)
END IF	

IF	NOT FileExists(ls_qr) THEN
	ls_qr =  ls_qr_blanco
END IF

RETURN ls_qr
end function

public function string of_leer_qr (string as_qrfilepath);String ls_lectura

if not of_controles_previos() then
	Return ls_lectura
end if	

IF isnull(as_qrfilepath) OR as_qrfilepath = "" or not FileExists( as_qrfilepath) THEN
	messagebox("Atención!", "¡ No hay ningun QR Cargado! ", exclamation!)
	Return ls_lectura
END IF

ls_lectura = io_Zxing.of_readbarcode(as_qrFilePath)

IF isnull(ls_lectura) or ls_lectura="" THEN
	messagebox("Error", io_zxing.is_ErrorText, Stopsign!)
END IF	

RETURN ls_lectura

end function

public function boolean of_controles_previos ();String ls_archivos[]
Int li_idx, li_TotalArchivos

ls_archivos[]={"ZxingBarcode.deps.json", "ZxingBarcode.dll", "zxing.dll", "ZXing.Windows.Compatibility.dll", "System.Drawing.Common.dll", "Microsoft.Win32.SystemEvents.dll"}

li_TotalArchivos = UpperBound(ls_archivos[])

FOR li_idx = 1 TO li_TotalArchivos
	IF NOT FileExists(gs_appdir+"DotNet\ZxingBarcode\"+ls_archivos[li_idx]) THEN
		MessageBox ("Atención", "¡ Necesita el Archivo "+ls_archivos[li_idx]+" !", Exclamation!)
		Return FALSE
	END IF
NEXT	

Return TRUE
end function

on nvo_barcode.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_barcode.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_zxing = CREATE nvo_zxingnet8

end event

event destructor;destroy io_zxing 
end event

