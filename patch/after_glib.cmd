@echo off
set VSSDK=%1

copy /Y "%VSSDK%\lib\libffi.a"         "%VSSDK%\lib\libffi.lib"
copy /Y "%VSSDK%\lib\libintl.a"        "%VSSDK%\lib\libintl.lib"
copy /Y "%VSSDK%\lib\libglib-2.0.a"    "%VSSDK%\lib\libglib-2.0.lib"
copy /Y "%VSSDK%\lib\libgobject-2.0.a" "%VSSDK%\lib\libgobject-2.0.lib"
copy /Y "%VSSDK%\lib\libgmodule-2.0.a" "%VSSDK%\lib\libgmodule-2.0.lib"
copy /Y "%VSSDK%\lib\libgthread-2.0.a" "%VSSDK%\lib\libgthread-2.0.lib"
copy /Y "%VSSDK%\lib\libgio-2.0.a"     "%VSSDK%\lib\libgio-2.0.lib"
