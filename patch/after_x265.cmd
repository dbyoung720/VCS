@echo off
set VSSDK=%1

copy /Y "%VSSDK%\lib\x265-static.lib" "%VSSDK%\lib\x265.lib"
