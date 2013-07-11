@echo off
::-----------------------------------------------------------
::VARS
::-----------------------------------------------------------
TITLE START LogMeIn Hamachi Service
COLOR 3F
set hamachidir="%programfiles(x86)%\LogMeIn Hamachi\"
set mostrado=0
echo Mas info en webtomich.com.ar
::-----------------------------------------------------------
::PRECONFIG
::-----------------------------------------------------------
echo *(Re) Configurando el Servicio de Hamachi para inicio manual
sc config Hamachi2Svc start= demand
::-----------------------------------------------------------
::INICIO
::-----------------------------------------------------------
echo *Comenzando Servicios de Hamachi
::Servicio
NET START Hamachi2Svc
::Interfaz
echo *Comenzando La Interfaz de Hamachi
CHDIR %hamachidir% 
START hamachi-2-ui.exe
::-----------------------------------------------------------
::Chequeo
::-----------------------------------------------------------
:CHECK
tasklist /FI "IMAGENAME eq hamachi-2-ui.exe" | find /i "hamachi-2-ui.exe" >NUL
 
IF ERRORLEVEL 2 GOTO HAMAOPEN 
IF ERRORLEVEL 1 GOTO HAMACLOSE 
::-----------------------------------------------------------
::Hamachi esta corriendo
::-----------------------------------------------------------
:HAMAOPEN 
IF %mostrado% == 0 ECHO *Hamachi esta corriendo (revise la bandeja de sistema al lado del reloj)
IF %mostrado% == 0 ECHO *Esta ventana se cerrara cuando Hamachi REALMENTE se detenga.
set mostrado=1
PING 127.0.0.1 -n 3 >NUL
goto CHECK
::-----------------------------------------------------------
::Hamachi se cerró
::-----------------------------------------------------------
:HAMACLOSE 
ECHO *Hamachi fue cerrado
ECHO *Matando el servicio
NET STOP Hamachi2Svc
ECHO *Servicio apagado
goto EXIT
::-----------------------------------------------------------
::TERMINAR
::-----------------------------------------------------------
:EXIT 
ECHO ****FIN del script****
pause