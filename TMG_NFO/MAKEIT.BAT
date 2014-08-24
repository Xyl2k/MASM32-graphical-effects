@echo off
\masm32\bin\rc.exe rsrc.rc
\masm32\bin\ml /coff /c /Cp /Gz ripped.asm
\masm32\bin\Link /SUBSYSTEM:WINDOWS  ripped.obj rsrc.res

del *.res
DEL *.obj
pause
