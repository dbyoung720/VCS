@echo off
set VSSDK=%1

copy /Y "%VSSDK%\lib\libdav1d.a" "%VSSDK%\lib\libdav1d.lib"
copy /Y "%VSSDK%\lib\libdav1d.a" "%VSSDK%\lib\dav1d.lib"
