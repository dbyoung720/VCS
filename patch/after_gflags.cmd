@echo off
set VSSDK=%1

copy /Y %VSSDK%\lib\gflags_static.lib           %VSSDK%\lib\gflags.lib
copy /Y %VSSDK%\lib\gflags_nothreads_static.lib %VSSDK%\lib\gflags_nothreads.lib
