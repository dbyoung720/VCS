@echo off
set RootPath=%1
set SourcePath=%2
set CodeName=%3

copy /Y "%RootPath%patch\%CodeName%\*.*"   "%SourcePath%\*.*" 
