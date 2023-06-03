@echo off
set RootPath=%1
set SourcePath=%2
set CodeName=%3

copy /Y "%RootPath%patch\%CodeName%\version.h"   "%SourcePath%\version.h" 
copy /Y "%RootPath%patch\%CodeName%\version.h"   "%SourcePath%\avs_core\core\version.h" 
