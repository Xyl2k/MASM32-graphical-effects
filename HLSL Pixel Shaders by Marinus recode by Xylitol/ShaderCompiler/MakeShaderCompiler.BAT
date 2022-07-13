SET FILE=ShaderCompiler
SET PATH=C:\masm32\bin\

@echo off
	
if not exist rsrc.rc goto delexe
%PATH%Rc.exe /v rsrc.rc
%PATH%Cvtres.exe /machine:ix86 rsrc.res

:delexe
if exist %FILE%.exe del %FILE%.exe

%PATH%Ml.exe /c /coff %FILE%.asm
if errorlevel 1 goto errorasm

if not exist rsrc.obj goto nores

%PATH%Link.exe /SUBSYSTEM:WINDOWS %FILE%.obj rsrc.obj
if errorlevel 1 goto errorlink

if exist %FILE%.obj del %FILE%.obj
if exist rsrc.obj del rsrc.obj
if exist rsrc.res del rsrc.res

dir %FILE%.*
goto Show

:nores
%PATH%Link.exe /SUBSYSTEM:WINDOWS %FILE%.obj
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

