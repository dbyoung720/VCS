@echo off
set VSSDK=%1

copy /Y "%VSSDK%\bin\sqlite.exe" "%VSSDK%\bin\sqlite3.exe"
