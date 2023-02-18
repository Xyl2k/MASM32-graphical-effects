@echo off
\masm32\bin\rc /v Resource.rc
\masm32\bin\ml.exe /c /coff /Cp /nologo Main.asm
\masm32\bin\link.exe /SUBSYSTEM:WINDOWS /RELEASE /VERSION:4.0 /OUT:ripped.exe Main.obj Resource.res
del Resource.res
del Main.obj
pause