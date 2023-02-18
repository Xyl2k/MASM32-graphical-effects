@echo off
\masm32\bin\rc /v demo.rc
\masm32\bin\ml.exe /c /coff /Cp /nologo demo.asm
\masm32\bin\link.exe /SUBSYSTEM:WINDOWS /RELEASE /VERSION:4.0 /OUT:ripped.exe demo.obj demo.res
del demo.res
del demo.obj
pause