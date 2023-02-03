@echo off
set VSSDK=%1

copy /Y "%VSSDK%\lib\libxml2s.lib" "%VSSDK%\lib\libxml2.lib"

