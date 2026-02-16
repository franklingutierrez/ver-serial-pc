@echo off
title GUIRATEC - Herramienta para ver Serial Number
color 0A

:: ================================
:: PRESENTACIÓN GUIRATEC
:: ================================
cls
echo.
echo ============================================================
echo                 *** GUIRATEC - TECNOLOGIA INTELIGENTE ***
echo ============================================================
echo.
echo        Herramienta desarrollada por:
echo        Ing. Franklin Gutierrez Arizaca
echo.
echo        Contacto: fgutierrezarizaca@gmail.com
echo        Web: www.guiratec.com
echo.
echo ============================================================
echo              Presione una tecla para continuar...
echo ============================================================
pause >nul

:inicio
cls
echo ================================================
echo        HERRAMIENTA PARA VER SERIAL NUMBER
echo ================================================
echo.
echo Selecciona el método para obtener el serial:
echo.
echo  1) Auto (recomendado)
echo  2) CMD (wmic)
echo  3) PowerShell (CIM/WMI)
echo.
set /p metodo=Elige una opcion: 

if "%metodo%"=="1" goto auto
if "%metodo%"=="2" goto usarCMD
if "%metodo%"=="3" goto usarPS

echo Opcion invalida...
pause
goto inicio

:: ================================
:: FUNCIÓN PARA VALIDAR SERIAL
:: ================================
:validarSerial
set serial=%1

if "%serial%"=="" goto invalido
if /I "%serial%"=="System Serial Number" goto invalido
if /I "%serial%"=="To be filled by O.E.M." goto invalido
if /I "%serial%"=="None" goto invalido
if /I "%serial%"=="0" goto invalido

goto valido

:invalido
echo ------------------------------------------------
echo No se encontro un numero de serie valido.
echo Esto suele ocurrir cuando:
echo  - El fabricante no registro el serial en la BIOS
echo  - La PC es ensamblada o generica
echo  - La placa madre fue reemplazada
echo.
echo Revise la etiqueta fisica del dispositivo:
echo  - Parte inferior del laptop
echo  - Interior del case
echo  - Placa madre
echo  - Caja original del equipo
echo ------------------------------------------------
echo.
pause
goto fin

:valido
echo Serial Number encontrado:
echo %serial%
echo.
pause
goto fin

:: ================================
:: MODO AUTOMATICO
:: ================================
:auto
cls
echo ================================================
echo     MODO AUTOMATICO - DETECTANDO METODO
echo ================================================
echo.

:: Probar WMIC
for /f "skip=1 tokens=1" %%a in ('wmic bios get serialnumber 2^>nul') do (
    if not "%%a"=="" (
        call :validarSerial "%%a"
        goto fin
    )
)

:: Probar PowerShell CIM
for /f "tokens=1" %%a in ('powershell -command "Get-CimInstance Win32_BIOS | Select -Expand SerialNumber" 2^>nul') do (
    call :validarSerial "%%a"
    goto fin
)

:: Probar PowerShell WMI
for /f "tokens=1" %%a in ('powershell -command "Get-WmiObject Win32_BIOS | Select -Expand SerialNumber" 2^>nul') do (
    call :validarSerial "%%a"
    goto fin
)

echo No se pudo obtener el serial por ningun metodo.
pause
goto fin

:: ================================
:: MODO CMD
:: ================================
:usarCMD
cls
echo ================================================
echo     SERIAL NUMBER (CMD - WMIC)
echo ================================================
echo.

for /f "skip=1 tokens=1" %%a in ('wmic bios get serialnumber 2^>nul') do (
    if not "%%a"=="" (
        call :validarSerial "%%a"
        goto fin
    )
)

echo WMIC no esta disponible en este sistema.
pause
goto fin

:: ================================
:: MODO POWERSHELL
:: ================================
:usarPS
cls
echo ================================================
echo     SERIAL NUMBER (PowerShell)
echo ================================================
echo.

for /f "tokens=1" %%a in ('powershell -command "Get-CimInstance Win32_BIOS | Select -Expand SerialNumber" 2^>nul') do (
    call :validarSerial "%%a"
    goto fin
)

for /f "tokens=1" %%a in ('powershell -command "Get-WmiObject Win32_BIOS | Select -Expand SerialNumber" 2^>nul') do (
    call :validarSerial "%%a"
    goto fin
)

echo No se pudo obtener el serial con PowerShell.
pause
goto fin

:: ================================
:: FIN
:: ================================
:fin
cls
echo ================================================
echo        ¿Deseas volver al menú principal?
echo ================================================
echo.
set /p volver=Escribe S para volver o N para salir: 
if /I "%volver%"=="S" goto inicio
exit
