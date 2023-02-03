@echo off
set VSSDK=%1

if not exist %VSSDK%\lib\pkgconfig (
  CD %VSSDK%\lib
  md pkgconfig
)

del /Q  %VSSDK%\bin\zlib.dll
del /Q  %VSSDK%\lib\zlib.lib
rename  %VSSDK%\lib\zlibstatic.lib zlib.lib
copy /Y %VSSDK%\lib\zlib.lib            %VSSDK%\lib\z.lib
copy /Y %VSSDK%\share\pkgconfig\zlib.pc %VSSDK%\lib\pkgconfig\zlib.pc

