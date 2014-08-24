@echo off
set path=\masm32\bin
set lib=\masm32\lib
set name=sin_scrl
set rsrc=rsrc

rem rc "%rsrc%".rc
ml.exe /c /coff "%name%".asm
  if not exist==*.res goto no_res
  link.exe /SUBSYSTEM:WINDOWS  /SECTION:.text,EWR  /opt:nowin98 /LIBPATH:"%lib%" "%name%".obj "%rsrc%".res
       



 goto final
:no_res
  link.exe /SUBSYSTEM:WINDOWS /opt:nowin98 /LIBPATH:"%lib%" "%name%".obj
:final
  if errorlevel 1 goto End
   del *.OBJ
 rem  del *.res
:End
 pause
@echo on
 cls