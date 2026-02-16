@echo off
title Herramienta para ver Serial Number - Guiratec
color 0A

:inicio
cls
echo ================================================
echo        HERRAMIENTA PARA VER SERIAL NUMBER
echo ================================================
echo.
echo Selecciona tu version de Windows:
echo.
echo  1) Windows 7
echo  2) Windows 8 / 8.1
echo  3) Windows 10
echo  4) Windows 11
echo  5) No estoy seguro
echo.
set /p verWin=Elige una opcion: 

if "%verWin%"=="1" goto menuMetodo
if "%verWin%"=="2" goto menuMetodo
if "%verWin%"=="3" goto menuMetodo
if "%verWin%"=="4" goto menuMetodo
if "%verWin%"=="5" goto menuMetodo

echo Opcion invalida...
pause
goto inicio

:menuMetodo
cls
echo ================================================
echo     ¿Deseas usar CMD o PowerShell?
echo ================================================
echo.
echo  1) CMD (wmic bios get serialnumber)
echo  2) PowerShell (Get-WmiObject / Get-CimInstance)
echo.
set /p metodo=Elige una opcion: 

if "%metodo%"=="1" goto usarCMD
if "%metodo%"=="2" goto usarPS

echo Opcion invalida...
pause
goto menuMetodo

:usarCMD
cls
echo ================================================
echo     SERIAL NUMBER (CMD)
echo ================================================
echo.
wmic bios get serialnumber
echo.
pause
goto fin

:usarPS
cls
echo ================================================
echo     SERIAL NUMBER (PowerShell)
echo ================================================
echo.
echo Ejecutando PowerShell...
echo.
powershell -command "Get-WmiObject Win32_BIOS | Select-Object SerialNumber"
echo.
echo Si falla, probando con CIM:
powershell -command "Get-CimInstance Win32_BIOS | Select-Object SerialNumber"
echo.
pause
goto fin

:fin
echo.
echo ¿Deseas volver al menú? (S/N)
set /p volver=
if /I "%volver%"=="S" goto inicio
exit
