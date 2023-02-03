@echo off
set VSSDK=%1

copy /Y %VSSDK%\lib\libfribidi.a %VSSDK%\lib\fribidi.lib
copy /Y %VSSDK%\lib\libfribidi.a %VSSDK%\lib\libfribidi.lib
