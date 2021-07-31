@echo off             
echo.


set path=\masm32\bin
set name=BMPFONT
set rsrc=rsrc
if exist "%name%".obj del "%name%".obj
if exist "%name%".exe del "%name%".exe

if exist %rsrc%.res goto next

if not exist %rsrc%.rc goto over1

rc /v %rsrc%.rc

:next
if not exist %rsrc%.res goto over1
cvtres /machine:ix86 %rsrc%.res




:over1


ml /c /coff "%name%".asm
if errorlevel 1 goto errasm

if not exist %rsrc%.obj goto nores






Link  "%name%".obj %rsrc%.res /SUBSYSTEM:WINDOWS  /OPT:NOREF /SECTION:.text,EWR


if errorlevel 1 goto errlink

dir "%name%".*
goto TheEnd

:nores


Link /SUBSYSTEM:WINDOWS /OPT:NOREF "%name%".obj
if errorlevel 1 goto errlink
dir "%name%".*
goto TheEnd

:errlink
echo _
echo Link error
goto TheEnd

:errasm
echo _
echo Assembly Error
goto TheEnd

:TheEnd
rem ning.exe %name%.exe
rem upack.exe %name%.exe
pause

del "*".obj
del "*".res


