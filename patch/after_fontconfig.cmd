@echo off
set VSSDK=%1

if not exist %VSSDK%\lib\pkgconfig (
  CD %VSSDK%\lib
  md pkgconfig
)

copy /Y %VSSDK%\lib\libexpat.a       %VSSDK%\lib\libexpat.lib
copy /Y %VSSDK%\lib\libfontconfig.a  %VSSDK%\lib\libfontconfig.lib
copy /Y %VSSDK%\lib\libfontconfig.a  %VSSDK%\lib\fontconfig.lib
copy /Y %VSSDK%\lib\libfreetype.a    %VSSDK%\lib\libfreetype.lib
