SET FILE=Dialog
SET PATH=C:\masm32\bin\

@echo off
	
if not exist Dialog.rc goto delexe
%PATH%Rc.exe /v Dialog.rc
%PATH%Cvtres.exe /machine:ix86 Dialog.res

:delexe
if exist %FILE%.exe del %FILE%.exe

%PATH%Ml.exe /c /coff /Cp %FILE%.asm
if errorlevel 1 goto errorasm

if not exist Dialog.obj goto nores

%PATH%Link.exe /SUBSYSTEM:WINDOWS /VERSION:4.0 %FILE%.obj Dialog.res
if errorlevel 1 goto errorlink

if exist %FILE%.obj del %FILE%.obj
if exist Dialog.obj del Dialog.obj
if exist Dialog.res del Dialog.res

dir %FILE%.*
goto Show

:nores
%PATH%Link.exe /SUBSYSTEM:WINDOWS /VERSION:4.0 %FILE%.obj
if errorlevel 1 goto errorlink

if exist %FILE%.obj del %FILE%.obj

dir %FILE%.*
goto Show

:errorlink
echo _
echo Link error
goto Done

:errorasm
echo _
echo Assembly Error
goto Done

:Show
%FILE%.exe
:Done
pause

