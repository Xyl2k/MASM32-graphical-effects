@echo off
c:\masm32\bin\rc fade2.rc
c:\masm32\bin\ml.exe /c /coff fade2.asm
  if not exist==*.res goto no_res
     c:\masm32\bin\link.exe /SUBSYSTEM:WINDOWS /LIBPATH:c:\masm32\lib *.obj *.res
        goto final
:no_res
  c:\masm32\bin\link.exe /SUBSYSTEM:WINDOWS /LIBPATH:c:\masm32\lib *.obj
:final
  if errorlevel 1 goto End
   del *.obj
   del *.res
:End
 pause
@echo on
 cls