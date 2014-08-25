@echo off

if exist keygen.exe del keygen.exe
if exist keygen.obj del keygen.obj
rem if exist rsrc.res   del rsrc.res
if exist rsrc.obj   del rsrc.obj

\masm32\bin\ml /c /coff keygen.asm
\masm32\bin\rc rsrc.rc
\masm32\bin\cvtres /machine:ix86 rsrc.res
pause
\masm32\bin\Link /SUBSYSTEM:WINDOWS keygen.obj rsrc.obj
pause
if exist keygen.obj del keygen.obj
if exist rsrc.obj   del rsrc.obj
if exist rsrc.res   del rsrc.res