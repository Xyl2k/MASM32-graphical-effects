@echo off

if not exist rsrc.rc goto over1
\MASM32\BIN\Rc.exe /v rsrc.rc
\MASM32\BIN\Cvtres.exe /machine:ix86 rsrc.res
:over1

if exist main.obj del main.obj
if exist main.exe del main.exe

\MASM32\BIN\Ml.exe /c /coff main.asm
\MASM32\BIN\Link.exe /SUBSYSTEM:WINDOWS /opt:nowin98  /MERGE:.rdata=.text -ignore:4078 main.obj rsrc.obj

del main.obj
del rsrc.obj
del rsrc.RES

cls

echo -------------------------------------
echo.
echo             BRUSH Example
echo.
echo       .::: c0ded by x0man :::.
echo           (C) tPORt 2006
echo.
echo -------------------------------------

pause