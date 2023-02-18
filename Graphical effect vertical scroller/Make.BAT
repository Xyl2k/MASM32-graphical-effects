@echo off
\masm32\bin\rc /v keygendlg.rc
\masm32\bin\ml.exe /c /coff /Cp /nologo keygendlg.asm
\masm32\bin\link.exe /SUBSYSTEM:WINDOWS /RELEASE /VERSION:4.0 /OUT:ripped.exe keygendlg.obj keygendlg.res
del keygendlg.res
del keygendlg.obj
pause