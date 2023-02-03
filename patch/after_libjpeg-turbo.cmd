@echo off
set VSSDK=%1

copy /Y "%VSSDK%\lib\jpeg-static.lib"      "%VSSDK%\lib\jpeg.lib"
copy /Y "%VSSDK%\lib\turbojpeg-static.lib" "%VSSDK%\lib\turbojpeg.lib"
