@echo off
set VSSDK=%1

del  /Q  %VSSDK%\bin\snappy.dll
del  /Q  %VSSDK%\lib\snappy.lib
copy /Y  %VSSDK%\lib\snappy_static.lib  %VSSDK%\lib\snappy.lib
