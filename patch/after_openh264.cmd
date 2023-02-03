@echo off
set VSSDK=%1

copy /Y "%VSSDK%\lib\libopenh264.a" "%VSSDK%\lib\libopenh264.lib"
copy /Y "%VSSDK%\lib\libopenh264.a" "%VSSDK%\lib\openh264.lib"
