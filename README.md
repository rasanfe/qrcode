# qrcode — Generar y leer códigos QR con PowerBuilder 📱

![PowerBuilder](https://img.shields.io/badge/PowerBuilder-2025-2D6CDF?style=flat-square)
![.NET](https://img.shields.io/badge/.NET-10-512BD4?style=flat-square&logo=dotnet&logoColor=white)
![ZXing](https://img.shields.io/badge/QR-ZXing.Net-00A98F?style=flat-square)
![Blog](https://img.shields.io/badge/blog-rsrsystem-FF5722?style=flat-square&logo=blogger&logoColor=white)

## 📋 ¿Qué es esto?

Un ejemplo PowerBuilder bien sencillo para **generar y leer códigos QR**. Pones un texto
(una URL, un identificador, lo que queráis), pulsas un botón y os sale el QR como imagen; y al
revés: le pasáis una imagen y os devuelve el contenido que lleva dentro.

¿Y cómo lo hace? Aquí está la gracia: PowerBuilder **no sabe** generar QR por sí mismo, así que
nos apoyamos en .NET. Cargamos una pequeña librería .NET (`ZxingBarcode`, que por debajo usa
**ZXing.Net**) como `dotnetobject` con el **.NET DLL Importer** de PB. Eso nos crea un objeto
proxy, **`nvo_zxingnet`**, que desde PowerScript se instancia y se usa como si fuera un objeto
nativo. Fijaos en lo limpio que queda:

- **Generar** → `nvo_zxingnet.BarcodeGenerate(texto, fichero, 12, alto, ancho, false, margen)`.
  Ese `12` es el código del formato **QR_CODE** dentro de la librería. Devuelve la ruta de la
  imagen creada.
- **Leer** → `nvo_zxingnet.ReadBarcode(fichero)` y os devuelve el texto que contenía el QR
  (cadena vacía si no reconoce nada).

Todos los métodos devuelven `string` a propósito, para que PowerBuilder nunca tenga que lidiar
con una excepción .NET: si algo falla, llega el mensaje de error como texto y listo.

## 🔗 Motor .NET

El "motor" que hace el trabajo es la librería .NET **`ZxingBarcode`** (clase `ZxingNet`):

- Se **despliega** ya compilada en la carpeta `DotNet\ZxingBarcode\` de este propio ejemplo,
  para que clones, compiles y funcione sin más.
- Se **consume** desde PowerBuilder como `dotnetobject` (el proxy `nvo_zxingnet`).
- El **código fuente** vive en `Blog\Net10\ZxingBarcode` (antes estaba en `Net8`) y se
  recompila/despliega con el script **`desplegar_dotnet.bat`** (hace `dotnet publish` y espeja
  las DLLs a la carpeta `DotNet` de cada ejemplo).
- Repo del proyecto .NET (Visual Studio 2022): <https://github.com/rasanfe/ZxingBarcode>

> 🔤 **Cambio de nombre (.NET 10):** la clase .NET pasó de `ZxingNet8` a `ZxingNet`, y el objeto
> PowerBuilder de `nvo_zxingnet8` a `nvo_zxingnet` (el "8" sugería .NET 8 y confundía). Recuerda
> **recompilar y volver a desplegar** la DLL de `ZxingBarcode`.

## 🛠️ Requisitos

- **PowerBuilder 2025** para abrir y compilar la solución.
- **.NET 10 Runtime** instalado en la máquina → <https://dotnet.microsoft.com/en-us/download/dotnet/10.0>
- La carpeta `DotNet\ZxingBarcode\` con las DLLs desplegadas (ya viene en el repo).

## ▶️ Cómo probarlo

1. Clona el repo y abre `app_qr.pbsln` con PowerBuilder 2025.
2. Compila (Full Build) y ejecuta.
3. Escribe un texto, genera el QR y compruébalo escaneándolo con el móvil.
4. Luego usa la opción de lectura sobre la imagen y verás cómo recupera el texto original.

🎬 **Vídeo demo en YouTube:** <https://youtu.be/rmw8BaNovJE>

## 🔗 Repo PowerBuilder

<https://github.com/rasanfe/qrcode>

---

> ¡Nos vemos en el próximo artículo! Y recuerda: en PowerBuilder, los límites solo están en nuestra imaginación. 🚀

📨 **Blog:** <https://rsrsystem.blogspot.com/>
