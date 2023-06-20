@echo off

for /r %%f in (*.bat) do (
    if NOT "%%f" == "%~f0" (
        cd %%~pf
        SET "PATH=%PATH%;%%~pf"
        call "%%f"
    )
)
