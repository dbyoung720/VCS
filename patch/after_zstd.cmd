@echo off
set VSSDK=%1

copy /Y %VSSDK%\lib\zstd_static.lib %VSSDK%\lib\zstd.lib
