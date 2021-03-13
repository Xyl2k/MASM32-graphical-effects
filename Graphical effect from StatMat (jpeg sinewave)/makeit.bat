c:\masm32\bin\rc minip.rc
c:\masm32\bin\ml.exe /c /coff /Cp /nologo minip.asm
c:\masm32\bin\Link /OPT:NOWIN98 /OUT:"sample.exe" /SUBSYSTEM:WINDOWS minip.obj minip.res
del *.obj
del *.res
pause
