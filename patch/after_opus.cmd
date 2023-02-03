@echo off
set VSSDK=%1

copy /Y %VSSDK%\lib\libopus.a %VSSDK%\lib\libopus.lib
