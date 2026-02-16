# URL del archivo BAT en GitHub RAW
$batUrl = "https://raw.githubusercontent.com/franklingutierrez/ver-serial-pc/main/Ver_serial.bat"

# Ruta temporal donde se guardará el BAT
$tempBat = "$env:TEMP\Ver_serial.bat"

# Descargar el BAT
Invoke-WebRequest -Uri $batUrl -OutFile $tempBat -UseBasicParsing

# Ejecutar el BAT
Start-Process -FilePath $tempBat -Wait

# Eliminar el archivo temporal al finalizar 
Remove-Item $tempBat -Force
