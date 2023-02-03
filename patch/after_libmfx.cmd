@echo off
set VSSDK=%1

copy /Y "%VSSDK%\lib\mfx.lib" "%VSSDK%\lib\libmfx.lib"
