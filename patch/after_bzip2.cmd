@echo off
set VSSDK=%1

copy /Y "%VSSDK%\lib\b2.lib"        "%VSSDK%\lib\bzip2.lib"
